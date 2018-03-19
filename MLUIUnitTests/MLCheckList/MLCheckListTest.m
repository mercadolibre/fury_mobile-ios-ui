//
// MLCheckListTest.m
// MLUI
//
// Created by Santiago Lazzari on 6/15/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MLCheckBox.h"
#import "MLCheckList.h"

@interface MLCheckListTest : XCTestCase

@end

@implementation MLCheckListTest

- (void)setUp
{
	[super setUp];
}

- (void)testExample
{
	[super setUp];
}

- (void)testCheckListInitWithIntegerLessOrEqualThanZero
{
	XCTAssertThrows([MLCheckList checkListWithCheckBoxCout:0]);
}

- (void)testCheckListInitWithInteger
{
	MLCheckList *checkList = [MLCheckList checkListWithCheckBoxCout:10];

	XCTAssertEqual([[checkList checkBoxes] count], 10);
}

- (void)testCheckListInitWithEmptySelectedIndexes
{
	MLCheckBox *checkBox0 = [[MLCheckBox alloc] init];
	MLCheckBox *checkBox1 = [[MLCheckBox alloc] init];
	MLCheckBox *checkBox2 = [[MLCheckBox alloc] init];

	MLCheckList *checkList = [MLCheckList checkListWithCheckBoxes:@[checkBox0, checkBox1, checkBox2]];

	XCTAssertEqual([[checkList indexesOfSelectedCheckBoxes] count], 0);
}

- (void)testCheckListSelectCorrectly
{
	MLCheckBox *checkButton0 = [[MLCheckBox alloc] init];
	MLCheckBox *checkButton1 = [[MLCheckBox alloc] init];
	MLCheckBox *checkButton2 = [[MLCheckBox alloc] init];

	MLCheckList *checkList = [MLCheckList checkListWithCheckBoxes:@[checkButton0, checkButton1, checkButton2]];

	[checkList toggleCheckBoxAtIndex:1];
	[checkList toggleCheckBoxAtIndex:2];

	XCTAssertEqual([[checkList indexesOfSelectedCheckBoxes] count], 2);
	XCTAssertEqual([[[checkList indexesOfSelectedCheckBoxes] objectAtIndex:0] integerValue], 1);
	XCTAssertEqual([[[checkList indexesOfSelectedCheckBoxes] objectAtIndex:1] integerValue], 2);
}

- (void)testCheckListUnselectCorrectly
{
	MLCheckBox *checkBox0 = [[MLCheckBox alloc] init];
	MLCheckBox *checkBox1 = [[MLCheckBox alloc] init];
	MLCheckBox *checkBox2 = [[MLCheckBox alloc] init];

	MLCheckList *checkList = [MLCheckList checkListWithCheckBoxes:@[checkBox0, checkBox1, checkBox2]];

	[checkList toggleCheckBoxAtIndex:1];
	[checkList toggleCheckBoxAtIndex:2];

	[checkList toggleCheckBoxAtIndex:1];

	XCTAssertEqual([[checkList indexesOfSelectedCheckBoxes] count], 1);
	XCTAssertEqual([[[checkList indexesOfSelectedCheckBoxes] objectAtIndex:0] integerValue], 2);

	[checkList toggleCheckBoxAtIndex:2];
	XCTAssertEqual([[checkList indexesOfSelectedCheckBoxes] count], 0);
}

@end
