//
// MLHeaderControllerDemoFifthViewController.m
// MLUI
//
// Created by Cristian Gimenez on 08/04/2019.
// Copyright © 2019 MercadoLibre. All rights reserved.
//

#import "MLHeaderControllerDemoFifthViewController.h"

static NSString *const kMLCellIdentifier = @"cell";

@interface MLHeaderControllerDemoFifthViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation MLHeaderControllerDemoFifthViewController

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.title = @"Example 5";
	}
	return self;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	self.headerViewController.mode = MLUIHeaderModeAlwaysCollapsed;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMLCellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMLCellIdentifier];
	}

	cell.textLabel.text = [NSString stringWithFormat:@"Item %ld", (long)indexPath.row];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.navigationController pushViewController:[[MLHeaderControllerDemoFifthViewController alloc] init] animated:YES];
}

- (BOOL)shouldScrollContent
{
	return YES;
}

- (UIScrollView *)scrollViewForHeader
{
	return self.tableView;
}

@end
