//
//  Appacitive.m
//  Appacitive-iOS-SDK
//
//  Created by Kauserali Hafizji on 29/08/12.
//  Copyright (c) 2012 Appacitive Software Pvt. All rights reserved.
//

#import "Appacitive.h"
#import "APConstants.h"
#import "APHelperMethods.h"
#import "APUser.h"
#import "APDevice.h"

static NSString* _apiKey;
static BOOL isEnvironmentLive = NO;

@implementation Appacitive

+ (NSString*)getCurrentEnvironment {
    if (isEnvironmentLive) {
        return @"live";
    }
    return @"sandbox";
}

+ (void) useLiveEnvironment:(BOOL)answer {
    isEnvironmentLive = answer;
}

+ (NSString*)getApiKey {
    return _apiKey;
}

+ (void) registerAPIKey:(NSString*)apiKey useLiveEnvironment:(BOOL)answer {
    _apiKey = apiKey;
    isEnvironmentLive = answer;
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"currentAPUser"] != nil) {
        [APUser restoreCurrentUser];
    }
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"currentAPDevice"] != nil) {
        [APDevice restoreCurrentDevice];
    }
}

@end
