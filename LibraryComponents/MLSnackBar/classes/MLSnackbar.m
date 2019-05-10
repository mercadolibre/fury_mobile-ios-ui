//
// MLSnackBar.m
// MLUI
//
// Created by Julieta Puente on 26/2/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import "MLSnackbar.h"
#import "UIFont+MLFonts.h"
#import "MLUIBundle.h"

@interface MLSnackbarButton : UIButton
@property (nonatomic, strong) UIColor *backgroundHighlightedColor;
@end

@implementation MLSnackbarButton

- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];

	if (highlighted) {
		self.backgroundColor = self.backgroundHighlightedColor;
	} else {
		self.backgroundColor = [UIColor clearColor];
	}
}

- (void)setSelected:(BOOL)selected
{
	[super setSelected:selected];
	if (selected) {
		self.backgroundColor = self.backgroundHighlightedColor;
	} else {
		self.backgroundColor = [UIColor clearColor];
	}
}

@end

@interface MLKeyboardInfo : NSObject
@property (nonatomic) CGFloat keyboardHeight;
+ (instancetype)sharedInstance;
@end

@interface MLSnackbar ()
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet MLSnackbarButton *actionButton;
@property (strong, nonatomic) UIView *snackbarView;
@property (nonatomic, copy) void (^actionBlock)(void);
@property (nonatomic, copy) MLSnackbarDismissBlock dismissBlock;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelButtonSpacing;
@property (nonatomic) MLSnackbarDuration duration;
@property (nonatomic) BOOL isShowingSnackbar;
@property (nonatomic) BOOL isAnimating;
@property (nonatomic) BOOL isDesappearing;
@property (nonatomic, strong) UIPanGestureRecognizer *gesture;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) long durationInMillis;
@property (nonatomic, copy) void (^pendingAction)(void);
@property (nonatomic, strong) NSLayoutConstraint *bottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *snackbarViewLeftConstraint;
@property (nonatomic, strong) NSLayoutConstraint *snackbarViewTopConstraint;
@property (nonatomic) UIViewController *presentingViewController;

@end

static CGFloat const kMLSnackbarAnimationDuration = 0.3;
static int const kMLSnackbarOneLineViewHeight = 48;
static int const kMLSnackbarTwoLineViewHeight = 82;
static int const kMLSnackbarOneLineComponentHeight = 20;
static int const kMLSnackbarOneLineTopSpacing = 14;
static int const kMLSnackbarTwoLineTopSpacing = 24;
static int const kMLSnackbarLabelButtonSpacing = 24;

@implementation MLSnackbar

+ (instancetype)showWithTitle:(NSString *)title type:(MLSnackbarType *)type duration:(MLSnackbarDuration)duration dismissGestureEnabled:(BOOL)dismissGestureEnabled
{
	return [MLSnackbar showWithTitle:title actionTitle:nil actionBlock:nil type:type duration:duration dismissGestureEnabled:dismissGestureEnabled];
}

+ (instancetype)showWithTitle:(NSString *)title actionTitle:(NSString *)buttonTitle actionBlock:(void (^)(void))actionBlock type:(MLSnackbarType *)type duration:(MLSnackbarDuration)duration
{
	return [MLSnackbar showWithTitle:title actionTitle:buttonTitle actionBlock:actionBlock type:type duration:duration dismissGestureEnabled:YES];
}

+ (instancetype)showWithTitle:(NSString *)title type:(MLSnackbarType *)type duration:(MLSnackbarDuration)duration
{
	return [MLSnackbar showWithTitle:title actionTitle:nil actionBlock:nil type:type duration:duration dismissGestureEnabled:YES];
}

+ (instancetype)showWithTitle:(NSString *)title actionTitle:(NSString *)buttonTitle actionBlock:(void (^)(void))actionBlock type:(MLSnackbarType *)type duration:(MLSnackbarDuration)duration dismissGestureEnabled:(BOOL)dismissGestureEnabled
{
	return [MLSnackbar showWithTitle:title actionTitle:buttonTitle actionBlock:actionBlock type:type duration:duration dismissGestureEnabled:dismissGestureEnabled dismissBlock:nil];
}

