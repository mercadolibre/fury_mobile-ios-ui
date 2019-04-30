//
// MLSnackbarTest.m
// MLUI
//
// Created by Julieta Puente on 4/3/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MLSnackbar.h"
#import "UIFont+MLFonts.h"
#import <OCMock/OCMock.h>

@interface MLSnackbar (Test)
@property (nonatomic) BOOL isShowingSnackbar;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
- (void)setUpSnackbarWithTitle:(NSString *)title actionTitle:(NSString *)buttonTitle actionBlock:(void (^)())actionBlock type:(MLSnackbarType *)type duration:(MLSnackbarDuration)duration dismissGestureEnabled:(BOOL)dismissGestureEnabled dismissBlock:(MLSnackbarDismissBlock)dismissBlock;
- (long)durationInMilliseconds:(MLSnackbarDuration)duration;
- (void)disappearAnimation:(MLSnackbarDismissCause)cause;
- (void)removeSnackbarWithAnimation:(MLSnackbarDismissCause)cause;
- (void)animateForKeyboardNotification:(NSNotification *)notification;
+ (instancetype)sharedInstance;

@end

@interface MLKeyboardInfo : NSObject
@property (nonatomic) CGFloat keyboardHeight;
+ (instancetype)sharedInstance;
//- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillChange:(NSNotification *)notification;
@end

@interface MLSnackbarTest : XCTestCase

@property (nonatomic) id snackbarMock;

@end

@implementation MLSnackbarTest

- (void)setUp
{
	[super setUp];
	// Put setup code here. This method is called before the invocation of each test method in the class.
	self.snackbarMock = OCMPartialMock([[MLSnackbar alloc] init]);
	// Fix to use [app keyWindow] instead of [[app delegate] window] because the delegate for test doesn't responds to the rooViewController selector
	[OCMStub([self.snackbarMock rootViewController]) andReturn:[[[UIApplication sharedApplication] keyWindow] rootViewController]];
}

- (void)tearDown
{
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[self.snackbarMock stopMocking];
	[super tearDown];
}

- (void)testSetUpWithTitleActionTitleActionBlockTypeDurationDismissGestureEnabled
{
	MLSnackbar *snackbar = self.snackbarMock;
	MLSnackbarType *type = [MLSnackbarType defaultType];
	[snackbar setUpSnackbarWithTitle:@"título" actionTitle:@"acción" actionBlock: ^{} type:type duration:MLSnackbarDurationIndefinitely dismissGestureEnabled:YES dismissBlock:NULL];
	XCTAssertEqualObjects(snackbar.messageLabel.text, @"título");
	XCTAssertEqual(snackbar.messageLabel.textColor, type.titleFontColor);
	XCTAssertEqual(snackbar.messageLabel.font, [UIFont ml_lightSystemFontOfSize:kMLFontsSizeXSmall]);
	XCTAssertEqual([snackbar.actionButton titleForState:UIControlStateNormal], @"acción");
	XCTAssertEqual([snackbar.actionButton titleColorForState:UIControlStateNormal], type.actionFontColor);
	XCTAssertEqual(snackbar.actionButton.titleLabel.font.pointSize, kMLFontsSizeXSmall);
	XCTAssertEqual([snackbar.actionButton titleColorForState:UIControlStateHighlighted], type.actionFontHighlightColor);
	XCTAssertFalse(snackbar.actionButton.hidden);
}

- (void)testSetUpWithTitleActionTitleActionBlockTypeDurationDismissGestureEnabledWithButton
{
	MLSnackbar *snackbar = self.snackbarMock;
	[snackbar setUpSnackbarWithTitle:@"título" actionTitle:@"acción" actionBlock: ^{} type:[MLSnackbarType defaultType] duration:MLSnackbarDurationIndefinitely dismissGestureEnabled:YES dismissBlock:NULL];
	XCTAssertFalse(snackbar.actionButton.hidden);
}

