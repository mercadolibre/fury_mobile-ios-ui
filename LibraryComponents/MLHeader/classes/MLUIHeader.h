//
// MLUIHeader.h
// MLUI
//
// Created by Cristian Gimenez on 12/03/2019.
//

#import <UIKit/UIKit.h>
#import "MLUIHeaderDelegate.h"

typedef NS_ENUM (NSInteger, MLUIHeaderMode) {
	/**
	 *  The default mode. The header is shown, but is collapsed as the user reaches the top of the content.
	 */
	MLUIHeaderModeDefault,

	/**
	 *  The header will not be visible. The navigation bar will be fixed on the screen.
	 */
	MLUIHeaderModeAlwaysCollapsed
};

@interface MLUIHeader : UIViewController

/**
 *  The header delegate.
 */
@property (nonatomic, weak) UIViewController <MLUIHeaderDelegate> *delegate;

/**
 *  The navigation bar background color.
 */
@property (nonatomic, strong) UIColor *navigationBarBackgroundcolor;

/**
 *  The header mode (see MLUICHeaderMode description above)
 */
@property (nonatomic, assign) MLUIHeaderMode mode;

/**
 *  If the navigation Bar have shadow.
 */
@property (nonatomic, assign) BOOL hasShadow;

@end
