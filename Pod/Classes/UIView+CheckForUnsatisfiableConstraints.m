//
//  UIView+CheckForUnsatisfiableConstraints.m
//  YXTUnsatisfiableConstraintsDetector
//
//

#import "UIView+CheckForUnsatisfiableConstraints.h"
#import "asl.h"

@implementation UIView (CheckForUnsatisfiableConstraints)

- (BOOL)yxt_hasUnsatisfiableConstraintForMessage:(NSString *)message {
    for (NSLayoutConstraint *constraint in self.constraints) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"NSLayoutConstraint:(0x[0-9a-f]+)" options:0 error:NULL];
        NSString *description = [constraint description];
        NSTextCheckingResult *match = [regex firstMatchInString:description options:0 range:NSMakeRange(0, [description length])];
        NSString* substringForMatch = [description substringWithRange:match.range];
        if([message containsString:substringForMatch]){
            return YES;
        }
    }
    return NO;
}

@end
