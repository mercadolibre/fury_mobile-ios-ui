//
// UIFont+MLFontsTest.m
// MLUI
//
// Created by Mauricio Minestrelli on 1/14/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIFont+MLFonts.h"
#import "NSAttributedString+MLFonts.h"
#import "MLStyleSheetTest.h"
#import "MLStyleSheetManager.h"

@interface UIFont_MLFontsTest : XCTestCase

@end

@implementation UIFont_MLFontsTest

- (void)setUp
{
	[super setUp];
	MLStyleSheetManager.styleSheet = [MLStyleSheetTest new];
}

- (void)testMlSystemFontShouldBeEqualToStylesheet
{
    NSString *styleSheetFont = [MLStyleSheetManager.styleSheet regularSystemFontOfSize:12].fontName;
	XCTAssertTrue([[UIFont ml_regularSystemFontOfSize:12].fontName isEqualToString:styleSheetFont]);
}

- (void)testMlBoldSystemFontShouldBeEqualToStylesheet
{
    NSString *styleSheetFont = [MLStyleSheetManager.styleSheet boldSystemFontOfSize:12].fontName;
	XCTAssertTrue([[UIFont ml_boldSystemFontOfSize:12].fontName isEqualToString:styleSheetFont]);
}

- (void)testMediumSystemFontShouldBeEqualToStylesheet
{
    NSString *styleSheetFont = [MLStyleSheetManager.styleSheet mediumSystemFontOfSize:12].fontName;
	XCTAssertTrue([[UIFont ml_mediumSystemFontOfSize:12].fontName isEqualToString:styleSheetFont]);
}

- (void)testBlackSystemFontShouldBeEqualToStylesheet
{
    NSString *styleSheetFont = [MLStyleSheetManager.styleSheet blackSystemFontOfSize:12].fontName;
	XCTAssertTrue([[UIFont ml_blackSystemFontOfSize:12].fontName isEqualToString:styleSheetFont]);
}

- (void)testSemiboldSystemFontShouldBeEqualToStylesheet
{
    NSString *styleSheetFont = [MLStyleSheetManager.styleSheet semiboldSystemFontOfSize:12].fontName;
	XCTAssertTrue([[UIFont ml_semiboldSystemFontOfSize:12].fontName isEqualToString:styleSheetFont]);
}

- (void)testLightSystemFontShouldBeEqualToStylesheet
{
    NSString *styleSheetFont = [MLStyleSheetManager.styleSheet lightSystemFontOfSize:12].fontName;
	XCTAssertTrue([[UIFont ml_lightSystemFontOfSize:12].fontName isEqualToString:styleSheetFont]);
}

- (void)testThinSystemFontShouldBeEqualToStylesheet
{
    NSString *styleSheetFont = [MLStyleSheetManager.styleSheet thinSystemFontOfSize:12].fontName;
	XCTAssertTrue([[UIFont ml_thinSystemFontOfSize:12].fontName isEqualToString:styleSheetFont]);
}

- (void)testExtraboldSystemFontShouldBeEqualToStylesheet
{
    NSString *styleSheetFont = [MLStyleSheetManager.styleSheet extraboldSystemFontOfSize:12].fontName;
	XCTAssertTrue([[UIFont ml_extraboldSystemFontOfSize:12].fontName isEqualToString:styleSheetFont]);
}

- (void)testXXLARGESystemFontShouldBeSanFrancisco
{
	XCTAssertEqual([UIFont systemFontOfSize:kMLFontsSizeXXLarge].pointSize, 32.0f);
}

- (void)testXLARGELightSystemFontShouldBeSanFrancisco
{
	XCTAssertEqual([UIFont systemFontOfSize:kMLFontsSizeXLarge].pointSize, 24.0f);
}

- (void)testLARGELightSystemFontShouldBeSanFrancisco
{
	XCTAssertEqual([UIFont systemFontOfSize:kMLFontsSizeLarge].pointSize, 20.0f);
}

- (void)testMEDIUMLightSystemFontShouldBeSanFrancisco
{
	XCTAssertEqual([UIFont systemFontOfSize:kMLFontsSizeMedium].pointSize, 18.0f);
}

- (void)testSMALLLightSystemFontShouldBeSanFrancisco
{
	XCTAssertEqual([UIFont systemFontOfSize:kMLFontsSizeSmall].pointSize, 16.0f);
}

- (void)testXSMALLLightSystemFontShouldBeSanFrancisco
{
	XCTAssertEqual([UIFont systemFontOfSize:kMLFontsSizeXSmall].pointSize, 14.0f);
}

- (void)testXXSMALLLightSystemFontShouldBeSanFrancisco
{
	XCTAssertEqual([UIFont systemFontOfSize:kMLFontsSizeXXSmall].pointSize, 12.0f);
}

- (void)testSystemFontWithWeightShouldReturnThinFont
{
	UIFont *target = [UIFont ml_systemFontWithWeight:-0.8f size:12.f];
	UIFont *expected = [UIFont ml_thinSystemFontOfSize:12.f];

	XCTAssertEqualObjects(target.fontName, expected.fontName);
	XCTAssertEqual(target.pointSize, expected.pointSize);
}

