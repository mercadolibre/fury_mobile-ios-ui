//
// MLUIHeader.m
// MLUI
//
// Created by Cristian Gimenez on 12/03/2019.
//

#import "MLUIHeader.h"
#import <MLUI/MLStyleSheetManager.h>
#import <MLUI/UIColor+MLColorPalette.h>

static NSString *const kMLHeaderControllerContentOffsetKey = @"contentOffset";
static NSString *const kMLHeaderControllerTitleKey = @"title";
static NSString *const kMLHeaderControllerHeaderBoundsKey = @"bounds";

@interface MLUIHeader ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIView *statusBarView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *statusBarViewHeight;

@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, strong) UIView *headerViewContainer;

@property (nonatomic, assign) CGFloat headerViewHeight;
@property (nonatomic, assign) CGFloat minNavigationBarVisibilityThreshold;
@property (nonatomic, assign) CGFloat maxNavigationBarVisibilityThreshold;
@property (nonatomic, assign) CGFloat parallaxEffectCoefficient;

@property (nonatomic, assign) BOOL shouldScrollContent;
@property (nonatomic, assign) BOOL isObserving;

@property (nonatomic, assign) CGFloat scrollViewOriginalTopInset;
@property (nonatomic, assign) UIEdgeInsets scrollViewIndicatorOriginalInset;

@property (nonatomic, copy) NSString *viewTitle;
@property (nonatomic, assign) BOOL titleHidden;

@property (nonatomic, assign) CGFloat statusbarHeight;
@property (nonatomic, assign) CGFloat navigationBarHeight;

@property (nonatomic, assign) BOOL navBarColorChanged;

@end

@implementation MLUIHeader

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.automaticallyAdjustsScrollViewInsets = NO;
		self.isObserving = NO;
		self.titleHidden = NO;
		self.shouldScrollContent = NO;

		self.headerViewHeight = 0.0f;
		self.minNavigationBarVisibilityThreshold = 0.0f;
		self.maxNavigationBarVisibilityThreshold = 1.0f;
		self.parallaxEffectCoefficient = 0.0f;

		_mode = MLUIHeaderModeDefault;
	}
	return self;
}

- (NSBundle *)nibBundle
{
	return [NSBundle bundleForClass:[self class]];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	if (!self.isObserving) {
		[self.scrollView addObserver:self forKeyPath:kMLHeaderControllerContentOffsetKey options:0 context:nil];
		[self.parentViewController addObserver:self forKeyPath:kMLHeaderControllerTitleKey options:0 context:nil];
		[self.headerView addObserver:self forKeyPath:kMLHeaderControllerHeaderBoundsKey options:0 context:nil];
		self.isObserving = YES;
	}

	[self updateNavigationBar];
}

- (void)viewDidDisappear:(BOOL)animated
{
	if (self.hasShadow) {
		UIImage *shadowImage = [[UIImage alloc] init];

		self.delegate.navigationController.navigationBar.shadowImage = shadowImage;

		[self.delegate.navigationController.navigationBar setBackgroundImage:shadowImage forBarMetrics:UIBarMetricsDefault];

		self.navigationBarBackgroundcolor = [[MLStyleSheetManager styleSheet] primaryColor];
	}
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
	[super didMoveToParentViewController:parent];

	// Get Statusbar and NavigationBar height
	self.statusbarHeight = CGRectGetHeight(UIApplication.sharedApplication.statusBarFrame);
	self.navigationBarHeight = parent.navigationController.navigationBar.frame.size.height;

	// Get Content View
	self.contentView = [self.delegate contentView];

	// Use the same background color as the parent view.
	self.view.backgroundColor = self.contentView.backgroundColor;

	// Ask the child view controller for any configuration.
	[self askDelegateForConfig];

	// Setup the scroll view.
	[self setupScrollView];

	// Finally, add the content.
	[self addContent];

	// Make the UINavigationController's navigation bar look as we want.
	[self setupSystemNavigationBar];

	// Add statusBar view
	self.statusBarViewHeight.constant = self.statusbarHeight + self.navigationBarHeight;
	[self.view bringSubviewToFront:self.statusBarView];

	// Set default backgroundColor
	if (!self.navBarColorChanged) {
		self.navigationBarBackgroundcolor = [[MLStyleSheetManager styleSheet] primaryColor];
	}
}

