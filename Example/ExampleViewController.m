//
// ExampleViewController.m
// MLUI
//
// Created by Julieta Puente on 11/1/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "ExampleViewController.h"
#import "MLColorPaletteViewController.h"
#import "MLFontsViewController.h"
#import <MLUI/MLButton.h>
#import "MLWidgetsViewController.h"
#import "MLHtmlViewController.h"
#import <MLUI/UIColor+MLColorPalette.h>
#import "MLStyleViewController.h"
#import "MLStyleSheetViewController.h"

@interface ExampleViewController ()
@property (weak, nonatomic) IBOutlet MLButton *fontsButton;
@property (weak, nonatomic) IBOutlet MLButton *colorPaletteButton;
@property (weak, nonatomic) IBOutlet MLButton *widgetsButton;
@property (weak, nonatomic) IBOutlet MLButton *styleButton;
@property (weak, nonatomic) IBOutlet MLButton *htmlButton;
@property (weak, nonatomic) IBOutlet MLButton *styleSheetButton;

@end

@implementation ExampleViewController

#pragma mark - Navigation
- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"New UI";

	self.fontsButton.buttonTitle = @"Fonts";
	[self.fontsButton addTarget:self action:@selector(showFonts:) forControlEvents:UIControlEventTouchUpInside];

	self.colorPaletteButton.buttonTitle = @"Color Palette";
	[self.colorPaletteButton addTarget:self action:@selector(showColorPallete:) forControlEvents:UIControlEventTouchUpInside];

	self.styleButton.buttonTitle = @"Style";
	[self.styleButton addTarget:self action:@selector(showStyle:) forControlEvents:UIControlEventTouchUpInside];

	self.widgetsButton.buttonTitle = @"Widgets";
	[self.widgetsButton addTarget:self action:@selector(showWidgetsController:) forControlEvents:UIControlEventTouchUpInside];

	self.htmlButton.buttonTitle = @"Html";
	[self.htmlButton addTarget:self action:@selector(showHtml:) forControlEvents:UIControlEventTouchUpInside];

	self.styleSheetButton.buttonTitle = @"StyleSheet";
	[self.styleSheetButton addTarget:self action:@selector(showStyleSheetController:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Actions
- (void)showColorPallete:(id)sender
{
	MLColorPaletteViewController *controller = [[MLColorPaletteViewController alloc] init];
	[self.navigationController pushViewController:controller animated:YES];
}

- (void)showFonts:(id)sender
{
	MLFontsViewController *controller = [[MLFontsViewController alloc] init];
	[self.navigationController pushViewController:controller animated:YES];
}

- (void)showWidgetsController:(id)sender
{
	MLWidgetsViewController *controller = [[MLWidgetsViewController alloc] init];
	[self.navigationController pushViewController:controller animated:YES];
}

- (void)showStyle:(id)sender
{
	MLStyleViewController *controller = [[MLStyleViewController alloc] init];
	[self.navigationController pushViewController:controller animated:YES];
}

- (void)showHtml:(id)sender
{
	MLHtmlViewController *controller = [[MLHtmlViewController alloc] init];
	[self.navigationController pushViewController:controller animated:YES];
}

- (void)showStyleSheetController:(id)sender
{
	MLStyleSheetViewController *controller = [[MLStyleSheetViewController alloc] init];
	[self.navigationController pushViewController:controller animated:YES];
}

@end
