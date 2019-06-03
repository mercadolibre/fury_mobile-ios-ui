//
// MLTitledMultiLineTextFieldTest.m
// MLUI
//
// Created by Juan Andres Gebhard on 5/18/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLTitledSingleLineTextFieldTest.h"
#import <MLUI/MLTitledMultiLineTextField.h>
#import <UIKit/UIKit.h>
#import <OCMock/OCMock.h>

@interface MLTitledMultiLineTextField ()

@property (weak, nonatomic) UITextView *textView;

- (UITextView *)textView;
- (CGSize)sizeForText:(NSString *)text;

@end

@interface MLTitledMultiLineTextFieldTest : MLTitledSingleLineTextFieldTest

- (MLTitledMultiLineTextField *)textField;

@end

@implementation MLTitledMultiLineTextFieldTest

- (MLTitledMultiLineTextField *)textField
{
	return [[MLTitledMultiLineTextField alloc] init];
}

- (void)testSetTextNil
{
	MLTitledMultiLineTextField *textField = self.textField;
	textField.text = nil;

	XCTAssertEqualObjects(textField.text, @"");
	XCTAssertEqualObjects(textField.textView.text, @"");
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

@end
