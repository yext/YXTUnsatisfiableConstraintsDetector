//
//  UIView+CheckForUnsatisfiableConstraints.h
//  YXTUnsatisfiableConstraintsDetector
//
//

#import <UIKit/UIKit.h>

@interface UIView (CheckForUnsatisfiableConstraints)

- (BOOL)yxt_hasUnsatisfiableConstraintForMessage:(NSString *)message;

@end
