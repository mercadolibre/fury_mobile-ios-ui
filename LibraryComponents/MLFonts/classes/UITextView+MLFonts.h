//
// UITextView+MLFonts.h
// MLUI
//
// Created by Nicolas Andres Suarez on 27/1/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import <UIKit/UIKit.h>

API_DEPRECATED("'MLUI' was deprecated, No longer supported; please adopt AndesTextArea.", ios(1.0, 13.0))
@interface UITextView (MLFonts)

- (void)ml_shouldSetSystemFont:(NSInteger)shouldSet UI_APPEARANCE_SELECTOR __deprecated_msg("'MLUI' was deprecated, No longer supported; please adopt AndesTextArea.");

@end
