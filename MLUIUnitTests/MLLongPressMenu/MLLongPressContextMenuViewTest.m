//
// MLLongPressMenuViewControllerTest.m
// MLUI
//
// Created by Nicolas Guido Brucchieri on 5/3/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <MLUI/MLContextualMenu.h>
#import <MLUI/UIColor+MLColorPalette.h>

#define LayerBackgroundColor [UIColor colorWithWhite:0.1f alpha:.8f].CGColor

@interface MLLongPressContextMenuViewTest : XCTestCase
@property (nonatomic) id longPressContextMenuMock;
@end

@interface MLContextualMenu (Test)
@property (nonatomic, strong) NSMutableArray *menuItems;
@property (nonatomic, strong) NSMutableArray *itemLocations;
@property (nonatomic) CGFloat arcAngle;
@property (nonatomic) CGFloat radius;
@property (nonatomic, assign) BOOL invertActionsOrder;
@property (nonatomic) CGColorRef itemBGColor;
@property (nonatomic) NSInteger prevIndex;
@property (nonatomic, assign) BOOL isShowing;
@property (nonatomic, assign) BOOL isPaning;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic) CGPoint longPressLocation;
@property (nonatomic, strong) NSMutableArray *originalGestureRecognizers;

- (void)setup;
- (void)setupDisplayLink;
- (void)setupView;
- (void)highlightMenuItemForPoint;
- (void)viewInitializations;
- (void)setDataSource:(id <MLContextualMenuDataSource> )dataSource;
- (void)reloadData;
- (BOOL)shouldShowMenuAtPoint:(CGPoint)point;
- (void)dismissWithSelectedIndexForMenuAtPoint:(CGPoint)point;
- (void)hideMenu;
- (void)resetSelectedIndex;
- (void)longPressDetected:(UIGestureRecognizer *)gestureRecognizer;
- (void)storeOriginalGestureRecognizersFromView:(UIView *)view;
- (void)showAnimateMenu:(BOOL)show;
- (CALayer *)layerWithIndex:(NSInteger)index;
- (CALayer *)drawMainLayer;
- (CALayer *)drawContentImageLayerAtIndex:(NSInteger)index width:(CGFloat)width height:(CGFloat)height;
- (CALayer *)drawTextLayerAtIndex:(NSInteger)index width:(CGFloat)width;
- (void)layoutMenuItems;
- (NSInteger)getClosestIndex;
- (BOOL)isValidIndexForSelection:(NSInteger)closestIndex;
- (void)animateSelectionAtIndex:(NSInteger)index selecting:(BOOL)selecting;
- (BOOL)isSelectedIndex;
- (void)resetPreviousSelectionIfNeeded:(NSInteger)closeToIndex;
- (void)resetPreviousSelection;
- (void)animateSelectionScaleAtIndex:(NSInteger)closeToIndex selecting:(BOOL)selecting;
- (void)animateSelectionTextAndBackgroundAtIndex:(NSInteger)index selecting:(BOOL)selecting;
- (void)drawCircle:(CGPoint)locationOfTouch;
- (BOOL)isValidClosestIndex:(NSInteger)closestIndex;
- (CGFloat)distanceFromItem;
- (CGFloat)toleranceDistance;
- (void)addStoredOriginalGestureRecognizers;
@end

@implementation MLLongPressContextMenuViewTest

- (void)setUp
{
	[super setUp];

	self.longPressContextMenuMock = OCMPartialMock([[MLContextualMenu alloc] init]);
}

- (void)tearDown
{
	[self.longPressContextMenuMock stopMocking];

	[super tearDown];
}

- (MLContextualMenu *)longPressContextMenuMockCasted
{
	return (MLContextualMenu *)self.longPressContextMenuMock;
}

