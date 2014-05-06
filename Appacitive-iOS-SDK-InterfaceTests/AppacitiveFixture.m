//
//  AppacitiveTest.m
//  Appacitive-iOS-SDK
//
//  Created by Kauserali Hafizji on 30/08/12.
//  Copyright (c) 2012 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import "AppacitiveFixture.h"
#import "Appacitive.h"

#define API_KEY @"+MmuqVgHVYH7Q+5imsGc4497fiuBAbBeCGYRkiQSCfY="

/**
 Test methods to check the interface of the Appacitive class
 */
@implementation AppacitiveFixture

/**
 @purpose Test for nil API_KEY
 @expected Appacitive object should be nil
 */
- (void) testInitMethodForNilApiKey {
    [Appacitive registerAPIKey:nil useLiveEnvironment:NO];
    NSString *key = [Appacitive getApiKey];
    XCTAssertNil(key, @"Test case for nil api key failed");
}

@end