- (void)askDelegateForConfig
{
	// Ask the child view for the header view.
	self.headerView = [self.delegate headerView];

	// Ask the child view controller for the parallax effect coefficient.
	if ([self.delegate respondsToSelector:@selector(parallaxEffectCoefficient)]) {
		self.parallaxEffectCoefficient = [self.delegate parallaxEffectCoefficient];
	}

	// Ask the child view controller if it wants to scroll its content.
	if ([self.delegate respondsToSelector:@selector(shouldScrollContent)]) {
		self.shouldScrollContent = [self.delegate shouldScrollContent];
	}

	// Calculate the header view height.
	if (self.headerView != nil) {
		self.headerViewHeight = [self calculateHeaderViewHeight];
	}

	// Ask the child view for the minimum navigation bar visibility threshold.
	if ([self.delegate respondsToSelector:@selector(minNavigationBarVisibilityThresholdForHeaderHeight:)]) {
		self.minNavigationBarVisibilityThreshold = [self calculateThresholdPercentWithThreshold:[self.delegate minNavigationBarVisibilityThresholdForHeaderHeight:self.headerViewHeight]];
	}

	// Ask the child view for the maximum navigation bar visibility threshold.
	if ([self.delegate respondsToSelector:@selector(maxNavigationBarVisibilityThresholdForHeaderHeight:)]) {
		self.maxNavigationBarVisibilityThreshold = [self calculateThresholdPercentWithThreshold:[self.delegate maxNavigationBarVisibilityThresholdForHeaderHeight:self.headerViewHeight]];
	}

	// Make sure the given thresholds make sense.
	if (self.minNavigationBarVisibilityThreshold > self.maxNavigationBarVisibilityThreshold) {
		NSLog(@"The minimum navigation bar visibility threshold is greater than the maximum. Resetting to default values.");
		self.minNavigationBarVisibilityThreshold = 0.0f;
		self.maxNavigationBarVisibilityThreshold = 1.0f;
	}
}

- (CGFloat)calculateHeaderViewHeight
{
	NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:CGRectGetWidth(self.view.frame)];
	[self.headerView addConstraint:widthConstraint];
	[self.headerView setNeedsLayout];
	[self.headerView layoutIfNeeded];
	CGFloat height = [self.headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
	[self.headerView removeConstraint:widthConstraint];
	return height;
}

- (CGFloat)calculateThresholdPercentWithThreshold:(CGFloat)threshold
{
	CGFloat navigationBarHeight = self.navigationBarHeight + self.statusbarHeight;
	return MIN(1.0f, MAX(0.0f, (threshold - navigationBarHeight) / (self.headerViewHeight - navigationBarHeight)));
}

- (void)setupScrollView
{
	CGFloat navigationBarHeight = self.navigationBarHeight + self.statusbarHeight;

	// Ask the child view controller for its scroll view that will handle the scrolling.
	if ([self.delegate respondsToSelector:@selector(scrollViewForHeader)]) {
		self.scrollView = [self.delegate scrollViewForHeader];

		// Disable Inset Adjustment for iOS 11
		if (@available(iOS 11.0, *)) {
			self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
		}
	}

	if (self.scrollView == nil) {
		self.scrollView = [[UIScrollView alloc] init];
		[self.scrollView addSubview:self.contentView];
		self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[v]|" options:0 metrics:nil views:@{@"v" : self.contentView}]];
		[self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[v]|" options:0 metrics:nil views:@{@"v" : self.contentView}]];
		[self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f]];

		// Now we need to set the child view height.
		// We have two cases here:
		//
		// 1. The view is set up with AutoLayout in a way that its height can be
		// calculated. For this, the view must add constraints along the 'y' axis,
		// either explicitly or implicitly.
		// 2. The view does not use AutoLayout, or it uses it but it does no have all
		// the needed constraints along the 'y' axis to let the header controller
		// calculate its height.
		//
		// In case 1, we guess that the view 'wants' the height defined by its constraints,
		// so just let it have that height.
		// In case 2, we guess that the view 'needs' to have the height that it would had
		// if no header controller was used at all.

		CGFloat contentViewHeight = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;

		if (contentViewHeight == 0.0f) {
		    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeHeight multiplier:1.0f constant:self.shouldScrollContent ? -navigationBarHeight : -self.headerViewHeight]];
		}
	}

	// Save the original scroll view insets.
	self.scrollViewOriginalTopInset = self.scrollView.contentInset.top;
	self.scrollViewIndicatorOriginalInset = self.scrollView.scrollIndicatorInsets;

	// Should the scroll view scroll at all?
	self.scrollView.scrollEnabled = self.shouldScrollContent;

	// Update the content inset.
	[self updateContentInset];
}

- (void)updateContentInset
{
    CGFloat navigationBarHeight = self.navigationBarHeight + self.statusbarHeight;

    CGFloat headerAddedTopInset;
    if (self.mode == MLUIHeaderModeDefault) {
        headerAddedTopInset = self.headerViewHeight;
	} else {
        headerAddedTopInset = navigationBarHeight;
	}

    self.scrollView.contentInset = UIEdgeInsetsMake(self.scrollViewOriginalTopInset + headerAddedTopInset, self.scrollView.contentInset.left, self.scrollView.contentInset.bottom, self.scrollView.contentInset.right);

    if (self.mode == MLUIHeaderModeDefault) {
        self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(navigationBarHeight, self.scrollView.scrollIndicatorInsets.left, self.scrollView.scrollIndicatorInsets.bottom, self.scrollView.scrollIndicatorInsets.right);
	} else {
        self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset;
	}
}

