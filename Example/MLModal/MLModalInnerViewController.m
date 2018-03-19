//
// MLModalInnerViewController.m
// MLUI
//
// Created by Martin Heras on 4/8/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLModalInnerViewController.h"

@interface MLModalInnerViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation MLModalInnerViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	NSLog(@"MODAL INNER VC: viewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	NSLog(@"MODAL INNER VC: viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	NSLog(@"MODAL INNER VC: viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	NSLog(@"MODAL INNER VC: viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	NSLog(@"MODAL INNER VC: viewDidDisappear");
}

- (IBAction)onButtonDidTouch:(id)sender
{
	NSLog(@"MODAL INNER VC: onButtonDidTouch");
	[self.textField resignFirstResponder];
}

@end
