//
// MLUIDiscountTagViewTest.m
// MLUI
//
// Created by Sebastián Bravo on 16/1/15.
// Copyright (c) 2015 MercadoLibre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MLUIPriceView.h"
#import "UIColor+Theme.h"
#import "UIFont+MLFonts.h"

@interface MLUIPriceView (Test)

@property (nonatomic, strong) UILabel *priceLabel;

- (NSMutableAttributedString *)attributedStringForPriceNumber:(NSNumber *)priceNumber withFormatter:(NSNumberFormatter *)formatter;

@end

@interface MLUIPriceViewTest : XCTestCase

@end

@implementation MLUIPriceViewTest

// Se testea que el componente de price se cree bien con el estilo tachado
- (void)testDiscountPriceViewDecimalNumberAndFormatter
{
	// Creo el AttributeString con los valores esperados
	UIFont *font = [UIFont ml_lightSystemFontOfSize:16.0];
	UIFont *smallFont = [UIFont ml_lightSystemFontOfSize:6.4];
	NSNumber *offsetFonts = @(font.capHeight - smallFont.capHeight);

	NSMutableAttributedString *expectedAttrString = [[NSMutableAttributedString alloc] initWithString:@"$ 1.20035"];
	[expectedAttrString addAttribute:NSBaselineOffsetAttributeName value:offsetFonts range:NSMakeRange(7, 2)];
	[expectedAttrString addAttribute:NSFontAttributeName value:smallFont range:NSMakeRange(7, 2)];
	[expectedAttrString addAttribute:NSStrikethroughStyleAttributeName value:@1 range:NSMakeRange(0, 9)];

	// Obtengo el PriceView a testear
	MLUIPriceView *priceView = [[MLUIPriceView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setCurrencySymbol:@"$"];
	[numberFormatter setDecimalSeparator:@","];
	[numberFormatter setMaximumFractionDigits:2];
	[numberFormatter setMinimumFractionDigits:2];
	[numberFormatter setGroupingSeparator:@"."];
	[numberFormatter setGroupingSize:3];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];

	// Le paso tamaño grande para hacer un assert sobre la fuente
	[priceView layoutViewWithNumber:@1200.35 formatter:numberFormatter style:MLPriceViewDiscountStyle fontSizeStyle:MLPriceSizeLarge];

	XCTAssertEqualObjects(priceView.priceLabel.text, @"$ 1.20035", @"Error en el texto del label de precio");
	XCTAssertEqual(priceView.priceLabel.font.pointSize, 16, @"La fuente es incorrecta");
	XCTAssertEqualObjects(priceView.priceLabel.textColor, [UIColor ml_discountPriceColor], @"El color de texto es incorrecto");
}

