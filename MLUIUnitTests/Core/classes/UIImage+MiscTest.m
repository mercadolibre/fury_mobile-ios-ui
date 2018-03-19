//
// UIImage+MiscTest.m
// MLUI
//
// Created by Leandro Fantin on 19/1/15.
// Copyright (c) 2015 MercadoLibre. All rights reserved.
//
#import "UIImage+Misc.h"
#import "UIImage+Transformations.h"
#import <XCTest/XCTest.h>

@interface UIImage_MiscTest : XCTestCase

@end

@implementation UIImage_MiscTest

- (void)testImageWithColor
{
	UIColor *color = [UIColor blueColor];
	UIImage *blackImage = [UIImage ml_imageWithColor:color];
	XCTAssertNotNil(blackImage);
	XCTAssertEqual([blackImage size].height == 1, [blackImage size].width == 1);

	// Verifica que el pixel tenga el mismo color
	CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(blackImage.CGImage));
	const UInt8 *data = CFDataGetBytePtr(pixelData);

	CGFloat blue = data[0] / 255.f;
	CGFloat green = data[1] / 255.f;
	CGFloat red = data[2] / 255.f;
	CGFloat alpha = data[3] / 255.f;
	UIColor *colorExpected = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
	XCTAssertTrue(CGColorEqualToColor(color.CGColor, colorExpected.CGColor));

	CFRelease(pixelData);
}

- (void)testIsEqualToImage
{
	UIImage *blackImage = [UIImage ml_imageWithColor:[UIColor blackColor]];
	UIImage *imageExpected = [UIImage ml_imageWithColor:[UIColor blackColor]];

	XCTAssertNotNil(blackImage);
	XCTAssertNotNil(imageExpected);
	XCTAssertTrue([blackImage ml_isEqualToImage:imageExpected]);

	UIImage *redImage = [UIImage ml_imageWithColor:[UIColor redColor]];
	XCTAssertFalse([blackImage ml_isEqualToImage:redImage]);
}

- (void)testTakeScreenSnapshotFromViewDrawViewHierarchyInRect
{
	UIView *viewToSnapshot = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 320, 430)];

	UIGraphicsBeginImageContext(viewToSnapshot.bounds.size);
	[viewToSnapshot drawViewHierarchyInRect:
	 viewToSnapshot.bounds afterScreenUpdates:NO];

	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	NSData *imageData = UIImageJPEGRepresentation(image, 0.75);

	image = [UIImage imageWithData:imageData];

	XCTAssertNotNil(image);
}

- (void)testTakeScreenSnapshotFromViewNotDrawViewHierarchyInRect
{
	UIView *viewToSnapshot = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 320, 430)];

	UIGraphicsBeginImageContext(viewToSnapshot.bounds.size);

	[viewToSnapshot.layer renderInContext:
	 UIGraphicsGetCurrentContext()];

	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
	image = [UIImage imageWithData:imageData];

	XCTAssertNotNil(image);
}

- (void)testTintedImageWithColor
{
	UIColor *color = [UIColor blackColor];
	UIImage *blackImage = [UIImage ml_imageWithColor:color];
	XCTAssertNotNil(blackImage);
	UIColor *redColor = [UIColor redColor];
	UIImage *redImage = [blackImage ml_tintedImageWithColor:redColor];
	XCTAssertNotNil(redImage);
	XCTAssertEqual([redImage size].height, [blackImage size].height);
	XCTAssertEqual([redImage size].width, [blackImage size].width);

	// Verifica que el pixel tenga el mismo color
	CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(redImage.CGImage));
	const UInt8 *data = CFDataGetBytePtr(pixelData);

	CGFloat blue = data[0] / 255.f;
	CGFloat green = data[1] / 255.f;
	CGFloat red = data[2] / 255.f;
	CGFloat alpha = data[3] / 255.f;
	UIColor *colorExpected = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
	XCTAssertTrue(CGColorEqualToColor(redColor.CGColor, colorExpected.CGColor));

	CFRelease(pixelData);
}

@end