#pragma mark -
#pragma mark Initializations
#pragma mark -
- (void)testSetup
{
	// -- Func Call
	[self.longPressContextMenuMock setup];
	OCMVerify([self.longPressContextMenuMockCasted setupView]);
	OCMVerify([self.longPressContextMenuMockCasted viewInitializations]);
	OCMVerify([self.longPressContextMenuMockCasted setupDisplayLink]);
}

- (void)testSetupView
{
	// -- Func Call
	[self.longPressContextMenuMock setupView];
	XCTAssertTrue(self.longPressContextMenuMockCasted.userInteractionEnabled);
	XCTAssertTrue(self.longPressContextMenuMockCasted.backgroundColor == [UIColor clearColor]);
	XCTAssertTrue(CGColorEqualToColor(self.longPressContextMenuMockCasted.layer.backgroundColor, LayerBackgroundColor));
}

- (void)testViewInitializations
{
	// -- Func Call
	[self.longPressContextMenuMock viewInitializations];

	XCTAssertNotNil(self.longPressContextMenuMockCasted.menuItems);
	XCTAssertTrue(self.longPressContextMenuMockCasted.menuItems.count == 0);

	XCTAssertNotNil(self.longPressContextMenuMockCasted.itemLocations);
	XCTAssertTrue(self.longPressContextMenuMockCasted.itemLocations.count == 0);

	CGFloat arcAngle = M_PI / 3;
	XCTAssertTrue(self.longPressContextMenuMockCasted.arcAngle == arcAngle);
	XCTAssertTrue(self.longPressContextMenuMockCasted.radius == 90);
	XCTAssertFalse(self.longPressContextMenuMockCasted.invertActionsOrder);
}

#pragma mark -
#pragma mark Datasource
#pragma mark -
- (void)testSetDataSource
{
	id dataSource = [OCMockObject mockForProtocol:@protocol(MLContextualMenuDataSource)];
	[OCMStub(([self.longPressContextMenuMock reloadData])) andDo:nil];
	// -- Func Call
	[self.longPressContextMenuMock setDataSource:(dataSource)];
	XCTAssertTrue(self.longPressContextMenuMockCasted.dataSource == dataSource);
	OCMVerify([self.longPressContextMenuMockCasted reloadData]);
}

- (void)testShouldShowMenuAtPoint
{
	CGPoint point = CGPointMake(0, 0);
	[OCMStub(([self.longPressContextMenuMock reloadData])) andDo:nil];

	self.longPressContextMenuMockCasted.dataSource = nil;
	// -- Func Call
	XCTAssertTrue([self.longPressContextMenuMock shouldShowMenuAtPoint:point]);

	id dataSource = [OCMockObject mockForProtocol:@protocol(MLContextualMenuDataSource)];
	OCMStub([dataSource contextualMenu:[OCMArg any] shouldShowMenuAtPoint:point]).andReturn(YES);
	[self.longPressContextMenuMock setDataSource:(dataSource)];
	// -- Func Call
	XCTAssertTrue([self.longPressContextMenuMock shouldShowMenuAtPoint:point]);

	dataSource = [OCMockObject mockForProtocol:@protocol(MLContextualMenuDataSource)];
	OCMStub([dataSource contextualMenu:[OCMArg any] shouldShowMenuAtPoint:point]).andReturn(NO);
	[self.longPressContextMenuMock setDataSource:(dataSource)];
	// -- Func Call
	XCTAssertFalse([self.longPressContextMenuMock shouldShowMenuAtPoint:point]);
}

