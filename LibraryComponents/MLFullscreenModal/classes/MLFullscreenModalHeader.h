//
// MLFullscreenModalHeader.h
// MLUI
//
// Created by Cristian Gimenez on 14/03/2019.
// Copyright © 2019 MercadoLibre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLFullscreenModalHeader : UIView

/**
 * Returns header instance.
 */
+ (instancetype)simpleHeaderView;

/**
 * Header title.
 */
@property (nonatomic, copy) NSString *title;

/**
 * Whether the header should react to screen content scroll.
 */
@property (nonatomic) BOOL scrollEnabled;

@end
