//
// MLStyleSheetDefault.h
// MercadoLibre
//
// Created by Cristian Leonel Gibert on 1/18/18.
//

#import <UIKit/UIKit.h>
#import "MLStyleSheetProtocol.h"

/**
   MLStyleSheetDefault is the standard class
   to build another custom stylesheet inheriting
   from this one and overriding the necessary colors and fonts
 */
API_DEPRECATED("'MLUI' was deprecated, No longer supported; please adopt AndesStyleSheetManager", ios(1.0, 13.0))
@interface MLStyleSheetDefault : NSObject <MLStyleSheetProtocol>

@end
