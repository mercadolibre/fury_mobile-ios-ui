//
// MLUISnackBarViewTest.m
// MLUI
//
// Created by Sebastián Bravo on 21/7/15.
// Copyright (c) 2015 MercadoLibre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "MLUISnackBarView.h"
#import "UIViewController+SnackBar.h"

@interface MLUISnackBarView ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@interface MLUISnackBarViewTest : XCTestCase

@end

@implementation MLUISnackBarViewTest

- (void)testSetMessageSnackBarView
{
	MLUISnackBarView *snackBar = [MLUISnackBarView snackBar:MLSnackBarDurationNone];

	[snackBar setMessage:@"Message test"];

	XCTAssertEqualObjects(snackBar.textLabel.text, @"Message test");
}

- (void)testPresentSnackBar
{
	UIViewController *controller = [[UIViewController alloc] initWithNibName:nil bundle:nil];

	MLUISnackBarView *snackBar = [MLUISnackBarView snackBar:MLSnackBarDurationNone];
	[controller ml_presentSnackBar:snackBar animated:YES];

	XCTAssertTrue(controller.view.subviews.count == 1);
	XCTAssertTrue(controller.ml_snackBarsArray.count == 1);
	XCTAssertTrue(controller.view.subviews[0] == snackBar);

	MLUISnackBarView *snackBar2 = [MLUISnackBarView snackBar:MLSnackBarDurationNone];

	[controller ml_presentSnackBar:snackBar2 animated:YES];

	XCTAssertTrue(controller.view.subviews.count == 1);
	XCTAssertTrue(controller.ml_snackBarsArray.count == 1);
	XCTAssertTrue(controller.view.subviews[0] == snackBar2);
}

- (void)testDismissSnackbars
{
	MLUISnackBarView *snackBar = [MLUISnackBarView snackBar:MLSnackBarDurationNone];

	UIViewController *controller = [[UIViewController alloc] initWithNibName:nil bundle:nil];

	[controller ml_presentSnackBar:snackBar animated:YES];

	XCTAssertTrue(controller.view.subviews.count == 1);
	XCTAssertTrue(controller.ml_snackBarsArray.count == 1);
	XCTAssertTrue(controller.view.subviews[0] == snackBar);

	[controller ml_dismissSnackBar:snackBar animated:NO];

	XCTAssertTrue(controller.view.subviews.count == 0);
	XCTAssertTrue(controller.ml_snackBarsArray.count == 0);
}

@end
