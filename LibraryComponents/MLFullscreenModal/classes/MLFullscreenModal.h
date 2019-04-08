//
// MLFullscreenModal.h
// MLUI
//
// Created by Cristian Gimenez on 13/03/2019.
// Copyright © 2019 MercadoLibre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLFullscreenModal : UIViewController

- (instancetype)initWithViewController:(UIViewController *)innerViewController title:(NSString *)title;

@end
