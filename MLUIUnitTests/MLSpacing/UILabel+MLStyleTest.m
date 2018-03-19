//
// UILabel+MLStyleTest.m
// MLUI
//
// Created by Julieta Puente on 8/2/16.
// Copyright © 2016 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UILabel+MLStyle.h"
#import "UIFont+MLFonts.h"
#import "MLStyleUtils.h"

@interface UILabel (Test)
- (NSMutableAttributedString *)attributedTextForAttributedDictionary:(NSDictionary *)attrDictionary;
@end
@interface UILabel_MLStyleTest : XCTestCase

@end

@implementation UILabel_MLStyleTest

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

- (void)testAttributedTextForAttributedDictionaryForLightMediumStyleShouldRespectExistingAlignmentAndLineBreak
{
	MLStyleUtils *style = [[MLStyleUtils alloc]init];
	NSDictionary *attrDict = [style attributedDictionaryForStyle:MLStyleLightMedium];
	UILabel *label = [[UILabel alloc]init];
	label.textAlignment = NSTextAlignmentCenter;
	label.lineBreakMode = NSLineBreakByTruncatingTail;

	[label attributedTextForAttributedDictionary:attrDict];

	XCTAssertEqual(label.textAlignment, NSTextAlignmentCenter, @"El interlineado debe respetar el alingment que tenga el texto");
	XCTAssertEqual(label.lineBreakMode, NSLineBreakByTruncatingTail, @"El interlineado debe respetar el lineBreakMode que tenga el texto");
}

- (void)testAttributedTextForAttributedDictionaryForLightMediumStyleShouldRespectExistingLineSpacing
{
	MLStyleUtils *style = [[MLStyleUtils alloc]init];
	NSDictionary *attrDict = [style attributedDictionaryForStyle:MLStyleLightMedium];
	UILabel *label = [[UILabel alloc]init];
	label.text = @"texto";
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.lineSpacing = 7;
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
	[attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, label.text.length)];
	label.attributedText = attributedString;

	[label attributedTextForAttributedDictionary:attrDict];

	NSParagraphStyle *existingParagraphStyle = [label.attributedText attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:nil];
	XCTAssertEqual(existingParagraphStyle.lineSpacing, 7, @"Se ignora el interlineado del estilo si el label ya tenía un interlineado custom");
}

@end
