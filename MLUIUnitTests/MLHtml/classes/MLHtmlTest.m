//
// NSAttributedString_NotificationsCenterTest.m
// MercadoLibre
//
// Created by amargalef on 16/6/16.
// Copyright © 2016 MercadoLibre - Mobile Apps. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <MLUI/UIFont+MLFonts.h>
#import <MLUI/MLHtml.h>
#import "MLStyleSheetTest.h"
#import "MLStyleSheetManager.h"

static NSString *const kHTMLRegularTag = @"regular";
static const CGFloat kBigSmallFontIncrement = 3;

@interface MLHtml (Test)

+ (void)overrideAttributesWithColor:(NSString *)colorStr dictionary:(NSMutableDictionary *)attrs;

+ (void)overrideAttributesWithTag:(NSString *)tag dictionary:(NSMutableDictionary *)attrs;

+ (NSTextCheckingResult *)nearest:(NSArray <NSTextCheckingResult *> *)values;

+ (NSTextCheckingResult *)nearest:(NSTextCheckingResult *)first other:(NSTextCheckingResult *)other;

+ (BOOL)isNullOrEmpty:(id)object;

@end

@interface MLHtmlTest : XCTestCase

@end

@implementation MLHtmlTest

- (void)setUp
{
	[super setUp];
	MLStyleSheetManager.styleSheet = [MLStyleSheetTest new];
}

#pragma mark - Test for overrideAttributesWithColor:dictionary:

- (void)testOverrideAttributesWithColorShouldDoNothingWithInvalidColor
{
	NSString *invalidColor = @"invalid color hexa";
	NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];
	[MLHtml overrideAttributesWithColor:invalidColor dictionary:attrs];

	XCTAssertNil(attrs[NSForegroundColorAttributeName]);
}

- (void)testOverrideAttributesWithColorShouldAddNewFontColor
{
	NSString *validColor = @"#FFF";
	NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];
	[MLHtml overrideAttributesWithColor:validColor dictionary:attrs];

	XCTAssertNotNil(attrs[NSForegroundColorAttributeName]);
}

- (void)testOverrideAttributesWithColorShouldOverrideWithNewFontColor
{
	UIColor *color = [UIColor redColor];
	NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];
	attrs[NSForegroundColorAttributeName] = color;
	[MLHtml overrideAttributesWithColor:@"#FFF" dictionary:attrs];

	// check != objects
	XCTAssert(color != attrs[NSForegroundColorAttributeName]);
}

#pragma mark - Test for overrideAttributesWithTag:dictionary:

- (void)testOverrideAttributesWithTagShouldDoNothingWithInvalidTag
{
	NSString *invalidTag = @"invalidtag";
	NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];
	[MLHtml overrideAttributesWithTag:invalidTag dictionary:attrs];

	XCTAssertEqual(attrs.count, 0);
}

- (void)testOverrideAttributesWithTagShouldReplaceWithBoldFont
{
	UIFont *defaultFont = [UIFont ml_regularSystemFontOfSize:kMLFontsSizeXXSmall];

	NSString *tag = @"b";
	NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];
	attrs[NSFontAttributeName] = defaultFont;

	[MLHtml overrideAttributesWithTag:tag dictionary:attrs];

	UIFont *targetFont = attrs[NSFontAttributeName];
	UIFont *expectedFont = [UIFont ml_boldSystemFontOfSize:defaultFont.pointSize];

	XCTAssertEqualObjects(targetFont.fontName, expectedFont.fontName);
	XCTAssertEqual(targetFont.pointSize, expectedFont.pointSize);
}

- (void)testOverrideAttributesWithTagShouldReplaceWithUnderlineAttribute
{
	NSString *tag = @"u";
	NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];

	[MLHtml overrideAttributesWithTag:tag dictionary:attrs];

	XCTAssertEqual(attrs.count, 1);
	XCTAssertEqualObjects(attrs[NSUnderlineStyleAttributeName], @(NSUnderlineStyleSingle));
}

- (void)testOverrideAttributesWithTagShouldReplaceWithStrikeThroughStyleAttribute
{
	NSString *tag = @"s";
	NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];

	[MLHtml overrideAttributesWithTag:tag dictionary:attrs];

	XCTAssertEqual(attrs.count, 2);
	XCTAssertEqualObjects(attrs[NSStrikethroughStyleAttributeName], @(NSUnderlineStyleSingle));
	XCTAssertEqualObjects(attrs[NSBaselineOffsetAttributeName], @0);
}

