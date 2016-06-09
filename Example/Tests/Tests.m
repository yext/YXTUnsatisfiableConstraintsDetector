//
//  YXTUnsatisfiableConstraintsDetectorTests.m
//  YXTUnsatisfiableConstraintsDetectorTests
//
//  Created by Thomas Elliott on 02/04/2016.
//  Copyright (c) 2016 Thomas Elliott. All rights reserved.
//

@import XCTest;
#import "UnsatisfiableView.h"
#import "SatisfiableView.h"
#import "YXTUnsatisfiableConstraintsDetector.h"

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// Verify that an empty view does not trigger a constraints issue
- (void) testEmptyView {
    
    YXTUnsatisfiableConstraintsDetector *detector = [YXTUnsatisfiableConstraintsDetector sharedInstance];
    [detector registerBlock:^(UIView *view){
        XCTFail(@"Did not expect error to be raised");
    }];
    
    UIView *empty = [[UIView alloc] initWithFrame:CGRectMake(0,0,100,100)];
    [empty setNeedsLayout];
    [empty layoutIfNeeded];
    
    [detector checkForUnsatisfiableConstraints];

}

// Verify that errors from a view that isn't visible on screen are still handled
- (void) testViewOutsideHierarchy {
    
    __block BOOL detectedError = NO;
    
    YXTUnsatisfiableConstraintsDetector *detector = [YXTUnsatisfiableConstraintsDetector sharedInstance];
    id blockId = [detector registerBlock:^(UIView *view){
        XCTAssertNil(view);
        detectedError = YES;
    }];
    
    UIView *unsatisfiable = [[UnsatisfiableView alloc] initWithFrame:CGRectMake(0,0,100,100)];
    [unsatisfiable setNeedsLayout];
    [unsatisfiable layoutIfNeeded];
    
    [detector checkForUnsatisfiableConstraints];
    
    XCTAssert(detectedError);
    
    [detector deregisterBlock:blockId];
}

// Verify that errors are picked up by polling
- (void) testPolling {
    
    XCTestExpectation *constraintErrorExp = [self expectationWithDescription:@"Expectation for constraint error"];
    
    YXTUnsatisfiableConstraintsDetector *detector = [YXTUnsatisfiableConstraintsDetector sharedInstance];
    id blockId = [detector registerBlock:^(UIView *view){
        XCTAssertNil(view);
        [constraintErrorExp fulfill];
    }];
    [detector beginMonitoring];
    
    UIView *unsatisfiable = [[UnsatisfiableView alloc] initWithFrame:CGRectMake(0,0,100,100)];
    [unsatisfiable setNeedsLayout];
    [unsatisfiable layoutIfNeeded];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
    
    [detector deregisterBlock:blockId];
    
    [detector stopMonitoring];
    
}

@end