- (void)addContent
{
    // Dependending on the scroll view being used, we need to add a different
    // subview into the view hierarchy.
    UIView *subview = self.scrollView;

    // Get rid of the autoresizing mask.
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:subview];

    // Add the anchors.
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[v]|" options:0 metrics:0 views:@{@"v" : subview}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[v]|" options:0 metrics:0 views:@{@"v" : subview}]];

    // We need to layout as we need to get the scroll view width.
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];

    // Update the header view.
    [self updateHeaderView];
}

- (void)updateHeaderView
{
    [self.headerViewContainer removeFromSuperview];

    if (self.mode != MLUIHeaderModeAlwaysCollapsed) {
        // We need to use a container for the header view because:
        // 1. It is useful to achieve the parallax effect.

        self.headerViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0.0f, -self.scrollView.contentInset.top, CGRectGetWidth(self.scrollView.frame), self.headerViewHeight)];
        self.headerViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.headerViewContainer.clipsToBounds = YES;
        self.headerViewContainer.translatesAutoresizingMaskIntoConstraints = YES;

        [self.scrollView addSubview:self.headerViewContainer];

        self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.headerViewContainer addSubview:self.headerView];
        self.headerViewContainer.backgroundColor = self.headerView.backgroundColor;
        [self.headerViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[v]|" options:0 metrics:nil views:@{@"v" : self.headerView}]];
        [self.headerViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v]|" options:0 metrics:nil views:@{@"v" : self.headerView}]];
	}
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary <NSString *, id> *)change context:(void *)context
{
    if (object == self.scrollView && [keyPath isEqualToString:kMLHeaderControllerContentOffsetKey]) {
        // Here we are observing any "contentOffset" change over the scroll view.
        if (self.mode == MLUIHeaderModeDefault) {
            [self updateNavigationBar];

            [self updateHeaderPosition];
		}
	} else if (object == self.parentViewController && [keyPath isEqualToString:kMLHeaderControllerTitleKey]) {
        // Here we are observing any "title" change.
        if (![self.parentViewController.title isEqualToString:@""]) {
            if (self.viewTitle != self.parentViewController.title) {
                self.viewTitle = self.parentViewController.title;
                if (!self.titleHidden) {
                    self.delegate.title = self.viewTitle;
				} else {
                    self.delegate.title = @"";
				}
			} else if (self.titleHidden) {
                self.delegate.title = @"";
			}
		}
	} else if (object == self.headerView && [keyPath isEqualToString:kMLHeaderControllerHeaderBoundsKey]) {
        // Observes for changes in bounds that could change header size
        // Update header layout
        CGFloat newHeaderHeight = CGRectGetHeight(self.headerView.frame);

        // Checks if header size should be updated.
        // In order to avoid infinite loop, header will be update only when height diff is major or equal to kMLHeaderControllerMinHeightDiffForUpdate
        CGFloat heightDiff = fabs(newHeaderHeight - self.headerViewHeight);
        if (heightDiff >= 0.5F) {
            CGPoint prevContentOffset = self.scrollView.contentOffset;  // Saves old contentOffset
            CGFloat prevHeaderHeight = self.headerViewHeight;  // Saves old header height
            self.headerViewHeight = newHeaderHeight;  // Set new contentOffset
            [self updateContentInset];  // Update Insets
            [self updateHeaderView];  // Update header container
            self.scrollView.contentOffset = CGPointMake(prevContentOffset.x, prevContentOffset.y + (prevHeaderHeight - self.headerViewHeight));  // Adds size delta to contentOffset
            [self updateHeaderPosition];
		}
	}
}

- (void)updateHeaderPosition
{
    CGFloat posY = MIN(self.scrollView.contentOffset.y, -self.headerViewHeight);
    CGFloat height = -posY;
    self.headerViewContainer.frame = CGRectMake(0, posY, CGRectGetWidth(self.headerViewContainer.frame), height);

    // Should we do parallax?
    if (self.parallaxEffectCoefficient > 0.0f) {
        // Determine how much parallax we should apply.
        CGFloat parallaxDisplacement = MAX((height - self.headerViewHeight), MIN(CGRectGetHeight(self.headerView.superview.frame), self.parallaxEffectCoefficient * (self.scrollView.contentOffset.y + self.scrollView.contentInset.top)));
        parallaxDisplacement = ceil(parallaxDisplacement);
        // Apply the parallax effect :)
        self.headerView.frame = CGRectMake(CGRectGetMinX(self.headerView.frame), parallaxDisplacement, CGRectGetWidth(self.headerView.frame), CGRectGetHeight(self.headerView.frame));
	}
}

