//
// MLButtonViewController.m
// MLUI
//
// Created by Julieta Puente on 14/1/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLButtonViewController.h"
#import <MLUI/MLButton.h>
#import <MLUI/MLButtonStylesFactory.h>
#import <MLUI/UIColor+MLColorPalette.h>

@interface MLButtonViewController ()

@property (weak, nonatomic) IBOutlet MLButton *buttonFromXib;
@property (strong, nonatomic)  MLButton *primaryActionDisabledButton;
@property (strong, nonatomic)  MLButton *secondaryActionButton;
@property (strong, nonatomic)  MLButton *secondaryActionDisabledButton;
@property (strong, nonatomic)  MLButton *primaryOptionButton;
@property (strong, nonatomic)  MLButton *primaryOptionDisabledButton;
@property (strong, nonatomic)  MLButton *secondaryOptionButton;
@property (strong, nonatomic)  MLButton *loadingButton;

@end

@implementation MLButtonViewController

#pragma mark - Navigation
- (void)viewDidLoad
{
	[super viewDidLoad];

	// Button created from xib
	self.buttonFromXib.buttonTitle = @"Primary Action";
	self.buttonFromXib.config = [MLButtonStylesFactory configForButtonType:MLButtonTypeSecondaryAction];

	// Buttons created with frame
	self.primaryActionDisabledButton = [[MLButton alloc] initWithConfig:[MLButtonStylesFactory configForButtonType:MLButtonTypePrimaryAction]];
	self.primaryActionDisabledButton.buttonTitle = @"Primary Action Disabled";
	self.primaryActionDisabledButton.enabled = NO;
	[self.view addSubview:self.primaryActionDisabledButton];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[previous]-8-[button]" options:0 metrics:nil views:@{@"button" : self.primaryActionDisabledButton, @"previous" : self.buttonFromXib}]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[button]-8-|" options:0 metrics:nil views:@{@"button" : self.primaryActionDisabledButton}]];

	self.secondaryActionButton = [[MLButton alloc] initWithConfig:[MLButtonStylesFactory configForButtonType:MLButtonTypeSecondaryAction]];
	[self.secondaryActionButton setButtonTitle:@"Secondary Action"];
	[self.view addSubview:self.secondaryActionButton];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[previous]-8-[button]" options:0 metrics:nil views:@{@"button" : self.secondaryActionButton, @"previous" : self.primaryActionDisabledButton}]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[button]-8-|" options:0 metrics:nil views:@{@"button" : self.secondaryActionButton}]];

	// Buttons created with constraints
	self.secondaryActionDisabledButton = [[MLButton alloc] initWithConfig:[MLButtonStylesFactory configForButtonType:MLButtonTypeSecondaryAction]];
	[self.secondaryActionDisabledButton setButtonTitle:@"Secondary Action Disabled"];
	self.secondaryActionDisabledButton.enabled = NO;
	[self.view addSubview:self.secondaryActionDisabledButton];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[previous]-8-[button]" options:0 metrics:nil views:@{@"button" : self.secondaryActionDisabledButton, @"previous" : self.secondaryActionButton}]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[button]-8-|" options:0 metrics:nil views:@{@"button" : self.secondaryActionDisabledButton}]];

	self.primaryOptionButton = [[MLButton alloc] initWithConfig:[MLButtonStylesFactory configForButtonType:MLButtonTypePrimaryOption]];
	[self.primaryOptionButton setButtonTitle:@"Primary Option"];
	[self.view addSubview:self.primaryOptionButton];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[previous]-8-[button]" options:0 metrics:nil views:@{@"button" : self.primaryOptionButton, @"previous" : self.secondaryActionDisabledButton}]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[button]-8-|" options:0 metrics:nil views:@{@"button" : self.primaryOptionButton}]];

	self.primaryOptionDisabledButton = [[MLButton alloc] initWithConfig:[MLButtonStylesFactory configForButtonType:MLButtonTypePrimaryOption]];
	[self.primaryOptionDisabledButton setButtonTitle:@"Primary Option Disabled"];
	self.primaryOptionDisabledButton.enabled = NO;
	[self.view addSubview:self.primaryOptionDisabledButton];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[previous]-8-[button]" options:0 metrics:nil views:@{@"button" : self.primaryOptionDisabledButton, @"previous" : self.primaryOptionButton}]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[button]-8-|" options:0 metrics:nil views:@{@"button" : self.primaryOptionDisabledButton}]];

	self.secondaryOptionButton = [[MLButton alloc] initWithConfig:[MLButtonStylesFactory configForButtonType:MLButtonTypeSecondaryOption]];
	[self.secondaryOptionButton setButtonTitle:@"Secondary Option"];
	[self.view addSubview:self.secondaryOptionButton];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[previous]-8-[button]" options:0 metrics:nil views:@{@"button" : self.secondaryOptionButton, @"previous" : self.primaryOptionDisabledButton}]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[button]-8-|" options:0 metrics:nil views:@{@"button" : self.secondaryOptionButton}]];

	self.loadingButton = [[MLButton alloc] initWithConfig:[MLButtonStylesFactory configForButtonType:MLButtonTypeLoading]];
	[self.loadingButton setButtonTitle:@"Loading Button"];
	[self.view addSubview:self.loadingButton];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[previous]-8-[button]" options:0 metrics:nil views:@{@"button" : self.loadingButton, @"previous" : self.secondaryOptionButton}]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[button]-8-|" options:0 metrics:nil views:@{@"button" : self.loadingButton}]];
	[self.loadingButton showLoadingStyle];
	self.title = @"Buttons";
}

@end
