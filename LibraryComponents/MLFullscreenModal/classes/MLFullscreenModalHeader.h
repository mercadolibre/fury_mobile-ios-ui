//
// MLFullscreenModalHeader.h
// MLUI
//
// Created by Cristian Gimenez on 14/03/2019.
// Copyright © 2019 MercadoLibre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLFullscreenModalHeader : UIView

+ (instancetype)simpleHeaderView;

@property (nonatomic, copy) NSString *title;
@property (nonatomic) BOOL scrollEnabled;

@end
