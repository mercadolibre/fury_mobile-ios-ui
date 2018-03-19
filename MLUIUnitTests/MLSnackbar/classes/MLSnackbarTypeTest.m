//
// MLSnackbarTypeTest.m
// MLUI
//
// Created by Julieta Puente on 4/3/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MLSnackbarType.h"
#import "MLStyleSheetManager.h"

@interface MLSnackbarTypeTest : XCTestCase

@end

@implementation MLSnackbarTypeTest

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

- (void)testDefaultType
{
	MLSnackbarType *type = [MLSnackbarType defaultType];

	XCTAssertTrue(CGColorEqualToColor(type.backgroundColor.CGColor, MLStyleSheetManager.styleSheet.blackColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(type.titleFontColor.CGColor, MLStyleSheetManager.styleSheet.whiteColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(type.actionFontColor.CGColor, MLStyleSheetManager.styleSheet.whiteColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(type.actionFontHighlightColor.CGColor, MLStyleSheetManager.styleSheet.whiteColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(type.actionBackgroundHighlightColor.CGColor, [UIColor colorWithRed:0.f / 255.f green:0.f / 255.f blue:0.f / 255.f alpha:0.1].CGColor));
}

- (void)testSuccessType
{
	MLSnackbarType *type = [MLSnackbarType successType];

	XCTAssertTrue(CGColorEqualToColor(type.backgroundColor.CGColor, MLStyleSheetManager.styleSheet.successColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(type.titleFontColor.CGColor, MLStyleSheetManager.styleSheet.whiteColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(type.actionFontColor.CGColor, MLStyleSheetManager.styleSheet.whiteColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(type.actionFontHighlightColor.CGColor, MLStyleSheetManager.styleSheet.whiteColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(type.actionBackgroundHighlightColor.CGColor, [UIColor colorWithRed:0.f / 255.f green:0.f / 255.f blue:0.f / 255.f alpha:0.1].CGColor));
}

- (void)testErrorType
{
	MLSnackbarType *type = [MLSnackbarType errorType];

	XCTAssertTrue(CGColorEqualToColor(type.backgroundColor.CGColor, MLStyleSheetManager.styleSheet.errorColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(type.titleFontColor.CGColor, MLStyleSheetManager.styleSheet.whiteColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(type.actionFontColor.CGColor, MLStyleSheetManager.styleSheet.whiteColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(type.actionFontHighlightColor.CGColor, MLStyleSheetManager.styleSheet.whiteColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(type.actionBackgroundHighlightColor.CGColor, [UIColor colorWithRed:0.f / 255.f green:0.f / 255.f blue:0.f / 255.f alpha:0.1].CGColor));
}

@end
