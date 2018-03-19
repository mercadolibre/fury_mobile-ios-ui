//
// MLRadioButtonTest.m
// MLUI
//
// Created by Santiago Lazzari on 6/9/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MLRadioButtonCollection.h"
#import "MLRadioButton.h"

@interface MLRadioButtonTest : XCTestCase

@end

@implementation MLRadioButtonTest

- (void)setUp
{
	[super setUp];
}

- (void)tearDown
{
	[super tearDown];
}

- (void)testDefaultStateOfRadioButtonIsClear
{
	MLRadioButton *radioButton = [[MLRadioButton alloc] init];

	XCTAssertEqual([radioButton isOff], YES);
}

- (void)testFillRadioButton
{
	MLRadioButton *radioButton = [[MLRadioButton alloc] init];

	[radioButton on];

	XCTAssertEqual([radioButton isOn], YES);
	XCTAssertEqual([radioButton isOff], NO);
}

- (void)testClearRadioButton
{
	MLRadioButton *radioButton = [[MLRadioButton alloc] init];

	[radioButton off];

	XCTAssertEqual([radioButton isOff], YES);
	XCTAssertEqual([radioButton isOn], NO);
}

- (void)testToggleRadioButton
{
	MLRadioButton *radioButton = [[MLRadioButton alloc] init];

	[radioButton off];
	[radioButton toggle];

	XCTAssertEqual([radioButton isOff], NO);
	XCTAssertEqual([radioButton isOn], YES);

	[radioButton toggle];

	XCTAssertEqual([radioButton isOff], YES);
	XCTAssertEqual([radioButton isOn], NO);
}

@end
