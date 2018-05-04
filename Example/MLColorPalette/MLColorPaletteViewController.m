//
// MLColorPaletteViewController.m
// MLUI
//
// Created by Julieta Puente on 11/1/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLColorPaletteViewController.h"
#import <MLUI/UIColor+MLColorPalette.h>
#import <MLUI/MLButton.h>

@interface MLColorPaletteViewController ()
@property (weak, nonatomic) IBOutlet UIButton *yellowButton;
@property (weak, nonatomic) IBOutlet UIButton *lightYellowButton;
@property (weak, nonatomic) IBOutlet UIButton *blackButton;
@property (weak, nonatomic) IBOutlet UIButton *darkGreyButton;
@property (weak, nonatomic) IBOutlet UIButton *midGreyButton;
@property (weak, nonatomic) IBOutlet UIButton *lightGreyButton;
@property (weak, nonatomic) IBOutlet UIButton *whiteButton;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *orangeButton;

@end

@implementation MLColorPaletteViewController

#pragma mark - Navigation
- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"Color Palette";
	[self.yellowButton setTitle:@"ml_meli_yellow" forState:UIControlStateNormal];
	self.yellowButton.enabled = NO;
	self.yellowButton.backgroundColor = [UIColor ml_meli_yellow];
	self.yellowButton.layer.cornerRadius = 4.0f;

	[self.lightYellowButton setTitle:@"ml_meli_light_yellow" forState:UIControlStateNormal];
	self.lightYellowButton.enabled = NO;
	self.lightYellowButton.backgroundColor = [UIColor ml_meli_light_yellow];
	self.lightYellowButton.layer.cornerRadius = 4.0f;

	[self.blackButton setTitle:@"ml_meli_black" forState:UIControlStateNormal];
	self.blackButton.enabled = NO;
	self.blackButton.backgroundColor = [UIColor ml_meli_black];
	self.blackButton.layer.cornerRadius = 4.0f;

	[self.darkGreyButton setTitle:@"ml_meli_dark_grey" forState:UIControlStateNormal];
	self.darkGreyButton.enabled = NO;
	self.darkGreyButton.backgroundColor = [UIColor ml_meli_dark_grey];
	self.darkGreyButton.layer.cornerRadius = 4.0f;

	[self.midGreyButton setTitle:@"ml_meli_mid_grey" forState:UIControlStateNormal];
	self.midGreyButton.enabled = NO;
	self.midGreyButton.backgroundColor = [UIColor ml_meli_mid_grey];
	self.midGreyButton.layer.cornerRadius = 4.0f;

	[self.lightGreyButton setTitle:@"ml_meli_light_grey" forState:UIControlStateNormal];
	self.lightGreyButton.enabled = NO;
	self.lightGreyButton.backgroundColor = [UIColor ml_meli_light_grey];
	self.lightGreyButton.layer.cornerRadius = 4.0f;

	[self.whiteButton setTitle:@"ml_meli_white" forState:UIControlStateNormal];
	self.whiteButton.enabled = NO;
	self.whiteButton.backgroundColor = [UIColor ml_meli_white];
	self.whiteButton.layer.cornerRadius = 4.0f;
	self.whiteButton.layer.borderColor = [UIColor ml_meli_black].CGColor;
	self.whiteButton.layer.borderWidth = 1.0f;

	[self.blueButton setTitle:@"ml_meli_blue" forState:UIControlStateNormal];
	self.blueButton.enabled = NO;
	self.blueButton.backgroundColor = [UIColor ml_meli_blue];
	self.blueButton.layer.cornerRadius = 4.0f;

	[self.greenButton setTitle:@"ml_meli_green" forState:UIControlStateNormal];
	self.greenButton.enabled = NO;
	self.greenButton.backgroundColor = [UIColor ml_meli_green];
	self.greenButton.layer.cornerRadius = 4.0f;

	[self.redButton setTitle:@"ml_meli_red" forState:UIControlStateNormal];
	self.redButton.enabled = NO;
	self.redButton.backgroundColor = [UIColor ml_meli_red];
	self.redButton.layer.cornerRadius = 4.0f;

	[self.orangeButton setTitle:@"ml_meli_orange" forState:UIControlStateNormal];
	self.orangeButton.enabled = NO;
	self.orangeButton.backgroundColor = [UIColor ml_meli_orange];
	self.orangeButton.layer.cornerRadius = 4.0f;
}

@end
