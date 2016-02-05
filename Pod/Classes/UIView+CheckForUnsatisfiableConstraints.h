//
//  UIView+CheckForUnsatisfiableConstraints.h
//  YXTUnsatisfiableConstraintsDetector
//
//

#import <UIKit/UIKit.h>

/**
 *  UIView category to allow testing for unsatisfiable constraints.
 */
@interface UIView (CheckForUnsatisfiableConstraints)

/**
 *  Check for unsatisfiable constraints on this view that are mentioned in the provided message.
 *
 *  @param message Console message to be tested.
 *
 *  @return True if one or more of this view's constraints are listed in the message.
 */
- (BOOL)yxt_hasUnsatisfiableConstraintForMessage:(NSString *)message;

@end
