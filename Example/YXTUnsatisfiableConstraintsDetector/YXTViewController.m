//
//  YXTViewController.m
//  YXTUnsatisfiableConstraintsDetector
//
//  Created by Thomas Elliott on 02/04/2016.
//  Copyright (c) 2016 Thomas Elliott. All rights reserved.
//

#import "YXTViewController.h"
#import "YXTUnsatisfiableConstraintsDetector.h"

@interface YXTViewController ()

@end

@implementation YXTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    YXTUnsatisfiableConstraintsDetector *detector = [[YXTUnsatisfiableConstraintsDetector alloc] init];
    
    [detector registerBlock:^(UIView *view){
        if(view != nil){
            dispatch_async(dispatch_get_main_queue(), ^(void){
                view.layer.borderColor = [UIColor redColor].CGColor;
                view.layer.borderWidth = 3.0;
            });
        }
    }];
    
    [detector beginMonitoring];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
