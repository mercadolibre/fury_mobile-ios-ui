//
//  MLButtonConfigStyleTest.m
//  MLUIUnitTests
//
//  Created by Ezequiel Perez Dittler on 14/06/2018.
//  Copyright © 2018 MercadoLibre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MLUI/MLButtonConfigStyle.h>

@interface MLButtonConfigStyleTest : XCTestCase

@end

@implementation MLButtonConfigStyleTest

- (void)testEqualsSelf {
    MLButtonConfigStyle *style = [[MLButtonConfigStyle alloc] initWithContentColor:UIColor.blueColor backgroundColor:UIColor.blackColor borderColor:UIColor.brownColor];
    XCTAssertTrue([style isEqual:style]);
}

- (void)testEqualNotNilWithNil {
    MLButtonConfigStyle *styleOne = [[MLButtonConfigStyle alloc] initWithContentColor:UIColor.blueColor backgroundColor:UIColor.blackColor borderColor:UIColor.brownColor];
    MLButtonConfigStyle *styleTwo = nil;
    XCTAssertNotEqual(styleOne, styleTwo);
    XCTAssertNotEqualObjects(styleOne, styleTwo);
    XCTAssertNotEqualObjects(styleTwo, styleOne);
    XCTAssertNotEqual(styleOne.hash, styleTwo.hash);
}

- (void)testEqualStyles {
    MLButtonConfigStyle *styleOne = [[MLButtonConfigStyle alloc] initWithContentColor:UIColor.blueColor backgroundColor:UIColor.blackColor borderColor:UIColor.brownColor];
    MLButtonConfigStyle *styleTwo = [[MLButtonConfigStyle alloc] initWithContentColor:UIColor.blueColor backgroundColor:UIColor.blackColor borderColor:UIColor.brownColor];
    XCTAssertNotEqual(styleOne, styleTwo);
    XCTAssertEqualObjects(styleOne, styleTwo);
    XCTAssertEqualObjects(styleTwo, styleOne);
    XCTAssertEqual(styleOne.hash, styleTwo.hash);
}

- (void)testNotEqualStyles {
    MLButtonConfigStyle *styleOne = [[MLButtonConfigStyle alloc] initWithContentColor:UIColor.blueColor backgroundColor:UIColor.blackColor borderColor:UIColor.brownColor];
    MLButtonConfigStyle *styleTwo = [[MLButtonConfigStyle alloc] initWithContentColor:UIColor.blueColor backgroundColor:UIColor.blackColor borderColor:UIColor.redColor];
    XCTAssertNotEqual(styleOne, styleTwo);
    XCTAssertNotEqualObjects(styleOne, styleTwo);
    XCTAssertNotEqualObjects(styleTwo, styleOne);
    XCTAssertNotEqual(styleOne.hash, styleTwo.hash);
}

@end
