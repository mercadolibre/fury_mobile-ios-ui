//
// MLFullscreenModal.m
// MLUI
//
// Created by Cristian Gimenez on 13/03/2019.
// Copyright © 2019 MercadoLibre. All rights reserved.
//

#import "MLFullscreenModal.h"
#import "MLFullscreenModalHeader.h"
#import "MLStyleSheetManager.h"
#import "MLUIHeader.h"
#import <MLUI/UIColor+MLColorPalette.h>
#import "MLUIBundle.h"

@interface MLFullscreenModal () <MLUIHeaderDelegate>

@property (nonatomic) MLUIHeader *headerViewController;
@property (nonatomic) UIViewController *innerViewController;

@property (nonatomic, strong) MLFullscreenModalHeader *simpleHeaderView;

@property (nonatomic) UIColor *previousNavBarColor;

@end

static int const kTransitionDuration = 0.4f;

@implementation MLFullscreenModal

- (instancetype)initWithViewController:(UIViewController *)innerViewController
                                 title:(NSString *)title
{
	if (self = [super init]) {
		self.title = title;
		self.innerViewController = innerViewController;
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.simpleHeaderView = [MLFullscreenModalHeader simpleHeaderView];
	self.simpleHeaderView.title = self.title;

	_headerViewController = [[MLUIHeader alloc] init];
	_headerViewController.delegate = self;
	_headerViewController.hasShadow = YES;
	_previousNavBarColor = self.navigationController.navigationBar.backgroundColor;
	[_headerViewController setNavigationBarBackgroundcolor:[[MLStyleSheetManager styleSheet] whiteColor]];
	[_headerViewController didMoveToParentViewController:self];

	[self addChildViewController:_headerViewController];
	[self.view addSubview:_headerViewController.view];
	[self.innerViewController viewDidLoad];

	self.simpleHeaderView.scrollEnabled = [UIScreen mainScreen].bounds.size.height < self.innerViewController.view.bounds.size.height;

	UIImage *closeImg = [UIImage imageNamed:@"MLFullscreenModalClose"
	                               inBundle:[MLUIBundle mluiBundle]
	          compatibleWithTraitCollection:nil];

	UIButton *buttonWithCustomImage = [UIButton buttonWithType:UIButtonTypeCustom];
	buttonWithCustomImage.bounds = CGRectMake(0, 0, closeImg.size.width, closeImg.size.height);
	[buttonWithCustomImage setImage:closeImg forState:UIControlStateNormal];
	[buttonWithCustomImage addTarget:self action:@selector(onCloseButtonDidTouch:) forControlEvents:UIControlEventTouchUpInside];

	UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc] initWithCustomView:buttonWithCustomImage];

	[self.navigationItem setLeftBarButtonItem:closeBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.innerViewController viewWillAppear:animated];

	CATransition *transition = [CATransition animation];
	transition.duration = kTransitionDuration;
	transition.type = kCATransitionMoveIn;
	transition.subtype = kCATransitionFromTop;
	[self.navigationController.view.layer addAnimation:transition
	                                            forKey:kCATransition];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.innerViewController viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self.innerViewController viewWillDisappear:animated];

	CATransition *transition = [CATransition animation];
	transition.duration = kTransitionDuration;
	transition.type = kCATransitionReveal;
	transition.subtype = kCATransitionFromBottom;
	[self.navigationController.view.layer addAnimation:transition
	                                            forKey:kCATransition];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	[self.innerViewController viewDidDisappear:animated];

	self.navigationController.navigationBar.backgroundColor = self.previousNavBarColor;
}

- (void)setTitle:(NSString *)title
{
	[super setTitle:title];
	if (title.length > 0) {
		self.simpleHeaderView.title = title;
	}
}

- (UIView *)headerView
{
	return self.simpleHeaderView;
}

- (UIView *)contentView
{
	return self.innerViewController.view;
}

- (BOOL)shouldScrollContent
{
	return YES;
}

- (IBAction)onCloseButtonDidTouch:(id)sender
{
	CATransition *transition = [CATransition animation];
	transition.duration = 0.4f;
	transition.type = kCATransitionReveal;
	transition.subtype = kCATransitionFromBottom;
	[self.navigationController.view.layer addAnimation:transition
	                                            forKey:kCATransition];
	[self.navigationController popViewControllerAnimated:NO];
}

@end
