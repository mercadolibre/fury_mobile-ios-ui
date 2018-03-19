//
// MLCheckButtonViewController.m
// MLUI
//
// Created by Santiago Lazzari on 6/13/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLCheckButtonViewController.h"

#import "MLButton.h"
#import "MLCheckButton.h"
#import "MLCheckList.h"

@interface MLCheckButtonViewController ()

#pragma mark - Animation Test
@property (weak, nonatomic) IBOutlet MLButton *radioButtonTrigger;
@property (weak, nonatomic) IBOutlet MLCheckButton *radioButton;

#pragma mark - Collection Test
@property (weak, nonatomic) IBOutlet MLButton *item1Button;
@property (weak, nonatomic) IBOutlet MLButton *item2Button;
@property (weak, nonatomic) IBOutlet MLButton *item3Button;

@property (weak, nonatomic) IBOutlet MLCheckButton *item1CheckButton;
@property (weak, nonatomic) IBOutlet MLCheckButton *item2CheckButton;
@property (weak, nonatomic) IBOutlet MLCheckButton *item3CheckButton;
@property MLCheckList *checkList;

@end

@implementation MLCheckButtonViewController

#pragma mark - Navigation
- (void)viewDidLoad
{
	[super viewDidLoad];

	[self setupRadioButton];
	[self setupRadioButtonCollection];
	[self setupTitle];
}

#pragma mark - Setup
- (void)setupRadioButton
{
	self.radioButtonTrigger.buttonTitle = @"Animation";
	[self.radioButtonTrigger addTarget:self action:@selector(triggerRadioButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupRadioButtonCollection
{
	self.checkList = [MLCheckList checkListWithCheckButtons:@[self.item1CheckButton, self.item2CheckButton, self.item3CheckButton]];

	self.item1Button.buttonTitle = @"Item 1";
	[self.item1Button addTarget:self action:@selector(item1WasTapped:) forControlEvents:UIControlEventTouchUpInside];

	self.item2Button.buttonTitle = @"Item 2";
	[self.item2Button addTarget:self action:@selector(item2WasTapped:) forControlEvents:UIControlEventTouchUpInside];

	self.item3Button.buttonTitle = @"Item 3";
	[self.item3Button addTarget:self action:@selector(item3WasTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupTitle
{
	self.title = @"Check Button";
}

#pragma mark - Actions
- (void)triggerRadioButton:(id)sender
{
	[self.radioButton toggleFillClear];
}

- (void)item1WasTapped:(id)sender
{
	[self.checkList toggleCheckButtonAtIndex:0];
}

- (void)item2WasTapped:(id)sender
{
	[self.checkList toggleCheckButtonAtIndex:1];
}

- (void)item3WasTapped:(id)sender
{
	[self.checkList toggleCheckButtonAtIndex:2];
}

@end