#pragma mark -
#pragma mark LongPress handler
#pragma mark -
- (void)testDismissWithSelectedIndexForMenuAtPoint
{
	CGPoint point = CGPointMake(0, 0);
	id delegate = [OCMockObject mockForProtocol:@protocol(MLContextualMenuDelegate)];

	OCMStub([self.longPressContextMenuMockCasted isSelectedIndex]).andReturn(YES);
	[[delegate reject] contextualMenu:[OCMArg any] didSelectItemAtIndex:0 atPoint:point];
	[[self.longPressContextMenuMock reject] resetSelectedIndex];
	self.longPressContextMenuMockCasted.delegate = nil;
	// -- Func Call
	[self.longPressContextMenuMockCasted dismissWithSelectedIndexForMenuAtPoint:point];
	OCMVerify([self.longPressContextMenuMockCasted hideMenu]);

	[self setUp];
	OCMStub([self.longPressContextMenuMockCasted isSelectedIndex]).andReturn(NO);
	delegate = [OCMockObject mockForProtocol:@protocol(MLContextualMenuDelegate)];
	OCMStub([delegate respondsToSelector:@selector(contextualMenu:didSelectItemAtIndex:atPoint:)]).andReturn(YES);
	[OCMStub([delegate contextualMenuDidClose:[OCMArg any]]) andDo:nil];
	self.longPressContextMenuMockCasted.delegate = delegate;
	[[delegate reject] contextualMenu:[OCMArg any] didSelectItemAtIndex:0 atPoint:point];
	[[self.longPressContextMenuMock reject] resetSelectedIndex];
	// -- Func Call
	[self.longPressContextMenuMockCasted dismissWithSelectedIndexForMenuAtPoint:point];
	OCMVerify([self.longPressContextMenuMockCasted hideMenu]);

	[self setUp];
	delegate = [OCMockObject mockForProtocol:@protocol(MLContextualMenuDelegate)];
	[OCMStub([delegate contextualMenuDidClose:[OCMArg any]]) andDo:nil];
	OCMStub([self.longPressContextMenuMockCasted isSelectedIndex]).andReturn(YES);
	[OCMStub(([delegate contextualMenu:[OCMArg any] didSelectItemAtIndex:0 atPoint:point])) andDo:nil];
	self.longPressContextMenuMockCasted.delegate = delegate;
	// -- Func Call
	[self.longPressContextMenuMockCasted dismissWithSelectedIndexForMenuAtPoint:point];
	OCMVerify([delegate contextualMenu:[OCMArg any] didSelectItemAtIndex:0 atPoint:point]);
	OCMVerify([self.longPressContextMenuMock resetSelectedIndex]);
	OCMVerify([self.longPressContextMenuMockCasted hideMenu]);

	[self setUp];
	delegate = [OCMockObject mockForProtocol:@protocol(MLContextualMenuDelegate)];
	OCMStub([delegate respondsToSelector:@selector(contextualMenuDidClose:)]).andReturn(YES);
	[OCMStub([delegate contextualMenuDidClose:[OCMArg any]]) andDo:nil];
	self.longPressContextMenuMockCasted.delegate = delegate;
	OCMStub([self.longPressContextMenuMockCasted isSelectedIndex]).andReturn(NO);
	// -- Func Call
	[self.longPressContextMenuMockCasted dismissWithSelectedIndexForMenuAtPoint:point];
	OCMVerify([delegate contextualMenuDidClose:[OCMArg any]]);
}

