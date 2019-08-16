//
// MLTitledSingleLineTextFieldTest.m
// MLUI
//
// Created by Juan Andres Gebhard on 5/18/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLTitledSingleLineTextFieldTest.h"
#import <OCMock/OCMock.h>
#import <MLUI/MLTitledSingleLineTextField.h>
#import <MLUI/MLUITextField.h>
// Must declare that textfield implements UITextFieldDelegate to call shouldChangeCharactersInRange:raplacementString:
@interface MLTitledSingleLineTextField () <UITextFieldDelegate, MLUITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UILabel *accessoryLabel;
@property (weak, nonatomic) IBOutlet UIView *accessoryViewContainer;

@property (strong, nonatomic) MLUITextField *textField;

@end

@implementation MLTitledSingleLineTextFieldTest

- (MLTitledSingleLineTextField *)textField
{
	return [[MLTitledSingleLineTextField alloc] init];
}

- (void)testSetText
{
	NSString *testText = @"A test text";
	MLTitledSingleLineTextField *textField = self.textField;
	textField.text = testText;

	XCTAssertEqualObjects(testText, textField.text);
}

- (void)testSetTextNil
{
	MLTitledSingleLineTextField *textField = self.textField;
	textField.text = nil;

	XCTAssertEqualObjects(textField.text, @"");
	XCTAssertEqualObjects(textField.textField.text, @"");
}

- (void)testSetTextFailsIfLongerThanMaxCharacters
{
	NSString *initialText = @"A test text";
	NSString *longerText = @"A text that is longer to the first text";
	MLTitledSingleLineTextField *textField = self.textField;
	textField.text = initialText;
	textField.maxCharacters = initialText.length;
	textField.text = longerText;

	XCTAssertEqualObjects(initialText, textField.text);
}

- (void)testSetHelperDescription
{
	MLTitledSingleLineTextField *textField = self.textField;
	textField.helperDescription = @"Helper Description";

	XCTAssertEqualObjects(textField.helperDescription, @"Helper Description");
	XCTAssertEqualObjects(textField.accessoryLabel.text, @"Helper Description");
}

- (void)testSetHelperDescriptionNil
{
	MLTitledSingleLineTextField *textField = self.textField;
	textField.helperDescription = nil;

	XCTAssertNil(textField.helperDescription);
	XCTAssertEqualObjects(textField.accessoryLabel.text, @"");
}

- (void)testAccessoryViewDefault
{
	MLTitledSingleLineTextField *textField = self.textField;

	XCTAssertNil(textField.accessoryView);
	XCTAssertEqual(textField.accessoryViewContainer.subviews.count, 1);
}

- (void)testSetAccessoryView
{
	MLTitledSingleLineTextField *textField = self.textField;
	UIView *accessoryView = [[UILabel alloc] init];
	textField.accessoryView = accessoryView;

	XCTAssertEqualObjects(textField.accessoryView, accessoryView);
	XCTAssertEqual(textField.accessoryViewContainer.subviews.count, 2);
}

- (void)testSetAccessoryViewNil
{
	MLTitledSingleLineTextField *textField = self.textField;
	textField.accessoryView = nil;

	XCTAssertNil(textField.accessoryView);
	XCTAssertEqual(textField.accessoryViewContainer.subviews.count, 1);
}

- (void)testKeyboardTypeDefault
{
	MLTitledSingleLineTextField *textField = self.textField;

	XCTAssertEqual(textField.keyboardType, UIKeyboardTypeDefault);
}

- (void)testSetKeyboardType
{
	MLTitledSingleLineTextField *textField = self.textField;
	textField.keyboardType = UIKeyboardTypeURL;

	XCTAssertEqual(textField.keyboardType, UIKeyboardTypeURL);
}

- (void)testAutocapitalizationTypeDefault
{
	MLTitledSingleLineTextField *textField = self.textField;

	XCTAssertEqual(textField.autocapitalizationType, UITextAutocapitalizationTypeSentences);
}

