//
// MLTitledMultiLineTextFieldTest.m
// MLUI
//
// Created by Juan Andres Gebhard on 5/18/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import <OCMock/OCMock.h>
#import "MLTitledMultiLineTextField.h"
#import "MLTitledSingleLineTextFieldTest.h"

@interface MLTitledMultiLineTextField ()
- (UITextView *)textView;
- (CGSize)sizeForText:(NSString *)text;
@end

@interface MLTitledMultiLineTextFieldTest : MLTitledSingleLineTextFieldTest
@end

@implementation MLTitledMultiLineTextFieldTest

- (MLTitledMultiLineTextField *)textField
{
	return [[MLTitledMultiLineTextField alloc] init];
}

- (void)testSetText
{
	[super testSetText];
}

- (void)testSetTextFailsIfLongerThanMaxCharacters
{
	[super testSetTextFailsIfLongerThanMaxCharacters];
}

- (void)testErrorState
{
	[super testErrorState];
}

- (void)testDisabledState
{
	[super testDisabledState];
}

- (void)testEditingEvents
{
	id textField = OCMPartialMock(self.textField);
	UITextView *textView = (UITextView *)[textField textInputControl];
	id <UITextViewDelegate> delegate = (id <UITextViewDelegate> )textField;

	[delegate textViewDidChange:textView];
	[delegate textViewDidBeginEditing:textView];
	[delegate textViewDidEndEditing:textView];

	OCMVerify([textField sendActionsForControlEvents:UIControlEventEditingChanged]);
	OCMVerify([textField sendActionsForControlEvents:UIControlEventEditingDidBegin]);
	OCMVerify([textField sendActionsForControlEvents:UIControlEventEditingDidEnd]);

	[textField stopMocking];
}

- (void)testGetSizeForTextWhenTextFieldHasNoFont
{
	MLTitledMultiLineTextField *textField = OCMPartialMock(self.textField);
	UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
	OCMStub([textField textView]).andReturn(textView);

	XCTAssertNil(textField.textView.font);
	XCTAssertEqual([textField sizeForText:@""].width, 0);
}

- (void)testAutocapitalizationType
{
	MLTitledMultiLineTextField *textField = OCMPartialMock(self.textField);

	textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	XCTAssertEqual(textField.autocapitalizationType, UITextAutocapitalizationTypeNone);
}

@end
