//
// UIViewController+SnackBar.m
// MLUI
//
// Created by Sebastián Bravo on 21/7/15.
// Copyright (c) 2015 MercadoLibre. All rights reserved.
//

#import "UIViewController+SnackBar.h"
#import <objc/runtime.h>

@implementation UIViewController (SnackBar)

@dynamic ml_snackBarsArray;

- (void)setMl_snackBarsArray:(NSMutableArray *)snackBars
{
    objc_setAssociatedObject(self, @selector(ml_snackBarsArray), snackBars, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)ml_snackBarsArray
{
    return objc_getAssociatedObject(self, @selector(ml_snackBarsArray));
}

- (void)ml_dismissAllSnackBars
{
    for (UIView *snackBarView in self.ml_snackBarsArray) {
        [snackBarView removeFromSuperview];
    }

    [self.ml_snackBarsArray removeAllObjects];
}

@end
