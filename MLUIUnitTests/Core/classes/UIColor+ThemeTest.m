//
// UIColor+Theme.m
// MLUI
//
// Created by Leandro Fantin on 14/1/15.
// Copyright (c) 2015 MercadoLibre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "UIColor+Theme.h"

@interface UIColor_ThemeTest : XCTestCase
@end

@implementation UIColor_ThemeTest

- (void)ml_textFeedbackColor
{
	UIColor *color = [UIColor ml_textFeedbackColor];
	UIColor *colorExpected = [UIColor colorWithRed:19.2 / 255.0 green:44.3 / 255.0 blue:62.4 / 255.0 alpha:1.0];
	XCTAssertNotNil(color);
	XCTAssertTrue(CGColorEqualToColor(color.CGColor, colorExpected.CGColor));
}

- (void)testTextDefaultColor
{
	UIColor *color = [UIColor ml_textDefaultColor];
	UIColor *colorExpected = [UIColor colorWithRed:84.0 / 255.0 green:84.0 / 255.0 blue:84.0 / 255.0 alpha:1.0];
	XCTAssertNotNil(color);
	XCTAssertTrue(CGColorEqualToColor(color.CGColor, colorExpected.CGColor));
}

- (void)testTextSubtitleColor
{
	UIColor *color = [UIColor ml_textSubtitleColor];
	UIColor *colorExpected = [UIColor colorWithRed:0.0 green:102.0 / 255.0 blue:255.0 alpha:1.0];
	XCTAssertNotNil(color);
	XCTAssertTrue(CGColorEqualToColor(color.CGColor, colorExpected.CGColor));
}

- (void)testCellBackgroundDefaultColor
{
	UIColor *color = [UIColor ml_cellBackgroundDefaultColor];
	UIColor *colorExpected = [UIColor whiteColor];
	XCTAssertNotNil(color);
	XCTAssertTrue(CGColorEqualToColor(color.CGColor, colorExpected.CGColor));
}

- (void)testTableViewBackgroundDefaultColor
{
	UIColor *color = [UIColor ml_tableViewBackgroundDefaultColor];
	UIColor *colorExpected = [UIColor whiteColor];
	XCTAssertNotNil(color);
	XCTAssertTrue(CGColorEqualToColor(color.CGColor, colorExpected.CGColor));
}

- (void)testBigErrorBackgroundDefaultColor
{
	UIColor *color = [UIColor ml_bigErrorBackgroundDefaultColor];
	UIColor *colorExpected = [UIColor colorWithRed:204.0 / 255.0 green:204.0 / 255.0 blue:204.0 / 255.0 alpha:1.0];
	XCTAssertNotNil(color);
	XCTAssertTrue(CGColorEqualToColor(color.CGColor, colorExpected.CGColor));
}

- (void)testPriceColor
{
	UIColor *color = [UIColor ml_priceColor];
	UIColor *colorExpected = [UIColor colorWithRed:168.f / 255.f green:40.f / 255.f blue:41.f / 255.f alpha:1];
	XCTAssertNotNil(color);
	XCTAssertTrue(CGColorEqualToColor(color.CGColor, colorExpected.CGColor));
}

- (void)testMercadoLibreLightBlueColor
{
	UIColor *color = [UIColor ml_mercadoLibreLightBlueColor];
	UIColor *colorExpected = [UIColor colorWithRed:233.f / 255.f green:238.f / 255.f blue:253.f / 255.f alpha:1];
	XCTAssertNotNil(color);
	XCTAssertTrue(CGColorEqualToColor(color.CGColor, colorExpected.CGColor));
}

- (void)testMercadoLibreBlueColor
{
	UIColor *color = [UIColor ml_mercadoLibreBlueColor];
	UIColor *colorExpected = [UIColor colorWithRed:43.f / 255.f green:50.f / 255.f blue:116.f / 255.f alpha:1];
	XCTAssertNotNil(color);
	XCTAssertTrue(CGColorEqualToColor(color.CGColor, colorExpected.CGColor));
}

- (void)testErrorCellColor
{
	UIColor *color = [UIColor ml_errorCellColor];
	UIColor *colorExpected = [UIColor colorWithRed:179.f / 255.f green:76.f / 255.f blue:66.f / 255.f alpha:1];
	XCTAssertNotNil(color);
	XCTAssertTrue(CGColorEqualToColor(color.CGColor, colorExpected.CGColor));
}

