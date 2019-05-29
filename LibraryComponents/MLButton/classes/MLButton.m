//
// MLButton.m
// MLUI
//
// Created by Julieta Puente on 13/1/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLButton.h"
#import "MLButtonConfigStyle.h"
#import "UIColor+MLColorPalette.h"
#import "UIFont+MLFonts.h"
#import "MLButtonConfig.h"
#import "MLSpinner.h"
#import "MLButtonStylesFactory.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat kMLButtonHorizontalPadding = 15.0f;
static const CGFloat kMLButtonVerticalPadding = 15.0f;
static const CGFloat kMLButtonIconSize = 24.0f;
static const CGFloat kMLButtonIconLeftPadding = 8.0f;
static const CGFloat kMLButtonCornerRadius = 4.0f;
static const CGFloat kMLButtonBorderWidth = 1.0f;
static const CGFloat kMLButtonLineSpacing = 7.0f;

@interface MLButton ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) CALayer *backgroundLayer;
@property (nonatomic, strong) MLSpinner *spinner;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) MLSpinnerConfig *spinnerConfig;

@property (nonatomic, assign) BOOL isLoading;

@end

@implementation MLButton

+ (BOOL)requiresConstraintBasedLayout
{
	return YES;
}

#pragma mark inits

- (instancetype)init
{
	self = [self initWithConfig:[MLButtonStylesFactory configForButtonType:MLButtonTypePrimaryAction]];
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setup];
		self.style = MLButtonStylePrimaryAction;
	}
	return self;
}

- (instancetype)initWithStyle:(MLButtonStyle)style
{
	self = [super initWithFrame:CGRectZero];
	if (self) {
		[self setup];
		self.style = style;
	}
	return self;
}

- (instancetype)initWithConfig:(MLButtonConfig *)config
{
	if (self = [super initWithFrame:CGRectZero]) {
		_config = config;
		[self setup];
		[self updateLookAndFeel];
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	self.backgroundLayer.frame = self.bounds;
}

#pragma mark configuration methods

- (void)setup
{
	self.translatesAutoresizingMaskIntoConstraints = NO;

	self.backgroundColor = [UIColor clearColor];

	self.backgroundLayer = [CALayer layer];
	[self.layer addSublayer:self.backgroundLayer];

	self.backgroundLayer.borderWidth = kMLButtonBorderWidth;
    
    [self setUpContentView];
}

- (void)setUpContentView
{
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.label];
    
    //ContentView Constarints
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|->=p-[content]->=p-|" options:0 metrics:@{@"p" : @(kMLButtonHorizontalPadding)} views:@{@"content" : self.contentView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-p@priority-[content]-p@priority-|" options:0 metrics:@{@"p" : @(kMLButtonVerticalPadding), @"priority" : @999} views:@{@"content" : self.contentView}]];
    [self.contentView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;

    //TitleLabel Constraints
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label]-p@priority-|" options:0 metrics:@{@"p" : @0, @"priority": @250} views:@{@"label" : self.label}]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|" options:0 metrics:0 views:@{@"label" : self.label}]];
}

- (void)setupIconView {
    [self.contentView addSubview:self.iconView];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[label]-p-[icon(size)]|" options:0 metrics:@{@"p" : @(kMLButtonIconLeftPadding), @"size": @(kMLButtonIconSize)} views:@{@"label" : self.label, @"icon": self.iconView}]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[icon(size)]" options:0 metrics:@{@"size": @(kMLButtonIconSize)} views:@{@"icon" : self.iconView}]];
    [self.contentView.centerYAnchor constraintEqualToAnchor:self.iconView.centerYAnchor].active = YES;
}

- (void)setupStatesConfig
{
    switch (self.style) {
		case MLButtonStylePrimaryAction: {
			self.config = [MLButtonStylesFactory configForButtonType:MLButtonTypePrimaryAction];
			break;
		}

		case MLButtonStyleSecondaryAction: {
			self.config = [MLButtonStylesFactory configForButtonType:MLButtonTypeSecondaryAction];
			break;
		}

		case MLButtonStylePrimaryOption: {
			self.config = [MLButtonStylesFactory configForButtonType:MLButtonTypePrimaryOption];
			break;
		}

		case MLButtonStyleSecondaryOption: {
			self.config = [MLButtonStylesFactory configForButtonType:MLButtonTypeSecondaryOption];
			break;
		}
	}

    [self updateLookAndFeel];
}