// Se testea que el componente de price se cree bien sin el estilo tachado
- (void)testThatPriceViewWithDefaultStyleHasTheCorrectFormat
{
	// Creo el AttributeString con los valores esperados
	UIFont *font = [UIFont ml_lightSystemFontOfSize:32.0];
	UIFont *smallFont = [UIFont fontWithName:font.fontName size:12.8];
	NSNumber *offsetFonts = @(font.capHeight - smallFont.capHeight);
	NSMutableAttributedString *expectedAttrString = [[NSMutableAttributedString alloc] initWithString:@"$ 1.20035"];
	[expectedAttrString addAttribute:NSBaselineOffsetAttributeName value:offsetFonts range:NSMakeRange(7, 2)];
	[expectedAttrString addAttribute:NSFontAttributeName value:smallFont range:NSMakeRange(7, 2)];

	// Creo el PriceView a testear
	MLUIPriceView *priceView = [[MLUIPriceView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setCurrencySymbol:@"$"];
	[numberFormatter setDecimalSeparator:@","];
	[numberFormatter setMaximumFractionDigits:2];
	[numberFormatter setMinimumFractionDigits:2];
	[numberFormatter setGroupingSeparator:@"."];
	[numberFormatter setGroupingSize:3];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	// Le paso tamaño grande para hacer un assert sobre la fuente
	[priceView layoutViewWithNumber:@1200.35 formatter:numberFormatter style:MLPriceViewDefaultStyle fontSizeStyle:MLPriceSizeLarge];

	XCTAssertEqualObjects(priceView.priceLabel.text, @"$ 1.20035", @"Error en el texto del label de precio");
	XCTAssertEqualObjects(priceView.priceLabel.font, font, @"La fuente es incorrecta");
	XCTAssertEqualObjects(priceView.font, font, @"La fuente es incorrecta");
	XCTAssertEqualObjects(priceView.priceLabel.textColor, [UIColor ml_defaultPriceColor], @"El color de texto es incorrecto");
	XCTAssertEqualObjects(priceView.priceLabel.attributedText, expectedAttrString, @"El label no tiene seteado los attributos correctos");
}

- (void)testThatThePriceViewIsInitalizedWithTheCorrectFrame
{
	MLUIPriceView *priceView = [[MLUIPriceView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];

	XCTAssertEqual(CGRectGetMinX(priceView.frame), 0, @"El offset en X debería ser 0");
	XCTAssertEqual(CGRectGetMinY(priceView.frame), 0, @"El offset en Y debería ser 0");
	XCTAssertEqual(CGRectGetWidth(priceView.frame), 100, @"El width debería ser 100");
	XCTAssertEqual(CGRectGetHeight(priceView.frame), 20, @"El height debería ser 20");
}

// Se testea que al componente de precio se le pasa un formatter incorrecto (que tiene un decimal separator pero no tiene digitos decimales)
- (void)testDiscountPriceViewNoDecimalNumberAndFormatter
{
	MLUIPriceView *priceView = [[MLUIPriceView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];

	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setCurrencySymbol:@"$"];
	[numberFormatter setDecimalSeparator:@","];

	[numberFormatter setMaximumFractionDigits:0];
	[numberFormatter setMinimumFractionDigits:0];
	[numberFormatter setGroupingSeparator:@"."];
	[numberFormatter setGroupingSize:3];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];

	// Le paso tamaño medium para hacer un assert sobre la fuente
	[priceView layoutViewWithNumber:@1200 formatter:numberFormatter style:MLPriceViewDiscountStyle fontSizeStyle:MLPriceSizeMedium];

	XCTAssertEqualObjects(priceView.priceLabel.text, @"$ 1.200", @"Error en el texto del label de precio");
	XCTAssertEqual(priceView.priceLabel.font.pointSize, 12, @"La fuente es incorrecta");
	XCTAssertEqual(priceView.font.pointSize, 12, @"La fuente es incorrecta");
	XCTAssertEqualObjects(priceView.priceLabel.textColor, [UIColor ml_discountPriceColor], @"El color de texto es incorrecto");

	// Comparo el atributted string con el que deberia ser
	NSMutableAttributedString *expectedAttrString = [[NSMutableAttributedString alloc] initWithString:@"$ 1.200"];
	[expectedAttrString addAttribute:NSStrikethroughStyleAttributeName value:@1 range:NSMakeRange(0, 7)];

	XCTAssertTrue([priceView.priceLabel.attributedText isEqualToAttributedString:expectedAttrString]);
}

// Se testea que al componente de precio no se le pasa un precio como parametro
- (void)testPriceNoNumber
{
	MLUIPriceView *priceView = [[MLUIPriceView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];

	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setCurrencySymbol:@"$"];
	[numberFormatter setDecimalSeparator:@","];

	[numberFormatter setMaximumFractionDigits:2];
	[numberFormatter setMinimumFractionDigits:2];
	[numberFormatter setGroupingSeparator:@"."];
	[numberFormatter setGroupingSize:3];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];

	[priceView layoutViewWithNumber:nil formatter:numberFormatter style:MLPriceViewDiscountStyle fontSizeStyle:MLPriceSizeSmall];

	XCTAssertTrue([priceView.priceLabel.text length] == 0, @"Error en el texto del label de precio");
}