- (void)testOverrideAttributesWithTagShouldReplaceWithIncrementedSizeFont
{
	UIFont *defaultFont = [UIFont ml_lightSystemFontOfSize:kMLFontsSizeXXSmall];

	NSString *tag = @"big";
	NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];
	attrs[NSFontAttributeName] = defaultFont;

	[MLHtml overrideAttributesWithTag:tag dictionary:attrs];

	UIFont *targetFont = attrs[NSFontAttributeName];
	UIFont *expectedFont = [UIFont ml_lightSystemFontOfSize:defaultFont.pointSize + kBigSmallFontIncrement];

	XCTAssertEqualObjects(targetFont.fontName, expectedFont.fontName);
	XCTAssertEqual(targetFont.pointSize, expectedFont.pointSize);
}

- (void)testOverrideAttributesWithTagShouldReplaceWithDecrementedSizeFont
{
	UIFont *defaultFont = [UIFont ml_lightSystemFontOfSize:kMLFontsSizeXXSmall];

	NSString *tag = @"small";
	NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];
	attrs[NSFontAttributeName] = defaultFont;

	[MLHtml overrideAttributesWithTag:tag dictionary:attrs];

	UIFont *targetFont = attrs[NSFontAttributeName];
	UIFont *expectedFont = [UIFont ml_lightSystemFontOfSize:defaultFont.pointSize - kBigSmallFontIncrement];

	XCTAssertEqualObjects(targetFont.fontName, expectedFont.fontName);
	XCTAssertEqual(targetFont.pointSize, expectedFont.pointSize);
}

/**
 *  Edge case when the decrement is higher to current font size
 */
- (void)testOverrideAttributesWithTagShouldReplaceWithDecrementedSizeFontWith0Size
{
	UIFont *defaultFont = [UIFont ml_regularSystemFontOfSize:1.0];

	NSString *tag = @"small";
	NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];
	attrs[NSFontAttributeName] = defaultFont;

	[MLHtml overrideAttributesWithTag:tag dictionary:attrs];

	UIFont *targetFont = attrs[NSFontAttributeName];
	UIFont *expectedFont = [defaultFont fontWithSize:0.0];

	XCTAssertEqualObjects(targetFont.fontName, expectedFont.fontName);
	XCTAssertEqual(targetFont.pointSize, expectedFont.pointSize);
}

#pragma mark - Test for nearest:values

- (void)testNearest
{
	NSError *error;
	NSRegularExpression *regularExpresion = [[NSRegularExpression alloc] initWithPattern:@"abc" options:0 error:&error];
	NSRange nearestRange = NSMakeRange(0, 10);
	NSTextCheckingResult *nearest = [NSTextCheckingResult regularExpressionCheckingResultWithRanges:&nearestRange count:1 regularExpression:regularExpresion];

	NSRange farthestRange = NSMakeRange(5, 10);
	NSTextCheckingResult *farthest = [NSTextCheckingResult regularExpressionCheckingResultWithRanges:&farthestRange count:1 regularExpression:regularExpresion];

	NSRange notFoundRange = NSMakeRange(NSNotFound, 0);
	NSTextCheckingResult *notfound = [NSTextCheckingResult regularExpressionCheckingResultWithRanges:&notFoundRange count:1 regularExpression:regularExpresion];

	NSTextCheckingResult *target = [MLHtml nearest:@[farthest, nearest]];
	XCTAssertEqualObjects(nearest, target);

	target = [MLHtml nearest:@[nearest, farthest]];
	XCTAssertEqualObjects(nearest, target);

	target = [MLHtml nearest:@[notfound, nearest]];
	XCTAssertEqualObjects(nearest, target);

	target = [MLHtml nearest:@[nearest]];
	XCTAssertEqualObjects(nearest, target);

	target = [MLHtml nearest:@[notfound]];
	XCTAssertNil(target);

	target = [MLHtml nearest:@[]];
	XCTAssertNil(target);

	target = [MLHtml nearest:nil];
	XCTAssertNil(target);
}

