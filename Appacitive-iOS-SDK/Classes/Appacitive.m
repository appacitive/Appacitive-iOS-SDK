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
#import "APdevice.h"
static NSString* _apiKey;
static BOOL isEnvironmentLive = NO;
static APDevice *currentAPDevice;

@implementation Appacitive

+ (NSString*) getCurrentEnvironment {
    if (isEnvironmentLive) {
        return @"live";
    }
    return @"sandbox";
}

+ (void) useLiveEnvironment:(BOOL)answer {
    isEnvironmentLive = answer;
}

+ (NSString*) getApiKey {
    return _apiKey;
}

+ (APDevice*) getCurrentAPDevice {
    return currentAPDevice;
}

+ (void) registerAPIKey:(NSString*)apiKey useLiveEnvironment:(BOOL)answer {
    _apiKey = apiKey;
    isEnvironmentLive = answer;
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"appacitive-device-guid"] == nil) {
        currentAPDevice = [[APDevice alloc]initWithDeviceToken:[self getUUID] deviceType:@"ios"];
        [currentAPDevice registerDeviceWithSuccessHandler:^{
            [[NSUserDefaults standardUserDefaults] setObject:currentAPDevice.objectId forKey:@"appacitive-device-guid"];
        } failureHandler:^(APError *error) {
            DLog(@"\n––––––––––ERROR–––––––––\n%@",error);
        }];
    }
    else {
        currentAPDevice = [[APDevice alloc] initWithTypeName:@"device" objectId:[[NSUserDefaults standardUserDefaults] valueForKey:@"appacitive-device-guid"]];
        [currentAPDevice fetchWithSuccessHandler:^{
            [[NSUserDefaults standardUserDefaults] setObject:currentAPDevice.objectId forKey:@"appacitive-device-guid"];
        } failureHandler:^(APError *error) {
            DLog(@"\n––––––––––ERROR–––––––––\n%@",error);
        }];
    }
}

#pragma mark - Private Methods

+ (NSString *)getUUID {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}

@end