+ (instancetype)showWithTitle:(NSString *)title type:(MLSnackbarType *)type duration:(MLSnackbarDuration)duration dismissGestureEnabled:(BOOL)dismissGestureEnabled dismissBlock:(MLSnackbarDismissBlock)dismissBlock
{
	return [MLSnackbar showWithTitle:title actionTitle:nil actionBlock:nil type:type duration:duration dismissGestureEnabled:dismissGestureEnabled dismissBlock:dismissBlock];
}

+ (instancetype)showWithTitle:(NSString *)title actionTitle:(NSString *)buttonTitle actionBlock:(void (^)(void))actionBlock type:(MLSnackbarType *)type duration:(MLSnackbarDuration)duration dismissBlock:(MLSnackbarDismissBlock)dismissBlock
{
	return [MLSnackbar showWithTitle:title actionTitle:buttonTitle actionBlock:actionBlock type:type duration:duration dismissGestureEnabled:YES dismissBlock:dismissBlock];
}

+ (instancetype)showWithTitle:(NSString *)title type:(MLSnackbarType *)type duration:(MLSnackbarDuration)duration dismissBlock:(MLSnackbarDismissBlock)dismissBlock
{
	return [MLSnackbar showWithTitle:title actionTitle:nil actionBlock:nil type:type duration:duration dismissGestureEnabled:YES dismissBlock:dismissBlock];
}

+ (instancetype)showWithTitle:(NSString *)title actionTitle:(NSString *)buttonTitle actionBlock:(void (^)(void))actionBlock type:(MLSnackbarType *)type duration:(MLSnackbarDuration)duration dismissGestureEnabled:(BOOL)dismissGestureEnabled dismissBlock:(MLSnackbarDismissBlock)dismissBlock
{
	return [MLSnackbar showWithTitle:title actionTitle:buttonTitle actionBlock:actionBlock type:type duration:duration dismissGestureEnabled:dismissGestureEnabled dismissBlock:dismissBlock viewController:nil];
}

// New methods with "ViewController" parameter
+ (instancetype)showWithTitle:(NSString *)title type:(MLSnackbarType *)type duration:(MLSnackbarDuration)duration viewController:(UIViewController *)viewController
{
	return [MLSnackbar showWithTitle:title actionTitle:nil actionBlock:nil type:type duration:duration dismissGestureEnabled:YES dismissBlock:nil viewController:viewController];
}

