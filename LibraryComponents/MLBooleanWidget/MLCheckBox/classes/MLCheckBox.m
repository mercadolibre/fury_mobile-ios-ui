//
// MLcheckBox.m
// MLUI
//
// Created by Santiago Lazzari on 6/14/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLCheckBox.h"

#import "UIColor+MLColorPalette.h"
#import "MLBooleanWidget_Protected.h"

static const CGFloat kMLCheckBoxExternalLineWidth = 2;
static const CGFloat kMLCheckBoxExternalCornerRadius = 1;

static const CGFloat kMLCheckBoxTickLineWidth = 2;

static const CGFloat kMLCheckBoxAnimationDuration = 0.2;
static const CGFloat kMLCheckBoxNotAnimationDuration = 0;

@interface MLCheckBox ()

@property (nonatomic, strong) CAShapeLayer *checkBoxExternalLayer;
@property (nonatomic, strong) CAShapeLayer *checkBoxInternalLayer;
@property (nonatomic, strong) CAShapeLayer *checkBoxTickLayer;

@end

@implementation MLCheckBox

#pragma mark - Init

- (void)commonInit
{
	[super commonInit];

	// create external Layer
	[self.checkBoxExternalLayer removeFromSuperlayer];
	self.checkBoxExternalLayer = [CAShapeLayer layer];
	[self.layer addSublayer:self.checkBoxExternalLayer];

	// create external Layer
	[self.checkBoxInternalLayer removeFromSuperlayer];
	self.checkBoxInternalLayer = [CAShapeLayer layer];
	[self.layer addSublayer:self.checkBoxInternalLayer];

	// create tick layer
	self.checkBoxTickLayer = [CAShapeLayer layer];
	[self.layer addSublayer:self.checkBoxTickLayer];
}

#pragma mark - Navigation
- (void)layoutSubviews
{
	[super layoutSubviews];

	self.checkBoxTickLayer.frame = self.bounds;
	self.checkBoxExternalLayer.frame = self.bounds;
	self.checkBoxInternalLayer.frame = self.bounds;
}

#pragma mark - Animation
- (void)setOnBooleanWidgetAnimated:(BOOL)animated
{
	if (self.isBooleanWidgetOn) {
		return;
	}

	[self fillCheckBoxExternalAnimated:animated];
	[self fillCheckBoxInternalAnimated:animated];
	[self fillCheckBoxTickAnimated:animated];
}

- (void)fillCheckBoxExternalAnimated:(BOOL)animated
{
	// Set circle layer bounds
	self.checkBoxExternalLayer.bounds = CGRectMake(0, 0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame));

	// Set circle layer path
	UIBezierPath *externalFrame = [UIBezierPath bezierPathWithRoundedRect:self.checkBoxExternalLayer.bounds cornerRadius:kMLCheckBoxExternalCornerRadius];
	self.checkBoxExternalLayer.path = externalFrame.CGPath;

	self.checkBoxExternalLayer.fillColor = [UIColor clearColor].CGColor;
	float lineWidth = kMLCheckBoxExternalLineWidth;

	self.checkBoxExternalLayer.lineWidth = lineWidth;

	// Color animation
	CABasicAnimation *colorFillAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
	colorFillAnimation.beginTime = 0;
	colorFillAnimation.fromValue = (id)[UIColor ml_meli_grey].CGColor;
	colorFillAnimation.toValue = (id)[UIColor ml_meli_blue].CGColor;
	colorFillAnimation.fillMode = kCAFillModeForwards;
	colorFillAnimation.duration = animated ? kMLCheckBoxAnimationDuration : kMLCheckBoxNotAnimationDuration;

	[self.checkBoxExternalLayer addAnimation:colorFillAnimation forKey:@"animateFill"];

	self.checkBoxExternalLayer.strokeColor = [UIColor ml_meli_blue].CGColor;
}

