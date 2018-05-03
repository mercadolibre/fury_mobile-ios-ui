//
// UIColor+MLColorPaletteTest.m
// MLUI
//
// Created by Julieta Puente on 29/1/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIColor+MLColorPalette.h"

@interface UIColor_MLColorPaletteTest : XCTestCase

@end

@implementation UIColor_MLColorPaletteTest

- (void)setUp
{
	[super setUp];
	// Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
}

- (void)testMLMeliYellow
{
	UIColor *meliYellow = [UIColor ml_meli_yellow];
	XCTAssertTrue(CGColorEqualToColor(meliYellow.CGColor, [UIColor colorWithRed:255.f / 255.f green:219.f / 255.f blue:21.f / 255.f alpha:1].CGColor)
	              );
}

- (void)testMLMeliLightYellow
{
	UIColor *meliLightYellow = [UIColor ml_meli_light_yellow];
	XCTAssertTrue(CGColorEqualToColor(meliLightYellow.CGColor, [UIColor colorWithRed:255.f / 255.f green:234.f / 255.f blue:120.f / 255.f alpha:1].CGColor)
	              );
}

- (void)testMLMeliBlack
{
	UIColor *meliBlack = [UIColor ml_meli_black];
	XCTAssertTrue(CGColorEqualToColor(meliBlack.CGColor, [UIColor colorWithRed:51.f / 255.f green:51.f / 255.f blue:51.f / 255.f alpha:1].CGColor)
	              );
}

- (void)testMLMeliDarkGrey
{
	UIColor *meliDarkGrey = [UIColor ml_meli_dark_grey];
	XCTAssertTrue(CGColorEqualToColor(meliDarkGrey.CGColor, [UIColor colorWithRed:102.f / 255.f green:102.f / 255.f blue:102.f / 255.f alpha:1].CGColor)
	              );
}

- (void)testMLMeliGrey
{
	UIColor *meliGrey = [UIColor ml_meli_grey];
	XCTAssertTrue(CGColorEqualToColor(meliGrey.CGColor, [UIColor colorWithRed:153.f / 255.f green:153.f / 255.f blue:153.f / 255.f alpha:1].CGColor)
	              );
}

- (void)testMLMeliMidGrey
{
	UIColor *meliMidGrey = [UIColor ml_meli_mid_grey];
	XCTAssertTrue(CGColorEqualToColor(meliMidGrey.CGColor, [UIColor colorWithRed:204.f / 255.f green:204.f / 255.f blue:204.f / 255.f alpha:1].CGColor)
	              );
}

- (void)testMLMeliLightGrey
{
	UIColor *meliLightGrey = [UIColor ml_meli_light_grey];
	XCTAssertTrue(CGColorEqualToColor(meliLightGrey.CGColor, [UIColor colorWithRed:238.f / 255.f green:238.f / 255.f blue:238.f / 255.f alpha:1].CGColor)
	              );
}

- (void)testMLMeliWhite
{
	UIColor *meliWhite = [UIColor ml_meli_white];
	XCTAssertTrue(CGColorEqualToColor(meliWhite.CGColor, [UIColor colorWithRed:255.f / 255.f green:255.f / 255.f blue:255.f / 255.f alpha:1].CGColor)
	              );
}

- (void)testMLMeliBlue
{
	UIColor *meliBlue = [UIColor ml_meli_blue];
	XCTAssertTrue(CGColorEqualToColor(meliBlue.CGColor, [UIColor colorWithRed:52.f / 255.f green:131.f / 255.f blue:250.f / 255.f alpha:1].CGColor)
	              );
}

- (void)testMLMeliGreen
{
	UIColor *meliGreen = [UIColor ml_meli_green];
	XCTAssertTrue(CGColorEqualToColor(meliGreen.CGColor, [UIColor colorWithRed:57.f / 255.f green:181.f / 255.f blue:74.f / 255.f alpha:1].CGColor)
	              );
}

- (void)testMLMeliOrange
{
    UIColor *meliOrange = [UIColor ml_meli_orange];
    XCTAssertTrue(CGColorEqualToColor(meliOrange.CGColor, [UIColor colorWithRed:0.98 green:0.67 blue:0.38 alpha:1.0].CGColor)
                  );
}

- (void)testMLMeliRed
{
	UIColor *meliRed = [UIColor ml_meli_red];
	XCTAssertTrue(CGColorEqualToColor(meliRed.CGColor, [UIColor colorWithRed:240.f / 255.f green:68.f / 255.f blue:73.f / 255.f alpha:1].CGColor)
	              );
}

@end
