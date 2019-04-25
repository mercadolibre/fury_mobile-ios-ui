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
#import "PureLayout.h"

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
@property (strong, nonatomic) UIView *view;
@property (nonatomic, copy) void (^actionBlock)(void);
@property (nonatomic, copy) MLSnackbarDismissBlock dismissBlock;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelButtonSpacing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonTrailingConstraint;
@property (nonatomic) MLSnackbarDuration duration;
@property (nonatomic) CGRect snackbarFrame;
@property (nonatomic) CGRect snackbarInitialFrame;
@property (nonatomic) CGFloat parentHeight;
@property (nonatomic) BOOL isShowingSnackbar;
@property (nonatomic) BOOL isAnimating;
@property (nonatomic) BOOL isDesappearing;
@property (nonatomic, strong) UIPanGestureRecognizer *gesture;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) long durationInMillis;
@property (nonatomic, copy) void (^pendingAction)(void);
@property (nonatomic, strong) NSLayoutConstraint *bottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;
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
    return [MLSnackbar showWithTitle:title actionTitle:nil actionBlock:nil type:type duration:duration dismissGestureEnabled:YES dismissBlock:dismissBlock viewController:nil];
}

+ (instancetype)showWithTitle:(NSString *)title actionTitle:(NSString *)buttonTitle actionBlock:(void (^)(void))actionBlock type:(MLSnackbarType *)type duration:(MLSnackbarDuration)duration dismissGestureEnabled:(BOOL)dismissGestureEnabled dismissBlock:(MLSnackbarDismissBlock)dismissBlock viewController:(UIViewController*)viewController
{
    MLSnackbar *snackbar = [MLSnackbar sharedInstance];
    __weak typeof(snackbar) weakSnackbar = snackbar;

    if (snackbar.isDesappearing) {
        snackbar.pendingAction = ^{[weakSnackbar setUpSnackbarWithTitle:title actionTitle:buttonTitle actionBlock:actionBlock type:type duration:duration dismissGestureEnabled:dismissGestureEnabled dismissBlock:dismissBlock viewController:viewController];
        };
    } else {
        if (viewController != nil) {
            snackbar.parentHeight = CGRectGetHeight(viewController.view.frame) + [viewController.view convertPoint:viewController.view.frame.origin toView:nil].y;
            snackbar.frame = CGRectMake(0, snackbar.parentHeight - CGRectGetHeight(snackbar.view.frame) - [[MLKeyboardInfo sharedInstance] keyboardHeight], CGRectGetWidth(snackbar.view.frame), CGRectGetHeight(snackbar.view.frame));
        } else {
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            snackbar.parentHeight = CGRectGetHeight(screenRect);
            snackbar.frame = CGRectMake(0, CGRectGetHeight(screenRect) - CGRectGetHeight(snackbar.view.frame) - [[MLKeyboardInfo sharedInstance] keyboardHeight], CGRectGetWidth(screenRect), CGRectGetHeight(snackbar.view.frame));
        }

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

- (void)setUpSnackbarWithTitle:(NSString *)title actionTitle:(NSString *)buttonTitle actionBlock:(void (^)(void))actionBlock type:(MLSnackbarType *)type duration:(MLSnackbarDuration)duration dismissGestureEnabled:(BOOL)dismissGestureEnabled dismissBlock:(MLSnackbarDismissBlock)dismissBlock viewController:(UIViewController*)viewController
{
	self.messageLabel.text = title;
	self.messageLabel.textColor = type.titleFontColor;
	self.messageLabel.font = [UIFont ml_lightSystemFontOfSize:kMLFontsSizeXSmall];

	self.view.backgroundColor = type.backgroundColor;
    self.presentingViewController = viewController;

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
		self.buttonTrailingConstraint.constant = 24;
	} else {
		// si no se recibe título del botón o un bloque de acción, se esconde el botón
		self.actionButton.hidden = YES;
		self.labelButtonSpacing.constant = 0;
		[self.actionButton setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
		self.buttonTrailingConstraint.constant = 0;
	}
	if (dismissGestureEnabled) {
		self.gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAnimation:)];
		[self addGestureRecognizer:self.gesture];
	}
	self.dismissBlock = dismissBlock;

    //CLEAN THIS
    [self updateLayoutWith:viewController];
	self.snackbarFrame = self.frame;
	self.snackbarInitialFrame = CGRectMake(CGRectGetMinX(self.snackbarFrame), CGRectGetMaxY(self.snackbarFrame), CGRectGetWidth(self.snackbarFrame), CGRectGetHeight(self.snackbarFrame));

    [self show];

    ////CLEAN THIS

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
		self.view = [[MLUIBundle mluiBundle] loadNibNamed:NSStringFromClass([MLSnackbar class])
		                                            owner:self
		                                          options:nil].firstObject;

		self.view.translatesAutoresizingMaskIntoConstraints = NO;

		[self addSubview:self.view];

        [self.view autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self];
        [self.view autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self];
        [self.view autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self];
        self.snackbarViewTopConstraint = [self.view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:0];

        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor orangeColor].CGColor;
        self.view.layer.borderColor = [UIColor yellowColor].CGColor;
        self.view.layer.borderWidth = 3;
        self.clipsToBounds = YES;


