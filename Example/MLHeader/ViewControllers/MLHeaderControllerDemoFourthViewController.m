//
// MLHeaderControllerDemoFourthViewController.m
// MLUI
//
// Created by Cristian Gimenez on 08/04/2019.
// Copyright © 2019 MercadoLibre. All rights reserved.
//

#import "MLHeaderControllerDemoFourthViewController.h"

static NSString *const kMLCellIdentifier = @"cell";

@interface MLHeaderControllerDemoFourthViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation MLHeaderControllerDemoFourthViewController

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.title = @"Example 4";
	}
	return self;
}

- (void)viewDidLoad
{
	[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kMLCellIdentifier];
	[super viewDidLoad];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return 200;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMLCellIdentifier forIndexPath:indexPath];
	cell.backgroundColor = [UIColor lightGrayColor];
	return cell;
}

- (BOOL)shouldScrollContent
{
	return YES;
}

- (UIScrollView *)scrollViewForHeader
{
	return self.collectionView;
}

@end