- (void)fillCheckBoxInternalAnimated:(BOOL)animated
{
	// Set circle layer bounds
	self.checkBoxInternalLayer.bounds = CGRectMake(0, 0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame));

	// Set circle layer path
	UIBezierPath *externalFrame = [UIBezierPath bezierPathWithRoundedRect:self.checkBoxExternalLayer.bounds cornerRadius:kMLCheckBoxExternalCornerRadius];
	self.checkBoxInternalLayer.path = externalFrame.CGPath;

	UIBezierPath *internalFrame = [UIBezierPath bezierPathWithRoundedRect:self.checkBoxExternalLayer.bounds cornerRadius:kMLCheckBoxExternalCornerRadius];

	self.checkBoxInternalLayer.fillColor = [UIColor ml_meli_blue].CGColor;
	float lineWidth = kMLCheckBoxExternalLineWidth;

	self.checkBoxInternalLayer.lineWidth = lineWidth;

	// Opacity animation
	CABasicAnimation *opacityFillAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	opacityFillAnimation.beginTime = 0;
	opacityFillAnimation.fromValue = @0;
	opacityFillAnimation.toValue = @1;
	opacityFillAnimation.fillMode = kCAFillModeForwards;

	// Color animation
	CABasicAnimation *colorFillAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
	colorFillAnimation.beginTime = 0;
	colorFillAnimation.fromValue = (id)[UIColor ml_meli_grey].CGColor;
	colorFillAnimation.toValue = (id)[UIColor ml_meli_blue].CGColor;
	colorFillAnimation.fillMode = kCAFillModeForwards;

	// Compaund animation
	CAAnimationGroup *fillAnimation = [CAAnimationGroup animation];
	fillAnimation.duration = animated ? kMLCheckBoxAnimationDuration : kMLCheckBoxNotAnimationDuration;
	[fillAnimation setAnimations:[NSArray arrayWithObjects:colorFillAnimation, opacityFillAnimation, nil]];

	[self.checkBoxInternalLayer addAnimation:fillAnimation forKey:@"animateFill"];

	self.checkBoxInternalLayer.strokeColor = [UIColor ml_meli_blue].CGColor;
	self.checkBoxInternalLayer.path = internalFrame.CGPath;
	self.checkBoxInternalLayer.opacity = 1;
}

- (void)fillCheckBoxTickAnimated:(BOOL)animated
{
	// Set circle layer bounds
	self.checkBoxTickLayer.bounds = CGRectMake(0, 0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame));

	// Set circle layer path
	UIBezierPath *tickPath = [UIBezierPath bezierPath];

	[tickPath moveToPoint:[self tickLeftPointInRect:self.bounds]];
	[tickPath addLineToPoint:[self tickBotomPointInRect:self.bounds]];
	[tickPath addLineToPoint:[self tickRightPointInRect:self.bounds]];

	self.checkBoxTickLayer.path = tickPath.CGPath;

	self.checkBoxTickLayer.strokeColor = [UIColor ml_meli_white].CGColor;
	self.checkBoxTickLayer.fillColor = [UIColor clearColor].CGColor;
	float lineWidth = kMLCheckBoxTickLineWidth;

	self.checkBoxTickLayer.lineWidth = lineWidth;

	// Color animation
	CABasicAnimation *pathTickAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
	pathTickAnimation.beginTime = 0;
	pathTickAnimation.fromValue = @0.0;
	pathTickAnimation.toValue = @1.0;
	pathTickAnimation.fillMode = kCAFillModeForwards;
	pathTickAnimation.duration = animated ? kMLCheckBoxAnimationDuration : kMLCheckBoxNotAnimationDuration;

	[self.checkBoxTickLayer addAnimation:pathTickAnimation forKey:@"animateFillTick"];
}

- (void)setOffBooleanWidgetAnimated:(BOOL)animated
{
	[self clearCheckBoxExternalAnimated:animated];
	[self clearCheckBoxInternalAnimated:animated];
}

