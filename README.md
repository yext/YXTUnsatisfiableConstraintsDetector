# YXTUnsatisfiableConstraintsDetector

 -[![CI Status](https://img.shields.io/travis/yext/YXTUnsatisfiableConstraintsDetector.svg?style=flat)](https://travis-ci.org/yext/YXTUnsatisfiableConstraintsDetector)

A debugging tool that catches unsatisfiable constraint errors as they appear at the console and provides call backs either directly to blocks or via NSNotificationCenter. This allows such errors to be handled at runtime.

This tool is intended for debugging only, and has not been designed for production-level performance.

## Use cases

* Highlighting constraint issues during development visually
* Catching constraint problems during unit testing
* Failing UI tests by killing the application on receipt of a constraint error.

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

The example project shows a use of the detector to highlight `UIViews` with unsatisfiable constraints, displaying a red border on problem views.

## Requirements

YXTUnsatisfiableConstraintsDetector supports projects for iOS 7 and above.

## Installation

### Manual Install

To install manually, copy the files under *Pod/Classes* into your project.

### CocoaPods

NOTE: This project has not yet been submitted to CocoaPods

YXTUnsatisfiableConstraintsDetector is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "YXTUnsatisfiableConstraintsDetector"
```

## Usage

To import the detector into a given source file:

    #import "YXTUnsatisfiableConstraintsDetector.h"

You can set up a callback and start monitoring as below:

    YXTUnsatisfiableConstraintsDetector *detector = [[YXTUnsatisfiableConstraintsDetector alloc] init];
    [detector registerBlock:^(UIView *view){
        if(view != nil){
            // Handle an error on a specific view here
        }
	    // Perform any handling that does not require a view
    }];
    [detector beginMonitoring];

Note that `view` may be null if the problem `UIView` is not currently in the view hierarchy.

## Author

Tom Elliott, telliott@yext.com

## License

YXTUnsatisfiableConstraintsDetector is available under the MIT license. See the LICENSE file for more info.
