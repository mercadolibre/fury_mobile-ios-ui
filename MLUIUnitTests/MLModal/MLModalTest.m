//
// MLModalTest.m
// MLUI
//
// Created by Julieta Puente on 29/3/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MLUI/MLModal.h>
#import <OCMock/OCMock.h>
#import "UIFont+MLFonts.h"
#import <MLUI/MLModalConfigStyle.h>

@interface MLModalTest : XCTestCase

@property (nonatomic, strong) MLModal *modal;
@property (nonatomic, strong) UIViewController *viewController;
@end

@interface MLModal (Test)
@property (nonatomic, strong) UIView *modalView;
@property (weak, nonatomic) UIView *titleViewContainer;
@property (weak, nonatomic) UIButton *actionButton;
@property (weak, nonatomic) UIButton *secondaryActionButton;
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UILabel *titleLabel;
@property (nonatomic, copy) void (^actionBlock)();
@property (nonatomic, copy) void (^secondaryActionBlock)();

- (void)layoutInnerViewWithTitle:(NSString *)title actionTitle:(NSString *)actionTitle secondaryActionTitle:(NSString *)secondaryTitle configStyle:(MLModalConfigStyle *)configStyle;
- (void)setupWithViewController:(UIViewController *)innerViewController title:(NSString *)title actionTitle:(NSString *)actionTitle actionBlock:(void (^)())actionBlock secondaryActionTitle:(NSString *)secondaryTitle secondaryActionBlock:(void (^)())secondaryActionBlock dismissBlock:(void (^)())dismissBlock enableScroll:(BOOL)enable configStyle:(MLModalConfigStyle *)configStyle;
- (void)show;
- (void)applyBlur;
- (void)findTopViewController;
- (void)makeVisibleModal;
@end

@implementation MLModalTest

- (void)setUp
{
	[super setUp];
	self.viewController = [[UIViewController alloc]init];
	self.modal = OCMPartialMock([[MLModal alloc]init]);
}

- (void)tearDown
{
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
}

- (void)testLayoutInnerViewWithTitleActionTitleSecondaryActionTitlePlainModal
{
	[self.modal layoutInnerViewWithTitle:nil actionTitle:nil secondaryActionTitle:nil configStyle:[[MLModalConfigStyle alloc] init]];

	OCMVerify([self.modal.titleViewContainer removeFromSuperview]);
	OCMVerify([self.modal.actionButton removeFromSuperview]);
}

- (void)testLayoutInnerViewWithTitleActionTitleSecondaryActionTitlePlainModalWithTitle
{
	OCMStub([self.modal titleLabel]).andReturn([[UILabel alloc]init]);
	[self.modal layoutInnerViewWithTitle:@"Title" actionTitle:nil secondaryActionTitle:nil configStyle:[[MLModalConfigStyle alloc] init]];

	XCTAssertEqualObjects(self.modal.titleLabel.text, @"Title");
	XCTAssertEqual(self.modal.titleLabel.font, [UIFont ml_lightSystemFontOfSize:kMLFontsSizeLarge]);
	OCMVerify([self.modal.actionButton removeFromSuperview]);
}

- (void)testLayoutInnerViewWithTitleActionTitleSecondaryActionTitlePlainModalWithButton
{
	self.modal.actionBlock = ^{};
	OCMStub([self.modal actionButton]).andReturn([[UIButton alloc]init]);
	[self.modal layoutInnerViewWithTitle:nil actionTitle:@"Button" secondaryActionTitle:nil configStyle:[[MLModalConfigStyle alloc] init]];

	OCMVerify([self.modal.titleViewContainer removeFromSuperview]);
	XCTAssertEqualObjects([self.modal.actionButton titleForState:UIControlStateNormal], @"Button");
}

