//
// MLButtonConfigTest.m
// MLUIUnitTests
//
// Created by Ezequiel Perez Dittler on 14/06/2018.
// Copyright © 2018 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MLUI/MLButtonConfig.h>

@interface MLButtonConfigTest : XCTestCase

@end

@implementation MLButtonConfigTest

- (void)testEqualsSelf
{
	MLButtonConfig *config = [[MLButtonConfig alloc] init];
	XCTAssertTrue([config isEqual:config]);
}

- (void)testEqualsNotNilWithNil
{
	MLButtonConfig *configOne = [[MLButtonConfig alloc] init];
	MLButtonConfig *configTwo = nil;
	XCTAssertNotEqual(configOne, configTwo);
	XCTAssertNotEqualObjects(configOne, configTwo);
	XCTAssertNotEqualObjects(configTwo, configOne);
}

- (void)testEqualsEmptyConfigs
{
	MLButtonConfig *configOne = [[MLButtonConfig alloc] init];
	MLButtonConfig *configTwo = [[MLButtonConfig alloc] init];
	XCTAssertNotEqual(configOne, configTwo);
	XCTAssertEqualObjects(configOne, configTwo);
	XCTAssertEqualObjects(configTwo, configOne);
	XCTAssertEqual(configOne.hash, configTwo.hash);
}

- (void)testNotEqualWithDifferentSizes
{
	MLButtonConfig *configOne = [MLButtonStylesFactory configForButtonType:MLButtonTypePrimaryAction withSize:MLButtonSizeSmall];
	MLButtonConfig *configTwo = [MLButtonStylesFactory configForButtonType:MLButtonTypePrimaryAction withSize:MLButtonSizeLarge];
	XCTAssertNotEqual(configOne, configTwo);
	XCTAssertNotEqualObjects(configOne, configTwo);
}

@end
