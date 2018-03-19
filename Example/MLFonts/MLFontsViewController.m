//
// MLFontsViewController.m
// MLUI
//
// Created by Julieta Puente on 12/1/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLFontsViewController.h"
#import <MLUI/UIFont+MLFonts.h>
#import <MLUI/UIColor+MLColorPalette.h>

@interface MLFontsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *xxlargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *xlargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *largeLabel;
@property (weak, nonatomic) IBOutlet UILabel *mediumLabel;
@property (weak, nonatomic) IBOutlet UILabel *smallLabel;
@property (weak, nonatomic) IBOutlet UILabel *xsmallLabel;
@property (weak, nonatomic) IBOutlet UILabel *xxsmallLabel;
@property (weak, nonatomic) IBOutlet UILabel *blackLabel;

@end

@implementation MLFontsViewController

#pragma mark - Navigation
- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"Fonts";
	self.xxlargeLabel.font = [UIFont ml_regularSystemFontOfSize:kMLFontsSizeXXLarge];
	self.xlargeLabel.font = [UIFont ml_boldSystemFontOfSize:kMLFontsSizeXLarge];
	self.largeLabel.font = [UIFont ml_thinSystemFontOfSize:kMLFontsSizeLarge];
	self.mediumLabel.font = [UIFont ml_lightSystemFontOfSize:kMLFontsSizeMedium];
	self.smallLabel.font = [UIFont ml_mediumSystemFontOfSize:kMLFontsSizeSmall];
	self.xsmallLabel.font = [UIFont ml_semiboldSystemFontOfSize:kMLFontsSizeXSmall];
	self.xxsmallLabel.font = [UIFont ml_extraboldSystemFontOfSize:kMLFontsSizeXXSmall];
	self.blackLabel.font = [UIFont ml_blackSystemFontOfSize:kMLFontsSizeSmall];
}

@end
