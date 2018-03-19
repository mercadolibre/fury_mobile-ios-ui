//
// MLButtonConfigStyle.m
// Pods
//
// Created by Cristian Leonel Gibert on 1/12/17.
//
//

#import "MLButtonConfigStyle.h"

@implementation MLButtonConfigStyle

- (instancetype)initWithContentColor:(UIColor *)contentColor backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor
{
	if (self = [super init]) {
		_contentColor = contentColor;
		_backgroundColor = backgroundColor;
		_borderColor = borderColor;
	}
	return self;
}

@end
