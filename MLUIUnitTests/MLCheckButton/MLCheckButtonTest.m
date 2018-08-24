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
	XCTAssertTrue([checkBox isEnabled]);
}

- (void)testFillCheckButton
{
	MLCheckBox *checkBox = [[MLCheckBox alloc] init];

	[checkBox on];

	XCTAssertEqual([checkBox isOn], YES);
	XCTAssertEqual([checkBox isOff], NO);
}

- (void)testDisableCheckBox
{
	MLCheckBox *enabledCheckBox = [[MLCheckBox alloc] init];
	MLCheckBox *disabledCheckBox = [[MLCheckBox alloc] init];
	[disabledCheckBox setEnabled:NO Animated:NO];

	XCTAssertTrue([enabledCheckBox isEnabled]);
	XCTAssertFalse([disabledCheckBox isEnabled]);

	[enabledCheckBox setEnabled:NO Animated:YES];
	[disabledCheckBox setEnabled:NO Animated:YES];

	XCTAssertFalse([enabledCheckBox isEnabled]);
	XCTAssertFalse([disabledCheckBox isEnabled]);
}

- (void)testEnableCheckBox
{
	MLCheckBox *enabledCheckBox = [[MLCheckBox alloc] init];
	MLCheckBox *disabledCheckBox = [[MLCheckBox alloc] init];
	[disabledCheckBox setEnabled:NO Animated:NO];

	[enabledCheckBox setEnabled:YES Animated:YES];
	[disabledCheckBox setEnabled:YES Animated:YES];

	XCTAssertTrue([enabledCheckBox isEnabled]);
	XCTAssertTrue([disabledCheckBox isEnabled]);
}

- (void)testClearRadioButton
{
	MLCheckBox *checkBox = [[MLCheckBox alloc] init];

	[checkBox off];

	XCTAssertEqual([checkBox isOff], YES);
	XCTAssertEqual([checkBox isOn], NO);
}

@end
