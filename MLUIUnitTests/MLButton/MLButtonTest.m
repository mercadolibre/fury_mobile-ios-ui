//
// MLButtonTest.m
// MLUI
//
// Created by Julieta Puente on 29/1/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "MLButton.h"
#import "MLStyleSheetManager.h"
#import "UIFont+MLFonts.h"
#import "MLButtonStylesFactory.h"
#import "MLButtonConfig.h"
#import "UIImage+Misc.h"

@interface MLButtonTest : XCTestCase

@end

@interface MLButton (Test)
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) CALayer *backgroundLayer;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, assign) CGFloat verticalPadding;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) NSArray <NSLayoutConstraint *> *verticalPaddingConstraints;

- (void)updateLookAndFeel;
- (void)updateButtonIcon:(UIImage *_Nullable)image;
- (void)setupIconView;
- (void)setup;

@end

@implementation MLButtonTest

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

- (void)testUpdateLookAndFeelForStylePrimaryAction
{
	MLButton *button = [[MLButton alloc]init];
	button.label = [[UILabel alloc]init];
	button.style = MLButtonStylePrimaryAction;
	button.backgroundLayer = [CALayer layer];
	button.enabled = YES;
	button.highlighted = NO;

	[button updateLookAndFeel];
	XCTAssertEqual(button.label.font, [UIFont ml_regularSystemFontOfSize:kMLFontsSizeMedium]);
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.backgroundColor, MLStyleSheetManager.styleSheet.secondaryColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.borderColor, MLStyleSheetManager.styleSheet.secondaryColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.label.textColor.CGColor, MLStyleSheetManager.styleSheet.whiteColor.CGColor));
	XCTAssertEqual(button.backgroundLayer.cornerRadius, 4.0f);
}

- (void)testUpdateLookAndFeelForStylePrimaryActionHighlighted
{
	MLButton *button = [[MLButton alloc]init];
	button.style = MLButtonStylePrimaryAction;
	button.backgroundLayer = [CALayer layer];
	button.enabled = YES;
	button.highlighted = YES;

	[button updateLookAndFeel];
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.backgroundColor, MLStyleSheetManager.styleSheet.secondaryColorPressed.CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.borderColor, MLStyleSheetManager.styleSheet.secondaryColorPressed.CGColor));
}

- (void)testUpdateLookAndFeelForStylePrimaryActionDisabled
{
	MLButton *button = [[MLButton alloc]init];
	button.style = MLButtonStylePrimaryAction;
	button.backgroundLayer = [CALayer layer];
	button.enabled = NO;

	[button updateLookAndFeel];
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.backgroundColor, MLStyleSheetManager.styleSheet.secondaryColorDisabled.CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.borderColor, MLStyleSheetManager.styleSheet.secondaryColorDisabled.CGColor));
}

- (void)testUpdateLookAndFeelForStyleSecondaryAction
{
	MLButton *button = [[MLButton alloc]init];
	button.label = [[UILabel alloc]init];
	button.style = MLButtonStyleSecondaryAction;
	button.backgroundLayer = [CALayer layer];
	button.enabled = YES;
	button.highlighted = NO;

	[button updateLookAndFeel];
	XCTAssertEqual(button.label.font, [UIFont ml_regularSystemFontOfSize:kMLFontsSizeMedium]);
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.backgroundColor, [UIColor clearColor].CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.borderColor, MLStyleSheetManager.styleSheet.secondaryColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.label.textColor.CGColor, MLStyleSheetManager.styleSheet.secondaryColor.CGColor));
	XCTAssertEqual(button.backgroundLayer.cornerRadius, 4.0f);
}

- (void)testUpdateLookAndFeelForStyleSecondaryActionHighlighted
{
	MLButton *button = [[MLButton alloc]init];
	button.style = MLButtonStyleSecondaryAction;
	button.backgroundLayer = [CALayer layer];
	button.label = [[UILabel alloc]init];
	button.enabled = YES;
	button.highlighted = YES;

	[button updateLookAndFeel];
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.backgroundColor, MLStyleSheetManager.styleSheet.midGreyColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.borderColor, MLStyleSheetManager.styleSheet.secondaryColorPressed.CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.label.textColor.CGColor, MLStyleSheetManager.styleSheet.secondaryColorPressed.CGColor));
}