+ (instancetype)showWithTitle:(NSString *)title actionTitle:(NSString *)buttonTitle actionBlock:(void (^)(void))actionBlock type:(MLSnackbarType *)type duration:(MLSnackbarDuration)duration dismissGestureEnabled:(BOOL)dismissGestureEnabled dismissBlock:(MLSnackbarDismissBlock)dismissBlock viewController:(UIViewController *)viewController
{
	MLSnackbar *snackbar = [MLSnackbar sharedInstance];
	__weak typeof(snackbar) weakSnackbar = snackbar;

	if (snackbar.isDesappearing) {
		snackbar.pendingAction = ^{[weakSnackbar setUpSnackbarWithTitle:title actionTitle:buttonTitle actionBlock:actionBlock type:type duration:duration dismissGestureEnabled:dismissGestureEnabled dismissBlock:dismissBlock viewController:viewController];
		};
	} else {
		if (snackbar.isShowingSnackbar) {
			snackbar.pendingAction = ^{[weakSnackbar setUpSnackbarWithTitle:title actionTitle:buttonTitle actionBlock:actionBlock type:type duration:duration dismissGestureEnabled:dismissGestureEnabled dismissBlock:dismissBlock viewController:viewController];
			};
			[snackbar removeSnackbarWithAnimation:MLSnackbarDismissCauseNone];
		} else {
			[snackbar setUpSnackbarWithTitle:title actionTitle:buttonTitle actionBlock:actionBlock type:type duration:duration dismissGestureEnabled:dismissGestureEnabled dismissBlock:dismissBlock viewController:viewController];
		}

		[[NSNotificationCenter defaultCenter] addObserver:snackbar selector:@selector(didRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
	}

	return snackbar;
}

- (void)setUpSnackbarWithTitle:(NSString *)title actionTitle:(NSString *)buttonTitle actionBlock:(void (^)(void))actionBlock type:(MLSnackbarType *)type duration:(MLSnackbarDuration)duration dismissGestureEnabled:(BOOL)dismissGestureEnabled dismissBlock:(MLSnackbarDismissBlock)dismissBlock
{
	[self setUpSnackbarWithTitle:title actionTitle:buttonTitle actionBlock:actionBlock type:type duration:duration dismissGestureEnabled:dismissGestureEnabled dismissBlock:dismissBlock viewController:nil];
}

- (void)setUpSnackbarWithTitle:(NSString *)title actionTitle:(NSString *)buttonTitle actionBlock:(void (^)(void))actionBlock type:(MLSnackbarType *)type duration:(MLSnackbarDuration)duration dismissGestureEnabled:(BOOL)dismissGestureEnabled dismissBlock:(MLSnackbarDismissBlock)dismissBlock viewController:(UIViewController *)viewController
{
	self.messageLabel.text = title;
	self.messageLabel.textColor = type.titleFontColor;
	self.messageLabel.font = [UIFont ml_lightSystemFontOfSize:kMLFontsSizeXSmall];

	self.snackbarView.backgroundColor = type.backgroundColor;

	if (buttonTitle != nil && actionBlock != nil) {
		[self.actionButton setTitle:buttonTitle forState:UIControlStateNormal];
		[self.actionButton setTitleColor:type.actionFontColor forState:UIControlStateNormal];
		[self.actionButton setTitleColor:type.actionFontHighlightColor forState:UIControlStateHighlighted];
		[self.actionButton setTitleColor:type.actionFontHighlightColor forState:UIControlStateSelected];
		self.actionButton.titleLabel.font = [UIFont ml_regularSystemFontOfSize:kMLFontsSizeXSmall];
		self.actionButton.backgroundHighlightedColor = type.actionBackgroundHighlightColor;
		self.actionButton.layer.cornerRadius = 4.0f;
		self.actionBlock = actionBlock;
		[self.actionButton addTarget:self action:@selector(actionButtonDismissSnackbar) forControlEvents:UIControlEventTouchUpInside];
		self.actionButton.hidden = NO;
		self.labelButtonSpacing.constant = kMLSnackbarLabelButtonSpacing;
		[self.actionButton setContentCompressionResistancePriority:751 forAxis:UILayoutConstraintAxisHorizontal];
	} else {
		// si no se recibe título del botón o un bloque de acción, se esconde el botón
		self.actionButton.hidden = YES;
		self.labelButtonSpacing.constant = 0;
		[self.actionButton setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
	}
	if (dismissGestureEnabled) {
		self.gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAnimation:)];
		[self addGestureRecognizer:self.gesture];
	}
	self.dismissBlock = dismissBlock;

	// Set presenting view controller
	self.presentingViewController = viewController ? : [self topViewController];

	[self updateLayout];
	[self show];

	if (duration != MLSnackbarDurationIndefinitely) {
		self.durationInMillis = [self durationInMilliseconds:duration];
		if (self.durationInMillis > 0) {
			self.timer = [NSTimer scheduledTimerWithTimeInterval:self.durationInMillis / 1000.0 target:self selector:@selector(snackbarTimeOut) userInfo:nil repeats:NO];
		}
	}
}

+ (instancetype)sharedInstance
{
	static MLSnackbar *sharedInstance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc] init];
	});
	return sharedInstance;
}

- (id)init
{
	if (self = [super init]) {
		self.snackbarView = [[MLUIBundle mluiBundle] loadNibNamed:NSStringFromClass([MLSnackbar class])
		                                                    owner:self
		                                                  options:nil].firstObject;

		self.snackbarView.translatesAutoresizingMaskIntoConstraints = NO;
		self.translatesAutoresizingMaskIntoConstraints = NO;

		[self addSubview:self.snackbarView];

		// Snackvar view constraints
		[self.snackbarView.widthAnchor constraintEqualToAnchor:self.widthAnchor constant:0.0].active = YES;
		[self.snackbarView.heightAnchor constraintEqualToAnchor:self.heightAnchor constant:0.0].active = YES;

		self.snackbarViewLeftConstraint = [self.snackbarView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:0.0];
		self.snackbarViewLeftConstraint.active = YES;

		self.snackbarViewTopConstraint = [self.snackbarView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0.0];
		self.snackbarViewTopConstraint.active = YES;

		self.clipsToBounds = YES;
	}

	return self;
}