- (void)testLongPressDetected
{
	CGPoint point = CGPointMake(0, 0);

	// UIGestureRecognizerStateBegan
	id gestureRecognizer = OCMPartialMock([[UIGestureRecognizer alloc] init]);
	OCMStub([gestureRecognizer state]).andReturn(UIGestureRecognizerStateBegan);
	[[self.longPressContextMenuMock reject] storeOriginalGestureRecognizersFromView:[OCMArg any]];
	// -- Func Call
	[[self.longPressContextMenuMock reject] showAnimateMenu:YES];
	OCMStub([self.longPressContextMenuMockCasted shouldShowMenuAtPoint:point]).andReturn(NO);
	[self.longPressContextMenuMockCasted longPressDetected:gestureRecognizer];
	OCMVerify([self.longPressContextMenuMockCasted resetSelectedIndex]);

	[self setUp];
	OCMStub([self.longPressContextMenuMockCasted shouldShowMenuAtPoint:point]).andReturn(YES);
	// -- Func Call
	[self.longPressContextMenuMockCasted longPressDetected:gestureRecognizer];
	OCMVerify([self.longPressContextMenuMockCasted storeOriginalGestureRecognizersFromView:[OCMArg any]]);
	OCMVerify([self.longPressContextMenuMockCasted showAnimateMenu:YES]);

	// UIGestureRecognizerStateChanged
	gestureRecognizer = OCMPartialMock([[UIGestureRecognizer alloc] init]);
	OCMStub([gestureRecognizer state]).andReturn(UIGestureRecognizerStateChanged);
	self.longPressContextMenuMockCasted.isShowing = NO;
	self.longPressContextMenuMockCasted.isPaning = NO;
	[[gestureRecognizer reject] locationInView:[OCMArg any]];
	// -- Func Call
	[self.longPressContextMenuMockCasted longPressDetected:gestureRecognizer];
	XCTAssertFalse(self.longPressContextMenuMockCasted.isPaning);

	gestureRecognizer = OCMPartialMock([[UIGestureRecognizer alloc] init]);
	OCMStub([gestureRecognizer state]).andReturn(UIGestureRecognizerStateChanged);
	self.longPressContextMenuMockCasted.isShowing = YES;
	self.longPressContextMenuMockCasted.isPaning = NO;
	// -- Func Call
	[self.longPressContextMenuMockCasted longPressDetected:gestureRecognizer];
	OCMVerify([gestureRecognizer locationInView:[OCMArg any]]);
	XCTAssertTrue(self.longPressContextMenuMockCasted.isPaning);

	// UIGestureRecognizerStateEnded
	gestureRecognizer = OCMPartialMock([[UIGestureRecognizer alloc] init]);
	OCMStub([gestureRecognizer state]).andReturn(UIGestureRecognizerStateEnded);
	// -- Func Call
	[self.longPressContextMenuMockCasted longPressDetected:gestureRecognizer];
	OCMVerify([self.longPressContextMenuMock dismissWithSelectedIndexForMenuAtPoint:point]);
}

#pragma mark -
#pragma mark Menu item layout
#pragma mark -
- (void)testReloadData
{
	[OCMStub(([self.longPressContextMenuMock reloadData])) andDo:nil];

	self.longPressContextMenuMockCasted.dataSource = nil;
	// -- Func Call
	[self.longPressContextMenuMock reloadData];
	XCTAssertTrue(self.longPressContextMenuMockCasted.menuItems.count == 0);
	XCTAssertTrue(self.longPressContextMenuMockCasted.itemLocations.count == 0);

	id dataSource = [OCMockObject mockForProtocol:@protocol(MLContextualMenuDataSource)];
	[self.longPressContextMenuMock setDataSource:(dataSource)];
	// -- Func Call
	[self.longPressContextMenuMock reloadData];
// OCMVerify([self.longPressContextMenuMock numberOfMenuItems]);
}

- (void)testLayerWithIndex
{
	OCMStub([self.longPressContextMenuMock drawMainLayer]).andReturn([CALayer layer]);
	// -- Func Call
	[self.longPressContextMenuMock layerWithIndex:0];
	OCMVerify([self.longPressContextMenuMock drawMainLayer]);
	OCMVerify([self.longPressContextMenuMock drawContentImageLayerAtIndex:0 width:0 height:0]);
	OCMVerify([self.longPressContextMenuMock drawTextLayerAtIndex:0 width:0]);
}

- (void)testDrawMainLayer
{
	XCTAssertNotNil([self.longPressContextMenuMock drawMainLayer]);
}

- (void)testDrawContentImageLayer
{
	XCTAssertNotNil([self.longPressContextMenuMock drawContentImageLayerAtIndex:0 width:0 height:0]);
}