- (void)testSystemFontWithWeightShouldReturnLightFont
{
	UIFont *target = [UIFont ml_systemFontWithWeight:-0.3f size:12.f];
	UIFont *expected = [UIFont ml_lightSystemFontOfSize:12.f];

	XCTAssertEqualObjects(target.fontName, expected.fontName);
	XCTAssertEqual(target.pointSize, expected.pointSize);
}

- (void)testSystemFontWithWeightShouldReturnRegularFont
{
	UIFont *target = [UIFont ml_systemFontWithWeight:0.f size:12.f];
	UIFont *expected = [UIFont ml_regularSystemFontOfSize:12.f];

	XCTAssertEqualObjects(target.fontName, expected.fontName);
	XCTAssertEqual(target.pointSize, expected.pointSize);
}

- (void)testSystemFontWithWeightShouldReturnMediumFont
{
	UIFont *target = [UIFont ml_systemFontWithWeight:0.25f size:12.f];
	UIFont *expected = [UIFont ml_mediumSystemFontOfSize:12.f];

	XCTAssertEqualObjects(target.fontName, expected.fontName);
	XCTAssertEqual(target.pointSize, expected.pointSize);
}

- (void)testSystemFontWithWeightShouldReturnSemiboldFont
{
	UIFont *target = [UIFont ml_systemFontWithWeight:0.35f size:12.f];
	UIFont *expected = [UIFont ml_semiboldSystemFontOfSize:12.f];

	XCTAssertEqualObjects(target.fontName, expected.fontName);
	XCTAssertEqual(target.pointSize, expected.pointSize);
}

- (void)testSystemFontWithWeightShouldReturnBoldFont
{
	UIFont *target = [UIFont ml_systemFontWithWeight:0.43f size:12.f];
	UIFont *expected = [UIFont ml_boldSystemFontOfSize:12.f];

	XCTAssertEqualObjects(target.fontName, expected.fontName);
	XCTAssertEqual(target.pointSize, expected.pointSize);
}

- (void)testSystemFontWithWeightShouldReturnExtraboldFont
{
	UIFont *target = [UIFont ml_systemFontWithWeight:0.6f size:12.f];
	UIFont *expected = [UIFont ml_extraboldSystemFontOfSize:12.f];

	XCTAssertEqualObjects(target.fontName, expected.fontName);
	XCTAssertEqual(target.pointSize, expected.pointSize);
}

- (void)testSystemFontWithWeightShouldReturnBlackFont
{
	UIFont *target = [UIFont ml_systemFontWithWeight:0.7f size:12.f];
	UIFont *expected = [UIFont ml_blackSystemFontOfSize:12.f];

	XCTAssertEqualObjects(target.fontName, expected.fontName);
	XCTAssertEqual(target.pointSize, expected.pointSize);
}

- (void)testSystemFontFromFontShouldReturnSanFrancisco
{
	UIFont *originalFont = [UIFont fontWithName:@"Helvetica" size:12];
	UIFont *expected = [UIFont ml_regularSystemFontOfSize:12];
	UIFont *target = [UIFont ml_systemFontFromFont:originalFont];

	XCTAssertEqualObjects(target, expected);
}

- (void)testLabelShouldBeCreatedWithRegularFont
{
	UILabel *label = [[UILabel alloc] init];
	UIFont *expectedFont = [UIFont ml_regularSystemFontOfSize:12.f];

	XCTAssertEqualObjects(label.font.fontName, expectedFont.fontName);
}

- (void)testButtonShouldBeCreatedWithRegularFont
{
	UIButton *button = [[UIButton alloc] init];
	UIFont *expectedFont = [UIFont ml_regularSystemFontOfSize:12.f];

	XCTAssertEqualObjects(button.titleLabel.font.fontName, expectedFont.fontName);
}

- (void)testAttributedStringByReplacingFontWithSystemFontShouldReplaceFont
{
	NSString *string = @"This is a test";

	NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:string];
	[expected addAttribute:NSFontAttributeName value:[UIFont ml_regularSystemFontOfSize:12] range:NSMakeRange(0, string.length / 2)];
	[expected addAttribute:NSFontAttributeName value:[UIFont ml_regularSystemFontOfSize:16] range:NSMakeRange(string.length / 2, string.length / 2)];

	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
	[attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:12] range:NSMakeRange(0, string.length / 2)];
	[attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:16] range:NSMakeRange(string.length / 2, string.length / 2)];

	NSAttributedString *target = [attributedString ml_attributedStringByReplacingFontWithSystemFont];

	XCTAssertEqualObjects(target, expected);
}

- (void)testAttributedStringByReplacingFontWithSystemFontShouldNotCrashWhenIsEmpty
{
	NSAttributedString *expected = [[NSAttributedString alloc] initWithString:@""];
	NSAttributedString *target = [expected ml_attributedStringByReplacingFontWithSystemFont];
	XCTAssertEqualObjects(target, expected);
}

@end
