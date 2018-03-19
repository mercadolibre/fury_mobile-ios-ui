//
// MLSpinnerTest.m
// MLUI
//
// Created by Julieta Puente on 26/4/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MLSpinner.h"
#import "MLStyleSheetManager.h"
#import <OCMock/OCMock.h>

@interface MLSpinner (Test)
@property (nonatomic) CGFloat diameter;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *endColor;
@property (nonatomic, strong) UIColor *startColor;
@property (nonatomic) BOOL allowsText;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, copy) NSString *spinnerText;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spinnerLabelVerticalSpacing;

- (void)setUpLabel;
@end

@interface MLSpinnerTest : XCTestCase

@end

@implementation MLSpinnerTest

- (void)setUp
{
	[super setUp];
}

- (void)tearDown
{
	[super tearDown];
}

// Test init

- (void)testInitWithStyle_styleBlueBig_returnMLSpinnerWithCorrectConfiguration
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
	MLSpinner *spinner = [[MLSpinner alloc] initWithStyle:MLSpinnerStyleBlueBig];
#pragma clang diagnostic pop

	XCTAssertEqual(spinner.diameter, 60);
	XCTAssertEqual(spinner.lineWidth, 3);
	XCTAssertTrue(CGColorEqualToColor(spinner.endColor.CGColor, MLStyleSheetManager.styleSheet.secondaryColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(spinner.startColor.CGColor, MLStyleSheetManager.styleSheet.primaryColor.CGColor));
	XCTAssertTrue(spinner.allowsText);
}

- (void)testInitWithStyle_styleWhiteBig_returnMLSpinnerWithCorrectConfiguration
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
	MLSpinner *spinner = [[MLSpinner alloc] initWithStyle:MLSpinnerStyleWhiteBig];
#pragma clang diagnostic pop

	XCTAssertEqual(spinner.diameter, 60);
	XCTAssertEqual(spinner.lineWidth, 3);
	XCTAssertTrue(CGColorEqualToColor(spinner.endColor.CGColor, MLStyleSheetManager.styleSheet.secondaryColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(spinner.startColor.CGColor, MLStyleSheetManager.styleSheet.whiteColor.CGColor));
	XCTAssertTrue(spinner.allowsText);
}

- (void)testInitWithStyle_styleBlueSmall_returnMLSpinnerWithCorrectConfiguration
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
	MLSpinner *spinner = [[MLSpinner alloc] initWithStyle:MLSpinnerStyleBlueSmall];
#pragma clang diagnostic pop

	XCTAssertEqual(spinner.diameter, 20);
	XCTAssertEqual(spinner.lineWidth, 2);
	XCTAssertTrue(CGColorEqualToColor(spinner.endColor.CGColor, MLStyleSheetManager.styleSheet.secondaryColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(spinner.startColor.CGColor, MLStyleSheetManager.styleSheet.secondaryColor.CGColor));
	XCTAssertFalse(spinner.allowsText);
}

- (void)testInitWithStyle_styleWhiteSmall_returnMLSpinnerWithCorrectConfiguration
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
	MLSpinner *spinner = [[MLSpinner alloc] initWithStyle:MLSpinnerStyleWhiteSmall];
#pragma clang diagnostic pop

	XCTAssertEqual(spinner.diameter, 20);
	XCTAssertEqual(spinner.lineWidth, 2);
	XCTAssertTrue(CGColorEqualToColor(spinner.endColor.CGColor, MLStyleSheetManager.styleSheet.whiteColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(spinner.startColor.CGColor, MLStyleSheetManager.styleSheet.whiteColor.CGColor));
	XCTAssertFalse(spinner.allowsText);
}

// Test config

- (void)testSetupWithConfigSizeBig
{
	MLSpinnerConfig *spinnerConfig = [[MLSpinnerConfig alloc] initWithSize:MLSpinnerSizeBig primaryColor:[UIColor redColor] secondaryColor:[UIColor whiteColor]];

	MLSpinner *spinner = [[MLSpinner alloc] initWithConfig:spinnerConfig text:@"Loading"];

	XCTAssertEqual(spinner.diameter, 60);
	XCTAssertEqual(spinner.lineWidth, 3);
	XCTAssertTrue(CGColorEqualToColor(spinner.startColor.CGColor, [UIColor redColor].CGColor));
	XCTAssertTrue(CGColorEqualToColor(spinner.endColor.CGColor, [UIColor whiteColor].CGColor));
	XCTAssertTrue(spinner.allowsText);
}

