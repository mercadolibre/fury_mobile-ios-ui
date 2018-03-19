//
// MLViewController.m
// MLUI
//
// Created by Santiago Lazzari on 7/7/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLViewController.h"

#import "UIColor+MLColorPalette.h"

@interface MLViewController ()

@end

@implementation MLViewController

#pragma mark - Init
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		[self setupBackgroundColor];
	}

	return self;
}

#pragma mark - Setup
- (void)setupBackgroundColor
{
	self.view.backgroundColor = [UIColor ml_meli_light_grey];
}

@end