- (void)testLayoutInnerViewWithTitleActionTitleSecondaryActionTitlePlainModalWithSecondaryButton
{
	self.modal.secondaryActionBlock = ^{};
	OCMStub([self.modal secondaryActionButton]).andReturn([[UIButton alloc]init]);
	[self.modal layoutInnerViewWithTitle:nil actionTitle:nil secondaryActionTitle:@"Button" configStyle:[[MLModalConfigStyle alloc] init]];

	OCMVerify([self.modal.titleViewContainer removeFromSuperview]);
	XCTAssertEqualObjects([self.modal.secondaryActionButton titleForState:UIControlStateNormal], @"Button");
	OCMVerify([self.modal.actionButton removeFromSuperview]);
}

- (void)testSetUpViewControllerTitleActionTitleActionBlockSecondaryActionTitleSecondaryActionBlockDismissBlockUIScrollViewControllerShouldRemoveScrollView
{
	self.viewController.view = [[UIScrollView alloc]init];
	OCMStub([self.modal findTopViewController]);
	OCMStub([self.modal applyBlur]);
	[self.modal setupWithViewController:self.viewController title:nil actionTitle:nil actionBlock:nil secondaryActionTitle:nil secondaryActionBlock:nil dismissBlock:nil enableScroll:YES configStyle:[[MLModalConfigStyle alloc] init]];

	OCMVerify([self.modal.scrollView removeFromSuperview]);
}

- (void)testSetUpViewControllerTitleActionTitleActionBlockSecondaryActionTitleSecondaryActionBlockDismissBlockWithDisabledScrollShouldRemoveScrollView
{
	OCMStub([self.modal findTopViewController]);
	OCMStub([self.modal applyBlur]);
	[self.modal setupWithViewController:self.viewController title:nil actionTitle:nil actionBlock:nil secondaryActionTitle:nil secondaryActionBlock:nil dismissBlock:nil enableScroll:NO configStyle:[[MLModalConfigStyle alloc] init]];

	OCMVerify([self.modal.scrollView removeFromSuperview]);
}

- (void)testSetUpViewControllerTitleActionTitleActionBlockSecondaryActionTitleSecondaryActionBlockDismissBlockShouldDisableInteraction
{
	UINavigationController *topViewController = [[UINavigationController alloc]init];
	OCMStub([self.modal findTopViewController]).andReturn(topViewController);
	OCMStub([self.modal applyBlur]);

	[self.modal setupWithViewController:self.viewController title:nil actionTitle:nil actionBlock:nil secondaryActionTitle:nil secondaryActionBlock:nil dismissBlock:nil enableScroll:YES configStyle:[[MLModalConfigStyle alloc] init]];

	XCTAssertFalse(topViewController.interactivePopGestureRecognizer.enabled);
}

- (void)testMakeVisibleModalShouldSetVisibleView
{
	self.modal.modalView = [[UIView alloc] init];
	self.modal.modalView.alpha = 0;

	[self.modal makeVisibleModal];
	XCTAssertEqual(self.modal.modalView.alpha, 1);
}

- (void)testCustomDismissBlockCall
{
	MLModal *aModal = OCMPartialMock([[MLModal alloc]init]);
	UINavigationController *topViewController = [[UINavigationController alloc]init];
	OCMStub([aModal findTopViewController]).andReturn(topViewController);

	id viewClassMock = OCMClassMock([UIView class]);

	__block void (^block) (BOOL completion);

	[OCMStub([viewClassMock animateWithDuration:0.3 animations:OCMOCK_ANY completion:[OCMArg checkWithBlock: ^BOOL (id obj) {
	    block = obj;

	    return YES;
	}]]) andDo: ^(NSInvocation *invocation) {
	    block(YES);
	}];

	[aModal setupWithViewController:self.viewController title:nil actionTitle:nil actionBlock:nil secondaryActionTitle:nil secondaryActionBlock:nil dismissBlock:nil enableScroll:YES configStyle:[[MLModalConfigStyle alloc] init]];

	[aModal setDismissBlock: ^{
	    NSLog(@"Dismissed modal");
	}];

	[aModal dismissModal];

	dispatch_async(dispatch_get_main_queue(), ^{
		OCMVerify([aModal dismissBlock]);
	});
}

@end