- (void)updateBottomConstraintWithBottomInset:(CGFloat)inset
                withKeyboardAnimationDuration:(NSTimeInterval)animationDuration
{
	[UIView animateWithDuration:animationDuration
	                 animations: ^{
	    self.bottomConstraint.constant = inset;
	    [self setNeedsLayout];
	    [self layoutIfNeeded];
	}];
}

- (void)updateLayout
{
	[self layoutIfNeeded];
	[self.messageLabel sizeToFit];

	UIView *presentingView = self.presentingViewController.view;
	[presentingView addSubview:self];

	CGFloat snackBarHeight = (CGRectGetHeight(self.messageLabel.frame) > kMLSnackbarOneLineComponentHeight) ? kMLSnackbarTwoLineViewHeight : kMLSnackbarOneLineViewHeight;
	CGFloat labelTopConstraintSpacing = snackBarHeight == kMLSnackbarOneLineComponentHeight ? kMLSnackbarOneLineTopSpacing : kMLSnackbarTwoLineTopSpacing;

	// Constraints
	if (self.superview) {
		[self.leftAnchor constraintEqualToAnchor:self.superview.leftAnchor constant:0.0].active = YES;
		[self.rightAnchor constraintEqualToAnchor:self.superview.rightAnchor constant:0.0].active = YES;

		self.heightConstraint = [self.heightAnchor constraintEqualToConstant:snackBarHeight];
		self.heightConstraint.active = YES;

		CGFloat keyboardHeight = [[MLKeyboardInfo sharedInstance] keyboardHeight];
		NSLayoutYAxisAnchor *bottomAnchor = self.superview.bottomAnchor;
		if (@available(iOS 11.0, *)) {
			bottomAnchor = self.superview.safeAreaLayoutGuide.bottomAnchor;
		}
		self.bottomConstraint = [self.bottomAnchor constraintEqualToAnchor:bottomAnchor constant:[self bottomInsetWithKeyboardHeight:keyboardHeight]];
		self.bottomConstraint.active = YES;
	}

	self.labelTopConstraint.constant = labelTopConstraintSpacing;

	[self layoutIfNeeded];
}

- (void)show
{
	// weakSelf
	__weak typeof(self) weakSelf = self;

	// if other snackbar is animating, we need to disappear it before showing new one
	if (self.isAnimating) {
		self.pendingAction = ^{[weakSelf show];
		};
		if (!self.isDesappearing) {
			[self removeSnackbarWithAnimation:MLSnackbarDismissCauseNone];
		}
	} else {
		CGFloat distance = self.heightConstraint.constant;
		self.snackbarViewTopConstraint.constant = distance;
		[self layoutIfNeeded];

		[UIView animateWithDuration:kMLSnackbarAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations: ^{
		    weakSelf.snackbarViewTopConstraint.constant = 0;
		    [weakSelf layoutIfNeeded];

		    weakSelf.isAnimating = YES;
		} completion: ^(BOOL finished) {
		    weakSelf.isShowingSnackbar = YES;
		    weakSelf.isAnimating = NO;
		}];
	}
}

- (void)snackbarTimeOut
{
	[self removeSnackbarWithAnimation:MLSnackbarDismissCauseDuration];
}

- (void)dismissSnackbar
{
	[self removeSnackbarWithAnimation:MLSnackbarDismissCauseNone];
}

- (UIViewController *)rootViewController
{
	return [[[[UIApplication sharedApplication] delegate] window] rootViewController];
}

- (UIViewController *)topViewController
{
	UIViewController *topViewController = [self rootViewController];

	while ([topViewController presentedViewController] != nil) {
		topViewController = [topViewController presentedViewController];
	}
	return topViewController;
}

- (void)actionButtonDismissSnackbar
{
	[self removeSnackbarWithAnimation:MLSnackbarDismissCauseActionButton];
}

- (IBAction)actionButtonCancelTimer:(id)sender
{
	// cancel timer for button touch down
	[self.timer invalidate];
}

- (long)durationInMilliseconds:(MLSnackbarDuration)duration
{
	switch (duration) {
		case MLSnackbarDurationShort: {
			return 2000;
			break;
		}

		case MLSnackbarDurationLong: {
			return 3500;
			break;
		}

		default: {
			return -1;
			break;
		}
	}
}

