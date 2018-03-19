//
// MLContextualMenuTableViewController.m
// MLUI
//
// Created by Nicolas Guido Brucchieri on 5/6/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLContextualMenuTableViewController.h"
#import <MLUI/MLContextualMenu.h>
#import <MLUI/MLSnackbar.h>
#import <MLUI/UIColor+MLColorPalette.h>

@interface MLContextualMenuTableViewController () <UIGestureRecognizerDelegate, MLContextualMenuDataSource, MLContextualMenuDelegate>

@end

@implementation MLContextualMenuTableViewController

#pragma mark - Navigation
- (void)viewDidLoad
{
	[super viewDidLoad];
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
	[self setupBookmarksLongPressRecognizer];
	[self setupBackgroundColor];
}

#pragma mark - Setup
- (void)setupBookmarksLongPressRecognizer
{
	MLContextualMenu *contextualMenu = [[MLContextualMenu alloc] init];
	contextualMenu.dataSource = self;
	contextualMenu.delegate = self;
	UILongPressGestureRecognizer *gestureRecognizer = [contextualMenu gestureRecognizerWithDelegate:self];
	// to keep in memory you need to addGestureRecognizer(gestureRecognizer) to a ViewController
	[self.tableView addGestureRecognizer:gestureRecognizer];
}

- (void)setupBackgroundColor
{
	self.view.backgroundColor = [UIColor ml_meli_light_grey];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
	cell.textLabel.text = @"Test";
	cell.backgroundColor = [UIColor clearColor];
	return cell;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
	BOOL isScrolling = self.tableView.isDragging || self.tableView.isDecelerating;
	return !([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] && isScrolling);
}

#pragma mark - MLContextualMenuDataSource
- (NSArray <MLContextualMenuItem *> *)contextualMenu:(MLContextualMenu *)contextualMenu itemsAtPoint:(CGPoint)point
{
	NSArray *myArray = @[
		[[MLContextualMenuItem alloc] initWithText:@"Favorites" image:[UIImage imageNamed:@"MLUI_ic_fav_off"] selected:NO],
		[[MLContextualMenuItem alloc] initWithText:@"Share" image:[UIImage imageNamed:@"MLUI_ic_share"] selected:NO],
	];
	return myArray;
}

#pragma mark - MLContextualMenuDelegate
- (void)contextualMenu:(MLContextualMenu *)contextualMenu didSelectItemAtIndex:(NSInteger)selectedIndex atPoint:(CGPoint)point
{
	NSString *snackbarText = [NSString stringWithFormat:@"User press option %ld", selectedIndex];
	[MLSnackbar showWithTitle:snackbarText actionTitle:nil actionBlock:nil type:[MLSnackbarType defaultType] duration:MLSnackbarDurationLong dismissGestureEnabled:@YES];
}

@end
