//
// MLHeaderControllerDemoSecondViewController.m
// MLUI
//
// Created by Cristian Gimenez on 08/04/2019.
// Copyright © 2019 MercadoLibre. All rights reserved.
//

#import "MLHeaderControllerDemoSecondViewController.h"

@interface MLHeaderControllerDemoSecondViewController ()

@end

@implementation MLHeaderControllerDemoSecondViewController

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.title = @"Example 2";
	}
	return self;
}

- (BOOL)shouldScrollContent
{
	return YES;
}

@end