- (void)testDrawCdrawTextLayer
{
	XCTAssertNotNil([self.longPressContextMenuMock drawTextLayerAtIndex:0 width:0]);
}

- (void)testLayoutMenuItems
{
	// -- Func Call
	[self.longPressContextMenuMock layoutMenuItems];
	OCMVerify([self.longPressContextMenuMock reloadData]);
	XCTAssertTrue(self.longPressContextMenuMockCasted.itemLocations.count == 0);
}

#pragma mark -
#pragma mark Menu animation and selection
#pragma mark -
- (void)testShowAnimateMenu
{
	self.longPressContextMenuMockCasted.isPaning = YES;
	[[self.longPressContextMenuMock reject] removeFromSuperview];
	// -- Func Call
	[self.longPressContextMenuMock showAnimateMenu:YES];
	OCMVerify([self.longPressContextMenuMock layoutMenuItems]);
	XCTAssertTrue(self.longPressContextMenuMockCasted.isShowing == YES);
	OCMVerify([self.longPressContextMenuMock setNeedsDisplay]);
	XCTAssertTrue(self.longPressContextMenuMockCasted.isPaning == YES);

	[self setUp];
	self.longPressContextMenuMockCasted.isPaning = YES;
	[[self.longPressContextMenuMock reject] layoutMenuItems];
	// -- Func Call
	[self.longPressContextMenuMock showAnimateMenu:NO];
	XCTAssertTrue(self.longPressContextMenuMockCasted.isShowing == NO);
	OCMVerify([self.longPressContextMenuMock setNeedsDisplay]);
	XCTAssertTrue(self.longPressContextMenuMockCasted.isPaning == NO);
}

- (void)testHighlightMenuItemForPoint
{
	[[self.longPressContextMenuMock reject] getClosestIndex];
	self.longPressContextMenuMockCasted.isPaning = NO;
	self.longPressContextMenuMockCasted.isShowing = YES;
	// -- Func Call
	[self.longPressContextMenuMock highlightMenuItemForPoint];

	[[self.longPressContextMenuMock reject] getClosestIndex];
	self.longPressContextMenuMockCasted.isPaning = YES;
	self.longPressContextMenuMockCasted.isShowing = NO;
	// -- Func Call
	[self.longPressContextMenuMock highlightMenuItemForPoint];

	NSInteger closeToIndex = 0;
	NSInteger selectedIndex = 1;
	[self setUp];
	self.longPressContextMenuMockCasted.isPaning = YES;
	self.longPressContextMenuMockCasted.isShowing = YES;
	self.longPressContextMenuMockCasted.selectedIndex = selectedIndex;
	OCMStub([self.longPressContextMenuMock getClosestIndex]).andReturn(closeToIndex);
	OCMStub([self.longPressContextMenuMock isValidIndexForSelection:closeToIndex]).andReturn(YES);
	[OCMStub(([self.longPressContextMenuMock animateSelectionAtIndex:closeToIndex selecting:YES])) andDo:nil];
	[OCMStub(([self.longPressContextMenuMock resetPreviousSelectionIfNeeded:closeToIndex])) andDo:nil];
	[[self.longPressContextMenuMock reject] resetPreviousSelection];
	// -- Func Call
	[self.longPressContextMenuMock highlightMenuItemForPoint];
	OCMVerify([self.longPressContextMenuMock getClosestIndex]);
	OCMVerify([self.longPressContextMenuMock isValidIndexForSelection:closeToIndex]);
	OCMVerify([self.longPressContextMenuMock animateSelectionAtIndex:closeToIndex selecting:YES]);
	OCMVerify([self.longPressContextMenuMock resetPreviousSelectionIfNeeded:closeToIndex]);
	XCTAssertTrue(self.longPressContextMenuMockCasted.selectedIndex == closeToIndex);

	[self setUp];
	self.longPressContextMenuMockCasted.isPaning = YES;
	self.longPressContextMenuMockCasted.isShowing = YES;
	self.longPressContextMenuMockCasted.selectedIndex = selectedIndex;
	OCMStub([self.longPressContextMenuMock getClosestIndex]).andReturn(closeToIndex);
	OCMStub([self.longPressContextMenuMock isValidIndexForSelection:closeToIndex]).andReturn(NO);
	[OCMStub(([self.longPressContextMenuMock resetPreviousSelection])) andDo:nil];
	[[self.longPressContextMenuMock reject] animateSelectionAtIndex:closeToIndex selecting:YES];
	[[self.longPressContextMenuMock reject] resetPreviousSelectionIfNeeded:closeToIndex];
	// -- Func Call
	[self.longPressContextMenuMock highlightMenuItemForPoint];
	OCMVerify([self.longPressContextMenuMock getClosestIndex]);
	OCMVerify([self.longPressContextMenuMock isValidIndexForSelection:closeToIndex]);
	OCMVerify([self.longPressContextMenuMock resetPreviousSelection]);
	XCTAssertTrue(self.longPressContextMenuMockCasted.selectedIndex == selectedIndex);
}