- (void)testAttributedStringWithHtmlShouldReturnNilValue
{
	NSError *error = nil;
	NSString *html = nil;
	NSAttributedString *target = [MLHtml attributedStringWithHtml:html error:&error];
	XCTAssertNil(target);
}

- (void)testAttributedStringWithHtmlShouldReturnAttributedStringWithBoldFont
{
	NSDictionary *defaultAttributes = @{
	        NSFontAttributeName : [UIFont ml_regularSystemFontOfSize:kMLFontsSizeXXSmall],
	        NSForegroundColorAttributeName : [UIColor blackColor]
	};

	NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@"normal text bold text normal text"];

	NSDictionary *boldAttributes = @{
	        NSFontAttributeName : [UIFont ml_boldSystemFontOfSize:kMLFontsSizeXXSmall],
	        NSForegroundColorAttributeName : [UIColor blackColor]
	};

	[expected addAttributes:defaultAttributes range:NSMakeRange(0, kMLFontsSizeXXSmall)];
	[expected addAttributes:boldAttributes range:NSMakeRange(12, 9)];
	[expected addAttributes:defaultAttributes range:NSMakeRange(21, 12)];

	NSString *html = @"normal text <b>bold text</b> normal text";

	NSError *error;
	NSAttributedString *target = [MLHtml attributedStringWithHtml:html error:&error];
	XCTAssertEqualObjects(expected, target);
}

- (void)testAttributedStringWithHtmlShouldReturnAttributedStringWithNestedTags
{
	NSDictionary *defaultAttributes = @{
	        NSFontAttributeName : [UIFont ml_regularSystemFontOfSize:kMLFontsSizeXXSmall],
	        NSForegroundColorAttributeName : [UIColor blackColor]
	};

	NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@"normal text bold text normal text"];

	NSDictionary *boldAttributes = @{
	        NSFontAttributeName : [UIFont ml_boldSystemFontOfSize:12],
	        NSForegroundColorAttributeName : [UIColor blackColor]
	};

	[expected addAttributes:defaultAttributes range:NSMakeRange(0, 12)];
	[expected addAttributes:boldAttributes range:NSMakeRange(12, 9)];
	[expected addAttributes:defaultAttributes range:NSMakeRange(21, 12)];

	NSString *html = @"normal text <b>bold text</b> normal text";

	NSError *error;
	NSAttributedString *target = [MLHtml attributedStringWithHtml:html error:&error];
	XCTAssertEqualObjects(expected, target);
}

- (void)testAttributedStringWithHtmlShouldReturnAttributedStringWithInvertedNestedTags
{
	NSString *htmlText1 = @"normal text <b><big>bold text</big></b> normal text";
	NSString *htmlText2 = @"normal text <b><big>bold text</big></b> normal text";

	NSError *error;
	NSAttributedString *html1 = [MLHtml attributedStringWithHtml:htmlText1 error:&error];
	NSAttributedString *html2 = [MLHtml attributedStringWithHtml:htmlText2 error:&error];

	XCTAssertEqualObjects(html1, html2);
}

- (void)testAttributedStringWithHtmlShouldReturnAttributedStringWithMultiTags
{
	NSDictionary *defaultAttributes = @{
	        NSFontAttributeName : [UIFont ml_regularSystemFontOfSize:kMLFontsSizeXXSmall],
	        NSForegroundColorAttributeName : [UIColor blackColor]
	};

	NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@"normal text bold text normal text bold text normal text"];

	NSDictionary *boldAttributes = @{
	        NSFontAttributeName : [UIFont ml_boldSystemFontOfSize:kMLFontsSizeXXSmall],
	        NSForegroundColorAttributeName : [UIColor blackColor]
	};

	[expected addAttributes:defaultAttributes range:NSMakeRange(0, 12)];
	[expected addAttributes:boldAttributes range:NSMakeRange(12, 9)];
	[expected addAttributes:defaultAttributes range:NSMakeRange(21, 13)];
	[expected addAttributes:boldAttributes range:NSMakeRange(34, 9)];
	[expected addAttributes:defaultAttributes range:NSMakeRange(43, 12)];

	NSString *html = @"normal text <b>bold text</b> normal text <b>bold text</b> normal text";

	NSError *error;
	NSAttributedString *target = [MLHtml attributedStringWithHtml:html error:&error];
	XCTAssertEqualObjects(expected, target);
}

