//
// MLButtonConfigStyle.h
// Pods
//
// Created by Cristian Leonel Gibert on 1/12/17.
//
//

#import <UIKit/UIKit.h>

/**
 *  Use this interface to create the button custom style configuration
 */
@interface MLButtonConfigStyle : NSObject

@property (nonatomic, strong) UIColor *contentColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *borderColor;

- (instancetype)init __attribute__((unavailable("Must use initWithSize:primaryColor:secondaryColor: instead.")));

- (instancetype)initWithContentColor:(UIColor *)contentColor backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor;

@end
