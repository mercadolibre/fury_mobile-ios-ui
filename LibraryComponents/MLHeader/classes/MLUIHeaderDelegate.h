//
// MLUIHeaderDelegate.h
// MLUI
//
// Created by Cristian Gimenez on 12/03/2019.
//

#import <UIKit/UIKit.h>

@protocol MLUIHeaderDelegate <NSObject>

/**
   The header view that will be expanded/collapsed depending of the mode.

   @return the header view to display.
 */
- (UIView *)headerView;

/**
   The content of the screen with the header.

   @return the content view to display.
 */
- (UIView *)contentView;

@optional

/**
   The scroll view of the screen with the header.

   @return If the child view controller provides its own scroll view (it could be any class that inherits from UIScrollView e.g. UITableView or UICollectionView), this method corresponds to that scroll view. Otherwise, the header will create his own scroll view.
 */
- (UIScrollView *)scrollViewForHeader;

/**
   Gets the minimum threshold for the navigation bar to start appearing in the screen,
   in the coordinates of the header view.

   @param headerHeight the header height.
   @return the minimum threshold for the navigation bar to start appearing in the screen, in the coordinates of the header view.
 */
- (CGFloat)minNavigationBarVisibilityThresholdForHeaderHeight:(CGFloat)headerHeight;

/**
   Gets the maximum threshold for the navigation bar to start appearing in the screen,
   in the coordinates of the header view.

   @param headerHeight the header height.

   @return the maximum threshold for the navigation bar to start appearing in the screen, in the coordinates of the header view.
 */
- (CGFloat)maxNavigationBarVisibilityThresholdForHeaderHeight:(CGFloat)headerHeight;

/**
   Gets whether the header controller should scroll the content or not.

   @return whether the header controller should scroll the content or not.
 */
- (BOOL)shouldScrollContent;

/**
   Gets the parallax effect coefficient. This value should be between 0.0 and 1.0,
   being 0.0 the value for no effect at all. Defaults to 0.0 if not implemented.

   @return the parallax effect coefficient.
 */
- (CGFloat)parallaxEffectCoefficient;

@end