- (void)testSetUpWithTitleActionTitleActionBlockTypeDurationDismissGestureEnabledWithNoButtonTitleShouldNotShowButton
{
	MLSnackbar *snackbar = self.snackbarMock;
	[snackbar setUpSnackbarWithTitle:@"titulo" actionTitle:nil actionBlock: ^{} type:[MLSnackbarType defaultType] duration:MLSnackbarDurationIndefinitely dismissGestureEnabled:YES dismissBlock:NULL];
	XCTAssertTrue(snackbar.actionButton.hidden);
}

- (void)testSetUpWithTitleActionTitleActionBlockTypeDurationDismissGestureEnabledWithNoButtonBlockShouldNotShowButton
{
	MLSnackbar *snackbar = self.snackbarMock;
	[snackbar setUpSnackbarWithTitle:@"titulo" actionTitle:@"acción" actionBlock:nil type:[MLSnackbarType defaultType] duration:MLSnackbarDurationIndefinitely dismissGestureEnabled:YES dismissBlock:NULL];
	XCTAssertTrue(snackbar.actionButton.hidden);
}

- (void)testSetUpWithTitleActionTitleActionBlockTypeDurationDismissGestureEnabledShouldAddGesture
{
	MLSnackbar *snackbar = self.snackbarMock;

	[snackbar setUpSnackbarWithTitle:@"titulo" actionTitle:@"acción" actionBlock: ^{} type:[MLSnackbarType defaultType] duration:MLSnackbarDurationIndefinitely dismissGestureEnabled:YES dismissBlock:NULL];

	UIGestureRecognizer *gesture = snackbar.gestureRecognizers[0];

	XCTAssertTrue([gesture isKindOfClass:[UIPanGestureRecognizer class]]);
}

- (void)testSetUpWithTitleActionTitleActionBlockTypeDurationDismissGestureEnabledWithIndefinitelyDurationShoulNotSetTimer
{
	[[self.snackbarMock reject]durationInMilliseconds:MLSnackbarDurationIndefinitely];

	[self.snackbarMock setUpSnackbarWithTitle:@"titulo" actionTitle:@"acción" actionBlock: ^{} type:[MLSnackbarType defaultType] duration:MLSnackbarDurationIndefinitely dismissGestureEnabled:YES dismissBlock:NULL];
}

- (void)testSetUpWithTitleActionTitleActionBlockTypeDurationDismissGestureEnabledWithShortDurationShoulSetTimer
{
	[self.snackbarMock setUpSnackbarWithTitle:@"titulo" actionTitle:@"acción" actionBlock: ^{} type:[MLSnackbarType defaultType] duration:MLSnackbarDurationShort dismissGestureEnabled:YES dismissBlock:NULL];

	OCMVerify([self.snackbarMock durationInMilliseconds:MLSnackbarDurationShort]);
}

- (void)testDismissSnackbarShouldRemoveSnackbar
{
	[self.snackbarMock setUpSnackbarWithTitle:@"titulo" actionTitle:nil actionBlock:nil type:[MLSnackbarType defaultType] duration:MLSnackbarDurationIndefinitely dismissGestureEnabled:YES dismissBlock:NULL];

	[self.snackbarMock dismissSnackbar];

	OCMVerify([self.snackbarMock removeSnackbarWithAnimation:MLSnackbarDismissCauseNone]);
}

- (void)testKeyboardWillShowShouldNotAnimateSnackbarIfKeyboardWasVisible
{
	MLKeyboardInfo *keyboardInfo = OCMPartialMock([MLKeyboardInfo sharedInstance]);
	OCMStub([keyboardInfo keyboardHeight]).andReturn(10);

	NSNotification *not = [NSNotification notificationWithName:@"Keyboard Appeared" object:nil];
//    [keyboardInfo keyboardWillShow:not];
    [keyboardInfo keyboardWillChange:not];

	[[self.snackbarMock reject] animateForKeyboardNotification:not];
}

- (void)testNumberOfLines
{
	MLSnackbar *snackbar = self.snackbarMock;
	XCTAssertTrue(snackbar.messageLabel.numberOfLines == 2);
}

@end