- (void)setupSystemNavigationBar
{
    // Get rid of the system navigation bar background color.
    [self.delegate.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.delegate.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.delegate.navigationController.navigationBar.translucent = YES;
    self.delegate.navigationController.navigationBar.opaque = NO;

    if (self.delegate.title.length > 0) {
        self.viewTitle = self.delegate.title;
        self.delegate.title = @"";
        self.titleHidden = YES;
	}
}

- (CGFloat)calculateNavigationBarAlpha
{
    if (self.mode == MLUIHeaderModeAlwaysCollapsed) {
        return 1.0f;
	}
    CGFloat navigationBarHeight = self.navigationBarHeight + self.statusbarHeight;

    // Determine how much alpha we should apply to our navigation bar.
    CGFloat headerVisibleProportion = MAX(0.0f, MIN(1.0f, (self.scrollView.contentOffset.y + self.scrollView.contentInset.top) / (self.headerViewHeight - navigationBarHeight)));
    return MAX(0.0f, MIN(1.0f, (headerVisibleProportion - self.minNavigationBarVisibilityThreshold) / (self.maxNavigationBarVisibilityThreshold - self.minNavigationBarVisibilityThreshold)));
}

- (void)updateNavigationBar
{
    [self setupSystemNavigationBar];

    CGFloat alpha = [self calculateNavigationBarAlpha];
    UIColor *colorWithAlpha = [self.navigationBarBackgroundcolor colorWithAlphaComponent:alpha];

    self.statusBarView.backgroundColor = colorWithAlpha;

    // Animate the appearance of our navigation bar title.
    bool showTitle = alpha == 1.f;
    if (showTitle && self.titleHidden) {
        self.titleHidden = NO;
        self.delegate.title = self.viewTitle;
	} else if (!showTitle && !self.titleHidden) {
        self.delegate.title = @"";
        self.titleHidden = YES;
	}

    if (self.titleHidden) {
        self.delegate.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
        self.delegate.navigationController.navigationBar.layer.shadowOpacity = 0;
	} else if (self.hasShadow) {
        UIImage *shadowImage = [[UIImage alloc] init];

        self.delegate.navigationController.navigationBar.shadowImage = shadowImage;

        CGSize size = CGSizeMake(1, 1);
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
        [[[MLStyleSheetManager styleSheet] whiteColor] setFill];
        UIRectFill(CGRectMake(0, 0, 1, 1));
        UIImage *shadowedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        [self.delegate.navigationController.navigationBar setBackgroundImage:shadowedImage forBarMetrics:UIBarMetricsDefault];
        self.delegate.navigationController.navigationBar.layer.shadowColor = [UIColor ml_meli_mid_grey].CGColor;
        self.delegate.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 4);
        self.delegate.navigationController.navigationBar.layer.shadowOpacity = 0.8;
        self.delegate.navigationController.navigationBar.layer.shadowRadius = 2;
	}
}

- (void)setNavigationBarBackgroundcolor:(UIColor *)navigationBarBackgroundcolor
{
    _navigationBarBackgroundcolor = navigationBarBackgroundcolor;
    _navBarColorChanged = YES;

    UIColor *oldColor = self.delegate.navigationController.navigationBar.backgroundColor;
    CGFloat alpha = CGColorGetAlpha([oldColor CGColor]);

    self.delegate.navigationController.navigationBar.backgroundColor = [_navigationBarBackgroundcolor colorWithAlphaComponent:alpha];
    self.statusBarView.backgroundColor = [_navigationBarBackgroundcolor colorWithAlphaComponent:alpha];
}

- (void)setMode:(MLUIHeaderMode)mode
{
    // If no header is provided, we force the always collapsed mode.
    if (self.headerViewHeight == 0.0f || self.headerView == nil) {
        _mode = MLUIHeaderModeAlwaysCollapsed;
	}

    // Update the field.
    _mode = mode;

    // Update the content inset and the header view once again, as we are changing
    // the mode.
    [self updateContentInset];
    [self updateHeaderView];

    if (mode == MLUIHeaderModeDefault) {
        [self updateHeaderPosition];
	}

    [self updateNavigationBar];
}

- (void)removeContentOffsetObserver
{
    if (self.isObserving) {
        [self.scrollView removeObserver:self forKeyPath:kMLHeaderControllerContentOffsetKey];
        [self.parentViewController removeObserver:self forKeyPath:kMLHeaderControllerTitleKey];
        [self.headerView removeObserver:self forKeyPath:kMLHeaderControllerHeaderBoundsKey];
        self.isObserving = NO;
	}
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeContentOffsetObserver];
}

- (void)dealloc
{
    // we make sure to remove the observer in case viewWillDisappear isn't called before dealloc
    [self removeContentOffsetObserver];
}

@end
