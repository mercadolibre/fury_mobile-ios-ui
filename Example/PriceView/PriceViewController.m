//
// PriceViewController.m
// MLUI
//
// Created by Sebastián Bravo on 16/1/15.
// Copyright (c) 2015 MercadoLibre. All rights reserved.
//

#import "PriceViewController.h"
#import <MLUI/MLUIPriceView.h>

@interface PriceViewController ()

@property (nonatomic, weak) IBOutlet MLUIPriceView *discountPriceView;
@property (nonatomic, weak) IBOutlet MLUIPriceView *priceView;
@property (nonatomic, weak) IBOutlet MLUIPriceView *disabledPriceView;

@end

@implementation PriceViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setCurrencySymbol:@"$"];
	[numberFormatter setDecimalSeparator:@","];

	[numberFormatter setMaximumFractionDigits:2];
	[numberFormatter setMinimumFractionDigits:2];
	[numberFormatter setGroupingSeparator:@"."];
	[numberFormatter setGroupingSize:3];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];

	[self.view setBackgroundColor:[UIColor whiteColor]];

	[self.discountPriceView layoutViewWithNumber:@1500.50 formatter:numberFormatter style:MLPriceViewDiscountStyle fontSizeStyle:MLPriceSizeLarge];
	[self.priceView layoutViewWithNumber:@1100.75 formatter:numberFormatter style:MLPriceViewDefaultStyle fontSizeStyle:MLPriceSizeLarge];
	[self.disabledPriceView layoutViewWithNumber:@1100.75 formatter:numberFormatter style:MLPriceViewDisabledStyle fontSizeStyle:MLPriceSizeLarge];

	[self.view layoutIfNeeded];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

@end
