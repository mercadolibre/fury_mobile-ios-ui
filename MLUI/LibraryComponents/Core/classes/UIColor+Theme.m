//
// UIColor+MercadoLibre.m
// MercadoLibre
//
// Created by Fabian Celdeiro on 8/22/12.
// Copyright (c) 2012 Casa. All rights reserved.
//

#import "UIColor+Theme.h"

@implementation UIColor (MercadoLibre)

+ (UIColor *)ml_textDefaultColor
{
	return [UIColor colorWithRed:84.0 / 255.0 green:84.0 / 255.0 blue:84.0 / 255.0 alpha:1.0];
}

+ (UIColor *)ml_textSecondaryColor
{
	return nil;
}

+ (UIColor *)ml_textSubtitleColor
{
	return [UIColor colorWithRed:0.0 green:102.0 / 255.0 blue:255.0 alpha:1.0];
}

+ (UIColor *)ml_backgroundDefaultColor;
{
	return [UIColor groupTableViewBackgroundColor];
}
+ (UIColor *)ml_cellBackgroundDefaultColor
{
	// return [UIColor colorWithRed:247.0 / 255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0];
	return [UIColor whiteColor];
}

+ (UIColor *)ml_tableViewBackgroundDefaultColor
{
	return [UIColor whiteColor];
}

+ (UIColor *)ml_bigErrorBackgroundDefaultColor
{
	return [UIColor colorWithRed:204.0 / 255.0 green:204.0 / 255.0 blue:204.0 / 255.0 alpha:1.0];
}

+ (UIColor *)ml_priceColor
{
	return [UIColor colorWithRed:168.f / 255.f green:40.f / 255.f blue:41.f / 255.f alpha:1];
}

+ (UIColor *)ml_colorWith255Red:(NSInteger)red withGreen:(NSInteger)green withBlue:(NSInteger)blue
{
	return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1.0];
}

+ (UIColor *)ml_colorWith255Red:(NSInteger)red withGreen:(NSInteger)green withBlue:(NSInteger)blue withAlpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

+ (UIColor *)ml_colorWith255RedAnd255GreenAnd255BlueAndAlpha:(NSString *)color withSeparator:(NSString *)separator
{
	NSArray *splitColor = [color componentsSeparatedByString:separator];
	return [self ml_colorWith255Red:[splitColor[0] integerValue]  withGreen:[splitColor[1] integerValue] withBlue:[splitColor[2] integerValue] withAlpha:[splitColor[3] floatValue]];
}

+ (UIColor *)ml_mercadoLibreLightBlueColor
{
	return [UIColor ml_colorWith255Red:233 withGreen:238 withBlue:253];
}

+ (UIColor *)ml_mercadoLibreBlueColor
{
	return [UIColor ml_colorWith255Red:43 withGreen:50 withBlue:116];
}

+ (UIColor *)ml_errorCellColor
{
	return [self ml_colorWithHexString:@"B34C42"];
}

+ (UIColor *)ml_warningCellColor
{
	return [self ml_colorWith255Red:170 withGreen:133 withBlue:71];
}

+ (UIColor *)ml_colorWithHexString:(NSString *)hexString
{
	NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
	CGFloat alpha, red, blue, green;
	switch ([colorString length]) {
		case 3: { // #RGB
			alpha = 1.0f;
			red = [self colorComponentFrom:colorString start:0 length:1];
			green = [self colorComponentFrom:colorString start:1 length:1];
			blue = [self colorComponentFrom:colorString start:2 length:1];
			break;
		}

		case 4: { // #ARGB
			alpha = [self colorComponentFrom:colorString start:0 length:1];
			red = [self colorComponentFrom:colorString start:1 length:1];
			green = [self colorComponentFrom:colorString start:2 length:1];
			blue = [self colorComponentFrom:colorString start:3 length:1];
			break;
		}

		case 6: { // #RRGGBB
			alpha = 1.0f;
			red = [self colorComponentFrom:colorString start:0 length:2];
			green = [self colorComponentFrom:colorString start:2 length:2];
			blue = [self colorComponentFrom:colorString start:4 length:2];
			break;
		}

		case 8: { // #AARRGGBB
			alpha = [self colorComponentFrom:colorString start:0 length:2];
			red = [self colorComponentFrom:colorString start:2 length:2];
			green = [self colorComponentFrom:colorString start:4 length:2];
			blue = [self colorComponentFrom:colorString start:6 length:2];
			break;
		}

		default: {
			[NSException raise:@"Invalid color value" format:@"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
			break;
		}
	}
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length
{
	NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
	NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
	unsigned hexComponent;
	[[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
	return hexComponent / 255.0;
}

+ (UIColor *)ml_tableViewMisComprasBackgroundColor
{
	return [UIColor colorWithRed:236.f / 255.f green:231.f / 255.f blue:227.f / 255.f alpha:1];
}

+ (UIColor *)ml_tableViewMisComprasFooterBackgroundColor
{
	return [UIColor colorWithRed:247.f / 255.f green:245.f / 255.f blue:244.f / 255.f alpha:1];
}

+ (UIColor *)ml_navigationBarColor
{
	return [UIColor ml_colorWithHexString:@"#FFF059"];
}

+ (UIColor *)ml_textNavigationBarColor
{
	return [UIColor colorWithRed:43.f / 255.f green:50.f / 255.f blue:116.f / 255.f alpha:1.0f];
}

+ (UIColor *)ml_listingsDetailLine
{
	return [UIColor colorWithRed:200.f / 255.f green:199.f / 255.f blue:206.f / 255.f alpha:1.0f];
}

+ (UIColor *)ml_iOS7TableViewBackgroundColor
{
	return [UIColor colorWithRed:243.f / 255.f green:243.f / 255.f blue:243.f / 255.f alpha:1.0f];
}

+ (UIColor *)ml_tabBarColor
{
	return [UIColor ml_colorWith255Red:128 withGreen:128 withBlue:128];
}

+ (UIColor *)ml_titleColor
{
	return [UIColor ml_colorWith255Red:51 withGreen:51 withBlue:51];
}

@end
