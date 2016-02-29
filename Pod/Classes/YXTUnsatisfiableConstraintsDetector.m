//
//  YXTUnsatisfiableConstraintsDetector.m
//  YXTUnsatisfiableConstraintsDetector
//

@import UIKit;

#import "YXTUnsatisfiableConstraintsDetector.h"
#import "UIView+CheckForUnsatisfiableConstraints.h"
#import "asl.h"

@interface YXTUnsatisfiableConstraintsDetector ()

@property NSString *lastLogId;
@property NSTimer *timer;
@property NSNotificationCenter *center;

@end

@implementation YXTUnsatisfiableConstraintsDetector

#define MSG_SEQUENCE_KEY ASL_KEY_MSG_ID

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static id obj;
    dispatch_once(&onceToken, ^{
        obj = [[YXTUnsatisfiableConstraintsDetector alloc] init];
    });
    return obj;
}

- (id) init {
    if(self = [super init]){
        [self setLastLog];
        self.pollInterval = 0.5;
        self.center = [NSNotificationCenter defaultCenter];
    }
    return self;
}

- (id) registerBlock:(void (^)(UIView*))handleUnsatisfiableConstraints {
    return [self.center addObserverForName:YXTUnsatisfiableConstraintsDetectorDidDetectError object:nil queue:nil usingBlock:^(NSNotification *note) {
        UIView *view = note.userInfo[@"view"];
        handleUnsatisfiableConstraints(view);
    }];
}

- (void) beginMonitoring {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.pollInterval target:self selector:@selector(checkForUnsatisfiableConstraints) userInfo:nil repeats:YES];
    // Make an initial call
    [self checkForUnsatisfiableConstraints];
}

- (void) stopMonitoring {
    [self.timer invalidate];
}

- (void)setLastLog
{
    aslmsg q, m;
    
    q = asl_new(ASL_TYPE_QUERY);
    aslresponse r = asl_search(NULL, q);
    while (NULL != (m = asl_next(r)))
    {
        const char *time = asl_get(m, MSG_SEQUENCE_KEY);
        self.lastLogId = [NSString stringWithUTF8String:time];
    }
    asl_release(r);
}


- (void)checkForUnsatisfiableConstraints
{
    aslmsg q, m;
    
    q = asl_new(ASL_TYPE_QUERY);
    if(self.lastLogId != nil){
        asl_set_query(q, MSG_SEQUENCE_KEY, [self.lastLogId UTF8String], ASL_QUERY_OP_GREATER);
    }
    
    aslresponse r = asl_search(NULL, q);
    while (NULL != (m = asl_next(r)))
    {
        const char *val = asl_get(m, ASL_KEY_MSG);
        NSString *line = val != NULL ? [NSString stringWithUTF8String:val] : nil;
        if([line hasPrefix:@"Unable to simultaneously satisfy constraints."]){
            // Check this against all views
            [self searchForViolationsForMessage:line];
        }
        const char *time = asl_get(m, MSG_SEQUENCE_KEY);
        self.lastLogId = [NSString stringWithUTF8String:time];
    }
    asl_release(r);
}

- (void) searchForViolationsForMessage:(NSString *)message {
    UIViewController *rootController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    UIView *foundView = [self searchForViolationsInView:rootController.view forMessage:message];
    if(foundView != nil){
        // Send notification
        [self.center postNotificationName:YXTUnsatisfiableConstraintsDetectorDidDetectError object:self userInfo:@{@"view" : foundView}];
    } else {
        // Send event without view
        [self.center postNotificationName:YXTUnsatisfiableConstraintsDetectorDidDetectError object:self];
    }
}

- (UIView *) searchForViolationsInView:(UIView *) view forMessage:(NSString *)message {
    if([view yxt_hasUnsatisfiableConstraintForMessage:message]){
        return view;
    }
    for (UIView *subview in view.subviews){
        UIView *foundView = [self searchForViolationsInView:subview forMessage:message];
        if(foundView != nil){
            return foundView;
        }
    }
    return nil;
}

@end