- (void)testUpdateLookAndFeelForStyleSecondaryActionDisabled
{
	MLButton *button = [[MLButton alloc]init];
	button.style = MLButtonStyleSecondaryAction;
	button.label = [[UILabel alloc]init];
	button.backgroundLayer = [CALayer layer];
	button.enabled = NO;

	[button updateLookAndFeel];
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.backgroundColor, [UIColor clearColor].CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.borderColor, MLStyleSheetManager.styleSheet.secondaryColorDisabled.CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.label.textColor.CGColor, MLStyleSheetManager.styleSheet.secondaryColorDisabled.CGColor));
}

- (void)testUpdateLookAndFeelForStylePrimaryOption
{
	MLButton *button = [[MLButton alloc]init];
	button.style = MLButtonStylePrimaryOption;
	button.backgroundLayer = [CALayer layer];
	button.label = [[UILabel alloc]init];
	button.enabled = YES;
	button.highlighted = NO;

	[button updateLookAndFeel];
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.backgroundColor, UIColor.clearColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.borderColor, UIColor.clearColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.label.textColor.CGColor, MLStyleSheetManager.styleSheet.secondaryColor.CGColor));
}

- (void)testUpdateLookAndFeelForStylePrimaryOptionHighlighted
{
	MLButton *button = [[MLButton alloc]init];
	button.style = MLButtonStylePrimaryOption;
	button.backgroundLayer = [CALayer layer];
	button.label = [[UILabel alloc]init];
	button.enabled = YES;
	button.highlighted = YES;

	[button updateLookAndFeel];
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.backgroundColor, MLStyleSheetManager.styleSheet.midGreyColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.borderColor, UIColor.clearColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.label.textColor.CGColor, MLStyleSheetManager.styleSheet.secondaryColorPressed.CGColor));
}

- (void)testUpdateLookAndFeelForStylePrimaryOptionDisabled
{
	MLButton *button = [[MLButton alloc]init];
	button.style = MLButtonStylePrimaryOption;
	button.label = [[UILabel alloc]init];
	button.backgroundLayer = [CALayer layer];
	button.enabled = NO;

	[button updateLookAndFeel];
	XCTAssertEqual(button.label.font, [UIFont ml_regularSystemFontOfSize:kMLFontsSizeMedium]);
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.backgroundColor, UIColor.clearColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.borderColor, UIColor.clearColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.label.textColor.CGColor, MLStyleSheetManager.styleSheet.secondaryColorDisabled.CGColor));
}

- (void)testUpdateLookAndFeelForStyleSecondaryOption
{
	MLButton *button = [[MLButton alloc]init];
	button.label = [[UILabel alloc]init];
	button.style = MLButtonStyleSecondaryOption;
	button.backgroundLayer = [CALayer layer];
	button.enabled = YES;
	button.highlighted = NO;

	[button updateLookAndFeel];
	XCTAssertEqual(button.label.font, [UIFont ml_regularSystemFontOfSize:kMLFontsSizeMedium]);
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.backgroundColor, UIColor.clearColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.borderColor, UIColor.clearColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.label.textColor.CGColor, MLStyleSheetManager.styleSheet.greyColor.CGColor));
}

- (void)testUpdateLookAndFeelForStyleSecondaryOptionHighlighted
{
	MLButton *button = [[MLButton alloc]init];
	button.style = MLButtonStyleSecondaryOption;
	button.label = [[UILabel alloc]init];
	button.backgroundLayer = [CALayer layer];
	button.enabled = YES;
	button.highlighted = YES;

	[button updateLookAndFeel];
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.backgroundColor, [MLStyleSheetManager.styleSheet.blackColor colorWithAlphaComponent:0.1].CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.borderColor, UIColor.clearColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.label.textColor.CGColor, MLStyleSheetManager.styleSheet.greyColor.CGColor));
}

- (void)testUpdateLookAndFeelForStyleSecondaryOptionDisabled
{
	MLButton *button = [[MLButton alloc]init];
	button.style = MLButtonStyleSecondaryOption;
	button.backgroundLayer = [CALayer layer];
	button.label = [[UILabel alloc]init];
	button.enabled = NO;

	[button updateLookAndFeel];
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.backgroundColor, UIColor.clearColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.backgroundLayer.borderColor, UIColor.clearColor.CGColor));
	XCTAssertTrue(CGColorEqualToColor(button.label.textColor.CGColor, MLStyleSheetManager.styleSheet.lightGreyColor.CGColor));
}

