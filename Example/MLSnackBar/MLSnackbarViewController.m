//
// MLSnackBarViewController.m
// MLUI
//
// Created by Julieta Puente on 26/2/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLSnackbarViewController.h"
#import <MLUI/MLButton.h>
#import <MLUI/MLSnackbar.h>
#import <MLUI/UIColor+MLColorPalette.h>

@interface MLSnackbarViewController ()
@property (weak, nonatomic) IBOutlet MLButton *successSnackBar;
@property (weak, nonatomic) IBOutlet MLButton *errorSnackBar;
@property (weak, nonatomic) IBOutlet MLButton *messageSnackBar;
@property (weak, nonatomic) IBOutlet MLButton *longmessageSnackBar;
@property (strong, nonatomic) MLSnackbar *currentSnackbar;

@end

@implementation MLSnackbarViewController

#pragma mark - Navigation
- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"SnackBar";
	self.successSnackBar.buttonTitle = @"Success Snackbar";
	self.errorSnackBar.buttonTitle = @"Error Snackbar without button";
	self.messageSnackBar.buttonTitle = @"Default Snackbar multiline";
	self.longmessageSnackBar.buttonTitle = @"Default Snackbar multiline no button";
	[self.longmessageSnackBar addTarget:self action:@selector(showDeafaultSnackbarNoButton) forControlEvents:UIControlEventTouchUpInside];
	[self.successSnackBar addTarget:self action:@selector(showSuccessSnackbar) forControlEvents:UIControlEventTouchUpInside];
	[self.errorSnackBar addTarget:self action:@selector(showErrorSnackbar) forControlEvents:UIControlEventTouchUpInside];
	[self.messageSnackBar addTarget:self action:@selector(showDefaultSnackbar) forControlEvents:UIControlEventTouchUpInside];

	[self setupBackgroundColor];
}

#pragma mark - Setup
- (void)setupBackgroundColor
{
	self.view.backgroundColor = [UIColor ml_meli_light_grey];
}

- (void)showSuccessSnackbar
{
	[MLSnackbar showWithTitle:@"Success Snackbar with button" actionTitle:@"ACEPTAR" actionBlock: ^{
	} type:[MLSnackbarType successType] duration:MLSnackbarDurationIndefinitely dismissGestureEnabled:YES];
}

- (void)showErrorSnackbar
{
	self.currentSnackbar = [MLSnackbar showWithTitle:@"Short duration Snackbar" actionTitle:nil actionBlock:nil type:[MLSnackbarType errorType] duration:MLSnackbarDurationIndefinitely dismissGestureEnabled:YES];
}

- (void)showDefaultSnackbar
{
	self.currentSnackbar = [MLSnackbar showWithTitle:@"Long duration Snackbar with multiline layout and button" actionTitle:@"ACEPTAR" actionBlock: ^{
	} type:[MLSnackbarType defaultType] duration:MLSnackbarDurationLong dismissGestureEnabled:YES];
}

- (void)showDeafaultSnackbarNoButton
{
	self.currentSnackbar = [MLSnackbar showWithTitle:@"Long duration snackbar with multiline layout and no button" actionTitle:nil actionBlock:nil type:[MLSnackbarType defaultType] duration:MLSnackbarDurationLong dismissGestureEnabled:YES];
}

- (IBAction)dismissSnackbar:(id)sender
{
	[self.currentSnackbar dismissSnackbar];
	[self showErrorSnackbar];
}

@end
