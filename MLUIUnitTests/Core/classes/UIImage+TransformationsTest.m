//
// UIImage+TransformationsTest.m
// MLUI
//
// Created by Leandro Fantin on 19/1/15.
// Copyright (c) 2015 MercadoLibre. All rights reserved.
//

#import "UIImage+Misc.h"
#import "UIImage+Transformations.h"
#import <XCTest/XCTest.h>

@interface UIImage_TransformationsTest : XCTestCase

@end

@implementation UIImage_TransformationsTest

- (void)testAutoAdjustImageToScale
{
	UIImage *image = [UIImage ml_imageWithColor:[UIColor blackColor]];
	XCTAssertNotNil(image);
	XCTAssertEqual([image size].height == 1, [image size].width == 1);
	UIImage *imageScaled = [UIImage ml_autoAdjustImageToScale:image];
	XCTAssertEqual([imageScaled size].height == 1, [imageScaled size].width == 1);
	XCTAssertEqual(imageScaled.scale, [UIScreen mainScreen].scale);
}

- (void)testImageByScalingToSize
{
	UIImage *image = [UIImage ml_imageWithColor:[UIColor blackColor]];
	XCTAssertNotNil(image);
	XCTAssertEqual([image size].height == 1, [image size].width == 1);
	[image ml_imageByScalingToSize:CGSizeMake(100, 100)];
	XCTAssertEqual([image size].height == 100, [image size].width == 100);
}

- (void)testCropImageToRect
{
	UIImage *image = [UIImage ml_imageWithColor:[UIColor blackColor]];
	XCTAssertNotNil(image);
	XCTAssertEqual([image size].height == 1, [image size].width == 1);
	image = [image ml_imageByScalingToSize:CGSizeMake(100, 100)];
	XCTAssertEqual([image size].height == 100, [image size].width == 100);
	UIImage *cropImage = [image ml_cropImageToRect:CGRectMake(0, 0, 100, 100)];
	XCTAssertEqual([image size].height == cropImage.size.height, [image size].width == cropImage.size.width);
	cropImage = [image ml_cropImageToRect:CGRectMake(0, 0, 50, 50)];
	XCTAssertEqual(50 == cropImage.size.height, 50 == cropImage.size.width);

	cropImage = [image ml_cropImageToRect:CGRectMake(10, 10, 50, 50)];
	XCTAssertEqual(50 == cropImage.size.height, 50 == cropImage.size.width);
	// 50 desde la posicion 90, seria una imagen de 10x10, ya que la imagen tiene 100x100
	cropImage = [image ml_cropImageToRect:CGRectMake(90, 90, 50, 50)];
	XCTAssertEqual(10 == cropImage.size.height, 10 == cropImage.size.width);
}

- (void)testImageByScalingToFitSizeHigher
{
	// Create an square image 1x1
	UIImage *originalImage = [UIImage ml_imageWithColor:[UIColor blackColor]];

	// Try scale it to rectangular size
	UIImage *scaledImage = [originalImage ml_imageByScalingToFitSize:CGSizeMake(50, 100)];

	// The image must be maintained square
	XCTAssertEqual(scaledImage.size.width, 50);
	XCTAssertEqual(scaledImage.size.height, 50);
}

- (void)testImageByScalingToFitSizeWider
{
	// Create an square image 1x1
	UIImage *originalImage = [UIImage ml_imageWithColor:[UIColor blackColor]]; // 1x1

	// Try scale it to rectangular size, the image must be maintained square
	UIImage *scaledImage = [originalImage ml_imageByScalingToFitSize:CGSizeMake(100, 50)];

	// The image must be maintained square
	XCTAssertEqual(scaledImage.size.width, 50);
	XCTAssertEqual(scaledImage.size.height, 50);
}

@end
