//
// MLSimpleHeaderView.h
// MLUI
//
// Created by Cristian Gimenez on 08/04/2019.
// Copyright © 2019 MercadoLibre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLSimpleHeaderView : UIView

+ (instancetype)simpleHeaderView;

@property (nonatomic, copy) NSString *title;

@end
