//
// MLUIActionButtonTest.m
// MLUI
//
// Created by Juan José Barrera on 1/14/15.
// Copyright (c) 2015 MercadoLibre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MLUIActionButton.h"
#import "UIImage+Misc.h"

@interface MLUIActionButtonTest : XCTestCase

@end

@implementation MLUIActionButtonTest

- (void)setUp
{
	[super setUp];
}

- (void)tearDown
{
	[super tearDown];
}

- (void)testInitWithFixHeigthConstraint
{
	MLUIActionButton *button = [[MLUIActionButton alloc] initWithFixHeigthConstraintAndStyle:MLUIActionButtonStylePrimary];

	XCTAssertNotNil(button.heightConstraint);
	XCTAssert(button.heightConstraint.firstAttribute == NSLayoutAttributeHeight);
	XCTAssert(button.heightConstraint.constant == 44);
}

- (void)testInitWithStyle
{
	MLUIActionButton *button = [[MLUIActionButton alloc] initWithStyle:MLUIActionButtonStylePrimary];

	XCTAssert([[button constraints] count] == 0);
	XCTAssert(button.frame.origin.x == 0);
	XCTAssert(button.frame.origin.y == 0);
	XCTAssert(button.frame.size.width == 0);
	XCTAssert(button.frame.size.height == 0);
}

- (void)testInitWithFrame
{
	MLUIActionButton *button = [[MLUIActionButton alloc] initWithFrame:CGRectMake(0, 5, 100, 150) andStyle:MLUIActionButtonStylePrimary];

	XCTAssert([[button constraints] count] == 0);
	XCTAssert(button.frame.origin.x == 0);
	XCTAssert(button.frame.origin.y == 5);
	XCTAssert(button.frame.size.width == 100);
	XCTAssert(button.frame.size.height == 150);
}

- (void)testSetupForStyle
{
	MLUIActionButton *button = [[MLUIActionButton alloc] initWithFixHeigthConstraintAndStyle:MLUIActionButtonStylePrimary];
	XCTAssert(button.buttonStyle == MLUIActionButtonStylePrimary);

	[button setupForStyle:MLUIActionButtonStyleSecondary];
	XCTAssert(button.buttonStyle == MLUIActionButtonStyleSecondary);

	[button setupForStyle:MLUIActionButtonStyleTertiary];
	XCTAssert(button.buttonStyle == MLUIActionButtonStyleTertiary);

	[button setupForStyle:MLUIActionButtonStyleDisabled];
	XCTAssert(button.buttonStyle == MLUIActionButtonStyleDisabled);

	[button setupForStyle:MLUIActionButtonStyleOnlyText];
	XCTAssert(button.buttonStyle == MLUIActionButtonStyleOnlyText);
}

- (void)testActiveSimulatedDisabled
{
	MLUIActionButton *button = [[MLUIActionButton alloc] initWithFixHeigthConstraintAndStyle:MLUIActionButtonStylePrimary];
	XCTAssert(button.buttonStyle == MLUIActionButtonStylePrimary);

	[button activeSimulatedDisabled];
	XCTAssert(button.buttonStyle == MLUIActionButtonStyleDisabled);
}

- (UIImage *)imageFromView:(UIView *)view
{
	UIGraphicsBeginImageContext(view.bounds.size);
	[view.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}

- (void)testThatSetButtonStyleAfterInitIsTheSameThatSetStyleAtInit
{
	CGRect frame = CGRectMake(0, 0, 100, 44);

	// Create a button and set style after the init
	MLUIActionButton *button1 = [[MLUIActionButton alloc] initWithFrame:frame];
	[button1 setTitle:@"Test" forState:UIControlStateNormal];
	button1.buttonStyle = MLUIActionButtonStylePrimary;

	// Create a button and set style at init
	MLUIActionButton *button2 = [[MLUIActionButton alloc] initWithFrame:frame andStyle:MLUIActionButtonStylePrimary];
	[button2 setTitle:@"Test" forState:UIControlStateNormal];

	// Transform buttons on images to compare
	UIImage *imageButton1 = [self imageFromView:button1];
	UIImage *imageButton2 = [self imageFromView:button2];

	XCTAssertTrue([imageButton1 ml_isEqualToImage:imageButton2]);
}

@end
