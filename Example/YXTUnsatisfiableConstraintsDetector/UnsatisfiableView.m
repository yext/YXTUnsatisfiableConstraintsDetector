//
//  UnsatisfiableView.m
//  YXTUnsatisfiableConstraintsDetector-Example
//


#import "UnsatisfiableView.h"

@implementation UnsatisfiableView

- (void) setupHorizontalConstraint {
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[leftView(==200)][rightView(==200)]|" options:0 metrics:nil views:@{@"leftView" : self.leftView, @"rightView" : self.rightView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[leftView(==100)][rightView(==100)]|" options:0 metrics:nil views:@{@"leftView" : self.leftView, @"rightView" : self.rightView}]];
}

@end
