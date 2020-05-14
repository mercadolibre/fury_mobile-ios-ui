//
// MLGenericErrorViewTest.m
// MLUI
//
// Created by Josefina Bustamante on 23/2/17.
// Copyright © 2017 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MLUI/MLGenericErrorView.h>
#import <MLUI/MLButton.h>

@interface MLGenericErrorView (Test)

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *subtitle;
@property (nonatomic, weak) IBOutlet MLButton *retryButton;

@end

@interface MLGenericErrorViewTest : XCTestCase

@end

@implementation MLGenericErrorViewTest

- (void)setUp
{
	[super setUp];
	// Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
}

- (void)testGenericErrorViewWithCustomData
{
	MLGenericErrorView *errorView = [MLGenericErrorView genericErrorViewWithImage:[UIImage imageNamed:@"MLNetworkError"]
	                                                                        title:@"¡Parece que no hay Internet!"
	                                                                     subtitle:@"Revisa tu conexión para seguir navegando."
	                                                                  buttonTitle:@"Reintentar"
	                                                                  actionBlock: ^{
	                                                                      NSLog(@"For test, retry button can have a nil action.");
																	  }];

	XCTAssertTrue(errorView.imageView.image, @"Image view should have image set and it doesn't.");
	XCTAssertTrue(errorView.title.text, @"Title label should have text set and it doesn't.");
	XCTAssertTrue(errorView.subtitle.text, @"Subtitle label should have text set and it doesn't.");
	XCTAssertTrue(errorView.retryButton.buttonTitle, @"Retry button should have button title set and it doesn't.");
	XCTAssertTrue([errorView isRetryButtonVisible], @"Retry button should be visible");
}

- (void)testGenericErrorViewWithOutActionBlock
{
	MLGenericErrorView *errorView = [MLGenericErrorView genericErrorViewWithImage:[UIImage imageNamed:@"MLNetworkError"]
	                                                                        title:@"¡Parece que no hay Internet!"
	                                                                     subtitle:@"Revisa tu conexión para seguir navegando."
	                                                                  buttonTitle:@"Reintentar"
	                                                                  actionBlock:nil];

	XCTAssertTrue(errorView.imageView.image, @"Image view should have image set and it doesn't.");
	XCTAssertTrue(errorView.title.text, @"Title label should have text set and it doesn't.");
	XCTAssertTrue(errorView.subtitle.text, @"Subtitle label should have text set and it doesn't.");
	XCTAssertTrue(errorView.retryButton.buttonTitle, @"Retry button should have button title set and it doesn't.");
	XCTAssertFalse([errorView isRetryButtonVisible], @"Retry button should be not visible");
}

@end
