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
    return [self initWithContentColor:contentColor backgroundColor:backgroundColor borderColor:borderColor iconImage:nil];
}

- (instancetype)initWithContentColor:(UIColor *)contentColor backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor iconImage:(UIImage * _Nullable)iconImage
{
	if (self = [super init]) {
		_contentColor = contentColor;
		_backgroundColor = backgroundColor;
		_borderColor = borderColor;
        _iconImage = iconImage;
	}
	return self;
}

- (BOOL)isEqualToButtonConfigStyle:(MLButtonConfigStyle *)buttonConfigStyle
{
	if (!buttonConfigStyle) {
		return NO;
	}
	BOOL haveEqualContentColor = (!self.contentColor && !buttonConfigStyle.contentColor) || [self.contentColor isEqual:buttonConfigStyle.contentColor];
	BOOL haveEqualBackgroundColor = (!self.backgroundColor && !buttonConfigStyle.backgroundColor) || [self.backgroundColor isEqual:buttonConfigStyle.backgroundColor];
	BOOL haveEqualBorderColor = (!self.borderColor && !buttonConfigStyle.borderColor) || [self.borderColor isEqual:buttonConfigStyle.borderColor];
    BOOL haveEqualIconImage = (!self.iconImage && !buttonConfigStyle.iconImage) || [self.iconImage isEqual:buttonConfigStyle.iconImage];

    return haveEqualContentColor && haveEqualBackgroundColor && haveEqualBorderColor && haveEqualIconImage;
}

- (BOOL)isEqual:(id)object
{
	if (self == object) {
		return YES;
	}
	if (![object isKindOfClass:MLButtonConfigStyle.class]) {
		return NO;
	}
	return [self isEqualToButtonConfigStyle:(MLButtonConfigStyle *)object];
}

- (NSUInteger)hash
{
	return self.contentColor.hash ^ self.backgroundColor.hash ^ self.borderColor.hash ^ self.iconImage.hash;
}

@end