- (void)swipeAnimation:(UIPanGestureRecognizer *)gesture
{
	BOOL swipingRight = [gesture velocityInView:gesture.view].x > 0 ? true : false;
	CGPoint translate = [gesture translationInView:gesture.view];
	CGFloat percent = translate.x / gesture.view.bounds.size.width;
	UIPercentDrivenInteractiveTransition *interactionController;

	if (gesture.state == UIGestureRecognizerStateBegan) {
		interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
		// cancel timer while swipe interaction is occuring
		[self.timer invalidate];
	} else if (gesture.state == UIGestureRecognizerStateChanged) {
		self.snackbarViewLeftConstraint.constant = translate.x;
		self.alpha = 1 - fabs(percent);
		[interactionController updateInteractiveTransition:percent];
	} else if (gesture.state == UIGestureRecognizerStateEnded) {
		if (fabs(percent) > 0.2) {
			__weak typeof(self) weakSelf = self;

			[UIView animateWithDuration:kMLSnackbarAnimationDuration animations: ^{
			    CGFloat mainScreenWidth = CGRectGetWidth([UIScreen mainScreen].bounds) * (swipingRight ? 1 : -1);
			    weakSelf.snackbarViewLeftConstraint.constant = mainScreenWidth;
			    [weakSelf layoutIfNeeded];
			    weakSelf.alpha = 0;
			} completion: ^(BOOL finished) {
			    [interactionController finishInteractiveTransition];
			    [weakSelf removeFromSuperview];
			    weakSelf.snackbarViewLeftConstraint.constant = 0;
			    [weakSelf layoutIfNeeded];
			    weakSelf.alpha = 1;
			    weakSelf.isShowingSnackbar = NO;
			    [[NSNotificationCenter defaultCenter] removeObserver:weakSelf];
			    [weakSelf removeGestureRecognizer:gesture];
			    if (weakSelf.dismissBlock != nil) {
			        weakSelf.dismissBlock(MLSnackbarDismissCauseSwipe);
				}
			}];
		} else {
			__weak typeof(self) weakSelf = self;

			[UIView animateWithDuration:kMLSnackbarAnimationDuration animations: ^{
			    weakSelf.snackbarViewLeftConstraint.constant = 0;
			    [weakSelf layoutIfNeeded];
			    weakSelf.alpha = 1;
			}];
			[interactionController cancelInteractiveTransition];

			// if swipe was canceled, the timer needs to restart
			if (self.durationInMillis > 0) {
				self.timer = [NSTimer scheduledTimerWithTimeInterval:self.durationInMillis / 1000.0 target:self selector:@selector(snackbarTimeOut) userInfo:nil repeats:NO];
			}
		}
	}
}

- (void)removeSnackbarWithAnimation:(MLSnackbarDismissCause)cause
{
	__weak typeof(self) weakSelf = self;

	MLSnackbarDismissBlock dismissBlock = [self.dismissBlock copy];
	void (^actionBlock)(void) = [self.actionBlock copy];

	[UIView animateWithDuration:kMLSnackbarAnimationDuration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationCurveEaseOut animations: ^{
	    weakSelf.isAnimating = YES;
	    weakSelf.isDesappearing = YES;
	    [weakSelf.timer invalidate];

	    CGFloat distance = weakSelf.heightConstraint.constant;
	    weakSelf.snackbarViewTopConstraint.constant = distance;
	    [weakSelf layoutIfNeeded];
	} completion: ^(BOOL finished) {
	    weakSelf.alpha = 1;
	    [weakSelf removeFromSuperview];
	    [[NSNotificationCenter defaultCenter] removeObserver:weakSelf];
	    [weakSelf removeGestureRecognizer:weakSelf.gesture];
	    weakSelf.isShowingSnackbar = NO;
	    weakSelf.isDesappearing = NO;
	    weakSelf.isAnimating = NO;

	    // perfom the action block if dismiss ocurred beacuse the Action Button was pressed
	    if (cause == MLSnackbarDismissCauseActionButton) {
	        if (actionBlock) {
	            actionBlock();
			}
		}

	    if (dismissBlock != nil) {
	        dismissBlock(cause);
		}

	    // perfom any pending action after the animation finished
	    if (weakSelf.pendingAction) {
	        weakSelf.pendingAction();
	        weakSelf.pendingAction = nil;
		}
	}];
}

