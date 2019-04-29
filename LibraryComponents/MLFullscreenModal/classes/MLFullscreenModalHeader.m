//
// MLFullscreenModalHeader.m
// MLUI
//
// Created by Cristian Gimenez on 14/03/2019.
// Copyright © 2019 MercadoLibre. All rights reserved.
//

#import "MLFullscreenModalHeader.h"
#import "UIFont+MLFonts.h"
#import "MLUIBundle.h"

static const CGFloat kMLFullscreenModalHeaderViewAnimationDuration = 0.3f;
static const CGFloat kMLFullscreenModalHeaderTitleLabelTopConstraintWithScrollEnabled = 15.f;
static const CGFloat kMLFullscreenModalHeaderTitleLabelTopConstraintWithoutScrollEnabled = 86.f;

@interface MLFullscreenModalHeader ()

/**
 * Header title label.
 */
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
/**
 * Title label top constraint.
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTopConstraint;

@end

@implementation MLFullscreenModalHeader

+ (instancetype)simpleHeaderView
{
	return [[MLUIBundle mluiBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	self.titleLabel.font = [UIFont ml_semiboldSystemFontOfSize:kMLFontsSizeXLarge];
}

- (void)setTitle:(NSString *)title
{
	__weak typeof(self) weakSelf = self;

	[UIView transitionWithView:self.titleLabel duration:kMLFullscreenModalHeaderViewAnimationDuration options:UIViewAnimationOptionTransitionCrossDissolve animations: ^{
	    weakSelf.titleLabel.text = title;
	} completion:nil];
}

- (NSString *)title
{
	return self.titleLabel.text;
}

- (void)setScrollEnabled:(BOOL)scrollEnabled
{
	_scrollEnabled = scrollEnabled;
	if (scrollEnabled) {
		self.titleLabelTopConstraint.constant = kMLFullscreenModalHeaderTitleLabelTopConstraintWithScrollEnabled;
	} else {
		self.titleLabelTopConstraint.constant = kMLFullscreenModalHeaderTitleLabelTopConstraintWithoutScrollEnabled;
	}
}

@end
