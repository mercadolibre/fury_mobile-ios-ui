//
// MLTitledSingleLineCharacter.m
// MLUI
//
// Created by JAVIER PEDRO MARTEGANI on 12/08/2019.
//

#import "MLTitledSingleLineCharacter.h"

@implementation MLTitledSingleLineCharacter

- (void)deleteBackward
{
	if ([self.characterDelegate respondsToSelector:@selector(textFieldDidPressDeleteKey:)]) {
		[self.characterDelegate textFieldDidPressDeleteKey:self];
	}

	[super deleteBackward];
}

@end
