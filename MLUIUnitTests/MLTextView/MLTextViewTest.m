//
// MLTextViewTest.m
// MLUI
//
// Created by MAURO CARREÑO on 5/22/17.
// Copyright © 2017 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <OCMock/OCMArg.h>
#import <UIKit/UIKit.h>
#import "MLTextView.h"
#import "MLGrowingTextViewHandler.h"
#import "MLViewController.h"

@import XCTest;

// Category used to expose the methods of MLGrowingTextViewHandler
@interface MLGrowingTextViewHandler (Test)

@end

// Category used to expose the methods of MLTextViewPlaceholder
@interface MLTextViewPlaceholder (Test)

@property (nonatomic, weak, readwrite) MLTextViewPlaceholder *textViewPlaceholder;
- (void)showPlaceholder:(BOOL)doShow;
- (void)showPlaceholderForText:(NSString *)text;

@end

// Category used to expose the methods of MLTextView
@interface MLTextView (Test)

@property (strong, nonatomic) MLGrowingTextViewHandler *handler;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
- (void)textViewDidChange:(NSNotification *)textViewNotification;

@end

@interface MLTextViewTest : XCTestCase

@end

@implementation MLTextViewTest

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

- (MLTextView *)mlTextView
{
	MLTextView *mlTextView = OCMPartialMock([[MLTextView alloc] init]);
	MLGrowingTextViewHandler *handler = OCMPartialMock([[MLGrowingTextViewHandler alloc] initWithTextView:mlTextView.textView heightConstraint:mlTextView.textViewHeightConstraint]);
	mlTextView.handler = handler;
	return mlTextView;
}

// When there is no text, the placeholder should be shown (alpha=1). When text appears, it should hide (alpha=0).
- (void)testTextViewPlaceholderShowAndHide
{
	// Setup
	MLTextView *mlTextView = [self mlTextView];
	mlTextView.text = @"";
	mlTextView.placeholder = @"Placeholder";

	// Check the calls are made
	OCMVerify([mlTextView.textViewPlaceholder showPlaceholderForText:@""]);
	sleep(1); // Waits the animation
	OCMVerify([mlTextView.textViewPlaceholder setAlpha:1.0]);
	XCTAssertEqual(mlTextView.textViewPlaceholder.alpha, 1.0);

	// Adds some text
	mlTextView.text = @"New text";

	// Check the calls are made
	OCMVerify([mlTextView.textViewPlaceholder showPlaceholderForText:@"New text"]);
	sleep(1); // Waits the animation
	OCMVerify([mlTextView.textViewPlaceholder setAlpha:0.0]);
	XCTAssertEqual(mlTextView.textViewPlaceholder.alpha, 0.0);
}

- (void)testTextViewBasics
{
	// Setup
	MLTextView *mlTextView = [self mlTextView];
	mlTextView.minLines = 1;
	mlTextView.maxLines = 2;
	mlTextView.text = @"Text";
	mlTextView.placeholder = @"Placeholder";

	// It should be flexible by default
	XCTAssertTrue(mlTextView.flexibleSize);

	// If the flexible state changes, styleHasChanged should be called
	mlTextView.flexibleSize = false;
	XCTAssertFalse(mlTextView.flexibleSize);
	OCMVerify([mlTextView styleHasChanged]);

	// The text requested to MLTextView should be the same as the one on the internal TextView
	XCTAssertEqualObjects(mlTextView.text, mlTextView.textView.text);

	// The placeholder requested to MLTextView should be the same as the one on the internal UILabel
	XCTAssertEqualObjects(mlTextView.placeholder, mlTextView.textViewPlaceholder.text);
}

- (void)testTextViewFlexibleMin1Max2
{
	// Setup
	MLTextView *mlTextView = [self mlTextView];
	mlTextView.minLines = 1;
	mlTextView.maxLines = 2;
	mlTextView.flexibleSize = true;
	mlTextView.text = @"";
	mlTextView.placeholder = @"Placeholder";
	[mlTextView styleHasChanged];

	// Save the initial size
	CGFloat initialHeight = mlTextView.textViewHeightConstraint.constant;

	// Add a 1st line of text
	mlTextView.text = @"First";

	// The height should not change (it's the first line)
	XCTAssertEqual(mlTextView.textViewHeightConstraint.constant, initialHeight);

	// Add a 2nd line of text
	mlTextView.text = @"First\nSecond";

	// The height should increase because the max lines = 2
	CGFloat twoLinesHeight = mlTextView.textViewHeightConstraint.constant;
	XCTAssertGreaterThan(twoLinesHeight, initialHeight);

	// Add a 3rd line of text
	mlTextView.text = @"First\nSecond\nThird";

	// The height might increase or not because its on the limit
	CGFloat threeLinesHeight = mlTextView.textViewHeightConstraint.constant;

	// Add a 4th line of text
	mlTextView.text = @"First\nSecond\nThird\nFourth";

	// The height should not change because its already higher than the limit
	CGFloat fourLinesHeight = mlTextView.textViewHeightConstraint.constant;
	XCTAssertEqual(threeLinesHeight, fourLinesHeight);
}

