//
// MLUITextField.h
// MLUI
//
// Created by JAVIER PEDRO MARTEGANI on 12/08/2019.
//
#import <Foundation/Foundation.h>

@protocol MLUITextFieldDelegate <NSObject>
- (void)textFieldDidPressDeleteKey:(UITextField *)textField;
@end

@interface MLUITextField : UITextField
@property (nonatomic, weak) id <MLUITextFieldDelegate> textFieldDelegate;
@end
