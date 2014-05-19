//
//  APUserGroup.m
//  Appacitive-iOS-SDK
//
//  Created by Pratik on 19-05-14.
//  Copyright (c) 2014 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import "APUserGroup.h"
#import "APNetworking.h"
#import "APLogger.h"

#define USERGROUP_PATH @"usergroup/"

@implementation APUserGroup

+ (void) addUsers:(NSArray*)users toUserGroup:(NSString*)userGroup {
    [self addUsers:users toUserGroup:userGroup successHandler:nil failureHandler:nil];
}

+ (void) addUsers:(NSArray *)users toUserGroup:(NSString *)userGroup failureHandler:(APFailureBlock)failureBlock {
    [self addUsers:users toUserGroup:userGroup successHandler:nil failureHandler:failureBlock];
}

+ (void) addUsers:(NSArray *)users toUserGroup:(NSString *)userGroup successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USERGROUP_PATH stringByAppendingFormat:@"%@/members",userGroup];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    NSMutableDictionary *requestData = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       users, @"add", nil];
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:requestData options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––JSON-ERROR–––––––––\n%@", [jsonError description]] withType:APMessageTypeError];
    [urlRequest setHTTPBody:requestBody];
    
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            successBlock(result);
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

+ (void) removeUsers:(NSArray*)users fromUserGroup:(NSString*)userGroup {
    [self addUsers:users toUserGroup:userGroup successHandler:nil failureHandler:nil];
}

+ (void) removeUsers:(NSArray *)users fromUserGroup:(NSString *)userGroup failureHandler:(APFailureBlock)failureBlock {
    [self addUsers:users toUserGroup:userGroup successHandler:nil failureHandler:failureBlock];
}

+ (void) removeUsers:(NSArray *)users fromUserGroup:(NSString *)userGroup successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USERGROUP_PATH stringByAppendingFormat:@"%@/members",userGroup];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    NSMutableDictionary *requestData = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        users, @"remove", nil];
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:requestData options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––JSON-ERROR–––––––––\n%@", [jsonError description]] withType:APMessageTypeError];
    [urlRequest setHTTPBody:requestBody];
    
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            successBlock(result);
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

@end
