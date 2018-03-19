//
// BoundingSizeTest.m
// MLUI
//
// Created by Matías Ginart on 4/9/15.
// Copyright (c) 2015 MercadoLibre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSString+BoundingSize.h"

@interface BoundingSizeTest : XCTestCase
@property (nonatomic, copy) NSString *exampleString;
@end

@implementation BoundingSizeTest

- (void)setUp
{
	[super setUp];
	self.exampleString = @"Un String extra grande para testear que el alto sea algo bueno!. Por Dios, anda bien por favor! Te lo pido";
}

- (void)tearDown
{
	self.exampleString = nil;
	[super tearDown];
}

- (void)testBoundingRectSizeWithSizeShouldReturnOk
{
	CGSize aSize = [self.exampleString ml_boundingRectSizeWithSize:CGSizeMake(200, CGFLOAT_MAX) andFont:[UIFont systemFontOfSize:13.0]];

	XCTAssertEqual(floorf(aSize.height), 62.f);
}

- (void)testBoundingRectSizeWithFontShouldReturnOk
{
	CGSize aSize = [self.exampleString ml_sizeWithFont:[UIFont systemFontOfSize:13.f]];

	XCTAssertEqual(floorf(aSize.height), 15.f);
}

- (void)testBoundingRectSizeWithFontNilShouldReturnSizeZero
{
	CGSize aSize = [self.exampleString ml_sizeWithFont:nil];
	XCTAssertEqual(aSize.height, 0.f);
	XCTAssertEqual(aSize.width, 0.f);
}

@end
