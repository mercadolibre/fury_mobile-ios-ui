//
// MLHeaderControllerDemoSixthViewController.m
// MLUI
//
// Created by Cristian Gimenez on 08/04/2019.
// Copyright © 2019 MercadoLibre. All rights reserved.
//

#import "MLHeaderControllerDemoSixthViewController.h"

static NSString *const kMLCellIdentifier = @"cell";

@interface MLHeaderControllerDemoSixthViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation MLHeaderControllerDemoSixthViewController

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.title = @"Example 6";
	}
	return self;
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];

	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 100;
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

@end
