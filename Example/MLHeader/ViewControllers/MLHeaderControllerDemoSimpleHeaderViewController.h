//
// MLHeaderControllerDemoSimpleHeaderViewController.h
// MLUI
//
// Created by Cristian Gimenez on 08/04/2019.
// Copyright © 2019 MercadoLibre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MLUI/MLUIHeader.h>
#import "MLViewController.h"

@interface MLHeaderControllerDemoSimpleHeaderViewController : MLViewController <MLUIHeaderDelegate>

@property (nonatomic) MLUIHeader *headerViewController;
@property (nonatomic, strong) IBOutlet UIView *content;

@end