// Se testea que al componente de precio no se le pasa un formatter como parametro
- (void)testPriceNoFormatter
{
	MLUIPriceView *priceView = [[MLUIPriceView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];

	[priceView layoutViewWithNumber:nil formatter:nil style:MLPriceViewDiscountStyle fontSizeStyle:MLPriceSizeMedium];

	XCTAssertTrue([priceView.priceLabel.text length] == 0, @"Error en el texto del label de precio");
}

// Se testea que al componente de precio se le pase un formatter con decimales y un number correcto.
- (void)testDefaultPriceCorrectFormatWithDecimals
{
	MLUIPriceView *priceView = [[MLUIPriceView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];

	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setCurrencySymbol:@"$"];
	[numberFormatter setDecimalSeparator:@","];

	[numberFormatter setMaximumFractionDigits:2];
	[numberFormatter setMinimumFractionDigits:2];
	[numberFormatter setGroupingSeparator:@"."];
	[numberFormatter setGroupingSize:3];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];

	// Le paso tamaño medium para hacer un assert sobre la fuente
	[priceView layoutViewWithNumber:@1200.50 formatter:numberFormatter style:MLPriceViewDefaultStyle fontSizeStyle:MLPriceSizeMedium];

	XCTAssertEqualObjects(priceView.priceLabel.text, @"$ 1.20050", @"Error en el texto del label de precio");
	XCTAssertEqualObjects(priceView.priceLabel.font, [UIFont ml_lightSystemFontOfSize:20.0], @"La fuente es incorrecta");
	XCTAssertEqualObjects(priceView.font, [UIFont ml_lightSystemFontOfSize:20.0], @"La fuente es incorrecta");
}

// Se testea que al componente de precio se le pase un formatter sin decimales y un number correcto.
- (void)testDefaultPriceCorrectFormat
{
	MLUIPriceView *priceView = [[MLUIPriceView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];

	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setCurrencySymbol:@"$"];
	[numberFormatter setDecimalSeparator:@","];

	[numberFormatter setMaximumFractionDigits:0];
	[numberFormatter setMinimumFractionDigits:0];
	[numberFormatter setGroupingSeparator:@"."];
	[numberFormatter setGroupingSize:3];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];

	// Se le pasa tamaño chico para hacer un assert sobre la fuente
	[priceView layoutViewWithNumber:@1200 formatter:numberFormatter style:MLPriceViewDefaultStyle fontSizeStyle:MLPriceSizeSmall];

	XCTAssertEqualObjects(priceView.priceLabel.text, @"$ 1.200", @"Error en el texto del label de precio");
	XCTAssertTrue(priceView.priceLabel.font == [UIFont ml_lightSystemFontOfSize:16.0], @"La fuente es incorrecta");
	XCTAssertTrue(priceView.font == [UIFont ml_lightSystemFontOfSize:16.0], @"La fuente es incorrecta");
}

// Se testea que el NSAttributedString que se crea a partir de un precio tenga los atributos correctos
- (void)testThatAttributesStringForPriceNumberHasTheCorrectAttributes
{
	// Creo el AttributdString con los parametros esperados
	UIFont *font = [UIFont ml_lightSystemFontOfSize:20.0];
	UIFont *smallFont = [UIFont fontWithName:font.fontName size:8.0];
	NSNumber *baseLineOffset = @(font.capHeight - smallFont.capHeight);
	NSMutableAttributedString *expectedAttrString = [[NSMutableAttributedString alloc] initWithString:@"$ 1.20050"];
	[expectedAttrString addAttribute:NSBaselineOffsetAttributeName value:baseLineOffset range:NSMakeRange(7, 2)];
	[expectedAttrString addAttribute:NSFontAttributeName value:smallFont range:NSMakeRange(7, 2)];

	// Obtengo el AttributedString a testear
	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setCurrencySymbol:@"$"];
	[numberFormatter setDecimalSeparator:@","];
	[numberFormatter setMaximumFractionDigits:2];
	[numberFormatter setMinimumFractionDigits:2];
	[numberFormatter setGroupingSeparator:@"."];
	[numberFormatter setGroupingSize:3];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	MLUIPriceView *priceView = [[MLUIPriceView alloc] init];
	[priceView layoutViewWithNumber:@1200.50 formatter:numberFormatter style:MLPriceViewDefaultStyle fontSizeStyle:MLPriceSizeMedium];

	NSMutableAttributedString *targetAttrString = [priceView attributedStringForPriceNumber:@1200.50 withFormatter:numberFormatter];

	XCTAssertEqualObjects(expectedAttrString, targetAttrString, @"No se setearon bien los atributos para el precio");
}

