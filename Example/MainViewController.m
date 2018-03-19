//
// MainViewController.m
// MLUI
//
// Created by Julieta Puente on 11/1/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MainViewController.h"
#import "LegacyExampleViewController.h"
#import "ExampleViewController.h"
#import "MLColorPaletteViewController.h"
#import "MLButton.h"
#import "UIColor+MLColorPalette.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet MLButton *legacyUILib;
@property (weak, nonatomic) IBOutlet MLButton *UILib;

@end

@implementation MainViewController

#pragma mark - Navigation
- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"UI Lib";
	self.legacyUILib.buttonTitle = @"Legacy UI Lib (Deprecated)";
	[self.legacyUILib addTarget:self action:@selector(goToLegacyUI:) forControlEvents:UIControlEventTouchUpInside];
	[self.legacyUILib setStyle:MLButtonStyleSecondaryAction];
	self.UILib.buttonTitle = @"UI Lib";
	[self.UILib addTarget:self action:@selector(goToUI:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Action
- (void)goToLegacyUI:(id)sender
{
	LegacyExampleViewController *controller = [[LegacyExampleViewController alloc] init];
	[self.navigationController pushViewController:controller animated:YES];
}

- (void)goToUI:(id)sender
{
	ExampleViewController *exampleController = [[ExampleViewController alloc] init];
	[self.navigationController pushViewController:exampleController animated:YES];
}

@end
