//
// MLHeaderControllerDemoFirstViewController.m
// MLUI
//
// Created by Cristian Gimenez on 08/04/2019.
// Copyright © 2019 MercadoLibre. All rights reserved.
//

#import "MLHeaderControllerDemoFirstViewController.h"
#import "MLSimpleHeaderView.h"

@interface MLHeaderControllerDemoFirstViewController ()
@property (nonatomic, copy) NSString *customTitle;
@end

@implementation MLHeaderControllerDemoFirstViewController

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.title = @"Example 1";
		self.customTitle = @"Example 1";
	}
	return self;
}

- (IBAction)changeTitleButtonDidTouch:(id)sender
{
	if ([self.customTitle isEqualToString:@"Example 1"]) {
		self.customTitle = @"First Example";
		self.title = @"First Example";
	} else {
		self.customTitle = @"Example 1";
		self.title = @"Example 1";
	}
}

- (BOOL)shouldScrollContent
{
	return YES;
}

@end
