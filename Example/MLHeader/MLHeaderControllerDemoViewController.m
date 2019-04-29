//
// MLHeaderControllerDemoViewController.m
// MLUI
//
// Created by Cristian Gimenez on 08/04/2019.
// Copyright © 2019 MercadoLibre. All rights reserved.
//

#import "MLHeaderControllerDemoViewController.h"
#import <MLUI/UIColor+MLColorPalette.h>
#import <MLUI/MLUIHeader.h>
#import <MLUI/MLFullscreenModal.h>
#import "MLHeaderControllerDemoFirstViewController.h"
#import "MLHeaderControllerDemoSecondViewController.h"
#import "MLHeaderControllerDemoThirdViewController.h"
#import "MLHeaderControllerDemoFourthViewController.h"
#import "MLHeaderControllerDemoFifthViewController.h"
#import "MLHeaderControllerDemoSixthViewController.h"
#import "MLFullscreenModalInnerViewController.h"

@interface MLHeaderControllerDemoViewController () <MLUIHeaderDelegate>

@property (nonatomic) MLUIHeader *headerViewController;
@property (nonatomic, weak) IBOutlet UIView *content;
@property (nonatomic, strong) UIView *header;

@end

@implementation MLHeaderControllerDemoViewController

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.title = @"Header Controller Demo";
		self.header = [[UIView alloc] init];
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.edgesForExtendedLayout = UIRectEdgeTop;
	_headerViewController = [[MLUIHeader alloc] init];
	_headerViewController.delegate = self;
	[self addChildViewController:_headerViewController];
	[self.view addSubview:_headerViewController.view];
	[_headerViewController didMoveToParentViewController:self];
	_headerViewController.mode = MLUIHeaderModeAlwaysCollapsed;
}

- (IBAction)firstButtonDidTouch:(id)sender
{
	[self.navigationController pushViewController:[[MLHeaderControllerDemoFirstViewController alloc] init] animated:YES];
}

- (IBAction)secondButtonDidTouch:(id)sender
{
	[self.navigationController pushViewController:[[MLHeaderControllerDemoSecondViewController alloc] init] animated:YES];
}

- (IBAction)thirdButtonDidTouch:(id)sender
{
	[self.navigationController pushViewController:[[MLHeaderControllerDemoThirdViewController alloc] init] animated:YES];
}

- (IBAction)fourthButtonDidTouch:(id)sender
{
	[self.navigationController pushViewController:[[MLHeaderControllerDemoFourthViewController alloc] init] animated:YES];
}

- (IBAction)fifthButtonDidTouch:(id)sender
{
	[self.navigationController pushViewController:[[MLHeaderControllerDemoFifthViewController alloc] init] animated:YES];
}

- (IBAction)sixthButtonDidTouch:(id)sender
{
	[self.navigationController pushViewController:[[MLHeaderControllerDemoSixthViewController alloc] init] animated:YES];
}

- (IBAction)sevenButtonDidTouch:(id)sender
{
	[self.navigationController pushViewController:[[MLFullscreenModal alloc] initWithViewController:[[MLFullscreenModalInnerViewController alloc] init] title:@"Fullscreen Modal"] animated:NO];
}

- (BOOL)shouldTrackPageView
{
	return NO;
}

- (BOOL)shouldScrollContent
{
	return YES;
}

- (UIView *)headerView
{
	return self.header;
}

- (UIView *)contentView
{
	return self.content;
}

@end
