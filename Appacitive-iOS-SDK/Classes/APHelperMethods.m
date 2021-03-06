//
//  APHelperMethods.m
//  Appacitive-iOS-SDK
//
//  Created by Kauserali Hafizji on 03/09/12.
//  Copyright (c) 2012 Appacitive Software Pvt. All rights reserved.
//

#import "APHelperMethods.h"
#import "APError.h"
#import "Appacitive.h"
#import "APUser.h"

#define ERROR_DOMAIN @"apis.appacitive.com"

@implementation APHelperMethods

+ (APError*)getErrorInfo:(NSHTTPURLResponse*)response {
    if(response != nil) {
        NSString *errorMessage = [NSString stringWithFormat:@"Message: HTTP Error"];
        NSDictionary *dictionary = @{NSLocalizedDescriptionKey: errorMessage};
        APError *error = [APError errorWithDomain:ERROR_DOMAIN code:[response statusCode] userInfo:dictionary];
        error.statusCode = [NSString stringWithFormat:@"%ld",(long)[response statusCode]];
        return error;
    }
    return nil;
}

+ (APError*)checkForErrorStatus:(id)response {
    NSDictionary *status;
    if (response[@"status"]) {
        status = response[@"status"];
    } else {
        status = response;
    }
    NSString *statusCode = status[@"code"];
    if (statusCode && ![statusCode isEqualToString:@"200"]) {
        NSString *referenceId = status[@"referenceid"];
        NSString *message = status[@"message"];
        NSString *version = status[@"version"];
        NSArray *additionalMessages = status[@"additionalmessages"];
        
        NSString *errorMessage = [NSString stringWithFormat:@"Message: %@ Additional messages: %@", message, additionalMessages.count>0 ? additionalMessages.description : @"NONE"];
        NSDictionary *dictionary = @{NSLocalizedDescriptionKey: errorMessage};
        APError *error = [APError errorWithDomain:ERROR_DOMAIN code:[statusCode integerValue] userInfo:dictionary];
        error.statusCode = statusCode;
        error.referenceId = referenceId;
        error.version = version;
        return error;
    }
    return nil;
}

+ (NSArray*)arrayOfPropertiesFromJSONResponse:(id)response {
    if (response) {
        __block NSMutableArray *properties;
        [response enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if (![[key substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"__"]) {
                if (!properties) {
                    properties = [NSMutableArray array];
                }
                [properties addObject:@{key:obj}.mutableCopy];
            }
        }];
        return properties;
    }
    return nil;
}

+ (NSMutableDictionary*)dictionaryOfPropertiesFromJSONResponse:(id)response {
    if (response) {
        __block NSMutableDictionary *properties;
        [response enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
            if (![[key substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"__"]) {
                if (!properties) {
                    properties = [NSMutableDictionary dictionary];
                }
                [properties setObject:obj forKey:key];
            }
        }];
        return properties;
    }
    return nil;
}

+ (NSDate *) deserializeJsonDateString:(NSString *)jsonDateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    return [dateFormatter dateFromString:jsonDateString];
}

+ (NSString *) jsonDateStringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    return [dateFormatter stringFromDate:date];
}

@end
