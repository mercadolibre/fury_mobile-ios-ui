//
// WidgetsViewController.m
// MLUI
//
// Created by Julieta Puente on 28/3/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLWidgetsViewController.h"

#import "MLModalViewController.h"
#import "MLSnackbarViewController.h"
#import "MLSpinnerViewController.h"
#import "MLBooleanWidgetViewController.h"
#import <MLUI/UIColor+MLColorPalette.h>
#import "MLButtonViewController.h"
#import "MLTitledTextFieldViewController.h"
#import "MLContextualMenuTableViewController.h"
#import <MLUI/MLGenericErrorView.h>
#import "MLTextViewController.h"

@interface MLWidgetsViewController ()

@property (weak, nonatomic) IBOutlet MLButton *buttonsButton;
@property (weak, nonatomic) IBOutlet MLButton *snackBarButton;
@property (weak, nonatomic) IBOutlet MLButton *modalButton;
@property (weak, nonatomic) IBOutlet MLButton *spinnerButton;
@property (weak, nonatomic) IBOutlet MLButton *textFieldButton;
@property (weak, nonatomic) IBOutlet MLButton *booleanWidgetButton;
@property (weak, nonatomic) IBOutlet MLButton *contextualMenuButton;
@property (weak, nonatomic) IBOutlet MLButton *errorViewButton;
@property (weak, nonatomic) IBOutlet MLButton *textViewButton;

@end

@implementation MLWidgetsViewController

#pragma mark - Navigation
- (void)viewDidLoad
{
	[super viewDidLoad];

	self.modalButton.buttonTitle = @"Modal";
	[self.modalButton addTarget:self action:@selector(showModal:) forControlEvents:UIControlEventTouchUpInside];

	self.snackBarButton.buttonTitle = @"SnackBar";
	[self.snackBarButton addTarget:self action:@selector(showSnackBar:) forControlEvents:UIControlEventTouchUpInside];

	self.spinnerButton.buttonTitle = @"Spinner";
	[self.spinnerButton addTarget:self action:@selector(showSpinner:) forControlEvents:UIControlEventTouchUpInside];

	self.booleanWidgetButton.buttonTitle = @"CheckBox, RadioButton & Switch";
	[self.booleanWidgetButton addTarget:self action:@selector(showBooleanWidgets:) forControlEvents:UIControlEventTouchUpInside];

	self.buttonsButton.buttonTitle = @"Buttons";
	[self.buttonsButton addTarget:self action:@selector(showButtons:) forControlEvents:UIControlEventTouchUpInside];

	self.textFieldButton.buttonTitle = @"Titled TextField";
	[self.textFieldButton addTarget:self action:@selector(showTextField:) forControlEvents:UIControlEventTouchUpInside];

	self.contextualMenuButton.buttonTitle = @"Contextual Menu";
	[self.contextualMenuButton addTarget:self action:@selector(showContextualMenu:) forControlEvents:UIControlEventTouchUpInside];

	self.errorViewButton.buttonTitle = @"Error View";
	[self.errorViewButton addTarget:self action:@selector(showErrorView:) forControlEvents:UIControlEventTouchUpInside];

	self.textViewButton.buttonTitle = @"Text View";
	[self.textViewButton addTarget:self action:@selector(showTextView:) forControlEvents:UIControlEventTouchUpInside];

	[self setupTitle];
}

#pragma mark - Setup
- (void)setupTitle
{
	self.title = @"Widgets";
}

#pragma mark - Actions
- (void)showModal:(id)sender
{
	MLModalViewController *controller = [[MLModalViewController alloc]init];
	[self.navigationController pushViewController:controller animated:YES];
}

- (void)showSnackBar:(id)sender
{
	MLSnackbarViewController *controller = [[MLSnackbarViewController alloc] init];
	[self.navigationController pushViewController:controller animated:YES];
}

- (void)showSpinner:(id)sender
{
	MLSpinnerViewController *controller = [[MLSpinnerViewController alloc] init];
	[self.navigationController pushViewController:controller animated:YES];
}

- (void)showBooleanWidgets:(id)sender
{
	MLBooleanWidgetViewController *controller = [[MLBooleanWidgetViewController alloc]init];
	[self.navigationController pushViewController:controller animated:YES];
}

- (void)showButtons:(id)sender
{
	MLButtonViewController *controller = [[MLButtonViewController alloc]init];
	[self.navigationController pushViewController:controller animated:YES];
}

- (void)showTextField:(id)sender
{
	MLTitledTextFieldViewController *controller = [[MLTitledTextFieldViewController alloc]init];
	[self.navigationController pushViewController:controller animated:YES];
}

- (void)showContextualMenu:(id)sender
{
	MLContextualMenuTableViewController *controller = [[MLContextualMenuTableViewController alloc]init];
	[self.navigationController pushViewController:controller animated:YES];
}

- (void)showErrorView:(id)sender
{
	UIViewController *errorViewController = [[UIViewController alloc] init];
	MLGenericErrorView *errorView = [MLGenericErrorView genericErrorViewWithImage:[UIImage imageNamed:@"MLNetworkError"]
		                                                                    title:@"¡Parece que no hay Internet!"
		                                                                 subtitle:@"Revisa tu conexión para seguir navegando."
		                                                              buttonTitle:@"Reintentar"
		                                                              actionBlock: ^{
		NSLog(@"For test app, retry button can have a nil action.");
	}];
	errorViewController.view = errorView;
	[self.navigationController pushViewController:errorViewController animated:YES];
}

- (void)showTextView:(id)sender
{
	MLTextViewController *controller = [[MLTextViewController alloc]init];
	[self.navigationController pushViewController:controller animated:YES];
}

@end
