//
//  SatisfiableView.m
//  YXTUnsatisfiableConstraintsDetector-Example
//

#import "SatisfiableView.h"

@implementation SatisfiableView

- (void) setupHorizontalConstraint {
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[leftView(==100)][rightView(==100)]" options:0 metrics:nil views:@{@"leftView" : self.leftView, @"rightView" : self.rightView}]];
}

@end