//        NSDictionary *views = @{@"view" : self.view};
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|"
//                                                                     options:0
//                                                                     metrics:nil
//                                                                       views:views]];
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|"
//                                                                     options:0
//                                                                     metrics:nil
//                                                                       views:views]];
	}

	return self;
}

- (void)animateForKeyboardNotification:(NSNotification *)notification
{
	if (!self.isShowingSnackbar) {
		return;
	}

	NSDictionary *info = [notification userInfo];
	UIViewAnimationCurve curve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
	double duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];

	BOOL movingUp = [notification.name isEqualToString:UIKeyboardWillShowNotification];

	CGFloat newY = CGRectGetMinY(self.frame) + (movingUp ? -1 : 1) * [[MLKeyboardInfo sharedInstance] keyboardHeight];

	__weak typeof(self) weakSelf = self;

	[UIView animateWithDuration:duration delay:0 options:curve << 16 animations: ^{
	    weakSelf.frame = CGRectMake(CGRectGetMinX(weakSelf.frame), newY, CGRectGetWidth(weakSelf.frame), CGRectGetHeight(weakSelf.frame));
		} completion:nil];
}

- (void)updateLayoutWith:(UIViewController*)viewController
{
	[self layoutIfNeeded];

	[self.messageLabel sizeToFit];

    CGFloat snackBarHeight = (CGRectGetHeight(self.messageLabel.frame) > kMLSnackbarOneLineComponentHeight) ? kMLSnackbarTwoLineViewHeight : kMLSnackbarOneLineViewHeight;
    CGFloat labelTopConstraintSpacing = snackBarHeight == kMLSnackbarOneLineComponentHeight ? kMLSnackbarOneLineTopSpacing : kMLSnackbarTwoLineTopSpacing;

    UIView *presentingView = [self topViewController].view;

    if (self.presentingViewController) {
        presentingView = self.presentingViewController.view;
    }

    [presentingView addSubview:self];

    [self autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:presentingView];
    [self autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:presentingView];
    CGFloat keyboardHeight = [[MLKeyboardInfo sharedInstance] keyboardHeight];
    self.heightConstraint = [self autoSetDimension:ALDimensionHeight toSize:snackBarHeight];
    self.bottomConstraint = [self autoPinEdge:ALEdgeBottom
                                       toEdge:ALEdgeBottom
                                       ofView:presentingView
                                   withOffset:[self bottomInsetWithKeyboardHeight:keyboardHeight]];


    self.labelTopConstraint.constant = labelTopConstraintSpacing;

    [self layoutIfNeeded];

//    if (self.presentingViewController) {
//
//        [self.presentingViewController.view addSubview:self];
//
//        [self autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.presentingViewController.view];
//        [self autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.presentingViewController.view];
//        CGFloat keyboardHeight = [[MLKeyboardInfo sharedInstance] keyboardHeight];
//        self.heightConstraint = [self autoSetDimension:ALDimensionHeight toSize:snackBarHeight];
//        self.bottomConstraint = [self autoPinEdge:ALEdgeBottom
//                                                     toEdge:ALEdgeBottom
//                                                     ofView:self.presentingViewController.view
//                                                 withOffset:[self bottomInsetWithKeyboardHeight:keyboardHeight]];
//
//
//        self.labelTopConstraint.constant = labelTopConstraintSpacing;
//
//        [self layoutIfNeeded];
//    } else {

//        CGFloat keyboardHeight = [[MLKeyboardInfo sharedInstance] keyboardHeight];
//        if (CGRectGetHeight(self.messageLabel.frame) > kMLSnackbarOneLineComponentHeight) {
//            self.frame = CGRectMake(self.frame.origin.x, self.parentHeight - kMLSnackbarTwoLineViewHeight - keyboardHeight, self.frame.size.width, kMLSnackbarTwoLineViewHeight);
//            self.labelTopConstraint.constant = kMLSnackbarTwoLineTopSpacing;
//        } else {
//            self.frame = CGRectMake(self.frame.origin.x, self.parentHeight - kMLSnackbarOneLineViewHeight - keyboardHeight, self.frame.size.width, kMLSnackbarOneLineViewHeight);
//            self.labelTopConstraint.constant = kMLSnackbarOneLineTopSpacing;
//        }
//
//        [self layoutIfNeeded];
//    }





//    if (viewController != nil) {
////        CGFloat assd = [viewController.view convertPoint:viewController.view.frame.origin toView:nil].y;
////        CGRect asd = [viewController.view convertRect:viewController.view.frame toView:nil];
//        self.parentHeight = CGRectGetHeight(viewController.view.frame);
//
////        self.parentHeight = CGRectGetMaxX(asd);
////        self.parentHeight = asd.size.height + asd.origin.y;
//    }
//
//    CGFloat keyboardHeight = [[MLKeyboardInfo sharedInstance] keyboardHeight];
//    if (CGRectGetHeight(self.messageLabel.frame) > kMLSnackbarOneLineComponentHeight) {
//        self.frame = CGRectMake(self.frame.origin.x, self.parentHeight - kMLSnackbarTwoLineViewHeight - keyboardHeight, self.frame.size.width, kMLSnackbarTwoLineViewHeight);
//        self.labelTopConstraint.constant = kMLSnackbarTwoLineTopSpacing;
//    } else {
//        self.frame = CGRectMake(self.frame.origin.x, self.parentHeight - kMLSnackbarOneLineViewHeight - keyboardHeight, self.frame.size.width, kMLSnackbarOneLineViewHeight);
//        self.labelTopConstraint.constant = kMLSnackbarOneLineTopSpacing;
//    }
//
//    [self layoutIfNeeded];
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
    // In iOS 7, although this property extendedLayoutIncludesOpaqueBars is available it is always nil.
    return bottomEdgesCanExtend && viewController.extendedLayoutIncludesOpaqueBars;
}


