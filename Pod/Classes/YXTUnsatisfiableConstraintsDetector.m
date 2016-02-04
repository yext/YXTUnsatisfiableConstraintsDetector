//
//  YXTUnsatisfiableConstraintsDetector.m
//  YXTUnsatisfiableConstraintsDetector
//

@import UIKit;

#import "YXTUnsatisfiableConstraintsDetector.h"
#import "UIView+CheckForUnsatisfiableConstraints.h"
#import "asl.h"

@interface YXTUnsatisfiableConstraintsDetector ()

@property NSDate *lastLogCheck;
@property NSTimer *timer;
@property NSNotificationCenter *center;

@end

@implementation YXTUnsatisfiableConstraintsDetector

- (id) init {
    if(self = [super init]){
        self.center = [NSNotificationCenter defaultCenter];
    }
    return self;
}

- (id) registerBlock:(void (^)(UIView*))handleUnsatisfiableConstraints {
    return [self.center addObserverForName:YXTConstraintVoilationMonitorDidDetectViolation object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        UIView *view = note.userInfo[@"view"];
        handleUnsatisfiableConstraints(view);
    }];
}

- (void) beginMonitoring {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(checkForUnsatisfiableConstraints) userInfo:nil repeats:YES];
    // Make an initial call
    [self checkForUnsatisfiableConstraints];
}

- (void) stopMonitoring {
    [self.timer invalidate];
}

- (BOOL)checkForUnsatisfiableConstraints
{
    aslmsg q, m;
    
    q = asl_new(ASL_TYPE_QUERY);
    if(self.lastLogCheck != nil){
        NSString *logSince = [NSString stringWithFormat:@"%.0f", [self.lastLogCheck
                                                              timeIntervalSince1970]];
    asl_set_query(q, ASL_KEY_TIME, [logSince UTF8String], ASL_QUERY_OP_GREATER_EQUAL);
    }
    self.lastLogCheck = [NSDate date];
    
    aslresponse r = asl_search(NULL, q);
    while (NULL != (m = asl_next(r)))
    {
        const char *val = asl_get(m, ASL_KEY_MSG);
        NSString *line = val != NULL ? [NSString stringWithUTF8String:val] : nil;
        if([line hasPrefix:@"Unable to simultaneously satisfy constraints."]){
            // Check this against all views
            [self searchForViolationsForMessage:line];
            return YES;
        }
    }
    asl_release(r);
    return NO;
}

- (void) searchForViolationsForMessage:(NSString *)message {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        UIViewController *rootController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        if(![self searchForViolationsInView:rootController.view forMessage:message]){
            // Send event without view
        }
    });
}

- (BOOL) searchForViolationsInView:(UIView *) view forMessage:(NSString *)message {
    if([view yxt_hasUnsatisfiableConstraintForMessage:message]){
        // Send notification
        [self.center postNotificationName:YXTConstraintVoilationMonitorDidDetectViolation object:self userInfo:@{@"view" : view}];
        return YES;
    }
    for (UIView *subview in view.subviews){
        if([self searchForViolationsInView:subview forMessage:message]){
            return YES;
        }
    }
    return NO;
}

@end
