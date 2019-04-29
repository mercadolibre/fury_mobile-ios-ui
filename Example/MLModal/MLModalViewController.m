//
// MLModalViewController.m
// MLUI
//
// Created by Julieta Puente on 18/3/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLModalViewController.h"
#import <MLUI/MLButton.h>
#import <MLUI/MLFullscreenModal.h>
#import <MLUI/MLModal.h>
#import <MLUI/UIColor+MLColorPalette.h>
#import <MLUI/MLStyleSheetManager.h>
#import "MLModalInnerViewController.h"

@interface MLModalViewController ()
@property (weak, nonatomic) IBOutlet MLButton *plainModal;
@property (weak, nonatomic) IBOutlet MLButton *modalWithTitle;
@property (weak, nonatomic) IBOutlet MLButton *modalWithButtons;
@property (strong, nonatomic) UIView *viewWithConstraints;
@property (weak, nonatomic) IBOutlet MLButton *modalMP;

@end

@implementation MLModalViewController

#pragma mark - Navigation
- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"MLModal";
	self.plainModal.buttonTitle = @"Plain modal";
	self.modalWithTitle.buttonTitle = @"Modal with Title";
	self.modalWithButtons.buttonTitle = @"Modal with Title and button";
	self.modalMP.buttonTitle = @"Modal MP";
}

#pragma mark - Action
- (IBAction)showPlainModal:(id)sender
{
	[MLModal showModalWithViewController:[[MLModalInnerViewController alloc] init]];
}

- (IBAction)showTitleModal:(id)sender
{
	[MLModal showModalWithViewController:[[MLModalInnerViewController alloc] init] title:@"Title" actionTitle:nil actionBlock:nil];
}

- (IBAction)showButtonModal:(id)sender
{
	[MLModal showModalWithViewController:[[MLModalInnerViewController alloc] init] title:@"Title" actionTitle:@"Button" actionBlock: ^{NSLog(@"Button tapped");
	} secondaryActionTitle:@"Apply" secondaryActionBlock: ^{NSLog(@"Secondary button tapped");
	} dismissBlock:nil enableScroll:YES];
}

- (IBAction)showModalMP:(id)sender
{
	[MLModal showModalWithViewController:[[MLModalInnerViewController alloc] init] title:@"Title" actionTitle:nil actionBlock:nil secondaryActionTitle:nil secondaryActionBlock:nil dismissBlock:nil enableScroll:YES];
}

@end
