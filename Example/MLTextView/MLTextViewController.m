//
// MLTextViewController.m
// MLUI
//
// Created by MAURO CARREÑO on 5/18/17.
// Copyright © 2017 MercadoLibre. All rights reserved.
//

#import "MLTextViewController.h"
#import <MLUI/MLTextView.h>
#import <MLUI/UIFont+MLFonts.h>

@interface MLTextViewController ()

@property (strong, nonatomic) IBOutlet MLTextView *customPlaceholderTextView;
@property (strong, nonatomic) IBOutlet MLTextView *customTextAndPlaceholderTextView;
@property (strong, nonatomic) IBOutlet MLTextView *customTextTextView;
@property (strong, nonatomic) IBOutlet MLTextView *customEmptyTextView;
@property (strong, nonatomic) IBOutlet MLTextView *customFontTextView;
@property (strong, nonatomic) IBOutlet MLTextView *customFixedSizeTextView;

@end

@implementation MLTextViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.

	[self customizeTextViews];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)customizeTextViews
{
	// 1
	// Nothing to do

	// 2
	[self.customTextAndPlaceholderTextView setText:@"Text + Placeholder"];

	// 3
	[self.customTextTextView setText:@"Text only"];

	// 4
	// Nothing to do

	// 5
	[self.customFontTextView.textView setFont:[UIFont ml_extraboldSystemFontOfSize:26]];
	[self.customFontTextView.textViewPlaceholder setFont:[UIFont ml_extraboldSystemFontOfSize:26]];
	[self.customFontTextView styleHasChanged];

	[self.customFontTextView setText:@"Custom font"];

	// 6
	// Nothing to do
}

@end
