//
// MLButtonConfigStyleTest.m
// MLUIUnitTests
//
// Created by Ezequiel Perez Dittler on 14/06/2018.
// Copyright © 2018 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MLUI/MLButtonConfigStyle.h>
#import "UIImage+Misc.h"

@interface MLButtonConfigStyleTest : XCTestCase

@end

@implementation MLButtonConfigStyleTest

- (void)testEqualsSelf
{
    UIImage * image = [UIImage ml_imageWithColor:UIColor.blueColor];
	MLButtonConfigStyle *style = [[MLButtonConfigStyle alloc] initWithContentColor:UIColor.blueColor backgroundColor:UIColor.blackColor borderColor:UIColor.brownColor iconImage:image];
	XCTAssertTrue([style isEqual:style]);
}

- (void)testEqualNotNilWithNil
{
    UIImage * image = [UIImage ml_imageWithColor:UIColor.blueColor];
    MLButtonConfigStyle *styleOne = [[MLButtonConfigStyle alloc] initWithContentColor:UIColor.blueColor backgroundColor:UIColor.blackColor borderColor:UIColor.brownColor iconImage:image];
	MLButtonConfigStyle *styleTwo = nil;
	XCTAssertNotEqual(styleOne, styleTwo);
	XCTAssertNotEqualObjects(styleOne, styleTwo);
	XCTAssertNotEqualObjects(styleTwo, styleOne);
	XCTAssertNotEqual(styleOne.hash, styleTwo.hash);
}

- (void)testEqualStyles
{
    UIImage * image = [UIImage ml_imageWithColor:UIColor.blueColor];

	MLButtonConfigStyle *styleOne = [[MLButtonConfigStyle alloc] initWithContentColor:UIColor.blueColor backgroundColor:UIColor.blackColor borderColor:UIColor.brownColor iconImage:image];
	MLButtonConfigStyle *styleTwo = [[MLButtonConfigStyle alloc] initWithContentColor:UIColor.blueColor backgroundColor:UIColor.blackColor borderColor:UIColor.brownColor iconImage:image];
	XCTAssertNotEqual(styleOne, styleTwo);
	XCTAssertEqualObjects(styleOne, styleTwo);
	XCTAssertEqualObjects(styleTwo, styleOne);
	XCTAssertEqual(styleOne.hash, styleTwo.hash);
}

- (void)testNotEqualStyles
{
    UIImage * image1 = [UIImage ml_imageWithColor:UIColor.blueColor];
    UIImage * image2 = [UIImage ml_imageWithColor:UIColor.blueColor];

	MLButtonConfigStyle *styleOne = [[MLButtonConfigStyle alloc] initWithContentColor:UIColor.blueColor backgroundColor:UIColor.blackColor borderColor:UIColor.brownColor iconImage:image1];
	MLButtonConfigStyle *styleTwo = [[MLButtonConfigStyle alloc] initWithContentColor:UIColor.blueColor backgroundColor:UIColor.blackColor borderColor:UIColor.redColor iconImage:image2];
	XCTAssertNotEqual(styleOne, styleTwo);
	XCTAssertNotEqualObjects(styleOne, styleTwo);
	XCTAssertNotEqualObjects(styleTwo, styleOne);
	XCTAssertNotEqual(styleOne.hash, styleTwo.hash);
}

@end
