//
// MLFullscreenModal.h
// MLUI
//
// Created by Cristian Gimenez on 13/03/2019.
// Copyright © 2019 MercadoLibre. All rights reserved.
//

#import <UIKit/UIKit.h>

API_DEPRECATED("'MLUI' was deprecated, No longer supported; please adopt AndesUI.", ios(1.0, 13.0))
@interface MLFullscreenModal : UIViewController

/**
 *  Creates modal with inner view controller and title
 *  @param innerViewController      viewController to show on the modal. View needs to have autolayout, and its width
 *                                  cannot be fixed.
 *  @param title                    modal title
 */
- (instancetype)initWithViewController:(UIViewController *)innerViewController title:(NSString *)title;

@end
