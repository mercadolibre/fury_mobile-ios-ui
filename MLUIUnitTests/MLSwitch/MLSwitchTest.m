//
// MLSwitchTest.m
// MLUI
//
// Created by Santiago Lazzari on 6/23/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MLSwitch.h"

@interface MLSwitch (Test)

@property (strong, nonatomic) IBOutlet UIView *view;

@end

@interface MLSwitchTest : XCTestCase

@end

@implementation MLSwitchTest

- (void)testShouldHaveTransparentBackground
{
	MLSwitch *mlSwitch = [[MLSwitch alloc]init];

	XCTAssertEqualObjects(mlSwitch.backgroundColor, UIColor.clearColor);
	XCTAssertEqualObjects(mlSwitch.view.backgroundColor, UIColor.clearColor);
}

- (void)testSwitchInitsClear
{
	MLSwitch *mlSwitch = [[MLSwitch alloc]init];

	XCTAssertEqual([mlSwitch isOff], YES);
}

- (void)testSwitchSwitchesItsValue
{
	MLSwitch *mlSwitch = [[MLSwitch alloc]init];

	[mlSwitch on];

	XCTAssertEqual([mlSwitch isOn], YES);
}

@end
