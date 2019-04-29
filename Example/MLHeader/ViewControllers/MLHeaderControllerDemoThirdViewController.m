//
// MLHeaderControllerDemoThirdViewController.m
// MLUI
//
// Created by Cristian Gimenez on 08/04/2019.
// Copyright © 2019 MercadoLibre. All rights reserved.
//

#import "MLHeaderControllerDemoThirdViewController.h"
#import "MLCreditCardHeaderView.h"
#import <MLUI/MLUIHeader.h>

static NSString *const kMLCellIdentifier = @"cell";

@interface MLHeaderControllerDemoThirdViewController () <UITableViewDataSource, UITableViewDelegate, MLUIHeaderDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MLCreditCardHeaderView *creditCardHeaderView;
@property (nonatomic, strong) MLUIHeader *headerViewController;

@end

@implementation MLHeaderControllerDemoThirdViewController

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.title = @"Example 3";
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.creditCardHeaderView = [MLCreditCardHeaderView creditCardHeaderView];

	_headerViewController = [[MLUIHeader alloc] init];
	_headerViewController.delegate = self;
	[self addChildViewController:_headerViewController];
	[self.view addSubview:_headerViewController.view];
	[_headerViewController didMoveToParentViewController:self];
	_headerViewController.navigationBarBackgroundcolor = [UIColor colorWithRed:0.220f green:0.647f blue:0.463f alpha:1.00f];
}

- (BOOL)shouldTrackPageView
{
	return NO;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.navigationController pushViewController:[[MLHeaderControllerDemoThirdViewController alloc] init] animated:YES];
}

- (BOOL)shouldScrollContent
{
	return YES;
}

- (UIView *)contentView
{
	return nil;
}

- (UIScrollView *)scrollViewForHeader
{
	return self.tableView;
}

- (UIView *)headerView
{
	return self.creditCardHeaderView;
}

- (CGFloat)parallaxEffectCoefficient
{
	return 0.5f;
}

- (CGFloat)minNavigationBarVisibilityThresholdForHeaderHeight:(CGFloat)headerHeight
{
	return 40.0f;
}

- (CGFloat)maxNavigationBarVisibilityThresholdForHeaderHeight:(CGFloat)headerHeight
{
	return 180.0f;
}

@end
