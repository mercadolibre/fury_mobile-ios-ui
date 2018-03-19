//
// MLSwitchViewController.m
// MLUI
//
// Created by Santiago Lazzari on 6/16/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLSwitchViewController.h"

#import "MLBooleanWidget.h"
#import "MLSwitch.h"

@interface MLSwitchViewController () <MLBooleanWidgetDelegate>

@property (weak, nonatomic) IBOutlet UILabel *switchLabel;
@property (weak, nonatomic) IBOutlet MLSwitch *mlSwitch;

@end

@implementation MLSwitchViewController

#pragma mark - Navigaiton
- (void)viewDidLoad
{
	[super viewDidLoad];

	[self setupTitle];
	[self setupSwitchLabel];
	[self setupSwitch];
}

#pragma mark - Setup
- (void)setupTitle
{
	self.title = @"Switch";
}

- (void)setupSwitchLabel
{
	[self.switchLabel setText:@"Switch off"];
}

- (void)setupSwitch
{
	self.mlSwitch.delegate = self;
}

#pragma mark - Actions
- (void)booleanWidgetWasTapped:(MLBooleanWidget *)booleanWidget
{
	[booleanWidget toggle];
	if ([booleanWidget isOn]) {
		[self.switchLabel setText:@"Switch on"];
	} else {
		[self.switchLabel setText:@"Switch off"];
	}
}

@end
