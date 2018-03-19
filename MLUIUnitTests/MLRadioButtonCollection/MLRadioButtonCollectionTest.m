//
// MLRadioButtonCollectionTest.m
// MLUI
//
// Created by Santiago Lazzari on 6/9/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MLRadioButtonCollection.h"
#import "MLRadioButton.h"

@interface MLRadioButtonCollectionTest : XCTestCase

@end

@implementation MLRadioButtonCollectionTest

- (void)setUp
{
	[super setUp];
}

- (void)tearDown
{
	[super tearDown];
}

- (void)testRadioButtonCollectionInitWithIntegerLessOrEqualThanZero
{
	XCTAssertThrows([MLRadioButtonCollection radioButtonCollectionWithRadioButtonCount:0]);
}

- (void)testRadioButtonCollectionInitWithInteger
{
	MLRadioButtonCollection *radioButtonCollection = [MLRadioButtonCollection radioButtonCollectionWithRadioButtonCount:10];

	XCTAssertEqual([[radioButtonCollection radioButtons] count], 10);
}

- (void)testRadioButtonCollectionSelectRadioButtonChangeItsState
{
	MLRadioButton *radioButton0 = [[MLRadioButton alloc] init];
	MLRadioButton *radioButton1 = [[MLRadioButton alloc] init];
	MLRadioButton *radioButton2 = [[MLRadioButton alloc] init];

	MLRadioButtonCollection *radioButtonCollection = [MLRadioButtonCollection radioButtonCollectionWithRadioButtons:@[radioButton0, radioButton1, radioButton2]];

	[radioButtonCollection selectRadioButtonAtIndex:0];

	XCTAssertEqual([radioButton0 isOn], YES);
	XCTAssertEqual([radioButton1 isOn], NO);
	XCTAssertEqual([radioButton2 isOn], NO);
}

- (void)testRadioButtonCollectionIndexOfSelectedRadioButton
{
	MLRadioButton *radioButton0 = [[MLRadioButton alloc] init];
	MLRadioButton *radioButton1 = [[MLRadioButton alloc] init];
	MLRadioButton *radioButton2 = [[MLRadioButton alloc] init];

	MLRadioButtonCollection *radioButtonCollection = [MLRadioButtonCollection radioButtonCollectionWithRadioButtons:@[radioButton0, radioButton1, radioButton2]];

	[radioButtonCollection selectRadioButtonAtIndex:1];

	XCTAssertEqual([radioButtonCollection indexOfSelectedRadioButton], 1);
}

@end