- (void)testSetAutocapitalizationType
{
	MLTitledSingleLineTextField *textField = self.textField;
	textField.autocapitalizationType = UITextAutocapitalizationTypeNone;

	XCTAssertEqual(textField.autocapitalizationType, UITextAutocapitalizationTypeNone);
}

- (void)testAutocorrectionTypeDefault
{
	MLTitledSingleLineTextField *textField = self.textField;

	XCTAssertEqual(textField.autocorrectionType, UITextAutocorrectionTypeDefault);
}

- (void)testSetAutocorrectionType
{
	MLTitledSingleLineTextField *textField = self.textField;
	textField.autocorrectionType = UITextAutocorrectionTypeNo;

	XCTAssertEqual(textField.autocorrectionType, UITextAutocorrectionTypeNo);
}

- (void)testErrorState
{
	MLTitledSingleLineTextField *textField = self.textField;
	textField.errorDescription = @"Error description";

	XCTAssertEqual(MLTitledTextFieldStateError, textField.state);
}

- (void)testDisabledState
{
	MLTitledSingleLineTextField *textField = self.textField;
	textField.enabled = NO;

	XCTAssertEqual(MLTitledTextFieldStateDisabled, textField.state);
}

- (void)testAlignCenter
{
	MLTitledSingleLineTextField *textField = self.textField;
	[textField setupInnerTextWithAlignment:NSTextAlignmentCenter];

	XCTAssertEqual(textField.placeholderLabel.textAlignment, NSTextAlignmentCenter);
	XCTAssertEqual(textField.titleLabel.textAlignment, NSTextAlignmentCenter);
	XCTAssertEqual(textField.accessoryLabel.textAlignment, NSTextAlignmentCenter);
}

- (void)testAlignLeft
{
	MLTitledSingleLineTextField *textField = self.textField;
	[textField setupInnerTextWithAlignment:NSTextAlignmentLeft];

	XCTAssertEqual(textField.placeholderLabel.textAlignment, NSTextAlignmentLeft);
	XCTAssertEqual(textField.titleLabel.textAlignment, NSTextAlignmentLeft);
	XCTAssertEqual(textField.accessoryLabel.textAlignment, NSTextAlignmentLeft);
}

- (void)testAlignRight
{
	MLTitledSingleLineTextField *textField = self.textField;
	[textField setupInnerTextWithAlignment:NSTextAlignmentRight];

	XCTAssertEqual(textField.placeholderLabel.textAlignment, NSTextAlignmentRight);
	XCTAssertEqual(textField.titleLabel.textAlignment, NSTextAlignmentRight);
	XCTAssertEqual(textField.accessoryLabel.textAlignment, NSTextAlignmentRight);
}

- (void)testDelegateDoesntModifyMaxCharacters
{
	// A delegate
	id protocolMock = OCMProtocolMock(@protocol(MLTitledTextFieldDelegate));
	OCMStub([[protocolMock ignoringNonObjectArgs] textField:[OCMArg any] shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:[OCMArg any]]).andReturn(YES);

	// Setup
	MLTitledSingleLineTextField *textField = self.textField;
	textField.maxCharacters = 4;
	textField.delegate = protocolMock;

	MLUITextField *internalTextField = [[MLUITextField alloc] init];
	internalTextField.text = @"";

	// Might simulate user using actual textfield
	[textField textField:internalTextField shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"t"];

	// Have to include a text field becouse original property textfield from textfiels is taken from view
	internalTextField.text = textField.text;

	[textField textField:internalTextField shouldChangeCharactersInRange:NSMakeRange(1, 0) replacementString:@"e"];

	// Might modify internalTextField's text by code becouse with a view this is make automaicaly
	internalTextField.text = textField.text;

	[textField textField:internalTextField shouldChangeCharactersInRange:NSMakeRange(2, 0) replacementString:@"s"];
	internalTextField.text = textField.text;
	[textField textField:internalTextField shouldChangeCharactersInRange:NSMakeRange(3, 0) replacementString:@"t"];
	internalTextField.text = textField.text;

	// Range might stay in (4, 0) becouse textCache is not updated when text is longer than maxCharacters
	[textField textField:internalTextField shouldChangeCharactersInRange:NSMakeRange(4, 0) replacementString:@" "];
	internalTextField.text = textField.text;
	[textField textField:internalTextField shouldChangeCharactersInRange:NSMakeRange(4, 0) replacementString:@"t"];
	internalTextField.text = textField.text;
	[textField textField:internalTextField shouldChangeCharactersInRange:NSMakeRange(4, 0) replacementString:@"e"];

	XCTAssertTrue([textField.text isEqualToString:@"test"]);
}

