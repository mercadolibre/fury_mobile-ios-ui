//
// MLLoadingViewController.m
// MLUI
//
// Created by Julieta Puente on 18/4/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLSpinnerViewController.h"
#import <MLUI/MLSpinner.h>
#import <MLUI/MLButton.h>
#import <MLUI/MLStyleSheetManager.h>

@interface MLSpinnerViewController ()
@property (weak, nonatomic) IBOutlet MLButton *bigWhiteSpinner;
@property (weak, nonatomic) IBOutlet MLButton *bigWhiteSpinnerWithText;
@property (weak, nonatomic) IBOutlet MLButton *bigBlueSpinner;
@property (weak, nonatomic) IBOutlet MLButton *bigBlueSpinnerWithText;

@property (weak, nonatomic) IBOutlet MLSpinner *spinner;
@property (weak, nonatomic) IBOutlet MLButton *smallBlueSpinner;
@property (weak, nonatomic) IBOutlet MLButton *smallWhiteSpinner;
@property (weak, nonatomic) IBOutlet UIView *smallSpinnerView;
@property (strong, nonatomic) MLSpinner *smallSpinner;
@end

@implementation MLSpinnerViewController

#pragma mark - Navigation
- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"Spinner";
	self.bigWhiteSpinner.buttonTitle = @"Big white spinner";
	[self.bigWhiteSpinner addTarget:self action:@selector(bigWhiteSpinner:) forControlEvents:UIControlEventTouchUpInside];
	self.bigBlueSpinner.buttonTitle = @"Big blue spinner";
	[self.bigBlueSpinner addTarget:self action:@selector(bigBlueSpinner:) forControlEvents:UIControlEventTouchUpInside];
	self.bigWhiteSpinnerWithText.buttonTitle = @"Big white spinner with text";
	[self.bigWhiteSpinnerWithText addTarget:self action:@selector(bigWhiteSpinnerWithText:) forControlEvents:UIControlEventTouchUpInside];
	self.bigBlueSpinnerWithText.buttonTitle = @"Big blue spinner with text";
	[self.bigBlueSpinnerWithText addTarget:self action:@selector(bigBlueSpinnerWithText:) forControlEvents:UIControlEventTouchUpInside];
	self.smallBlueSpinner.buttonTitle = @"Small blue spinner";
	[self.smallBlueSpinner addTarget:self action:@selector(smallBlueSpinner:) forControlEvents:UIControlEventTouchUpInside];
	self.smallWhiteSpinner.buttonTitle = @"Small white spinner";
	[self.smallWhiteSpinner addTarget:self action:@selector(smallWhiteSpinner:) forControlEvents:UIControlEventTouchUpInside];
	MLSpinnerConfig *config = [[MLSpinnerConfig alloc] initWithSize:MLSpinnerSizeSmall primaryColor:MLStyleSheetManager.styleSheet.whiteColor secondaryColor:MLStyleSheetManager.styleSheet.whiteColor];
	self.smallSpinner = [[MLSpinner alloc] initWithConfig:config text:nil];
	[self.smallSpinnerView addSubview:self.smallSpinner];

	[self.smallSpinnerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[smallSpinner]-0-|" options:0 metrics:nil views:@{@"smallSpinner" : self.smallSpinner}]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[smallSpinner]-0-|" options:0 metrics:nil views:@{@"smallSpinner" : self.smallSpinner}]];
}

#pragma mark - Setup
- (void)bigBlueSpinnerWithText:(id)sender
{
	[self.spinner hideSpinner];
	[self.smallSpinner hideSpinner];
	MLSpinnerConfig *config = [[MLSpinnerConfig alloc] initWithSize:MLSpinnerSizeBig primaryColor:MLStyleSheetManager.styleSheet.primaryColor secondaryColor:MLStyleSheetManager.styleSheet.secondaryColor];
	[self.spinner setUpSpinnerWithConfig:config];
	[self.spinner setText:@"Texto de soporte de hasta dos líneas"];
	[self.spinner showSpinner];
}

- (void)bigWhiteSpinnerWithText:(id)sender
{
	[self.spinner hideSpinner];
	[self.smallSpinner hideSpinner];
	MLSpinnerConfig *config = [[MLSpinnerConfig alloc] initWithSize:MLSpinnerSizeBig primaryColor:MLStyleSheetManager.styleSheet.whiteColor secondaryColor:MLStyleSheetManager.styleSheet.secondaryColor];
	[self.spinner setUpSpinnerWithConfig:config];
	[self.spinner setText:@"Texto"];
	[self.spinner showSpinner];
}

- (void)bigWhiteSpinner:(id)sender
{
	[self.spinner hideSpinner];
	[self.smallSpinner hideSpinner];
	MLSpinnerConfig *config = [[MLSpinnerConfig alloc] initWithSize:MLSpinnerSizeBig primaryColor:MLStyleSheetManager.styleSheet.whiteColor secondaryColor:MLStyleSheetManager.styleSheet.secondaryColor];
	[self.spinner setUpSpinnerWithConfig:config];
	[self.spinner setText:nil];
	[self.spinner showSpinner];
}

- (void)bigBlueSpinner:(id)sender
{
	[self.smallSpinner hideSpinner];
	MLSpinnerConfig *config = [[MLSpinnerConfig alloc] initWithSize:MLSpinnerSizeBig primaryColor:MLStyleSheetManager.styleSheet.primaryColor secondaryColor:MLStyleSheetManager.styleSheet.secondaryColor];
	[self.spinner setUpSpinnerWithConfig:config];
	[self.spinner setText:nil];
	[self.spinner showSpinner];
}

- (void)smallWhiteSpinner:(id)sender
{
	[self.spinner hideSpinner];
	[self.smallSpinner hideSpinner];
	MLSpinnerConfig *config = [[MLSpinnerConfig alloc] initWithSize:MLSpinnerSizeSmall primaryColor:MLStyleSheetManager.styleSheet.whiteColor secondaryColor:MLStyleSheetManager.styleSheet.whiteColor];
	[self.spinner setUpSpinnerWithConfig:config];
	[self.spinner showSpinner];
}

- (void)smallBlueSpinner:(id)sender
{
	[self.spinner hideSpinner];
	[self.smallSpinner hideSpinner];
	MLSpinnerConfig *config = [[MLSpinnerConfig alloc] initWithSize:MLSpinnerSizeSmall primaryColor:MLStyleSheetManager.styleSheet.secondaryColor secondaryColor:MLStyleSheetManager.styleSheet.secondaryColor];
	[self.spinner setUpSpinnerWithConfig:config];
	[self.spinner showSpinner];
}

@end
