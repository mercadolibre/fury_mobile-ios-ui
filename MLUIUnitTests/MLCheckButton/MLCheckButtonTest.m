//
// MLCheckButtonTest.m
// MLUI
//
// Created by Santiago Lazzari on 6/15/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MLCheckBox.h"

@interface MLCheckButtonTest : XCTestCase

@end

@implementation MLCheckButtonTest

- (void)setUp
{
	[super setUp];
}

- (void)tearDown
{
	[super tearDown];
}

- (void)testDefaultStateOfCheckButtonIsClear
{
	MLCheckBox *checkBox = [[MLCheckBox alloc] init];

	XCTAssertEqual([checkBox isOff], YES);
}

- (void)testFillCheckButton
{
	MLCheckBox *checkBox = [[MLCheckBox alloc] init];

	[checkBox on];

	XCTAssertEqual([checkBox isOn], YES);
	XCTAssertEqual([checkBox isOff], NO);
}

- (void)testClearRadioButton
{
	MLCheckBox *checkBox = [[MLCheckBox alloc] init];

	[checkBox off];

	XCTAssertEqual([checkBox isOff], YES);
	XCTAssertEqual([checkBox isOn], NO);
}

@end
