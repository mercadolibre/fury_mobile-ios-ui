//
// MLErrorExampleViewController.m
// MeliSDK
//
// Created by Sebastián Bravo on 14/7/15.
// Copyright (c) 2015 Nicolas Suarez. All rights reserved.
//

#import "MLUISnackBarExampleViewController.h"
#import <MLUI/UIViewController+SnackBar.h>
#import <MLUI/MLUISnackBarView.h>
#import <MLUI/UIColor+MLColorPalette.h>

@implementation MLUISnackBarExampleViewController

#pragma mark - Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

	if (self) {
		self.view.backgroundColor = [UIColor ml_meli_light_grey];
	}

	return self;
}

- (void)showSnackBar
{
	MLUISnackBarView *snackBarView = [MLUISnackBarView snackBar:MLSnackBarDurationShort];

	[snackBarView setMessage:@"¡Listo! Enviamos tu pregunta"];

	[self ml_presentSnackBar:snackBarView animated:YES];
}

@end
