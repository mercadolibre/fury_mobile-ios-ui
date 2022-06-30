//
// MLBooleanWidgetViewController.m
// MLUI
//
// Created by Santiago Lazzari on 6/28/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLBooleanWidgetViewController.h"

#import <MLUI/MLCheckBox.h>
#import <MLUI/MLRadioButton.h>
#import <MLUI/MLSwitch.h>
#import <MLUI/MLRadioButtonCollection.h>
#import <MLUI/MLButton.h>
#import <MLUI/UIColor+MLColorPalette.h>

@interface MLBooleanWidgetViewController () <MLBooleanWidgetDelegate>

@property (weak, nonatomic) IBOutlet MLCheckBox *mlCheckBox1;
@property (weak, nonatomic) IBOutlet MLCheckBox *mlCheckBox2;
@property (weak, nonatomic) IBOutlet MLCheckBox *mlCheckBox3;

@property (weak, nonatomic) IBOutlet MLRadioButton *mlRadioButton1;
@property (weak, nonatomic) IBOutlet MLRadioButton *mlRadioButton2;
@property (weak, nonatomic) IBOutlet MLSwitch *mlSwitch;
@property (strong, nonatomic) MLRadioButtonCollection *mlRadioButtonCollection;

@property (weak, nonatomic) IBOutlet UILabel *checkBox1Label;
@property (weak, nonatomic) IBOutlet UILabel *checkBox2Label;
@property (weak, nonatomic) IBOutlet UILabel *option1Label;
@property (weak, nonatomic) IBOutlet UILabel *option2Label;

@end

@implementation MLBooleanWidgetViewController

#pragma mark - Navigation
- (void)viewDidLoad
{
	[super viewDidLoad];

	[self setupTitle];
	[self setupControlCheckbox];
	[self setupRadioButton];
	[self setupOptionLabels];
	[self setupSwitch];
}

#pragma mark - Setup
- (void)setupTitle
{
	self.title = @"MLCheckBox, MLRadioButton & MLSwitch";
}

- (void)setupControlCheckbox
{
	[self.mlCheckBox3 onAnimated:NO];
	self.mlCheckBox1.delegate = self;
    self.mlCheckBox2.delegate = self;
    self.mlCheckBox3.delegate = self;
}


- (void)setupRadioButton
{
	self.mlRadioButtonCollection = [MLRadioButtonCollection radioButtonCollectionWithRadioButtons:@[self.mlRadioButton1, self.mlRadioButton2]];
}

- (void)setupOptionLabels
{
	[self.option1Label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(radioButtonOption1DidTouch:)]];
	[self.option2Label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(radioButtonOption2DidTouch:)]];
}

- (void)setupSwitch
{
	self.mlSwitch.delegate = self;
}

#pragma mark - MLBooleanWidgetDelegate
- (void)booleanWidgetDidRequestChangeOfState:(MLBooleanWidget *)booleanWidget
{
	[booleanWidget toggleAnimated:YES];

	if (booleanWidget == self.mlCheckBox3) {
		[self.mlCheckBox1 setEnabled:booleanWidget.isOn Animated:YES];
		[self.mlCheckBox2 setEnabled:booleanWidget.isOn Animated:YES];
	}
}

#pragma mark - Actions

- (void)radioButtonOption1DidTouch:(id)sender
{
	[self.mlRadioButtonCollection selectRadioButtonAtIndex:0];
}

- (void)radioButtonOption2DidTouch:(id)sender
{
	[self.mlRadioButtonCollection selectRadioButtonAtIndex:1];
}

@end
