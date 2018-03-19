//
// MLModalStyleFactoryTest.m
// MLUIUnitTests
//
// Created by Cristian Leonel Gibert on 2/23/18.
// Copyright © 2018 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MLUI/MLModalStyleFactory.h>
#import <MLUI/MLStyleSheetManager.h>
#import <MLUI/MLModalConfigStyle.h>
#import <MLUI/UIFont+MLFonts.h>

@interface MLModalStyleFactoryTest : XCTestCase
@property (nonatomic, strong) MLModalConfigStyle *modalStyle;
@end

@implementation MLModalStyleFactoryTest

- (void)setUp
{
	[super setUp];
	self.modalStyle = [MLModalStyleFactory configForModalType:MLModalTypeML];
}

- (void)testModalStylePropertiesValues
{
	XCTAssertTrue(CGColorEqualToColor(self.modalStyle.backgroundColor.CGColor, MLStyleSheetManager.styleSheet.modalBackgroundColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(self.modalStyle.headerBackgroundColor.CGColor, MLStyleSheetManager.styleSheet.lightGreyColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(self.modalStyle.tintColor.CGColor, MLStyleSheetManager.styleSheet.modalTintColor.CGColor));
	XCTAssertEqual(self.modalStyle.titleFont, [UIFont ml_lightSystemFontOfSize:kMLFontsSizeLarge]);
	XCTAssertTrue(self.modalStyle.showBlurView);
}

@end
