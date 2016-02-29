//
//  YXTUnsatisfiableConstraintsDetector.h
//  YXTUnsatisfiableConstraintsDetector
//
//

#import <Foundation/Foundation.h>

/**
 *  YXTUnsatisfiableConstraintsDetector is a utility class that
 *  listens for unsatisfiable constraint errors on the console
 *  and issues notifications and callbacks appropriately.
 */
@interface YXTUnsatisfiableConstraintsDetector : NSObject

#define YXTUnsatisfiableConstraintsDetectorDidDetectError @"YXTUnsatisfiableConstraintsDetectorDidDetectError"

/**
 * Gets the singleton instance of the unsatisfiable constraints detector.
 *
 * @return Unsatisfiable constraints detector.
 */
+ (instancetype)sharedInstance;

/**
 *  Polling interval for checking console logs for errors in seconds. Default 0.5s.
 */
@property (nonatomic) NSTimeInterval pollInterval;

/**
 *  Start monitoring for constraint errors
 */
- (void) beginMonitoring;
/**
 *  Stop monitoring if currently running
 */
- (void) stopMonitoring;

/**
 *  Register a block for callbacks in the event of a constraint error.
 *  This sets up an observer on the YXTUnsatisfiableConstraintsDetectorDidDetectError notification.
 *
 *  @param handleUnsatisfiableConstraints Method to handle a constraint error. Accepts a UIView which may be null.
 *
 *  @return A reference to the notification observer for cancellation.
 */
- (id) registerBlock:(void (^)(UIView*))handleUnsatisfiableConstraints;

/**
 *  Force a check for unsatisfiable constraints.
 */
- (void)checkForUnsatisfiableConstraints;

@end