- (void)clearCheckBoxExternalAnimated:(BOOL)animated
{
	// Set circle layer bounds
	self.checkBoxExternalLayer.bounds = CGRectMake(0, 0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame));

	// Set circle layer path
	UIBezierPath *externalFrame = [UIBezierPath bezierPathWithRoundedRect:self.checkBoxExternalLayer.bounds cornerRadius:kMLCheckBoxExternalCornerRadius];

	self.checkBoxExternalLayer.path = externalFrame.CGPath;

	self.checkBoxExternalLayer.fillColor = [UIColor clearColor].CGColor;
	float lineWidth = kMLCheckBoxExternalLineWidth;

	self.checkBoxExternalLayer.lineWidth = lineWidth;

	// Color animation
	CABasicAnimation *colorFillAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
	colorFillAnimation.beginTime = 0;
	colorFillAnimation.fromValue = (id)[UIColor ml_meli_blue].CGColor;
	colorFillAnimation.toValue = (id)[UIColor ml_meli_grey].CGColor;
	colorFillAnimation.fillMode = kCAFillModeForwards;
	colorFillAnimation.duration = animated ? kMLCheckBoxAnimationDuration : kMLCheckBoxNotAnimationDuration;

	[self.checkBoxExternalLayer addAnimation:colorFillAnimation forKey:@"animateFill"];

	self.checkBoxExternalLayer.strokeColor = [UIColor ml_meli_grey].CGColor;
}

- (void)clearCheckBoxInternalAnimated:(BOOL)animated
{
	// Set circle layer bounds
	self.checkBoxInternalLayer.bounds = CGRectMake(0, 0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame));

	// Set circle layer path
	UIBezierPath *externalFrame = [UIBezierPath bezierPathWithRoundedRect:self.checkBoxExternalLayer.bounds cornerRadius:kMLCheckBoxExternalCornerRadius];

	UIBezierPath *internalFrame = [UIBezierPath bezierPathWithRoundedRect:self.checkBoxExternalLayer.bounds cornerRadius:kMLCheckBoxExternalCornerRadius];
	[internalFrame fill];

	self.checkBoxInternalLayer.path = internalFrame.CGPath;

	self.checkBoxInternalLayer.fillColor = [UIColor clearColor].CGColor;
	float lineWidth = kMLCheckBoxExternalLineWidth;
	self.checkBoxInternalLayer.lineWidth = lineWidth;

	// Opacity animation
	CABasicAnimation *opacityClearAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	opacityClearAnimation.beginTime = 0;
	opacityClearAnimation.fromValue = @1;
	opacityClearAnimation.toValue = @0;
	opacityClearAnimation.fillMode = kCAFillModeForwards;

	// Color animation
	CABasicAnimation *colorClearAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
	colorClearAnimation.beginTime = 0;
	colorClearAnimation.fromValue = (id)[UIColor ml_meli_blue].CGColor;
	colorClearAnimation.toValue = (id)[UIColor ml_meli_grey].CGColor;
	colorClearAnimation.fillMode = kCAFillModeForwards;

	// Compaund animation
	CAAnimationGroup *clearAnimation = [CAAnimationGroup animation];
	clearAnimation.duration = animated ? kMLCheckBoxAnimationDuration : kMLCheckBoxNotAnimationDuration;
	[clearAnimation setAnimations:[NSArray arrayWithObjects:colorClearAnimation, opacityClearAnimation, nil]];

	[self.checkBoxInternalLayer addAnimation:clearAnimation forKey:@"animateClear"];

	self.checkBoxInternalLayer.strokeColor = [UIColor ml_meli_grey].CGColor;
	self.checkBoxInternalLayer.path = externalFrame.CGPath;
	self.checkBoxInternalLayer.opacity = 0;
}

#pragma mark - Tick Positions
- (CGPoint)tickLeftPointInRect:(CGRect)rect
{
	CGFloat x = rect.size.width * (2.5 / 15.0);
	CGFloat y = rect.size.height / 2.0;

	return CGPointMake(x, y);
}

- (CGPoint)tickBotomPointInRect:(CGRect)rect
{
	CGFloat x = rect.size.width * (1.0 / 3.0);
	CGFloat y = rect.size.height * (2.0 / 3.0);

	return CGPointMake(x, y);
}

- (CGPoint)tickRightPointInRect:(CGRect)rect
{
	CGFloat x = rect.size.width - (rect.size.width * (2.5 / 15.0));
	CGFloat y = rect.size.height / 4.0;

	return CGPointMake(x, y);
}

@end
