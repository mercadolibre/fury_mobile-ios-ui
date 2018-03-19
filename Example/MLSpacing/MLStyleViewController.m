//
// MLStyleViewController.m
// MLUI
//
// Created by Julieta Puente on 7/25/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLStyleViewController.h"
#import <MLUI/UILabel+MLStyle.h>
#import <MLUI/UITextView+MLStyle.h>
#import <MLUI/UIColor+MLColorPalette.h>
#import <MLUI/UIFont+MLFonts.h>

@interface MLStyleViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *regularXXLargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *regularXLargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *regularLargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *regularMediumLabel;
@property (weak, nonatomic) IBOutlet UILabel *regularSmallLabel;
@property (weak, nonatomic) IBOutlet UILabel *regularXSmallLabel;
@property (weak, nonatomic) IBOutlet UILabel *regularXXSmallLabel;
@property (weak, nonatomic) IBOutlet UILabel *lightXXLargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lightXLargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lightLargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lightMediumLabel;
@property (weak, nonatomic) IBOutlet UILabel *lightSmallLabel;
@property (weak, nonatomic) IBOutlet UILabel *lightXSmallLabel;
@property (weak, nonatomic) IBOutlet UILabel *lightXXSmallLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation MLStyleViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.title = @"MLStyle";
	self.view.backgroundColor = [UIColor ml_meli_light_grey];

	[self.regularXXLargeLabel ml_setStyle:MLStyleRegularXXLarge];
	[self.regularXLargeLabel ml_setStyle:MLStyleRegularXLarge];
	[self.regularLargeLabel ml_setStyle:MLStyleRegularLarge];
	[self.regularMediumLabel ml_setStyle:MLStyleRegularMedium];
	[self.regularSmallLabel ml_setStyle:MLStyleRegularSmall];
	[self.regularXSmallLabel ml_setStyle:MLStyleRegularXSmall];
	[self.regularXXSmallLabel ml_setStyle:MLStyleRegularXXSmall];
	[self.lightXXLargeLabel ml_setStyle:MLStyleLightXXLarge];
	[self.lightXLargeLabel ml_setStyle:MLStyleLightXLarge];
	[self.lightLargeLabel ml_setStyle:MLStyleLightLarge];
	[self.lightMediumLabel ml_setStyle:MLStyleLightMedium];
	[self.lightSmallLabel ml_setStyle:MLStyleLightSmall];
	[self.lightXSmallLabel ml_setStyle:MLStyleLightXSmall];
	[self.lightXXSmallLabel ml_setStyle:MLStyleLightXXSmall];

	self.textView.font = [UIFont ml_lightSystemFontOfSize:kMLFontsSizeXXLarge];
}

@end