- (void)didRotate:(NSNotification *)notification
{
	CGRect screenRect = [[UIScreen mainScreen] bounds];
	// take keyboard height into account when device rotates
	self.frame = CGRectMake(0, CGRectGetHeight(screenRect) - CGRectGetHeight(self.snackbarView.frame) - [[MLKeyboardInfo sharedInstance] keyboardHeight], CGRectGetWidth(screenRect), CGRectGetHeight(self.snackbarView.frame));
}

- (CGFloat)bottomInsetWithKeyboardHeight:(CGFloat)keyboardHeight
{
	UITabBar *tabBar = [self findTabBarForViewController:self.presentingViewController];
	CGFloat tabBarOffsetHeight = (tabBar && !tabBar.hidden) ? CGRectGetHeight(tabBar.bounds) : 0;
	CGFloat offset = 0;

	// To define the offset height, the only thing I do care is if the view extends or not at bottom behind the tabbar.
	if ([self viewExtendsAtBottomForViewController:self.presentingViewController]) {
		/* If it extends,
		 * If the keyboard exists, the maximum value is going to be the keyboardHeight.
		 * If the keyboard does not exist, the maximum value will be the tabBarOffset.
		 */

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
		offset = MAX(keyboardHeight, tabBarOffsetHeight);
#pragma clang diagnostic pop
	} else {
		/* If it does not extend,
		 * If the keyboard does not exist, the 0 is actually 49 (the tabBar height) so the offset needs to be 0.
		 * If it exists, the offset can't be just the keyboard height because it also starts in 49, so i need to
		 * substract 49 (the tabBarHeight).
		 */

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
		offset = MAX(0, keyboardHeight - tabBarOffsetHeight);
#pragma clang diagnostic pop
	}

	return -offset;
}

/*Returns the tabbar if exists.*/
- (nullable __kindof UITabBar *)findTabBarForViewController:(UIViewController *)viewController
{
	UIViewController *current = viewController;

	while (current) {
		UIViewController *parent = current.parentViewController;

		if ([parent isKindOfClass:[UITabBarController class]]) {
			return ((UITabBarController *)parent).tabBar;
		}

		current = parent;
	}
	return nil;
}

/*Checks if the view can extend behind the tabbar, filling the whole screen or not.*/
- (BOOL)viewExtendsAtBottomForViewController:(UIViewController *)viewController
{
	BOOL bottomEdgesCanExtend = ((viewController.edgesForExtendedLayout & UIRectEdgeBottom) == UIRectEdgeBottom);

	// I also include opaque bars because the tabbar is opaque by default and if not is not considered in the
	// above condition.
	return bottomEdgesCanExtend && viewController.extendedLayoutIncludesOpaqueBars;
}

@end

@implementation MLKeyboardInfo

+ (void)load
{
	[MLKeyboardInfo sharedInstance];
}

+ (instancetype)sharedInstance
{
	static MLKeyboardInfo *sharedInstance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc] init];
	});
	return sharedInstance;
}

- (id)init
{
	if (self = [super init]) {
		self.keyboardHeight = 0.0f;

		[[NSNotificationCenter defaultCenter] addObserver:self
		                                         selector:@selector(keyboardWillChange:)
		                                             name:UIKeyboardWillChangeFrameNotification object:nil];
	}
	return self;
}

- (UIWindow *)window
{
	return [[[UIApplication sharedApplication] delegate] window];
}

- (void)keyboardWillChange:(NSNotification *)notification
{
	MLSnackbar *snackbar = [MLSnackbar sharedInstance];

	NSDictionary *info = [notification userInfo];
	CGFloat mainScreenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
	CGFloat keyboardEndPosition = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
	if (@available(iOS 11.0, *)) {
		UIWindow *window = [self window];
		CGFloat bottomPadding = window.safeAreaInsets.bottom;
		keyboardEndPosition += bottomPadding;
	}
	CGFloat newKeyboardHeight = mainScreenHeight - keyboardEndPosition;
	self.keyboardHeight = newKeyboardHeight;

	if (!snackbar.snackbarView || !snackbar.bottomConstraint) {
		return;
	}

	CGFloat finalHeight = [snackbar bottomInsetWithKeyboardHeight:newKeyboardHeight];
	NSTimeInterval animationDuration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	[snackbar updateBottomConstraintWithBottomInset:finalHeight withKeyboardAnimationDuration:animationDuration];
}

@end