- (void)testEditingEvents
{
	MLTitledSingleLineTextField *textField = OCMPartialMock(self.textField);
	id <UITextFieldDelegate> innerTextFieldDelegate = textField;
	UITextField *innerTextField = (UITextField *)textField.textInputControl;

	[innerTextField sendActionsForControlEvents:UIControlEventEditingChanged];
	[innerTextFieldDelegate textFieldDidBeginEditing:innerTextField];
	[innerTextFieldDelegate textFieldDidEndEditing:innerTextField];

	OCMVerify([textField sendActionsForControlEvents:UIControlEventEditingChanged]);
	OCMVerify([textField sendActionsForControlEvents:UIControlEventEditingDidBegin]);
	OCMVerify([textField sendActionsForControlEvents:UIControlEventEditingDidEnd]);
}

- (void)testSecureTextEntry
{
	MLTitledSingleLineTextField *textField = self.textField;
	XCTAssertFalse(textField.secureTextEntry);

	textField.secureTextEntry = YES;
	XCTAssertTrue(textField.secureTextEntry);
}

- (void)testDelegateHasMinCharacters
{
	id protocolMock = OCMProtocolMock(@protocol(MLTitledTextFieldDelegate));

	NSString *initialText = @"Aa";
	NSString *longerText = @"Aaaa";
	MLTitledSingleLineTextField *textField = self.textField;
	[textField setDelegate:protocolMock];
	textField.minCharacters = 4;

	OCMExpect([protocolMock textField:textField hasMinCharacters:NO]);
	[textField textField:textField.textField shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:initialText];
	OCMVerifyAll(protocolMock);

	OCMExpect([protocolMock textField:textField hasMinCharacters:YES]);
	[textField textField:textField.textField shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:longerText];
	OCMVerifyAll(protocolMock);
}

- (void)testDelegateHasMinCharactersDontChange
{
	id protocolMock = OCMProtocolMock(@protocol(MLTitledTextFieldDelegate));

	NSString *initialText = @"Aa";
	NSString *longerText = @"Aaaa";
	MLTitledSingleLineTextField *textField = self.textField;
	[textField setDelegate:protocolMock];
	textField.minCharacters = 6;

	OCMExpect([protocolMock textField:textField hasMinCharacters:NO]);
	[textField textField:textField.textField shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:initialText];
	OCMVerifyAll(protocolMock);

	OCMExpect([protocolMock textField:textField hasMinCharacters:NO]);
	[textField textField:textField.textField shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:longerText];
	OCMVerifyAll(protocolMock);
}

- (void)testDelegateTextFieldDidPressDeleteKey
{
	id protocolMock = OCMProtocolMock(@protocol(MLTitledTextFieldDelegate));
	MLTitledSingleLineTextField *textField = self.textField;
	textField.textField = [[MLUITextField alloc] init];
	textField.textField.textFieldDelegate = textField;
	[textField setDelegate:protocolMock];

	OCMExpect([protocolMock textFieldDidPressDeleteKey:textField]);
	[textField.textField deleteBackward];
	OCMVerifyAll(protocolMock);
}

@end
