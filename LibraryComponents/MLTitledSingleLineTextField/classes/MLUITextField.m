//
// MLUITextField.m
// MLUI
//
// Created by JAVIER PEDRO MARTEGANI on 12/08/2019.
//

#import "MLUITextField.h"

@implementation MLUITextField

- (void)deleteBackward
{
	if ([self.textFieldDelegate respondsToSelector:@selector(textFieldDidPressDeleteKey:)]) {
		[self.textFieldDelegate textFieldDidPressDeleteKey:self];
	}

	[super deleteBackward];
}

@end
