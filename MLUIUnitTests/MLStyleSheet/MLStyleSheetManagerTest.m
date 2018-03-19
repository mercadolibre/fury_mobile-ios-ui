//
// MLStyleSheetManagerTest.m
// MLUIUnitTests
//
// Created by Ezequiel Perez Dittler on 14/02/2018.
// Copyright © 2018 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MLUI/MLStyleSheetManager.h>

@interface MLStyleSheetManagerTests : XCTestCase

@end

@implementation MLStyleSheetManagerTests

- (void)testSetNilStyleSheet
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
	XCTAssertThrows([MLStyleSheetManager setStyleSheet:nil]);
#pragma clang diagnostic pop
}

@end