- (void)testWarningCellColor
{
	UIColor *color = [UIColor ml_warningCellColor];
	UIColor *colorExpected = [UIColor colorWithRed:170.f / 255.f green:133.f / 255.f blue:71.f / 255.f alpha:1];
	XCTAssertNotNil(color);
	XCTAssertTrue(CGColorEqualToColor(color.CGColor, colorExpected.CGColor));
}

- (void)testTableViewMisComprasBackgroundColor
{
	UIColor *color = [UIColor ml_tableViewMisComprasBackgroundColor];
	UIColor *colorExpected = [UIColor colorWithRed:236.f / 255.f green:231.f / 255.f blue:227.f / 255.f alpha:1];
	XCTAssertNotNil(color);
	XCTAssertTrue(CGColorEqualToColor(color.CGColor, colorExpected.CGColor));
}

- (void)testTableViewMisComprasFooterBackgroundColor
{
	UIColor *color = [UIColor ml_tableViewMisComprasFooterBackgroundColor];
	UIColor *colorExpected = [UIColor colorWithRed:247.f / 255.f green:245.f / 255.f blue:244.f / 255.f alpha:1];
	XCTAssertNotNil(color);
	XCTAssertTrue(CGColorEqualToColor(color.CGColor, colorExpected.CGColor));
}

- (void)testNavigationBarColor
{
	UIColor *color = [UIColor ml_navigationBarColor];
	UIColor *colorExpected = [UIColor colorWithRed:254.f / 255.f green:220.f / 255.f blue:19.f / 255.f alpha:1];
	XCTAssertNotNil(color);
	XCTAssertTrue(CGColorEqualToColor(color.CGColor, colorExpected.CGColor));
}

- (void)testiOS7TableViewBackgroundColor
{
	UIColor *color = [UIColor ml_iOS7TableViewBackgroundColor];
	UIColor *colorExpected = [UIColor colorWithRed:243.f / 255.f green:243.f / 255.f blue:243.f / 255.f alpha:1.0f];
	XCTAssertNotNil(color);
	XCTAssertTrue(CGColorEqualToColor(color.CGColor, colorExpected.CGColor));
}

- (void)testTabBarColor
{
	UIColor *color = [UIColor ml_tabBarColor];
	UIColor *colorExpected = [UIColor colorWithRed:128.f / 255.f green:128.f / 255.f blue:128.f / 255.f alpha:1];
	XCTAssertNotNil(color);
	XCTAssertTrue(CGColorEqualToColor(color.CGColor, colorExpected.CGColor));
}

- (void)testListingsDetailLine
{
	UIColor *color = [UIColor ml_listingsDetailLine];
	UIColor *colorExpected = [UIColor colorWithRed:200.f / 255.f green:199.f / 255.f blue:206.f / 255.f alpha:1.0f];
	XCTAssertNotNil(color);
	XCTAssertTrue(CGColorEqualToColor(color.CGColor, colorExpected.CGColor));
}

- (void)testTitleColor
{
	UIColor *color = [UIColor ml_titleColor];
	UIColor *colorExpected = [UIColor colorWithRed:51.f / 255.f green:51.f / 255.f blue:51.f / 255.f alpha:1];
	XCTAssertNotNil(color);
	XCTAssertTrue(CGColorEqualToColor(color.CGColor, colorExpected.CGColor));
}

- (void)testLighterColor
{
	UIColor *color = [UIColor colorWithRed:32.f / 255.f green:35.f / 255.f blue:96.f / 255.f alpha:1];
	XCTAssertNotNil(color);
	CGFloat h, s, b, a;
	XCTAssertTrue([color getHue:&h saturation:&s brightness:&b alpha:&a]);
	UIColor *colorExpected = [UIColor colorWithHue:h
	                                    saturation:s
	                                    brightness:MIN(b * 1.3, 1.0)
	                                         alpha:a];
	XCTAssertTrue(CGColorEqualToColor([color ml_lighterColor].CGColor, colorExpected.CGColor));
}

- (void)testDarkerColor
{
	UIColor *color = [UIColor colorWithRed:32.f / 255.f green:35.f / 255.f blue:96.f / 255.f alpha:1];
	XCTAssertNotNil(color);
	CGFloat h, s, b, a;
	XCTAssertTrue([color getHue:&h saturation:&s brightness:&b alpha:&a]);
	UIColor *colorExpected = [UIColor colorWithHue:h
	                                    saturation:s
	                                    brightness:b * 0.75
	                                         alpha:a];
	XCTAssertTrue(CGColorEqualToColor([color ml_darkerColor].CGColor, colorExpected.CGColor));
}

@end