- (void)testAttributedStringWithHtmlShouldReturnNewLineForClosedHtmlBrTag
{
	NSDictionary *defaultAttributes = @{
	        NSFontAttributeName : [UIFont ml_regularSystemFontOfSize:kMLFontsSizeXXSmall],
	        NSForegroundColorAttributeName : [UIColor blackColor]
	};

	NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@"normal \n text"];
	[expected addAttributes:defaultAttributes range:NSMakeRange(0, 13)];

	NSString *html = @"normal <br /> text";

	NSError *error;
	NSAttributedString *target = [MLHtml attributedStringWithHtml:html error:&error];
	XCTAssertEqualObjects(expected, target);
}

- (void)testAttributedStringWithHtmlShouldReturnNewLineForHtmlBrTag
{
	NSDictionary *defaultAttributes = @{
	        NSFontAttributeName : [UIFont ml_regularSystemFontOfSize:kMLFontsSizeXXSmall],
	        NSForegroundColorAttributeName : [UIColor blackColor]
	};

	NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@"normal \n text"];
	[expected addAttributes:defaultAttributes range:NSMakeRange(0, 13)];

	NSString *html = @"normal <br> text";

	NSError *error;
	NSAttributedString *target = [MLHtml attributedStringWithHtml:html error:&error];
	XCTAssertEqualObjects(expected, target);
}

- (void)testAttributedStringWithHtmlWithEmptyTextShouldReturnEmptyAttributedString
{
	NSDictionary *defaultAttributes = @{
	        NSFontAttributeName : [UIFont ml_regularSystemFontOfSize:kMLFontsSizeXXSmall],
	        NSForegroundColorAttributeName : [UIColor blackColor]
	};

	NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@""];
	[expected addAttributes:defaultAttributes range:NSMakeRange(0, 0)];

	NSString *html = @"";

	NSError *error;
	NSAttributedString *target = [MLHtml attributedStringWithHtml:html error:&error];
	XCTAssertEqualObjects(expected, target);
}

- (void)testAttributedStringWithHtmlWithEmptyTaggedTextShouldReturnEmptyAttributedString
{
	NSDictionary *defaultAttributes = @{
	        NSFontAttributeName : [UIFont ml_regularSystemFontOfSize:kMLFontsSizeXXSmall],
	        NSForegroundColorAttributeName : [UIColor blackColor]
	};

	NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@""];
	[expected addAttributes:defaultAttributes range:NSMakeRange(0, 0)];

	NSString *html = @"<b></b>";

	NSError *error;
	NSAttributedString *target = [MLHtml attributedStringWithHtml:html error:&error];
	XCTAssertEqualObjects(expected, target);
}

- (void)testAttributedStringWithProtocolShouldCallIt
{
	id protocolMock = OCMProtocolMock(@protocol(MLHtmlAttributeProvider));
	[[protocolMock expect] processAttributesForTag:[OCMArg any] attributes:[OCMArg any]];

	NSString *html = @"<b></b>";

	NSError *error;
	NSAttributedString *target = [MLHtml attributedStringWithHtml:html attributesProvider:protocolMock error:&error];
	[protocolMock verify];
	XCTAssertNotNil(target);
}

