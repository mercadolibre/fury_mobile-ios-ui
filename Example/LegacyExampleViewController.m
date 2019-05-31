//
// ViewController.m
// MLUI
//
// Created by Fabian Celdeiro on 9/10/14.
// Copyright (c) 2014 MercadoLibre. All rights reserved.
//

#import "MLUIActionButtonViewController.h"
#import "PriceViewController.h"
#import "LegacyExampleViewController.h"
#import "MLUISnackBarExampleViewController.h"
#import "MLUIActionButtonInXibViewController.h"

@interface LegacyExampleViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *componentsNamesArray;

@end

@implementation LegacyExampleViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.tableView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:self.tableView];

	// El nombre del componente, matchea con un metodo con el mismo nombre que pushea un controller que muestra el componente
	NSArray *arrayToSort = @[@"mlUIPriceView", @"mlUIActionButton", @"mlUIActionButtonIntoXib", @"mlUIImageTransformations", @"mlUISnackBarView"];
	[self sortArrayByName:arrayToSort];
}

- (void)mlUIPriceView
{
	PriceViewController *controller = [[PriceViewController alloc] initWithNibName:nil bundle:nil];
	[self.navigationController pushViewController:controller animated:YES];
}

- (void)mlUISnackBarView
{
	MLUISnackBarExampleViewController *exampleViewController = [[MLUISnackBarExampleViewController alloc] initWithNibName:nil bundle:nil];
	[self.navigationController pushViewController:exampleViewController animated:YES];

	[exampleViewController showSnackBar];
}

- (void)mlUIActionButton
{
	MLUIActionButtonViewController *controller = [[MLUIActionButtonViewController alloc] initWithNibName:nil bundle:nil];
	[self.navigationController pushViewController:controller animated:YES];
}

- (void)mlUIActionButtonIntoXib
{
	MLUIActionButtonInXibViewController *controller = [[MLUIActionButtonInXibViewController alloc] initWithNibName:nil bundle:nil];
	[self.navigationController pushViewController:controller animated:YES];
}

- (void)sortArrayByName:(NSArray *)array
{
	NSArray *sortedArray = [array sortedArrayUsingSelector:
		                    @selector(localizedCaseInsensitiveCompare:)];
	self.componentsNamesArray = [[NSMutableArray alloc] initWithArray:sortedArray];
}

#pragma mark - UITableViewDelegate and UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.componentsNamesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCell"];

	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCell"];
	}

	cell.textLabel.text = self.componentsNamesArray[indexPath.row];

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *stringSelector = self.componentsNamesArray[indexPath.row];

	SEL selector = NSSelectorFromString(stringSelector);

	if ([self respondsToSelector:selector]) {
		#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
		[self performSelector:selector withObject:nil];
	} else {
		Class vcClass = NSClassFromString(stringSelector);
		UIViewController *viewController = [[vcClass alloc] initWithNibName:nil bundle:nil];
		[self.navigationController pushViewController:viewController animated:YES];
	}

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
