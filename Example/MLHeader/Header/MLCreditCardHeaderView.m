//
// MLCreditCardHeaderView.m
// MLUI
//
// Created by Cristian Gimenez on 08/04/2019.
// Copyright © 2019 MercadoLibre. All rights reserved.
//

#import "MLCreditCardHeaderView.h"

@implementation MLCreditCardHeaderView

+ (instancetype)creditCardHeaderView
{
	return [[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:self options:nil].firstObject;
}

@end
