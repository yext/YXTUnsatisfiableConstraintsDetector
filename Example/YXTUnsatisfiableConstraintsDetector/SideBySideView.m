//
//  SideBySideView.m
//  YXTUnsatisfiableConstraintsDetector-Example
//

#import "SideBySideView.h"

@implementation SideBySideView

- (id) initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self configureView];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]){
        [self configureView];
    }
    return self;
}

- (void) configureView {

    UIView *leftView = [[UIView alloc] init];
    UIView *rightView = [[UIView alloc] init];
    
    leftView.translatesAutoresizingMaskIntoConstraints = NO;
    rightView.translatesAutoresizingMaskIntoConstraints = NO;

    leftView.backgroundColor = [UIColor greenColor];
    rightView.backgroundColor = [UIColor blueColor];
    
    [self addSubview:leftView];
    [self addSubview:rightView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[leftView]|" options:0 metrics:nil views:@{@"leftView" : leftView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rightView]|" options:0 metrics:nil views:@{@"rightView" : rightView}]];
    
    self.leftView = leftView;
    self.rightView = rightView;
    
    [self setupHorizontalConstraint];
    
}

- (void) setupHorizontalConstraint {
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[leftView(==100)][rightView(==100)]" options:0 metrics:nil views:@{@"leftView" : self.leftView, @"rightView" : self.rightView}]];
}

- (void) layoutSubviews {
    [super layoutSubviews];
}


@end
