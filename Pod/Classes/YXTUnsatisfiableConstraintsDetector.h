//
//  YXTUnsatisfiableConstraintsDetector.h
//  YXTUnsatisfiableConstraintsDetector
//
//

#import <Foundation/Foundation.h>

@interface YXTUnsatisfiableConstraintsDetector : NSObject

#define YXTConstraintVoilationMonitorDidDetectViolation @"YXTConstraintVoilationMonitorDidDetectViolation"

- (void) beginMonitoring;
- (void) stopMonitoring;

- (id) registerBlock:(void (^)(UIView*))handleUnsatisfiableConstraints;

@end