- (void)testTextViewFlexibleMin1Max1
{
	// Setup
	MLTextView *mlTextView = [self mlTextView];
	mlTextView.minLines = 1;
	mlTextView.maxLines = 1;
	mlTextView.flexibleSize = true;
	mlTextView.text = @"";
	mlTextView.placeholder = @"Placeholder";
	[mlTextView styleHasChanged];

	// Save the initial size
	CGFloat initialHeight = mlTextView.textViewHeightConstraint.constant;

	// Add a 1st line of text
	mlTextView.text = @"First";

	// The height should not change (it's the first line)
	XCTAssertEqual(mlTextView.textViewHeightConstraint.constant, initialHeight);

	// Add a 2nd line of text
	mlTextView.text = @"First\nSecond";

	// The height might increase or not because its on the limit
	CGFloat twoLinesHeight = mlTextView.textViewHeightConstraint.constant;
	XCTAssertGreaterThanOrEqual(twoLinesHeight, initialHeight);

	// Add a 3rd line of text
	mlTextView.text = @"First\nSecond\nThird";

	// The height should not change because its already higher than the limit
	CGFloat threeLinesHeight = mlTextView.textViewHeightConstraint.constant;
	XCTAssertEqual(threeLinesHeight, twoLinesHeight);
}

- (void)testTextViewFixed
{
	// Setup
	MLTextView *mlTextView = [self mlTextView];
	mlTextView.text = @"";
	mlTextView.placeholder = @"Placeholder";
	[mlTextView styleHasChanged];

	// Add some text
	mlTextView.text = @"First";

	// Initialy the internal constraint should have a really high priority
	XCTAssertGreaterThan(mlTextView.textViewHeightConstraint.priority, UILayoutPriorityDefaultHigh);

	// The flexible option is turned off
	mlTextView.flexibleSize = false;
	XCTAssertFalse(mlTextView.flexibleSize);
	[mlTextView styleHasChanged];

	// Now the priority should be really small to be easily surpassed by external constraints
	XCTAssertLessThan(mlTextView.textViewHeightConstraint.priority, UILayoutPriorityDefaultLow);
}

- (void)testTextViewSetImposibleValues
{
	MLTextView *mlTextView = [self mlTextView];

	// Min lines cant be less than 1
	mlTextView.minLines = 0;
	XCTAssertEqual(mlTextView.minLines, 1);

	// Max lines neither
	mlTextView.maxLines = 0;
	XCTAssertEqual(mlTextView.maxLines, 1);

	// Min lines cant be heigher than max lines
	mlTextView.minLines = 2;
	XCTAssertEqual(mlTextView.minLines, 2);
	XCTAssertEqual(mlTextView.maxLines, 2);

	// Max lines cant be smaller than min lines
	mlTextView.maxLines = 1;
	XCTAssertEqual(mlTextView.minLines, 2);
	XCTAssertEqual(mlTextView.maxLines, 2);
}

- (void)testTextViewTextDidChangeNotification
{
	// Creates 2 MLTextViews
	MLTextView *mlTextView = [self mlTextView];
	MLTextView *mlTextViewAnother = [self mlTextView];

	OCMStub([mlTextView window]).andReturn(@"Something");
	OCMStub([mlTextViewAnother window]).andReturn(@"Something");

	// Make the MLTextView register to the notifications
	[mlTextView didMoveToWindow];
	[mlTextViewAnother didMoveToWindow];

	// Change the text
	mlTextView.text = @"Text";

	// Simulates the notification
	[[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:mlTextView.textView];

	// Both MLTextViews should receive the notification
	OCMVerify([mlTextView textViewDidChange:OCMOCK_ANY]);
	OCMVerify([mlTextViewAnother textViewDidChange:OCMOCK_ANY]);

	// But only mlTextView should call the text modification in the handler
	OCMVerify([mlTextView.handler setText:@"Text" animated:false]);
	OCMReject([mlTextViewAnother.handler setText:@"Text" animated:false]);
}

- (void)testTextViewTextDidChangeNotificationRemove
{
	// Creates 2 MLTextViews
	MLTextView *mlTextView = [self mlTextView];

	OCMStub([mlTextView window]).andReturn(@"Something");

	// Make the MLTextView register to the notifications
	[mlTextView didMoveToWindow];

	// Simulate the screen leaving
	[mlTextView willMoveToWindow:nil];

	// Change the text
	mlTextView.text = @"Text";

	// Simulates the notification
	[[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:mlTextView.textView];

	// The notification should not be received
	OCMReject([mlTextView textViewDidChange:OCMOCK_ANY]);
	OCMReject([mlTextView.handler setText:OCMOCK_ANY animated:false]);
}

@end
