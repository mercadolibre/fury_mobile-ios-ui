//
// MLUIActionButtonViewController.m
// MLUI
//
// Created by Sebastián Bravo on 16/1/15.
// Copyright (c) 2015 MercadoLibre. All rights reserved.
//

#import "MLUIActionButtonViewController.h"
#import <MLUI/MLUIActionButton.h>

@interface MLUIActionButtonViewController ()

@end

@implementation MLUIActionButtonViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	[self addMLUIActionButtonTests];

	self.view.backgroundColor = [UIColor whiteColor];
}

- (void)addMLUIActionButtonTests
{
	UILabel *titleButtons = [[UILabel alloc] init];

	[titleButtons setText:@"Botones del tipo MLUIActionButton"];
	[titleButtons setTranslatesAutoresizingMaskIntoConstraints:NO];

	NSString *keyTitleButtons = @"titleButtons";

	[self.view addSubview:titleButtons];

	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-8-[%@]-8-|", keyTitleButtons]
	                                                                  options:0
	                                                                  metrics:nil
	                                                                    views:@{keyTitleButtons : titleButtons}]];

	NSMutableDictionary *buttons = [[NSMutableDictionary alloc] init];

	[buttons setObject:titleButtons forKey:keyTitleButtons];

	for (int i = 0; i <= MLUIActionButtonStyleDisabled; i++) {
		MLUIActionButton *button = [self createMLUIActionButtonWithStyle:(MLUIActionButtonStyle)i];

		[buttons setObject:button forKey:[NSString stringWithFormat:@"button%i", i]];

		[self.view addSubview:button];
	}

	// Agrego la constraint para el orden de los elementos y para tener una separacion entre cada boton
	NSMutableString *verticalVisualFormat = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"V:|-5-[%@(44)]", keyTitleButtons]];

	for (NSString *buttonKey in buttons) {
		if (![buttonKey isEqualToString:keyTitleButtons]) {
			[verticalVisualFormat appendString:[NSString stringWithFormat:@"-10-[%@]", buttonKey]];

			[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-8-[%@]-8-|", buttonKey]
			                                                                  options:0
			                                                                  metrics:nil
			                                                                    views:@{buttonKey : [buttons objectForKey:buttonKey]}]];
		}
	}

	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalVisualFormat
	                                                                  options:0
	                                                                  metrics:nil
	                                                                    views:buttons]];
}

- (MLUIActionButton *)createMLUIActionButtonWithStyle:(MLUIActionButtonStyle)style
{
	MLUIActionButton *button = [[MLUIActionButton alloc] initWithFixHeigthConstraintAndStyle:style];

	[button setTitle:[NSString stringWithFormat:@"MLUIActionButton %u", style] forState:UIControlStateNormal];

	return button;
}

@end
