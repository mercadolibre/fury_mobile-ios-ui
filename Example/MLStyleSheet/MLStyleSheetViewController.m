//
// MLStyleSheetViewController.m
// MLUI
//
// Created by Cristian Leonel Gibert on 2/2/18.
// Copyright © 2018 MercadoLibre. All rights reserved.
//

#import "MLStyleSheetViewController.h"
#import "MLButton.h"
#import "MLButtonStylesFactory.h"
#import "MLStyleSheetManager.h"
#import "MLStyleSheetTest.h"
#import "MLStyleSheetDefault.h"

@interface MLStyleSheetViewController ()
@property (strong, nonatomic) MLButton *button;
@property (strong, nonatomic) MLButton *buttonDisabled;
@property (strong, nonatomic) IBOutlet UISwitch *switchStyles;
@property (strong, nonatomic) UILabel *textDescription;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *styleSheetTitle;
@end

@implementation MLStyleSheetViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.styleSheetTitle.text = @"StyleSheet Test";

	// setup switch styles control
	[self.switchStyles addTarget:self action:@selector(stateChanged:) forControlEvents:UIControlEventValueChanged];
	[self setupButton];
	[self setupDisableButton];
	[self setupTextDescription];
}

- (void)stateChanged:(UISwitch *)switchState
{
	if ([switchState isOn]) {
		MLStyleSheetManager.styleSheet = [MLStyleSheetTest new];
		self.styleSheetTitle.text = @"Custom StyleSheet";
	} else {
		MLStyleSheetManager.styleSheet = [MLStyleSheetDefault new];
		self.styleSheetTitle.text = @"Default StyleSheet";
	}

	[self.button removeFromSuperview];
	[self.buttonDisabled removeFromSuperview];
	[self.textDescription removeFromSuperview];
	[self setupButton];
	[self setupDisableButton];
	[self setupTextDescription];
}

- (void)setupButton
{
	// setup button configuration
	self.button = [[MLButton alloc] initWithConfig:[MLButtonStylesFactory configForButtonType:MLButtonTypePrimaryAction]];
	self.button.buttonTitle = @"Primary Action";

	// setup button layout
	self.button.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.button];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-24]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:16]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:-16]];
}

- (void)setupDisableButton
{
	// setup button configuration
	self.buttonDisabled = [[MLButton alloc] init];
	self.buttonDisabled.enabled = NO;
	[self.buttonDisabled updateStatesConfig:[MLButtonStylesFactory configForButtonType:MLButtonTypePrimaryAction]];
	self.buttonDisabled.buttonTitle = @"Primary Action Disabled";

	// setup button layout
	self.buttonDisabled.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.buttonDisabled];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.buttonDisabled attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.button attribute:NSLayoutAttributeBottom multiplier:1 constant:-72]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.buttonDisabled attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:16]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.buttonDisabled attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:-16]];
	[self.buttonDisabled setNeedsDisplay];
}

- (void)setupTextDescription
{
	self.textDescription = [[UILabel alloc] init];
	self.textDescription.text = @"Use this switch to change the button theme from ML to MP";
	self.textDescription.numberOfLines = 2;

	self.titleLabel.text = @"StyleSheet Switch";
	self.textDescription.textColor = MLStyleSheetManager.styleSheet.successColor;

	// setup text layout
	[self.view addSubview:self.textDescription];
	self.textDescription.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.textDescription attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:-16]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.textDescription attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:16]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.textDescription attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:44]];
}

@end