// Se testea que el precio se cree bien pasandole un string como parametro, con tamaño grande
- (void)testPriceWithStringLargeSize
{
	MLUIPriceView *priceView = [[MLUIPriceView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];

	[priceView layoutViewWithString:@"A convenir" fontSizeStyle:MLPriceSizeLarge];

	XCTAssertEqualObjects(priceView.priceLabel.text, @"A convenir", @"El texto es incorrecto");
	XCTAssertEqualObjects(priceView.font, [UIFont systemFontOfSize:32]);
	XCTAssertEqualObjects(priceView.priceLabel.font, [UIFont systemFontOfSize:32]);
	XCTAssertEqualObjects(priceView.priceLabel.textColor, [UIColor ml_defaultPriceColor], @"El color de texto es incorrecto");
}

// Se testea que el precio se cree bien pasandole un string como parametro, con tamaño medio
- (void)testPriceWithStringMediumSize
{
	MLUIPriceView *priceView = [[MLUIPriceView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];

	[priceView layoutViewWithString:@"A convenir" fontSizeStyle:MLPriceSizeMedium];

	XCTAssertEqualObjects(priceView.priceLabel.text, @"A convenir", @"El texto es incorrecto");
	XCTAssertEqualObjects(priceView.font, [UIFont systemFontOfSize:20]);
	XCTAssertEqualObjects(priceView.priceLabel.font, [UIFont systemFontOfSize:20]);
	XCTAssertEqualObjects(priceView.priceLabel.textColor, [UIColor ml_defaultPriceColor], @"El color de texto es incorrecto");
}

// Se testea que el precio se cree bien pasandole un string como parametro, con tamaño chico
- (void)testPriceWithStringSmallSize
{
	MLUIPriceView *priceView = [[MLUIPriceView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];

	[priceView layoutViewWithString:@"A convenir" fontSizeStyle:MLPriceSizeSmall];

	XCTAssertEqualObjects(priceView.priceLabel.text, @"A convenir", @"El texto es incorrecto");
	XCTAssertEqualObjects(priceView.font, [UIFont systemFontOfSize:16]);
	XCTAssertEqualObjects(priceView.priceLabel.font, [UIFont systemFontOfSize:16]);
	XCTAssertEqualObjects(priceView.priceLabel.textColor, [UIColor ml_defaultPriceColor], @"El color de texto es incorrecto");
}

// Se testea que el precio este bien y que se le pase un tamaño de fuente chica y estilo tachado
- (void)testDefaultPriceCorrectFormatSmallFont
{
	MLUIPriceView *priceView = [[MLUIPriceView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];

	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setCurrencySymbol:@"$"];
	[numberFormatter setDecimalSeparator:@","];

	[numberFormatter setMaximumFractionDigits:0];
	[numberFormatter setMinimumFractionDigits:0];
	[numberFormatter setGroupingSeparator:@"."];
	[numberFormatter setGroupingSize:3];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];

	// Se le pasa tamaño chico para hacer un assert sobre la fuente
	[priceView layoutViewWithNumber:@1200 formatter:numberFormatter style:MLPriceViewDiscountStyle fontSizeStyle:MLPriceSizeSmall];

	XCTAssertEqualObjects(priceView.priceLabel.text, @"$ 1.200", @"Error en el texto del label de precio");
	XCTAssertTrue(priceView.priceLabel.font.pointSize == 12, @"La fuente es incorrecta");
	XCTAssertTrue(priceView.font.pointSize == 12, @"La fuente es incorrecta");
}

@end
