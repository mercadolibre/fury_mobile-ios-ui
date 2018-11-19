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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

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
	id <UITextViewDelegate> delegate = (id <UITextViewDelegate>)textField;

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

- (void)test_shouldRespectWhenDelegate_Accepts {
	MLTitledMultiLineTextField *textField = [[MLTitledMultiLineTextField alloc] init];

	NSString *currentText = @"Current Text";
	textField.text = currentText;

	NSString *newText = @"New Text";
	NSRange range = NSMakeRange(0, currentText.length);

	NSObject <MLTitledTextFieldDelegate> *delegate = OCMProtocolMock(@protocol(MLTitledTextFieldDelegate));
	[OCMStub([delegate textField:textField shouldChangeCharactersInRange:range replacementString:newText]) andReturnValue:@(NO)];

	textField.delegate = delegate;
	BOOL result = [textField textView:textField.textView shouldChangeTextInRange:range replacementText:newText];

	XCTAssertFalse(result);
}

- (void)test_shouldRespectWhenDelegate_Rejects {
	MLTitledMultiLineTextField *textField = [[MLTitledMultiLineTextField alloc] init];

	NSString *currentText = @"Current Text";
	textField.text = currentText;

	NSString *newText = @"New Text";
	NSRange range = NSMakeRange(0, currentText.length);

	NSObject <MLTitledTextFieldDelegate> *delegate = OCMProtocolMock(@protocol(MLTitledTextFieldDelegate));
	[OCMStub([delegate textField:textField shouldChangeCharactersInRange:range replacementString:newText]) andReturnValue:@(YES)];

	textField.delegate = delegate;
	BOOL result = [textField textView:textField.textView shouldChangeTextInRange:range replacementText:newText];

	XCTAssertTrue(result);
}

@end