- (void)updateLookAndFeel
{
    self.label.font = [UIFont ml_regularSystemFontOfSize:kMLFontsSizeMedium];
    self.label.textColor = self.isEnabled ? (self.isHighlighted ? self.config.highlightedState.contentColor : self.config.defaultState.contentColor) : self.config.disableState.contentColor;
    self.backgroundLayer.backgroundColor = self.isEnabled ? (self.isHighlighted ? self.config.highlightedState.backgroundColor.CGColor : self.config.defaultState.backgroundColor.CGColor) : self.config.disableState.backgroundColor.CGColor;
    self.backgroundLayer.borderColor = self.isEnabled ? (self.isHighlighted ? self.config.highlightedState.borderColor.CGColor : self.config.defaultState.borderColor.CGColor) : self.config.disableState.borderColor.CGColor;
    self.backgroundLayer.cornerRadius = kMLButtonCornerRadius;
    [self updateButtonIcon:self.stateIconImage];
}

- (UIImage * _Nullable) stateIconImage
{
    return  self.isEnabled ? (self.isHighlighted ? self.config.highlightedState.iconImage : self.config.defaultState.iconImage) : self.config.disableState.iconImage;;
}

- (void) updateButtonIcon:(UIImage * _Nullable)image
{
    if (image && self.iconView.superview == nil){
        [self setupIconView];
    }
    image ? self.iconView.image = image : [self.iconView removeFromSuperview];
}

- (void)updateStatesConfig:(MLButtonConfig *)buttonStates
{
    self.config = buttonStates;
}

- (void)setupLoadingStyle
{
    self.contentView.hidden = YES;
    self.spinner.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.spinner];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.spinner attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.spinner attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];

    self.backgroundLayer.backgroundColor = self.config.loadingState.backgroundColor.CGColor;
    self.backgroundLayer.borderColor = self.config.loadingState.borderColor.CGColor;

    [self.spinner showSpinner];
}

- (void)showLoadingStyle
{
    if (self.config.loadingState) {
        self.enabled = NO;
        self.isLoading = YES;
        [self setupLoadingStyle];
	}
}

- (void)hideLoadingStyle
{
    self.enabled = YES;
    self.contentView.hidden = NO;
    self.isLoading = NO;
    [self.spinner hideSpinner];
    [self updateLookAndFeel];
}

#pragma mark setters and getters

- (void)setStyle:(MLButtonStyle)style
{
    _style = style;
    [self setupStatesConfig];
}

- (void)setEnabled:(BOOL)enabled
{
    if (!self.isLoading) {
        [super setEnabled:enabled];
        [self updateLookAndFeel];
	}
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self updateLookAndFeel];
}

- (NSString *)buttonTitle
{
    return [self.label.attributedText string];
}

- (void)setButtonIcon:(UIImage *)buttonIcon
{
    self.config.defaultState.iconImage = self.config.highlightedState.iconImage = self.config.disableState.iconImage = buttonIcon;
    [self updateLookAndFeel];
}

- (void)setButtonTitle:(NSString *)buttonTitle
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = kMLButtonLineSpacing;
    paragraphStyle.alignment = NSTextAlignmentCenter;

    NSString *title = buttonTitle ? : @"";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, title.length)];

    self.label.attributedText = attributedString;
}

- (void)setConfig:(MLButtonConfig *)config
{
    _config = config;
    [self updateLookAndFeel];
}

#pragma mark lazy initializations

- (MLSpinner *)spinner
{
    if (!_spinner) {
        _spinner = [[MLSpinner alloc] initWithConfig:self.spinnerConfig text:nil];
	}
    return _spinner;
}

- (MLSpinnerConfig *)spinnerConfig
{
    if (!_spinnerConfig) {
        _spinnerConfig = [[MLSpinnerConfig alloc] initWithSize:MLSpinnerSizeSmall primaryColor:[UIColor whiteColor] secondaryColor:[UIColor whiteColor]];
	}
    return _spinnerConfig;
}

- (UIView *) contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        _contentView.userInteractionEnabled = NO;
        _contentView.clipsToBounds = NO;
        _contentView.backgroundColor = UIColor.clearColor;
    }
    
    return _contentView;
}

- (UILabel *) label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.translatesAutoresizingMaskIntoConstraints = NO;
        _label.numberOfLines = 0;
    }
    
    return _label;
}

- (UIImageView * ) iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconView;
}

@end