- (void)testResetPreviousSelectionIfNeeded
{
	OCMStub([self.longPressContextMenuMock isSelectedIndex]).andReturn(NO);
	self.longPressContextMenuMockCasted.selectedIndex = 1;
	NSInteger closeToIndex = 1;
	[[self.longPressContextMenuMock reject] resetPreviousSelection];
	// -- Func Call
	[self.longPressContextMenuMock resetPreviousSelectionIfNeeded:closeToIndex];

	closeToIndex = 2;
	// -- Func Call
	[self.longPressContextMenuMock resetPreviousSelectionIfNeeded:closeToIndex];

	[self setUp];
	OCMStub([self.longPressContextMenuMock isSelectedIndex]).andReturn(YES);
	self.longPressContextMenuMockCasted.selectedIndex = 1;
	[OCMStub(([self.longPressContextMenuMock resetPreviousSelection])) andDo:nil];
	// -- Func Call
	[self.longPressContextMenuMock resetPreviousSelectionIfNeeded:closeToIndex];
	OCMVerify([self.longPressContextMenuMock resetPreviousSelection]);
}

- (void)testAnimateSelectionAtIndex
{
	NSInteger index = 1;
	BOOL selecting = YES;
	[OCMStub(([self.longPressContextMenuMock animateSelectionScaleAtIndex:index selecting:selecting])) andDo:nil];
	[OCMStub(([self.longPressContextMenuMock animateSelectionTextAndBackgroundAtIndex:index selecting:selecting])) andDo:nil];
	// -- Func Call
	[self.longPressContextMenuMock animateSelectionAtIndex:index selecting:selecting];
	OCMVerify([self.longPressContextMenuMock animateSelectionScaleAtIndex:index selecting:selecting]);
	OCMVerify([self.longPressContextMenuMock animateSelectionTextAndBackgroundAtIndex:index selecting:selecting]);
}

- (void)testDrawRect
{
	CGPoint point = CGPointMake(0, 0);
	CGRect rect = CGRectMake(0, 0, 0, 0);
	self.longPressContextMenuMockCasted.longPressLocation = point;

	self.longPressContextMenuMockCasted.isShowing = YES;
	// -- Func Call
	[self.longPressContextMenuMock drawRect:rect];
	OCMVerify([self.longPressContextMenuMock drawCircle:point]);

	self.longPressContextMenuMockCasted.isShowing = NO;
	[[self.longPressContextMenuMock reject] drawCircle:point];
	// -- Func Call
	[self.longPressContextMenuMock drawRect:rect];
}