- (void)testUpdateLookAndFeel_shouldUpdateIconView
{
	// Given
	MLButton *button = [[MLButton alloc]init];
	button.style = MLButtonStyleSecondaryOption;
	button.iconImage = [UIImage ml_imageWithColor:UIColor.redColor];
	// When
	[button updateLookAndFeel];
	// Then
	XCTAssertNotNil(button.iconView.image);
}

- (void)testSetButtonTitleNil
{
	MLButton *button = [[MLButton alloc] init];
	button.buttonTitle = nil;
	XCTAssertEqualObjects(button.buttonTitle, @"");
}

- (void)testSetButtonIcon_shouldAddIconView
{
	// Given
	MLButton *button = [[MLButton alloc] init];
	UIImage *redImage = [UIImage ml_imageWithColor:UIColor.redColor];
	// When
	[button setButtonIcon:redImage];
	// Then
	XCTAssertEqual(button.contentView.subviews.count, 2);
	XCTAssertNotNil(button.iconView.image);
}

- (void)testUpdateButtonIcon_shouldAddView_whenImageIsNotNil
{
	// Given
	MLButton *button = [[MLButton alloc] init];
	UIImage *redImage = [UIImage ml_imageWithColor:UIColor.redColor];
	// When
	XCTAssertEqual(button.contentView.subviews.count, 1);// Lable
	[button updateButtonIcon:redImage];
	// Then
	XCTAssertEqual(button.iconView.image, redImage);
	XCTAssertEqual(button.contentView.subviews.count, 2);// Lable+image
}

- (void)testUpdateButtonIcon_shouldRemoveView_whenImageIsNil
{
	// Given
	MLButton *button = [[MLButton alloc] init];
	[button setupIconView];
	// When
	XCTAssertEqual(button.contentView.subviews.count, 2);// Lable+image
	[button updateButtonIcon:nil];
	// Then
	XCTAssertEqual(button.contentView.subviews.count, 1);// label
	XCTAssertNil(button.iconView.image);
}

- (void)testContentView_shouldBeSetupOnInit
{
	// When
	MLButton *button = [[MLButton alloc] init];
	// Then
	XCTAssertEqualObjects(button.contentView.superview, button);
	XCTAssertEqualObjects(button.label.superview, button.contentView);
	XCTAssertEqual(button.contentView.subviews.count, 1);// Only the label
	XCTAssertNil(button.iconView.superview);
}

- (void)testSetupIconView_shouldAddIconView
{
	// Given
	MLButton *button = [[MLButton alloc] init];
	// When
	[button setupIconView];
	// Then
	XCTAssertEqualObjects(button.iconView.superview, button.contentView);
	XCTAssertEqualObjects(button.label.superview, button.contentView);
	XCTAssertEqual(button.contentView.subviews.count, 2);// Lable+image
}

- (void)testDefaultInit_shouldHaveVerticalPaddingAndFontSize
{
	// When
	MLButton *button = [[MLButton alloc] init];
	[button setup];

	// Then
	XCTAssertEqual(button.verticalPadding, 15.0f);
	XCTAssertEqual(button.fontSize, kMLFontsSizeMedium);
}

- (void)testSetupWithSmallSizeConfig_shouldSetSmallVerticalPadding
{
	// when
	MLButton *button = [[MLButton alloc] initWithConfig:[MLButtonStylesFactory configForButtonType:MLButtonTypePrimaryAction withSize:MLButtonSizeSmall]];
	// Then
	XCTAssertEqual(button.verticalPadding, 11.0f);
	XCTAssertEqual(button.fontSize, kMLFontsSizeXSmall);
}

- (void)testConstraintSetupwithSmallSize
{
	// when
	MLButton *button = [[MLButton alloc] initWithConfig:[MLButtonStylesFactory configForButtonType:MLButtonTypePrimaryAction withSize:MLButtonSizeSmall]];

	// Then
	for (NSLayoutConstraint *constraint in  button.verticalPaddingConstraints) {
		XCTAssertEqual(constraint.constant, 11.0f);
	}
}

- (void)testConstraintSetupwithLargeSize
{
	// when
	MLButton *button = [[MLButton alloc] initWithConfig:[MLButtonStylesFactory configForButtonType:MLButtonTypePrimaryAction withSize:MLButtonSizeLarge]];

	// Then
	for (NSLayoutConstraint *constraint in  button.verticalPaddingConstraints) {
		XCTAssertEqual(constraint.constant, 15.0f);
	}
}

@end
