//
// MLTextFieldWithLabelViewController.m
// MLUI
//
// Created by Juan Andres Gebhard on 5/6/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLTitledTextFieldViewController.h"
#import <MLUI/MLTitledSingleLineTextField.h>
#import <MLUI/UIColor+MLColorPalette.h>
#import <MLUI/MLTitledMultiLineTextField.h>
#import <MLUI/MLTextView.h>

@interface MLTitledTextFieldViewController () <MLTitledTextFieldDelegate>
@property (weak, nonatomic) IBOutlet MLTitledSingleLineTextField *textField1;
@property (weak, nonatomic) IBOutlet MLTitledSingleLineTextField *textField2;
@property (weak, nonatomic) IBOutlet MLTitledSingleLineTextField *textFieldAlignCenter;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UIView *activeTextField;

@end

@implementation MLTitledTextFieldViewController

#pragma mark - Navigation
- (void)viewDidLoad
{
	[super viewDidLoad];
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(keyboardWasShown:)
	                                             name:UIKeyboardDidShowNotification object:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(keyboardWillBeHidden:)
	                                             name:UIKeyboardWillHideNotification object:nil];

	self.textField1.textInputControl.autocorrectionType = UITextAutocorrectionTypeNo;
	self.textField1.keyboardType = UIKeyboardTypeNumberPad;
	self.textField2.textInputControl.keyboardType = UIKeyboardTypeNumberPad;
	[self.textFieldAlignCenter setupInnerTextWithAlignment:NSTextAlignmentCenter];
	self.textFieldAlignCenter.helperDescription = @"Helper Description Centered";
}

#pragma mark - Memory
- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
}

#pragma mark User actions

- (IBAction)addCharCount:(id)sender
{
	self.textField1.helperDescription = @"";
	self.textField1.charactersCountVisible = YES;
}

- (IBAction)addHelperDescription:(id)sender
{
	self.textField1.charactersCountVisible = NO;
	self.textField1.helperDescription = @"Helper Description";
}

- (IBAction)addErrors:(id)sender
{
	self.textField1.errorDescription = @"A short error description";
	self.textField2.errorDescription = @"A longer error description that may take up to two lines or maybe three who knows";
	self.textFieldAlignCenter.errorDescription = @"A longer error description that may take up to two lines or maybe three who knows";
}

#pragma mark Keyboard changes

- (void)keyboardWasShown:(NSNotification *)aNotification
{
	NSDictionary *info = [aNotification userInfo];
	CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

	UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
	self.scrollView.contentInset = contentInsets;
	self.scrollView.scrollIndicatorInsets = contentInsets;

	CGRect aRect = self.view.frame;
	aRect.size.height -= kbSize.height;
	if (!CGRectContainsPoint(aRect, self.activeTextField.frame.origin)) {
		[self.scrollView scrollRectToVisible:self.activeTextField.frame animated:YES];
	}
}

- (void)keyboardWillBeHidden:(id)object
{
	UIEdgeInsets contentInsets = UIEdgeInsetsZero;
	self.scrollView.contentInset = contentInsets;
	self.scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark TextField delegate

- (void)textFieldDidBeginEditing:(MLTitledSingleLineTextField *)textField
{
	self.activeTextField = textField;
}

- (void)textFieldDidEndEditing:(MLTitledSingleLineTextField *)textField
{
	self.activeTextField = nil;
}

#pragma mark Target-Action

- (IBAction)editingChanged:(id)sender
{
	NSLog(@"Text changed for %@", sender);
}

@end