- (void)testIsValidClosestIndex
{
	self.longPressContextMenuMockCasted.menuItems = [[NSMutableArray alloc] initWithObjects:@"1", @"2", nil];

	NSInteger closestIndex = -1;
	// -- Func Call
	XCTAssertFalse([self.longPressContextMenuMock isValidClosestIndex:closestIndex]);

	closestIndex = 5;
	// -- Func Call
	XCTAssertFalse([self.longPressContextMenuMock isValidClosestIndex:closestIndex]);

	closestIndex = 1;
	// -- Func Call
	XCTAssertTrue([self.longPressContextMenuMock isValidClosestIndex:closestIndex]);
}

- (void)testIsValidIndexForSelection
{
	NSInteger closestIndex = 0;

	OCMStub([self.longPressContextMenuMock isValidClosestIndex:closestIndex]).andReturn(NO);
	// -- Func Call
	XCTAssertFalse([self.longPressContextMenuMock isValidIndexForSelection:closestIndex]);

	[self setUp];
	OCMStub([self.longPressContextMenuMock isValidClosestIndex:closestIndex]).andReturn(YES);
	OCMStub([self.longPressContextMenuMock distanceFromItem]).andReturn(2);
	OCMStub([self.longPressContextMenuMock toleranceDistance]).andReturn(2);
	// -- Func Call
	XCTAssertFalse([self.longPressContextMenuMock isValidIndexForSelection:closestIndex]);

	[self setUp];
	OCMStub([self.longPressContextMenuMock isValidClosestIndex:closestIndex]).andReturn(YES);
	OCMStub([self.longPressContextMenuMock distanceFromItem]).andReturn(1);
	OCMStub([self.longPressContextMenuMock toleranceDistance]).andReturn(2);
	// -- Func Call
	XCTAssertTrue([self.longPressContextMenuMock isValidIndexForSelection:closestIndex]);
}

- (void)testResetSelectedIndex
{
	self.longPressContextMenuMockCasted.selectedIndex = 1;
	// -- Func Call
	[self.longPressContextMenuMock resetSelectedIndex];
	XCTAssertTrue(self.longPressContextMenuMockCasted.selectedIndex == -1);
}

- (void)testIsSelectedIndex
{
	self.longPressContextMenuMockCasted.selectedIndex = -1;
	// -- Func Call
	XCTAssertFalse([self.longPressContextMenuMock isSelectedIndex]);

	self.longPressContextMenuMockCasted.selectedIndex = 1;
	// -- Func Call
	XCTAssertTrue([self.longPressContextMenuMock isSelectedIndex]);
}

- (void)testStoreOriginalGestureRecognizersFromView
{
	self.longPressContextMenuMockCasted.originalGestureRecognizers = nil;
	// -- Func Call
	[self.longPressContextMenuMockCasted storeOriginalGestureRecognizersFromView:nil];
	XCTAssertNotNil(self.longPressContextMenuMockCasted.originalGestureRecognizers);
}

- (void)testAddStoredOriginalGestureRecognizers
{
	self.longPressContextMenuMockCasted.originalGestureRecognizers = nil;
	[self.longPressContextMenuMockCasted storeOriginalGestureRecognizersFromView:nil];
	// -- Func Call
	[self.longPressContextMenuMockCasted addStoredOriginalGestureRecognizers];
	XCTAssertNil(self.longPressContextMenuMockCasted.originalGestureRecognizers);
}

- (void)testHideMenu
{
	self.longPressContextMenuMockCasted.isShowing = NO;
	[[self.longPressContextMenuMock reject] addStoredOriginalGestureRecognizers];
	[[self.longPressContextMenuMock reject] showAnimateMenu:NO];
	// -- Func Call
	[self.longPressContextMenuMockCasted hideMenu];

	[self setUp];
	self.longPressContextMenuMockCasted.isShowing = YES;
	// -- Func Call
	[self.longPressContextMenuMockCasted hideMenu];
	OCMVerify([self.longPressContextMenuMock addStoredOriginalGestureRecognizers]);
	OCMVerify([self.longPressContextMenuMock showAnimateMenu:NO]);
}

@end