- (void)show
{
	// get the current position
	CGRect currentFrame = [[self.layer presentationLayer] frame];
	CGFloat currentMinY = CGRectGetMinY(currentFrame);

	// weakSelf
	__weak typeof(self) weakSelf = self;

	// if other snackbar is animating, we need to disappear it before showing new one
	if (self.isAnimating) {
		// if snackbar isn't visible, set the default initial position for animation
		if (currentMinY == 0 || currentMinY < CGRectGetMinY(self.snackbarFrame)) {
			self.snackbarInitialFrame = CGRectMake(CGRectGetMinX(self.snackbarFrame), CGRectGetMaxY(self.snackbarFrame), CGRectGetWidth(self.snackbarFrame), CGRectGetHeight(self.snackbarFrame));
		} else {
			self.snackbarInitialFrame = currentFrame;
		}
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

            self.snackbarViewTopConstraint.constant = 0;
            [self layoutIfNeeded];

            weakSelf.isAnimating = YES;
        } completion: ^(BOOL finished) {
            weakSelf.isShowingSnackbar = YES;
            weakSelf.isAnimating = NO;
        }];


//        // get remaining distance constant
//        CGFloat distance2 = CGRectGetMinY(self.snackbarInitialFrame) / CGRectGetMaxY(self.snackbarFrame);
//
//        // perform animation
//        self.view.frame = self.snackbarInitialFrame;
//        weakSelf.frame = weakSelf.snackbarFrame;
//        [UIView animateWithDuration:kMLSnackbarAnimationDuration * distance delay:0 options:UIViewAnimationOptionCurveEaseOut animations: ^{
//            weakSelf.view.frame = weakSelf.snackbarFrame;
//
//            if (self.presentingViewController) {
//                [self.presentingViewController.view addSubview:weakSelf];
//            } else {
//                UIViewController *topViewController = [weakSelf topViewController];
//                UIView *parentView = topViewController.view;
//                [parentView addSubview:weakSelf];
//            }
//
//            weakSelf.isAnimating = YES;
//        } completion: ^(BOOL finished) {
//            weakSelf.isShowingSnackbar = YES;
//            weakSelf.isAnimating = NO;
//        }];
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
	CGRect frame = self.snackbarFrame;

	CGPoint translate = [gesture translationInView:gesture.view];
	CGFloat percent = translate.x / gesture.view.bounds.size.width;
	UIPercentDrivenInteractiveTransition *interactionController;

	if (gesture.state == UIGestureRecognizerStateBegan) {
		interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
		// cancel timer while swipe interaction is occuring
		[self.timer invalidate];
	} else if (gesture.state == UIGestureRecognizerStateChanged) {
		self.frame = CGRectMake(translate.x, CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame));
		self.alpha = 1 - fabs(percent);
		[interactionController updateInteractiveTransition:percent];
	} else if (gesture.state == UIGestureRecognizerStateEnded) {
		CGRect finalFrame;
		if (translate.x > 0) {
			finalFrame = CGRectMake(CGRectGetMaxX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame));
		} else {
			finalFrame = CGRectMake(CGRectGetMinX(frame) - CGRectGetWidth(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame));
		}
		if (fabs(percent) > 0.2) {
			__weak typeof(self) weakSelf = self;

			[UIView animateWithDuration:kMLSnackbarAnimationDuration animations: ^{
			    weakSelf.frame = finalFrame;
			    weakSelf.alpha = 0;
			} completion: ^(BOOL finished) {
			    [interactionController finishInteractiveTransition];
			    [weakSelf removeFromSuperview];
			    weakSelf.frame = frame;
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
			    weakSelf.frame = frame;
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
	CGRect frame = self.frame;

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

//    [UIView animateWithDuration:kMLSnackbarAnimationDuration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationCurveEaseOut animations: ^{
//        weakSelf.isAnimating = YES;
//        weakSelf.isDesappearing = YES;
//        [weakSelf.timer invalidate];
//        weakSelf.view.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMaxY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame));
//    } completion: ^(BOOL finished) {
//        weakSelf.alpha = 1;
//        [weakSelf removeFromSuperview];
//        [[NSNotificationCenter defaultCenter] removeObserver:weakSelf];
//        [weakSelf removeGestureRecognizer:weakSelf.gesture];
//        weakSelf.isShowingSnackbar = NO;
//        weakSelf.isDesappearing = NO;
//        weakSelf.isAnimating = NO;
//
//        // perfom the action block if dismiss ocurred beacuse the Action Button was pressed
//        if (cause == MLSnackbarDismissCauseActionButton) {
//            if (actionBlock) {
//                actionBlock();
//            }
//        }
//
//        if (dismissBlock != nil) {
//            dismissBlock(cause);
//        }
//
//        // perfom any pending action after the animation finished
//        if (weakSelf.pendingAction) {
//            weakSelf.pendingAction();
//            weakSelf.pendingAction = nil;
//        }
//    }];
}

- (void)didRotate:(NSNotification *)notification
{
	CGRect screenRect = [[UIScreen mainScreen] bounds];
	// take keyboard height into account when device rotates
	self.frame = CGRectMake(0, CGRectGetHeight(screenRect) - CGRectGetHeight(self.view.frame) - [[MLKeyboardInfo sharedInstance] keyboardHeight], CGRectGetWidth(screenRect), CGRectGetHeight(self.view.frame));
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
		                                         selector:@selector(keyboardWillShow:)
		                                             name:UIKeyboardWillShowNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self
		                                         selector:@selector(keyboardWillHide:)
		                                             name:UIKeyboardWillHideNotification object:nil];
	}
	return self;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
	NSDictionary *info = [notification userInfo];

	// If keyboard was already visible, snackbar should not animate
	if (self.keyboardHeight == 0) {
		self.keyboardHeight = CGRectGetHeight([info[UIKeyboardFrameEndUserInfoKey] CGRectValue]);
		[[MLSnackbar sharedInstance] animateForKeyboardNotification:notification];
	}
}

- (void)keyboardWillHide:(NSNotification *)notification
{
	[[MLSnackbar sharedInstance] animateForKeyboardNotification:notification];
	self.keyboardHeight = 0.0f; // Set to zero after the animation because it uses this height
}

@end
