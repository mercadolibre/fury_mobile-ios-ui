//
// MLStyleUtilsTest.m
// MLUI
//
// Created by Julieta Puente on 8/2/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MLStyleUtils.h"
#import "UIFont+MLFonts.h"

@interface MLStyleUtilsTest : XCTestCase

@end

@implementation MLStyleUtilsTest

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

- (void)testAttributedDictionaryForFontXLargeShouldSetBigSapcing
{
	MLStyleUtils *style = [[MLStyleUtils alloc]init];
	UIFont *font = [UIFont ml_regularSystemFontOfSize:kMLFontsSizeXLarge];

	NSDictionary *dict = [style attributedDictionaryForFont:font];

	XCTAssertTrue(((NSParagraphStyle *)dict[NSParagraphStyleAttributeName]).lineSpacing == 4);
}

- (void)testAttributedDictionaryForFontSmallShouldSetSmallSapcing
{
	MLStyleUtils *style = [[MLStyleUtils alloc]init];
	UIFont *font = [UIFont ml_regularSystemFontOfSize:kMLFontsSizeMedium];

	NSDictionary *dict = [style attributedDictionaryForFont:font];

	XCTAssertTrue(((NSParagraphStyle *)dict[NSParagraphStyleAttributeName]).lineSpacing == 2);
}

- (void)testAttributedDictionaryForStyleRegularXXLarge
{
	MLStyleUtils *style = [[MLStyleUtils alloc]init];
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.lineSpacing = 4;
	NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
	[attrDict setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
	[attrDict setObject:[UIFont ml_regularSystemFontOfSize:kMLFontsSizeXXLarge] forKey:NSFontAttributeName];

	NSDictionary *dict = [style attributedDictionaryForStyle:MLStyleRegularXXLarge];

	XCTAssertEqualObjects(dict, attrDict);
}

- (void)testAttributedDictionaryForStyleRegularXLarge
{
	MLStyleUtils *style = [[MLStyleUtils alloc]init];
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.lineSpacing = 4;
	NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
	[attrDict setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
	[attrDict setObject:[UIFont ml_regularSystemFontOfSize:kMLFontsSizeXLarge] forKey:NSFontAttributeName];

	NSDictionary *dict = [style attributedDictionaryForStyle:MLStyleRegularXLarge];

	XCTAssertEqualObjects(dict, attrDict);
}

- (void)testAttributedDictionaryForStyleRegularLarge
{
	MLStyleUtils *style = [[MLStyleUtils alloc]init];
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.lineSpacing = 4;
	NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
	[attrDict setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
	[attrDict setObject:[UIFont ml_regularSystemFontOfSize:kMLFontsSizeLarge] forKey:NSFontAttributeName];

	NSDictionary *dict = [style attributedDictionaryForStyle:MLStyleRegularLarge];

	XCTAssertEqualObjects(dict, attrDict);
}

- (void)testAttributedDictionaryForStyleRegularMedium
{
	MLStyleUtils *style = [[MLStyleUtils alloc]init];
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.lineSpacing = 2;
	NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
	[attrDict setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
	[attrDict setObject:[UIFont ml_regularSystemFontOfSize:kMLFontsSizeMedium] forKey:NSFontAttributeName];

	NSDictionary *dict = [style attributedDictionaryForStyle:MLStyleRegularMedium];

	XCTAssertEqualObjects(dict, attrDict);
}

- (void)testAttributedDictionaryForStyleRegularSmall
{
	MLStyleUtils *style = [[MLStyleUtils alloc]init];
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.lineSpacing = 2;
	NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
	[attrDict setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
	[attrDict setObject:[UIFont ml_regularSystemFontOfSize:kMLFontsSizeSmall] forKey:NSFontAttributeName];

	NSDictionary *dict = [style attributedDictionaryForStyle:MLStyleRegularSmall];

	XCTAssertEqualObjects(dict, attrDict);
}

- (void)testAttributedDictionaryForStyleRegularXSmall
{
	MLStyleUtils *style = [[MLStyleUtils alloc]init];
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.lineSpacing = 2;
	NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
	[attrDict setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
	[attrDict setObject:[UIFont ml_regularSystemFontOfSize:kMLFontsSizeXSmall] forKey:NSFontAttributeName];

	NSDictionary *dict = [style attributedDictionaryForStyle:MLStyleRegularXSmall];

	XCTAssertEqualObjects(dict, attrDict);
}

- (void)testAttributedDictionaryForStyleRegularXXSmall
{
	MLStyleUtils *style = [[MLStyleUtils alloc]init];
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.lineSpacing = 2;
	NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
	[attrDict setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
	[attrDict setObject:[UIFont ml_regularSystemFontOfSize:kMLFontsSizeXXSmall] forKey:NSFontAttributeName];

	NSDictionary *dict = [style attributedDictionaryForStyle:MLStyleRegularXXSmall];

	XCTAssertEqualObjects(dict, attrDict);
}

@end
