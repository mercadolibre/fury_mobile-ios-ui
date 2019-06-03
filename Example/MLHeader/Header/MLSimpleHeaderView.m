//
// MLSimpleHeaderView.m
// MLUI
//
// Created by Cristian Gimenez on 08/04/2019.
// Copyright © 2019 MercadoLibre. All rights reserved.
//

#import "MLSimpleHeaderView.h"
#import <MLUI/UILabel+MLStyle.h>

static const CGFloat kMLSimpleHeaderViewAnimationDuration = 0.3f;

@interface MLSimpleHeaderView ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end

@implementation MLSimpleHeaderView

+ (instancetype)simpleHeaderView
{
	return [[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:self options:nil].firstObject;
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	[self.titleLabel ml_setStyle:MLStyleLightXLarge];
}

- (void)setTitle:(NSString *)title
{
	__weak typeof(self)weakSelf = self;

	[UIView transitionWithView:self.titleLabel duration:kMLSimpleHeaderViewAnimationDuration options:UIViewAnimationOptionTransitionCrossDissolve animations: ^{
	    weakSelf.titleLabel.text = title;
	} completion:nil];
}

- (NSString *)title
{
	return self.titleLabel.text;
}

@end
