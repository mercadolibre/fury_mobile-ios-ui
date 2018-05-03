//
// MLStyleSheetTest.m
// MLUI
//
// Created by Cristian Leonel Gibert on 2/1/18.
// Copyright © 2018 MercadoLibre. All rights reserved.
//

#import "MLStyleSheetTest.h"

@implementation MLStyleSheetTest

#pragma mark Colors
- (UIColor *)primaryColor
{
	return [UIColor colorWithRed:0.20 green:0.70 blue:0.08 alpha:1.0];
}

- (UIColor *)lightPrimaryColor
{
	return [UIColor colorWithRed:1.00 green:0.30 blue:0.50 alpha:1.0];
}

- (UIColor *)secondaryColor
{
	return [UIColor colorWithRed:0.12 green:0.30 blue:0.98 alpha:1.0];
}

- (UIColor *)secondaryColorPressed
{
	return [UIColor colorWithRed:0.15 green:0.58 blue:0.73 alpha:1.0];
}

- (UIColor *)secondaryColorDisabled
{
	return [UIColor colorWithRed:0.84 green:0.60 blue:1.00 alpha:1.0];
}

- (UIColor *)successColor
{
	return [UIColor colorWithRed:0.62 green:0.21 blue:0.29 alpha:1.0];
}

- (UIColor *)warningColor
{
    return [UIColor colorWithRed:0.98 green:0.67 blue:0.38 alpha:1.0];
}

- (UIColor *)errorColor
{
	return [UIColor colorWithRed:0.24 green:0.19 blue:0.29 alpha:1.0];
}

- (UIColor *)blackColor
{
	return [UIColor colorWithRed:0.60 green:0.16 blue:0.20 alpha:1.0];
}

- (UIColor *)darkGreyColor
{
	return [UIColor colorWithRed:0.40 green:0.20 blue:0.40 alpha:1.0];
}

- (UIColor *)greyColor
{
	return [UIColor colorWithRed:0.60 green:0.30 blue:0.60 alpha:1.0];
}

- (UIColor *)midGreyColor
{
	return [UIColor colorWithRed:0.80 green:0.40 blue:0.80 alpha:1.0];
}

- (UIColor *)lightGreyColor
{
	return [UIColor colorWithRed:0.93 green:0.47 blue:0.93 alpha:1.0];
}

- (UIColor *)whiteColor
{
	return [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0];
}

- (UIColor *)modalBackgroundColor
{
	return [UIColor colorWithRed:1.00 green:0.86 blue:0.08 alpha:1.0];
}

- (UIColor *)modalTintColor
{
	return [UIColor colorWithRed:0.20 green:0.20 blue:0.20 alpha:1.0];
}

#pragma mark Fonts
- (UIFont *)regularSystemFontOfSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
}

- (UIFont *)boldSystemFontOfSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize];
}

- (UIFont *)thinSystemFontOfSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:fontSize];
}

- (UIFont *)lightSystemFontOfSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
}

- (UIFont *)mediumSystemFontOfSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"HelveticaNeue-Medium" size:fontSize];
}

- (UIFont *)semiboldSystemFontOfSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize];
}

- (UIFont *)extraboldSystemFontOfSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:fontSize];
}

- (UIFont *)blackSystemFontOfSize:(CGFloat)fontSize
{
	return [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:fontSize];
}

@end
