//
// UITextView+MLStyle.h
// MLUI
//
// Created by Julieta Puente on 7/25/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLStyleUtils.h"

API_DEPRECATED("'MLUI' was deprecated, No longer supported; please adopt AndesUI.", ios(1.0, 13.0))
@interface UITextView (MLStyle)

/**
 *  Set label style. It includes lineSpacing and font
 *
 *  @param style     style
 */
- (void)ml_setStyle:(MLStyle)style;

@end
