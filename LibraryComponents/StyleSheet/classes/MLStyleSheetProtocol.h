//
// MLStyleSheetProtocol.h
// Bugsnag
//
// Created by Cristian Leonel Gibert on 2/1/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
   MLStyleSheetProtocol is used to create a new StyleSheet
   implementing all the necessary colors and fonts
 */
@protocol MLStyleSheetProtocol <NSObject>

/**
   The default colors that you need to override
   to use your color palette through all the UI components
 */
@property (nonatomic, readonly) UIColor *primaryColor;
@property (nonatomic, readonly) UIColor *lightPrimaryColor;
@property (nonatomic, readonly) UIColor *secondaryColor;
@property (nonatomic, readonly) UIColor *secondaryColorPressed;
@property (nonatomic, readonly) UIColor *secondaryColorDisabled;
@property (nonatomic, readonly) UIColor *successColor;
@property (nonatomic, readonly) UIColor *warningColor;
@property (nonatomic, readonly) UIColor *errorColor;
@property (nonatomic, readonly) UIColor *blackColor;
@property (nonatomic, readonly) UIColor *darkGreyColor;
@property (nonatomic, readonly) UIColor *greyColor;
@property (nonatomic, readonly) UIColor *midGreyColor;
@property (nonatomic, readonly) UIColor *lightGreyColor  __deprecated_msg("'MLUI' was deprecated, No longer supported; please adopt UIcolor.Andes.graySolid070");
@property (nonatomic, readonly) UIColor *whiteColor __deprecated_msg("'MLUI' was deprecated, No longer supported; please adopt UIcolor.Andes.white");
@property (nonatomic, readonly) UIColor *modalBackgroundColor;
@property (nonatomic, readonly) UIColor *modalTintColor;

/**
   The default font variations that you need to override
   to use your own font through all the UI components.
   By default these methods return the SF system font
 */
- (UIFont *)regularSystemFontOfSize:(CGFloat)fontSize;
- (UIFont *)boldSystemFontOfSize:(CGFloat)fontSize;
- (UIFont *)thinSystemFontOfSize:(CGFloat)fontSize;
- (UIFont *)lightSystemFontOfSize:(CGFloat)fontSize;
- (UIFont *)mediumSystemFontOfSize:(CGFloat)fontSize;
- (UIFont *)semiboldSystemFontOfSize:(CGFloat)fontSize;
- (UIFont *)extraboldSystemFontOfSize:(CGFloat)fontSize;
- (UIFont *)blackSystemFontOfSize:(CGFloat)fontSize;

/*
   Not every stylesheet must override these methods or properties
 */
@optional
- (UIFont *)monospaceFontOfSize:(CGFloat)fontSize;
@property (nonatomic, readonly) UIColor *primaryBackgroundColor __deprecated_msg("'MLUI' was deprecated, No longer supported; please adopt AndesStyleSheetManager.styleSheet.bgColorPrimary");
@property (nonatomic, readonly) UIColor *secondaryBackgroundColor __deprecated_msg("'MLUI' was deprecated, No longer supported; please adopt AndesStyleSheetManager.styleSheet.bgColorSecondary");
@property (nonatomic, readonly) UIStatusBarStyle statusBarStyle;
@end

NS_ASSUME_NONNULL_END
