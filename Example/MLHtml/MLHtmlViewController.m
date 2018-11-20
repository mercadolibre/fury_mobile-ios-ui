//
// MLHtmlViewController.m
// MLUI
//
// Created by amargalef on 6/7/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLHtmlViewController.h"
#import <MLUI/NSAttributedString+MLHtml.h>
#import <MLUI/UIFont+MLFonts.h>

// Bold tag
static NSString *const kHTMLRegularTag = @"regular";

@interface MLHtmlViewController () <MLHtmlAttributeProvider>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation MLHtmlViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.textView.layer.borderWidth = 1;
	self.textView.layer.borderColor = [[UIColor blackColor] CGColor];
	self.label.layer.borderWidth = 2;
	self.label.layer.borderColor = [[UIColor blackColor] CGColor];
}

- (IBAction)buttonTouchUpInside:(id)sender
{
	NSString *htmlString = self.textView.text;

	NSDictionary *defaultAttributes = @{
	        NSForegroundColorAttributeName : [UIColor blackColor],
	        NSFontAttributeName : [UIFont ml_regularSystemFontOfSize:16]
	};

	NSError *error;
	NSAttributedString *htmlAttributedString = [NSAttributedString ml_attributedStringWithHtml:htmlString attributes:defaultAttributes error:&error];

	self.label.attributedText = htmlAttributedString;
}

- (IBAction)buttonTouchUpInsideWithProtocol:(id)sender
{
	NSString *htmlString = self.textView.text;

	NSError *error;

	NSAttributedString *htmlAttributedString = [NSAttributedString ml_attributedStringWithHtml:htmlString attributesProvider:self error:&error];

	self.label.attributedText = htmlAttributedString;
}

#pragma MLHtmlAttributeProvider
- (void)processAttributesForTag:(NSString *)tag attributes:(NSMutableDictionary *)attrs
{
	id object = [attrs objectForKey:NSFontAttributeName];
	UIFont *currentFont = [self isNullOrEmpty:object] ? nil : object;

	if ([tag isEqualToString:kHTMLRegularTag]) {
		currentFont = [UIFont ml_regularSystemFontOfSize:currentFont.pointSize];
	}

	if (currentFont) {
		attrs[NSFontAttributeName] = currentFont;
	}
}

- (BOOL)isNullOrEmpty:(id)object
{
	if (object == nil || [object isEqual:[NSNull null]]) {
		return YES;
	}

	if ([object isKindOfClass:[NSString class]]) {
		if ([object isEqualToString:@""]) {
			return YES;
		}
	}

	return NO;
}

@end
