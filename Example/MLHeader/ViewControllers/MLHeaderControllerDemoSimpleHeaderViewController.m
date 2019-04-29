//
// MLHeaderControllerDemoSimpleHeaderViewController.m
// MLUI
//
// Created by Cristian Gimenez on 08/04/2019.
// Copyright © 2019 MercadoLibre. All rights reserved.
//

#import "MLHeaderControllerDemoSimpleHeaderViewController.h"
#import "MLSimpleHeaderView.h"
#import <MLUI/MLUIHeader.h>

@interface MLHeaderControllerDemoSimpleHeaderViewController ()

@property (nonatomic, strong) MLSimpleHeaderView *simpleHeaderView;

@end

@implementation MLHeaderControllerDemoSimpleHeaderViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.simpleHeaderView = [MLSimpleHeaderView simpleHeaderView];
	self.simpleHeaderView.title = self.title;

	_headerViewController = [[MLUIHeader alloc] init];
	_headerViewController.delegate = self;
	[self addChildViewController:_headerViewController];
	[self.view addSubview:_headerViewController.view];
	[_headerViewController didMoveToParentViewController:self];
}

- (void)setTitle:(NSString *)title
{
	[super setTitle:title];
	if (title.length > 0) {
		self.simpleHeaderView.title = title;
	}
}

- (BOOL)shouldTrackPageView
{
	return NO;
}

- (UIView *)headerView
{
	return self.simpleHeaderView;
}

- (UIView *)contentView
{
	return self.content;
}

@end
