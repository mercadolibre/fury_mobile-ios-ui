//
// UIViewController+SnackBar.h
// MLUI
//
// Created by Sebastián Bravo on 21/7/15.
// Copyright (c) 2015 MercadoLibre. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MLUISnackBarProtocol;

API_DEPRECATED("'MLUI' was deprecated, No longer supported; please adopt AndesUI.", ios(1.0, 13.0))
@interface UIViewController (SnackBar)

@property (nonatomic, strong) NSMutableArray *ml_snackBarsArray;

/**
 *  Hide all snackbars
 */
- (void)ml_dismissAllSnackBars;

@end

