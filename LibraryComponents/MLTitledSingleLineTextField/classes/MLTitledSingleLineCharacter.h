//
//  MLTitledSingleLineCharacter.h
//  MLUI
//
//  Created by JAVIER PEDRO MARTEGANI on 12/08/2019.
//
#import <Foundation/Foundation.h>

@protocol MLTitledSingleLineCharacterDelegate <NSObject>
- (void)textFieldDidPressDeleteKey:(UITextField *)textField;
@end

@interface MLTitledSingleLineCharacter : UITextField
@property (nonatomic, weak) id <MLTitledSingleLineCharacterDelegate> characterDelegate;
@end