- (void)testAttributedStringWithProtocol_CustomTagsOnProtocol
{
	id protocolMock = OCMProtocolMock(@protocol(MLHtmlAttributeProvider));

	OCMStub([protocolMock processAttributesForTag:OCMOCK_ANY attributes:OCMOCK_ANY]).andDo( ^(NSInvocation *invocation)
	{
		__unsafe_unretained NSString *tag;
		[invocation getArgument:&tag atIndex:2];

		__unsafe_unretained NSMutableDictionary *attrs;
		[invocation getArgument:&attrs atIndex:3];

		id object = [attrs objectForKey:NSFontAttributeName];
		UIFont *currentFont = [MLHtml isNullOrEmpty:object] ? nil : object;

		if ([tag isEqualToString:kHTMLRegularTag]) {
		    currentFont = [UIFont ml_regularSystemFontOfSize:currentFont.pointSize];
		}

		if (currentFont) {
		    attrs[NSFontAttributeName] = currentFont;
		}
	});

	NSDictionary *regularAttributes = @{
	        NSFontAttributeName : [UIFont ml_regularSystemFontOfSize:kMLFontsSizeXXSmall],
	        NSForegroundColorAttributeName : [UIColor blackColor]
	};

	NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@"Texto en bold esto en regular sigo en bold"];

	NSDictionary *boldAttributes = @{
	        NSFontAttributeName : [UIFont ml_boldSystemFontOfSize:kMLFontsSizeXXSmall],
	        NSForegroundColorAttributeName : [UIColor blackColor]
	};

	[expected addAttributes:boldAttributes range:NSMakeRange(0, 14)];
	[expected addAttributes:regularAttributes range:NSMakeRange(14, 15)];
	[expected addAttributes:boldAttributes range:NSMakeRange(29, 13)];

	NSString *html = @"<b>Texto en bold <regular>esto en regular</regular> sigo en bold</b>";

	NSError *error;
	NSAttributedString *target = [MLHtml attributedStringWithHtml:html attributesProvider:protocolMock error:&error];
	[protocolMock verify];

	XCTAssertEqualObjects(expected, target);
	XCTAssertNotNil(target);
}

- (void)testAttributedStringWithProtocol_CustomTagsOnProtocol_AndDefaultParams
{
	id protocolMock = OCMProtocolMock(@protocol(MLHtmlAttributeProvider));

	OCMStub([protocolMock processAttributesForTag:OCMOCK_ANY attributes:OCMOCK_ANY]).andDo( ^(NSInvocation *invocation)
	{
		__unsafe_unretained NSString *tag;
		[invocation getArgument:&tag atIndex:2];

		__unsafe_unretained NSMutableDictionary *attrs;
		[invocation getArgument:&attrs atIndex:3];

		id object = [attrs objectForKey:NSFontAttributeName];
		UIFont *currentFont = [MLHtml isNullOrEmpty:object] ? nil : object;

		if ([tag isEqualToString:kHTMLRegularTag]) {
		    currentFont = [UIFont ml_regularSystemFontOfSize:currentFont.pointSize];
		}

		if (currentFont) {
		    attrs[NSFontAttributeName] = currentFont;
		}
	});

	NSDictionary *defaultAttributes = @{
	        NSFontAttributeName : [UIFont ml_lightSystemFontOfSize:kMLFontsSizeSmall],
	        NSForegroundColorAttributeName : [UIColor blackColor]
	};

	NSDictionary *regularAttributes = @{
	        NSFontAttributeName : [UIFont ml_regularSystemFontOfSize:kMLFontsSizeSmall],
	        NSForegroundColorAttributeName : [UIColor blackColor]
	};

	NSMutableAttributedString *expected = [[NSMutableAttributedString alloc] initWithString:@"Texto en bold esto en regular sigo en bold"];

	NSDictionary *boldAttributes = @{
	        NSFontAttributeName : [UIFont ml_boldSystemFontOfSize:kMLFontsSizeSmall],
	        NSForegroundColorAttributeName : [UIColor blackColor]
	};

	[expected addAttributes:boldAttributes range:NSMakeRange(0, 14)];
	[expected addAttributes:regularAttributes range:NSMakeRange(14, 15)];
	[expected addAttributes:boldAttributes range:NSMakeRange(29, 13)];

	NSString *html = @"<b>Texto en bold <regular>esto en regular</regular> sigo en bold</b>";

	NSError *error;
	NSAttributedString *target = [MLHtml attributedStringWithHtml:html attributesProvider:protocolMock attributes:defaultAttributes error:&error];
	[protocolMock verify];

	XCTAssertEqualObjects(expected, target);
	XCTAssertNotNil(target);
}

- (void)testAttributedStringShouldReturnNilWhenAnErrorOccursWithNilErrorArgument
{
	NSString *invalidHtml = @"<b>invalidhtml";
	NSError *error = nil;

	NSAttributedString *target = [MLHtml attributedStringWithHtml:invalidHtml error:&error];
	XCTAssertNil(target);
	XCTAssertNotNil(error);

	target = [MLHtml attributedStringWithHtml:invalidHtml error:nil];
	XCTAssertNil(target);
}

@end
