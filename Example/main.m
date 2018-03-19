//
// main.m
// MLUI
//
// Created by Fabian Celdeiro on 9/10/14.
// Copyright (c) 2014 MercadoLibre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TestAppDelegate.h"

int main(
	int argc, char *argv[])
{
	@autoreleasepool {
		BOOL runningTests = NSClassFromString(@"XCTestCase") != nil;
		if (!runningTests) {
			return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
		} else {
			return UIApplicationMain(argc, argv, nil, NSStringFromClass([TestAppDelegate class]));
		}
	}
}