- (void)testSetupWithConfigSizeSmall
{
	MLSpinnerConfig *spinnerConfig = [[MLSpinnerConfig alloc] initWithSize:MLSpinnerSizeSmall primaryColor:[UIColor redColor] secondaryColor:[UIColor whiteColor]];

	MLSpinner *spinner = [[MLSpinner alloc] initWithConfig:spinnerConfig text:@"Loading"];

	XCTAssertEqual(spinner.diameter, 20);
	XCTAssertEqual(spinner.lineWidth, 2);
	XCTAssertTrue(CGColorEqualToColor(spinner.startColor.CGColor, [UIColor redColor].CGColor));
	XCTAssertTrue(CGColorEqualToColor(spinner.endColor.CGColor, [UIColor whiteColor].CGColor));
	XCTAssertFalse(spinner.allowsText);
}

- (void)testSetUpForStyleBlueBig
{
	MLSpinner *spinner = [[MLSpinner alloc]init];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
	[spinner setStyle:MLSpinnerStyleBlueBig];
#pragma clang diagnostic pop

	XCTAssertEqual(spinner.diameter, 60);
	XCTAssertEqual(spinner.lineWidth, 3);
	XCTAssertTrue(CGColorEqualToColor(spinner.endColor.CGColor, MLStyleSheetManager.styleSheet.secondaryColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(spinner.startColor.CGColor, MLStyleSheetManager.styleSheet.primaryColor.CGColor));
	XCTAssertTrue(spinner.allowsText);
}

- (void)testSetUpForStyleWhiteBig
{
	MLSpinner *spinner = [[MLSpinner alloc]init];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
	[spinner setStyle:MLSpinnerStyleWhiteBig];
#pragma clang diagnostic pop

	XCTAssertEqual(spinner.diameter, 60);
	XCTAssertEqual(spinner.lineWidth, 3);
	XCTAssertTrue(CGColorEqualToColor(spinner.endColor.CGColor, MLStyleSheetManager.styleSheet.secondaryColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(spinner.startColor.CGColor, MLStyleSheetManager.styleSheet.whiteColor.CGColor));
	XCTAssertTrue(spinner.allowsText);
}

- (void)testSetUpForStyleBlueSmall
{
	MLSpinner *spinner = [[MLSpinner alloc]init];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
	[spinner setStyle:MLSpinnerStyleBlueSmall];
#pragma clang diagnostic pop

	XCTAssertEqual(spinner.diameter, 20);
	XCTAssertEqual(spinner.lineWidth, 2);
	XCTAssertTrue(CGColorEqualToColor(spinner.endColor.CGColor, MLStyleSheetManager.styleSheet.secondaryColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(spinner.startColor.CGColor, MLStyleSheetManager.styleSheet.secondaryColor.CGColor));
	XCTAssertFalse(spinner.allowsText);
}

- (void)testSetUpForStyleWhiteSmall
{
	MLSpinner *spinner = [[MLSpinner alloc]init];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
	[spinner setStyle:MLSpinnerStyleWhiteSmall];
#pragma clang diagnostic pop

	XCTAssertEqual(spinner.diameter, 20);
	XCTAssertEqual(spinner.lineWidth, 2);
	XCTAssertTrue(CGColorEqualToColor(spinner.endColor.CGColor, MLStyleSheetManager.styleSheet.whiteColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(spinner.startColor.CGColor, MLStyleSheetManager.styleSheet.whiteColor.CGColor));
	XCTAssertFalse(spinner.allowsText);
}

- (void)testSetUpLabelDoesNotAllowTextShowHideLabel
{
	MLSpinner *spinner = [[MLSpinner alloc]init];
	spinner.allowsText = NO;

	[spinner setUpLabel];

	XCTAssertEqual(spinner.spinnerLabelVerticalSpacing.constant, 0);
}

- (void)testSetUpLabelWithTextButDoesNotAllowTextShowHideLabel
{
	MLSpinner *spinner = [[MLSpinner alloc]init];
	spinner.allowsText = NO;
	spinner.spinnerText = @"prueba";

	[spinner setUpLabel];

	XCTAssertEqual(spinner.spinnerLabelVerticalSpacing.constant, 0);
}

- (void)testSetUpLabelShouldShowText
{
	MLSpinner *spinner = [[MLSpinner alloc]init];
	spinner.allowsText = YES;
	spinner.spinnerText = @"prueba";

	[spinner setUpLabel];

	XCTAssertEqual(spinner.spinnerLabelVerticalSpacing.constant, 32);
}

- (void)testSpinnerInitHidden
{
	MLSpinner *spinner = [[MLSpinner alloc] init];

	XCTAssertEqual(spinner.isHidden, YES);
}

- (void)testSpinnerShows
{
	MLSpinner *spinner = [[MLSpinner alloc] init];

	[spinner showSpinner];

	XCTAssertEqual(spinner.isHidden, NO);
}

- (void)testSpinnerSetText
{
	MLSpinner *spinner = [[MLSpinner alloc] init];

	[spinner setText:@"test"];

	XCTAssertTrue([spinner.spinnerText isEqualToString:@"test"]);
}

@end
