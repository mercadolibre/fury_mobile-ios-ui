//
// UIColor+MercadoLibre.h
// MercadoLibre
//
// Created by Fabian Celdeiro on 8/22/12.
// Copyright (c) 2012 Casa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Theme)

+ (UIColor *)ml_textDefaultColor;
+ (UIColor *)ml_textSecondaryColor;
+ (UIColor *)ml_textSubtitleColor;
+ (UIColor *)ml_cellBackgroundDefaultColor;
+ (UIColor *)ml_backgroundDefaultColor;
+ (UIColor *)ml_tableViewBackgroundDefaultColor;
+ (UIColor *)ml_bigErrorBackgroundDefaultColor;
+ (UIColor *)ml_priceColor;
+ (UIColor *)ml_mercadoLibreLightBlueColor;
+ (UIColor *)ml_mercadoLibreBlueColor;

+ (UIColor *)ml_colorWith255Red:(NSInteger)red withGreen:(NSInteger)green withBlue:(NSInteger)blue;
+ (UIColor *)ml_colorWith255Red:(NSInteger)red withGreen:(NSInteger)green withBlue:(NSInteger)blue withAlpha:(CGFloat)alpha;
+ (UIColor *)ml_colorWith255RedAnd255GreenAnd255BlueAndAlpha:(NSString *)color withSeparator:(NSString *)separator;

+ (UIColor *)ml_colorWithHexString:(NSString *)hexString;

+ (UIColor *)ml_errorCellColor;
+ (UIColor *)ml_warningCellColor;

+ (UIColor *)ml_tableViewMisComprasBackgroundColor;
+ (UIColor *)ml_tableViewMisComprasFooterBackgroundColor;

+ (UIColor *)ml_navigationBarColor;
+ (UIColor *)ml_textNavigationBarColor;

+ (UIColor *)ml_iOS7TableViewBackgroundColor;

+ (UIColor *)ml_tabBarColor;

+ (UIColor *)ml_listingsDetailLine;

+ (UIColor *)ml_titleColor;

@end
