//
// UILabel+MLFonts.h
// MLUI
//
// Created by Nicolas Andres Suarez on 27/1/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import <UIKit/UIKit.h>

API_DEPRECATED("'MLUI' was deprecated, No longer supported; please adopt AndesLabel.", ios(1.0, 13.0))
@interface UILabel (MLFonts)

- (void)ml_shouldSetSystemFont:(NSInteger)shouldSet UI_APPEARANCE_SELECTOR;

@end
