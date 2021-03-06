//
//  APUser.m
//  Appacitive-iOS-SDK
//
//  Created by Kauserali on 07/01/13.
//  Copyright (c) 2013 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import "APUser.h"
#import "Appacitive.h"
#import "APHelperMethods.h"
#import "APConstants.h"
#import "APNetworking.h"
#import "APLogger.h"
#define USER_PATH @"user/"

static APUser* currentUser = nil;
static NSDictionary *headerParams;

@implementation APUser

- (instancetype) init {
    return self = [super initWithTypeName:@"user"];
}

+ (APUser *) currentUser {
    [self restoreCurrentUser];
    return currentUser;
}

+ (void) setCurrentUser:(APUser *)user {
    currentUser = user;
    [APUser saveCustomObject:user forKey:@"currentAPUser"];
    [APNetworking addHTTPHeaderValue:currentUser.userToken forKey:UserAuthHeaderKey];
}

+ (void) restoreCurrentUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"currentAPUser"] != nil) {
        NSData *encodedObject = [defaults objectForKey:@"currentAPUser"];
        APUser *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        [self setCurrentUser:object];
    }
}

#pragma mark - Authenticate methods

+ (void) authenticateUserWithUsername:(NSString *)username password:(NSString *)password sessionExpiresAfter:(NSNumber*)minutes limitAPICallsTo:(NSNumber*)calls {
    [APUser authenticateUserWithUsername:username password:password sessionExpiresAfter:minutes limitAPICallsTo:calls successHandler:nil failureHandler:nil];
}

+ (void) authenticateUserWithUsername:(NSString*) username password:(NSString*) password sessionExpiresAfter:(NSNumber*)minutes limitAPICallsTo:(NSNumber*)calls failureHandler:(APFailureBlock)failureBlock {
    [APUser authenticateUserWithUsername:username password:password sessionExpiresAfter:minutes limitAPICallsTo:calls successHandler:nil failureHandler:failureBlock];
}

+ (void) authenticateUserWithUsername:(NSString*) username password:(NSString*) password sessionExpiresAfter:(NSNumber*)minutes limitAPICallsTo:(NSNumber*)calls successHandler:(APUserSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingString:@"authenticate"];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    if(minutes == nil) {
        minutes = @86400000;
    }
    if(calls == nil) {
        calls = @-1;
    }
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   username, @"username",
                                                                   password, @"password",
                                                                   minutes, @"expiry",
                                                                   calls, @"attempts",
                                                                   nil]
                                                          options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––JSON-ERROR–––––––––\n%@", [jsonError description]] withType:APMessageTypeError];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPBody:requestBody];
    [urlRequest setHTTPMethod:@"POST"];
    
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        currentUser = [[APUser alloc] initWithTypeName:@"user"];
        [currentUser setPropertyValuesFromDictionary:result];
        [APUser saveCustomObject:currentUser forKey:@"currentAPUser"];
        [APNetworking addHTTPHeaderValue:currentUser.userToken forKey:UserAuthHeaderKey];
        if (successBlock != nil) {
            successBlock(currentUser);
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

+ (void) authenticateUserWithFacebook:(NSString *)accessToken signUp:(BOOL)signUp sessionExpiresAfter:(NSNumber*)minutes limitAPICallsTo:(NSNumber*)calls {
    [APUser authenticateUserWithFacebook:accessToken signUp:signUp sessionExpiresAfter:minutes limitAPICallsTo:calls successHandler:nil failureHandler:nil];
}

+ (void) authenticateUserWithFacebook:(NSString *)accessToken signUp:(BOOL)signUp sessionExpiresAfter:(NSNumber*)minutes limitAPICallsTo:(NSNumber*)calls failureHandler:(APFailureBlock)failureBlock {
    [APUser authenticateUserWithFacebook:accessToken signUp:signUp sessionExpiresAfter:minutes limitAPICallsTo:calls successHandler:nil failureHandler:failureBlock];
}

+(void) authenticateUserWithFacebook:(NSString *) accessToken signUp:(BOOL)signUp{
    [APUser authenticateUserWithFacebook:accessToken signUp:signUp sessionExpiresAfter:nil limitAPICallsTo:nil successHandler:nil failureHandler:nil];
}

+(void) authenticateUserWithFacebook:(NSString *) accessToken signUp:(BOOL)signUp successHandler:(APUserSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock{
    [APUser authenticateUserWithFacebook:accessToken signUp:signUp sessionExpiresAfter:nil limitAPICallsTo:nil successHandler:successBlock failureHandler:failureBlock];
}

+(void) authenticateUserWithFacebook:(NSString *) accessToken signUp:(BOOL)signUp failureHandler:(APFailureBlock)failureBlock{
    [APUser authenticateUserWithFacebook:accessToken signUp:signUp sessionExpiresAfter:nil limitAPICallsTo:nil successHandler:nil failureHandler:failureBlock];
}

+ (void) authenticateUserWithFacebook:(NSString *)accessToken signUp:(BOOL)signUp sessionExpiresAfter:(NSNumber*)minutes limitAPICallsTo:(NSNumber*)calls successHandler:(APUserSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingString:@"authenticate"];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];

    if (minutes == nil) {
        minutes = @86400000;
    }
    if(calls == nil) {
        calls = @-1;
    }
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   signUp?@YES:@NO,@"createnew",
                                                                   @"facebook",@"type",
                                                                   accessToken, @"accesstoken",
                                                                   minutes, @"expiry",
                                                                   calls, @"attempts",
                                                                   nil] options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––JSON-ERROR–––––––––\n%@", [jsonError description]] withType:APMessageTypeError];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPBody:requestBody];
    [urlRequest setHTTPMethod:@"POST"];
    
    
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__
                              successHandler:^(NSDictionary *result) {
                                  currentUser = [[APUser alloc] initWithTypeName:@"user"];
                                  [currentUser setPropertyValuesFromDictionary:result];
                                  [currentUser setLoggedInWithFacebook:YES];
                                  [APNetworking addHTTPHeaderValue:currentUser.userToken forKey:UserAuthHeaderKey];
                                  [APUser saveCustomObject:currentUser forKey:@"currentAPUser"];
                                  if (successBlock != nil) {
                                      successBlock(currentUser);
                                  }
                              } failureHandler:^(APError *error) {
                                  if (failureBlock != nil) {
                                      failureBlock(error);
                                  }
                              }];
}




+ (void) authenticateUserWithTwitter:(NSString*)oauthToken oauthSecret:(NSString*)oauthSecret signUp:(BOOL)signUp successHandler:(APUserSuccessBlock)successBlock failureHandler:(APFailureBlock)failureHandler{
        [APUser authenticateUserWithTwitter:oauthToken oauthSecret:oauthSecret signUp:signUp sessionExpiresAfter:nil limitAPICallsTo:nil successHandler:successBlock failureHandler:failureHandler];
}

+ (void) authenticateUserWithTwitter:(NSString*)oauthToken oauthSecret:(NSString*)oauthSecret signUp:(BOOL)signUp failureHandler:(APFailureBlock)failureHandler{
    [APUser authenticateUserWithTwitter:oauthToken oauthSecret:oauthSecret signUp:signUp sessionExpiresAfter:nil limitAPICallsTo:nil successHandler:nil failureHandler:failureHandler];
}


+ (void) authenticateUserWithTwitter:(NSString*)oauthToken oauthSecret:(NSString*)oauthSecret signUp:(BOOL)signUp {
    [APUser authenticateUserWithTwitter:oauthToken oauthSecret:oauthSecret signUp:signUp sessionExpiresAfter:nil limitAPICallsTo:nil successHandler:nil failureHandler:nil];
}

+ (void) authenticateUserWithTwitter:(NSString*) oauthToken oauthSecret:(NSString*) oauthSecret signUp:(BOOL)signUp sessionExpiresAfter:(NSNumber*)minutes limitAPICallsTo:(NSNumber*)calls {
    [APUser authenticateUserWithTwitter:oauthToken oauthSecret:oauthSecret signUp:signUp sessionExpiresAfter:minutes limitAPICallsTo:calls successHandler:nil failureHandler:nil];
}


+ (void) authenticateUserWithTwitter:(NSString*) oauthToken oauthSecret:(NSString*) oauthSecret signUp:(BOOL)signUp sessionExpiresAfter:(NSNumber*)minutes limitAPICallsTo:(NSNumber*)calls failureHandler:(APFailureBlock)failureHandler {
    [APUser authenticateUserWithTwitter:oauthToken oauthSecret:oauthSecret signUp:signUp sessionExpiresAfter:minutes limitAPICallsTo:calls successHandler:nil failureHandler:failureHandler];
}

+ (void) authenticateUserWithTwitter:(NSString*) oauthToken oauthSecret:(NSString*) oauthSecret signUp:(BOOL)signUp sessionExpiresAfter:(NSNumber*)minutes limitAPICallsTo:(NSNumber*)calls successHandler:(APUserSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingString:@"authenticate"];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    if(minutes == nil) {
        minutes = @86400000;
    }
    if(calls == nil) {
        calls = @-1;
    }
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   signUp?@"true":@"false",@"createnew",
                                                                   @"twitter",@"type",
                                                                   oauthToken, @"oauthtoken",
                                                                   oauthSecret, @"oauthsecret",
                                                                   minutes, @"expiry",
                                                                   calls, @"attempts",
                                                                   nil] options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––JSON-ERROR–––––––––\n%@", [jsonError description]] withType:APMessageTypeError];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPBody:requestBody];
    [urlRequest setHTTPMethod:@"POST"];
    
    
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__
                              successHandler:^(NSDictionary *result) {
                                  currentUser = [[APUser alloc] initWithTypeName:@"user"];
                                  [currentUser setPropertyValuesFromDictionary:result];
                                  [currentUser setLoggedInWithFacebook:YES];
                                  [APNetworking addHTTPHeaderValue:currentUser.userToken forKey:UserAuthHeaderKey];
                                  [APUser saveCustomObject:currentUser forKey:@"currentAPUser"];
                                  if (successBlock != nil) {
                                      successBlock(currentUser);
                                  }
                              } failureHandler:^(APError *error) {
                                  if (failureBlock != nil) {
                                      failureBlock(error);
                                  }
                              }];
}



+ (void) authenticateUserWithTwitter:(NSString *)oauthToken oauthSecret:(NSString *)oauthSecret consumerKey:(NSString*)consumerKey consumerSecret:(NSString*)consumerSecret signUp:(BOOL)signUp {
    [APUser authenticateUserWithTwitter:oauthToken oauthSecret:oauthSecret consumerKey:consumerKey consumerSecret:consumerSecret signUp:signUp sessionExpiresAfter:nil limitAPICallsTo:nil successHandler:nil failureHandler:nil];
}


+ (void) authenticateUserWithTwitter:(NSString *)oauthToken oauthSecret:(NSString *)oauthSecret consumerKey:(NSString*)consumerKey consumerSecret:(NSString*)consumerSecret signUp:(BOOL)signUp failureHandler:(APFailureBlock)failureBlock{
    [APUser authenticateUserWithTwitter:oauthToken oauthSecret:oauthSecret consumerKey:consumerKey consumerSecret:consumerSecret signUp:signUp sessionExpiresAfter:nil limitAPICallsTo:nil successHandler:nil failureHandler:failureBlock];
}

+ (void) authenticateUserWithTwitter:(NSString *)oauthToken oauthSecret:(NSString *)oauthSecret consumerKey:(NSString*)consumerKey consumerSecret:(NSString*)consumerSecret signUp:(BOOL)signUp successHandler:(APUserSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock{
    [APUser authenticateUserWithTwitter:oauthToken oauthSecret:oauthSecret consumerKey:consumerKey consumerSecret:consumerSecret signUp:signUp sessionExpiresAfter:nil limitAPICallsTo:nil successHandler:successBlock failureHandler:failureBlock];
}

+ (void) authenticateUserWithTwitter:(NSString *)oauthToken oauthSecret:(NSString *)oauthSecret consumerKey:(NSString*)consumerKey consumerSecret:(NSString*) consumerSecret signUp:(BOOL)signUp sessionExpiresAfter:(NSNumber*)minutes limitAPICallsTo:(NSNumber*)calls {
    [APUser authenticateUserWithTwitter:oauthToken oauthSecret:oauthSecret consumerKey:consumerKey consumerSecret:consumerSecret signUp:signUp sessionExpiresAfter:minutes limitAPICallsTo:calls successHandler:nil failureHandler:nil];
}

+ (void) authenticateUserWithTwitter:(NSString *)oauthToken oauthSecret:(NSString *)oauthSecret consumerKey:(NSString*)consumerKey consumerSecret:(NSString*) consumerSecret signUp:(BOOL)signUp sessionExpiresAfter:(NSNumber*)minutes limitAPICallsTo:(NSNumber*)calls failureHandler:(APFailureBlock)failureBlock {
    [APUser authenticateUserWithTwitter:oauthToken oauthSecret:oauthSecret consumerKey:consumerKey consumerSecret:consumerSecret signUp:signUp sessionExpiresAfter:minutes limitAPICallsTo:calls successHandler:nil failureHandler:failureBlock];
}

+ (void) authenticateUserWithTwitter:(NSString *)oauthToken oauthSecret:(NSString *)oauthSecret consumerKey:(NSString*)consumerKey consumerSecret:(NSString*) consumerSecret signUp:(BOOL)signUp sessionExpiresAfter:(NSNumber*)minutes limitAPICallsTo:(NSNumber*)calls successHandler:(APUserSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingString:@"authenticate"];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    if(minutes == nil) {
        minutes = @86400000;
    }
    if(calls == nil) {
        calls = @-1;
    }
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   signUp?@"true":@"false",@"createnew",
                                                                   @"twitter",@"type",
                                                                   oauthToken, @"oauthtoken",
                                                                   oauthSecret, @"oauthsecret",
                                                                   consumerKey, @"consumerKey",
                                                                   consumerSecret, @"consumerSecret",
                                                                   minutes, @"expiry",
                                                                   calls, @"attempts",
                                                                   nil] options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––JSON-ERROR–––––––––\n%@", [jsonError description]] withType:APMessageTypeError];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPBody:requestBody];
    [urlRequest setHTTPMethod:@"POST"];
    

    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        currentUser = [[APUser alloc] initWithTypeName:@"user"];
        [currentUser setPropertyValuesFromDictionary:result];
        [currentUser setLoggedInWithFacebook:YES];
        [APNetworking addHTTPHeaderValue:currentUser.userToken forKey:UserAuthHeaderKey];
        [APUser saveCustomObject:currentUser forKey:@"currentAPUser"];
        if (successBlock != nil) {
            successBlock(currentUser);
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

#pragma mark - User Account Linking Methods

- (void) linkFacebookAccountWithAccessToken:(NSString*)facebookAcessToken {
    [self linkFacebookAccountWithAccessToken:facebookAcessToken successHandler:nil failureHandler:nil];
}

- (void) linkFacebookAccountWithAccessToken:(NSString*)facebookAcessToken failureHandler:(APFailureBlock)failureBlock {
    [self linkFacebookAccountWithAccessToken:facebookAcessToken successHandler:nil failureHandler:failureBlock];
}

- (void) linkFacebookAccountWithAccessToken:(NSString*)facebookAcessToken successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@/link",self.objectId];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   @"facebook",@"authtype",
                                                                   facebookAcessToken, @"accesstoken",
                                                                   nil] options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––JSON-ERROR–––––––––\n%@", [jsonError description]] withType:APMessageTypeError];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPBody:requestBody];
    [urlRequest setHTTPMethod:@"POST"];
    
    
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

- (void) linkTwitterAccountWithOauthToken:(NSString*)oauthToken oauthSecret:(NSString*)oauthSecret {
    [self linkTwitterAccountWithOauthToken:oauthToken oauthSecret:oauthSecret successHandler:nil failureHandler:nil];
}

- (void) linkTwitterAccountWithOauthToken:(NSString*)oauthToken oauthSecret:(NSString*)oauthSecret failureHandler:(APFailureBlock)failureBlock {
    [self linkTwitterAccountWithOauthToken:oauthToken oauthSecret:oauthSecret successHandler:nil failureHandler:failureBlock];
}

- (void) linkTwitterAccountWithOauthToken:(NSString*)oauthToken oauthSecret:(NSString*)oauthSecret successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@/link",self.objectId];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   @"twitter",@"authtype",
                                                                   oauthToken, @"oauthtoken",
                                                                   oauthSecret, @"oauthsecret",
                                                                   nil] options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––JSON-ERROR–––––––––\n%@", [jsonError description]] withType:APMessageTypeError];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPBody:requestBody];
    [urlRequest setHTTPMethod:@"POST"];
    
    
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

- (void) linkTwitterAccountWithOauthToken:(NSString*)oauthToken oauthSecret:(NSString*)oauthSecret consumerKey:(NSString*)consumerKey consumerSecret:(NSString*)consumerSecret {
    [self linkTwitterAccountWithOauthToken:oauthToken oauthSecret:oauthSecret consumerKey:consumerKey consumerSecret:consumerSecret successHandler:nil failureHandler:nil];
}

- (void) linkTwitterAccountWithOauthToken:(NSString*)oauthToken oauthSecret:(NSString*)oauthSecret consumerKey:(NSString*)consumerKey consumerSecret:(NSString*)consumerSecret failureHandler:(APFailureBlock)failureBlock {
    [self linkTwitterAccountWithOauthToken:oauthToken oauthSecret:oauthSecret consumerKey:consumerKey consumerSecret:consumerSecret successHandler:nil failureHandler:failureBlock];
}

- (void) linkTwitterAccountWithOauthToken:(NSString*)oauthToken oauthSecret:(NSString*)oauthSecret consumerKey:(NSString*)consumerKey consumerSecret:(NSString*)consumerSecret successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@/link",self.objectId];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   @"twitter",@"authtype",
                                                                   oauthToken, @"oauthtoken",
                                                                   oauthSecret, @"oauthsecret",
                                                                   consumerKey, @"consumerkey",
                                                                   consumerSecret, @"consumersecret",
                                                                   nil] options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––JSON-ERROR–––––––––\n%@", [jsonError description]] withType:APMessageTypeError];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPBody:requestBody];
    [urlRequest setHTTPMethod:@"POST"];
    
    
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];    
}

- (void) delinkAccountWithServiceName:(NSString*)serviceName {
    [self delinkAccountWithServiceName:serviceName successHandler:nil failureHandler:nil];
}

- (void) delinkAccountWithServiceName:(NSString*)serviceName failureHandler:(APFailureBlock)failureBlock {
    [self delinkAccountWithServiceName:serviceName successHandler:nil failureHandler:failureBlock];
}

- (void) delinkAccountWithServiceName:(NSString*)serviceName successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@/%@/delink",self.objectId,serviceName];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

- (void) getLinkedAccountWithServiceName:(NSString*)serviceName successHandler:(APResultSuccessBlock)successBlock {
    [self getLinkedAccountWithServiceName:serviceName successHandler:successBlock failureHandler:nil];
}

- (void) getLinkedAccountWithServiceName:(NSString*)serviceName successHandler:(APResultSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@/linkedaccounts/%@",self.objectId,serviceName];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    
    
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

- (void) getAllLinkedAccountsWithSuccessHandler:(APResultSuccessBlock)successBlock {
    [self getAllLinkedAccountsWithSuccessHandler:successBlock failureHandler:nil];
}

- (void) getAllLinkedAccountsWithSuccessHandler:(APResultSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@/linkedaccounts",self.objectId];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    
    
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

#pragma mark - Create methods

- (void) createUser {
    [self createUserWithSuccessHandler:nil failureHandler:nil];
}

- (void) createUserWithSuccessHandler:(APSuccessBlock)successBlock {
    [self createUserWithSuccessHandler:successBlock failureHandler:nil];
}

- (void) createUserWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingString:@"create"];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[self postParameters] options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––JSON-ERROR–––––––––\n%@", [jsonError description]] withType:APMessageTypeError];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPBody:requestBody];
    [urlRequest setHTTPMethod:@"PUT"];
    
    [self updateSnapshot];
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        [self setPropertyValuesFromDictionary:result];
        if (successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

- (void) createUserWithFacebook:(NSString*)token {
    [self createUserWithFacebook:token successHandler:nil failureHandler:nil];
}

- (void) createUserWithFacebook:(NSString*)token failureHandler:(APFailureBlock)failureBlock {
    [self createUserWithFacebook:token successHandler:nil failureHandler:failureBlock];
}

- (void) createUserWithFacebook:(NSString*)token successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"create"];
    
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"PUT"];
    NSError *jsonError = nil;
    NSMutableDictionary *bodyDict = [self postParameters];
    NSDictionary *facebookdata = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"facebook",@"authtype",
                                  token,@"accesstoken",
                                  self.username,@"name",
                                  self.firstName,@"username",
                                  nil];
    [bodyDict setObject:facebookdata forKey:@"__link"];
    
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:bodyDict options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––JSON-ERROR–––––––––\n%@", [jsonError description]] withType:APMessageTypeError];
    [urlRequest setHTTPBody:requestBody];
    [self updateSnapshot];
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        [self setPropertyValuesFromDictionary:result];
        if (successBlock != nil) {
            successBlock(result);
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

- (void) createUserWithTwitter:(NSString*)oauthToken oauthSecret:(NSString *)oauthSecret consumerKey:(NSString*)consumerKey consumerSecret:(NSString*) consumerSecret {
    [self createUserWithTwitter:oauthToken oauthSecret:oauthToken consumerKey:consumerKey consumerSecret:consumerSecret successHandler:nil failureHandler:nil];
}

- (void) createUserWithTwitter:(NSString*)oauthToken oauthSecret:(NSString *)oauthSecret consumerKey:(NSString*)consumerKey consumerSecret:(NSString*) consumerSecret failureHandler:(APFailureBlock)failureBlock {
    [self createUserWithTwitter:oauthToken oauthSecret:oauthToken consumerKey:consumerKey consumerSecret:consumerSecret successHandler:nil failureHandler:failureBlock];
}

- (void) createUserWithTwitter:(NSString*)oauthToken oauthSecret:(NSString *)oauthSecret consumerKey:(NSString*)consumerKey consumerSecret:(NSString*) consumerSecret successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"create"];
    
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"PUT"];
    NSError *jsonError = nil;
    NSMutableDictionary *bodyDict = [self postParameters];
    NSDictionary *facebookdata = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"twitter",@"authtype",
                                  oauthToken,@"oauthtoken",
                                  oauthSecret,@"oauthtokensecret",
                                  consumerKey,@"consumerkey",
                                  consumerSecret,@"consumersecret",
                                  self.username,@"name",
                                  self.firstName,@"username",
                                  nil];
    [bodyDict setObject:facebookdata forKey:@"__link"];
    
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:bodyDict options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––JSON-ERROR–––––––––\n%@", [jsonError description]] withType:APMessageTypeError];
    [urlRequest setHTTPBody:requestBody];
    [self updateSnapshot];
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        [self setPropertyValuesFromDictionary:result];
        if (successBlock != nil) {
            successBlock(result);
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

#pragma mark - Save methods

- (void) saveObject {
    [self saveObjectWithSuccessHandler:nil failureHandler:nil];
}

- (void) saveObjectWithFailureHandler:(APFailureBlock)failureBlock {
    [self saveObjectWithSuccessHandler:nil failureHandler:failureBlock];
}

- (void) saveObjectWithSuccessHandler:(APResultSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    NSString *path = [USER_PATH stringByAppendingFormat:@"create"];
    
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"PUT"];
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[self postParameters] options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––JSON-ERROR–––––––––\n%@", [jsonError description]] withType:APMessageTypeError];
    [urlRequest setHTTPBody:requestBody];
    [self updateSnapshot];
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        [self setPropertyValuesFromDictionary:result];
        if (successBlock != nil) {
            successBlock(result);
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}


#pragma mark - Retrieve User methods

- (void) fetchUserById:(NSString *)userId {
    [self fetchUserById:userId successHandler:nil failureHandler:nil];
}

- (void) fetchUserById:(NSString *)userId successHandler:(APSuccessBlock)successBlock {
    [self fetchUserById:userId successHandler:successBlock failureHandler:nil];
}

- (void) fetchUserById:(NSString *)userId successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    [self fetchUserById:userId propertiesToFetch:nil successHandler:successBlock failureHandler:failureBlock];
}

- (void) fetchUserById:(NSString *)userId propertiesToFetch:(NSArray*)propertiesToFetch successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@",userId];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    
     if(propertiesToFetch != nil || propertiesToFetch.count > 0)
        path = [path stringByAppendingFormat:@"?fields=%@",[propertiesToFetch componentsJoinedByString:@","]];
    
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    
    
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        [self setPropertyValuesFromDictionary:result];
            if (successBlock != nil) {
            successBlock();
        }
        
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

- (void) fetchUserByUsername:(NSString *)username {
    [self fetchUserByUsername:username successHandler:nil failureHandler:nil];
}

- (void) fetchUserByUsername:(NSString *)username successHandler:(APSuccessBlock)successBlock {
    [self fetchUserByUsername:username successHandler:successBlock failureHandler:nil];
}

- (void) fetchUserByUsername:(NSString *)username successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    [self fetchUserByUsername:username propertiesToFetch:nil successHandler:successBlock failureHandler:failureBlock];
}

- (void) fetchUserByUsername:(NSString *)username propertiesToFetch:(NSArray*)propertiesToFetch successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@?useridtype=username",username];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    
     if(propertiesToFetch != nil || propertiesToFetch.count > 0)
        path = [path stringByAppendingFormat:@"&fields=%@",[propertiesToFetch componentsJoinedByString:@","]];
    
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    
    [self updateSnapshot];
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        [self setPropertyValuesFromDictionary:result];
        if (successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

- (void) fetchUserWithUserToken:(NSString *)userToken {
    [self fetchUserWithUserToken:userToken successHandler:nil failureHandler:nil];
}

- (void) fetchUserWithUserToken:(NSString*)userToken successHandler:(APSuccessBlock)successBlock {
    [self fetchUserWithUserToken:userToken successHandler:successBlock failureHandler:nil];
}

- (void) fetchUserWithUserToken:(NSString*)userToken successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    [self fetchUserWithUserToken:userToken propertiesToFetch:nil successHandler:successBlock failureHandler:failureBlock];
}

- (void) fetchUserWithUserToken:(NSString*)userToken propertiesToFetch:(NSArray*)propertiesToFetch successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"me?useridtype=token&token=%@",userToken];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    
     if(propertiesToFetch != nil || propertiesToFetch.count > 0)
        path = [path stringByAppendingFormat:@"&fields=%@",[propertiesToFetch componentsJoinedByString:@","]];
    
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    
    [self updateSnapshot];
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        APUser *user = [[APUser alloc] initWithTypeName:@"user"];
        [user setPropertyValuesFromDictionary:result];
        if (successBlock != nil) {
            successBlock();
        }
        
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

#pragma mark - Update methods

- (void) updateObject {
    [self updateObjectWithRevisionNumber:nil successHandler:nil failureHandler:nil];
}

- (void) updateObjectWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    [self updateObjectWithRevisionNumber:nil successHandler:successBlock failureHandler:failureBlock];
}

- (void) updateObjectWithRevisionNumber:(NSNumber *)revision successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@",self.objectId];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSError *jsonError = nil;
    NSMutableDictionary *updateData = [[NSMutableDictionary alloc] initWithDictionary:[self postParametersUpdate]];
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:updateData options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––JSON-ERROR–––––––––\n%@", [jsonError description]] withType:APMessageTypeError];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPBody:requestBody];
    [urlRequest setHTTPMethod:@"POST"];
    
    [self updateSnapshot];
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        APUser *user = [[APUser alloc] initWithTypeName:@"user"];
        [user setPropertyValuesFromDictionary:result];
        if (successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
        
        if (failureBlock != nil) {
            
            failureBlock(error);
        }
    }];
}

#pragma mark - Delete methods

- (void) deleteObject {
    [self deleteObjectWithSuccessHandler:nil failureHandler:nil];
}

- (void) deleteObjectWithConnectingConnections {
    [self deleteObjectWithSuccessHandler:nil failureHandler:nil deleteConnectingConnections:YES];
}

- (void) deleteObjectWithConnectingConnections:(APFailureBlock)failureBlock {
    [self deleteObjectWithSuccessHandler:nil failureHandler:failureBlock deleteConnectingConnections:YES];
}

- (void) deleteObjectWithConnectingConnectionsSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    [self deleteObjectWithSuccessHandler:successBlock failureHandler:failureBlock deleteConnectingConnections:YES];
}

- (void) deleteObjectWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock deleteConnectingConnections:(BOOL)deleteConnections {
    
    NSString *path = [[NSString alloc] init];
    
    path = [USER_PATH stringByAppendingFormat:@"%@", self.objectId];

    if(deleteConnections == YES) {
        path = [path stringByAppendingString:@"?deleteconnections=true"];
    } else {
        path = [path stringByAppendingString:@"?deleteconnections=false"];
    }
    
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"DELETE"];
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

- (void) deleteObjectWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@",self.objectId];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"DELETE"];
    
    
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        if(currentUser != nil) {
            if(self.objectId == currentUser.objectId) {
                currentUser = nil;
                [APNetworking resetDefaultHTTPHeaders];
                [APUser saveCustomObject:nil forKey:@"currentAPUser"];
            }
        }
        if (successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

- (void) deleteObjectWithUsername:(NSString*)username
{
    [self deleteObjectWithUsername:username successHandler:nil failureHandler:nil];
}

- (void) deleteObjectWithUsername:(NSString*)username successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock
{
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@?useridtype=username",username];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"DELETE"];
    
    
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

+ (void) deleteCurrentlyLoggedInUser{
    [self deleteCurrentlyLoggedInUserWithSuccessHandler:nil failureHandler:nil];
}

+ (void) deleteCurrentlyLoggedInUserWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    [currentUser deleteObjectWithSuccessHandler:successBlock failureHandler:failureBlock];
    currentUser = nil;
    [APNetworking resetDefaultHTTPHeaders];
    [APUser saveCustomObject:nil forKey:@"currentAPUser"];
}

#pragma mark - Fetch methods

- (void) fetch {
    [self fetchWithSuccessHandler:nil failureHandler:nil];
}

- (void) fetchWithFailureHandler:(APFailureBlock)failureBlock {
    [self fetchWithSuccessHandler:nil failureHandler:failureBlock];
}

- (void) fetchWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    [self fetchWithPropertiesToFetch:nil successHandler:successBlock failureHandler:failureBlock];
}

- (void) fetchWithPropertiesToFetch:(NSArray*)propertiesToFetch successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [OBJECT_PATH stringByAppendingFormat:@"%@/%@", self.type, self.objectId];
    
     if(propertiesToFetch != nil || propertiesToFetch.count > 0)
        path = [path stringByAppendingFormat:@"?fields=%@",[propertiesToFetch componentsJoinedByString:@","]];
    
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    [self updateSnapshot];
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        [self setPropertyValuesFromDictionary:result];
        if (successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}


#pragma mark - Location Tracking Methods

+ (void) setUserLocationToLatitude:(NSString *)latitude longitude:(NSString *)longitude forUserWithUserId:(NSString *)userId {
    [self setUserLocationToLatitude:latitude longitude:longitude forUserWithUserId:userId successHandler:nil failureHandler:nil];
}

+ (void) setUserLocationToLatitude:(NSString *)latitude longitude:(NSString *)longitude forUserWithUserId:(NSString *)userId failureHandler:(APFailureBlock)failureBlock {
    [self setUserLocationToLatitude:latitude longitude:longitude forUserWithUserId:userId successHandler:nil failureHandler:failureBlock];
}

+ (void) setUserLocationToLatitude:(NSString *)latitude longitude:(NSString *)longitude forUserWithUserId:(NSString *)userId successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@/checkin?lat=%@&long=%@",userId,latitude,longitude];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

#pragma mark - Session management methods

+ (void) validateCurrentUserSessionWithSuccessHandler:(APResultSuccessBlock)successBlock {
    [self validateCurrentUserSessionWithSuccessHandler:successBlock failureHandler:nil];
}

+ (void) validateCurrentUserSessionWithSuccessHandler:(APResultSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"validate"];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        NSString *responseJSON = [NSString stringWithFormat:@"%@",[result objectForKey:@"result"]];
        if([responseJSON isEqualToString:@"1"])
        {
            [APUser saveCustomObject:currentUser forKey:@"currentAPUser"];
            if (successBlock != nil) {
                successBlock(result);
            }
        } else {
            currentUser = nil;
            [APNetworking resetDefaultHTTPHeaders];
            [APUser saveCustomObject:nil forKey:@"currentAPUser"];
            if (successBlock != nil)
                successBlock(result);
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

+ (void) logOutCurrentUser {
    [self logOutCurrentUserWithSuccessHandler:nil failureHandler:nil];
}

+ (void) logOutCurrentUserWithFailureHandler:(APFailureBlock)failureBlock {
    [self logOutCurrentUserWithSuccessHandler:nil failureHandler:failureBlock];
}

+ (void) logOutCurrentUserWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"invalidate"];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        currentUser = nil;
        [APNetworking resetDefaultHTTPHeaders];
        [APUser saveCustomObject:nil forKey:@"currentAPUser"];
        if (successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

#pragma mark - Password management methods

- (void) changePasswordFromOldPassword:(NSString *)oldPassword toNewPassword:(NSString *)newPassword {
    [self changePasswordFromOldPassword:oldPassword toNewPassword:newPassword successHandler:nil failureHandler:nil];
}

- (void) changePasswordFromOldPassword:(NSString *)oldPassword toNewPassword:(NSString *)newPassword failureHandler:(APFailureBlock)failureBlock {
    [self changePasswordFromOldPassword:oldPassword toNewPassword:newPassword successHandler:nil failureHandler:failureBlock];
}

- (void) changePasswordFromOldPassword:(NSString *)oldPassword toNewPassword:(NSString *)newPassword successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@/changePassword",self.objectId];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSError *jsonError = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                oldPassword, @"oldpassword",
                                                                newPassword, @"newpassword", nil]
                                                       options:0 error:&jsonError];
    if(jsonError != nil)
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––JSON-ERROR–––––––––\n%@", [jsonError description]] withType:APMessageTypeError];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:postData];
    
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        [self updateSnapshot];
        if (successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

+ (void) sendResetPasswordEmailForUserWithUsername:(NSString*)username withSubject:(NSString *)emailSubject {
    [self sendResetPasswordEmailForUserWithUsername:username withSubject:emailSubject successHandler:nil failureHandler:nil];
}

+ (void) sendResetPasswordEmailForUserWithUsername:(NSString*)username withSubject:(NSString *)emailSubject failureHandler:(APFailureBlock)failureBlock {
    [self sendResetPasswordEmailForUserWithUsername:username withSubject:emailSubject successHandler:nil failureHandler:failureBlock];
}

+ (void) sendResetPasswordEmailForUserWithUsername:(NSString*)username withSubject:(NSString *)emailSubject successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"sendresetpasswordemail"];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSError *jsonError = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                username, @"username",
                                                                emailSubject,@"subject", nil]
                                                       options:0 error:&jsonError];
    if(jsonError != nil)
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––JSON-ERROR–––––––––\n%@", [jsonError description]] withType:APMessageTypeError];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:postData];
    
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

#pragma mark - Private methods

- (void) setLoggedInWithFacebook:(BOOL)loggedInWithFacebook {
    _loggedInWithFacebook = YES;
}

- (void) setLoggedInWithTwitter:(BOOL)loggedInWithTwitter {
    _loggedInWithTwitter = YES;
}

- (void) setPropertyValuesFromDictionary:(NSDictionary*) dictionary {
    
    if(dictionary[@"token"] != nil)
        _userToken = dictionary[@"token"];
    
    NSMutableDictionary *object = [[NSMutableDictionary alloc] init];
    
    if([[dictionary allKeys] containsObject:@"user"])
        object = [dictionary[@"user"] mutableCopy];
    
    else object = [dictionary mutableCopy];;
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"currentAPUser"] != nil) {
        APUser *savedUser = [APUser loadCustomObjectForKey:@"currentAPUser"];
        if(savedUser.objectId == object[@"__id"]) {
            [savedUser setCurrentUserPropertyValuesFromDictionary:[dictionary mutableCopy]];
            [APUser saveCustomObject:savedUser forKey:@"currentAPUser"];
        }
    }
    
    self.createdBy = (NSString*) object[@"__createdby"];
    _objectId = object[@"__id"];
    _lastModifiedBy = (NSString*) object[@"__lastmodifiedby"];
    _revision = (NSNumber*) object[@"__revision"];
    _utcDateCreated = [APHelperMethods deserializeJsonDateString:object[@"__utcdatecreated"]];
    _utcLastUpdatedDate = [APHelperMethods deserializeJsonDateString:object[@"__utclastupdateddate"]];
    _attributes = [object[@"__attributes"] mutableCopy];
    self.tags = object[@"__tags"];
    self.type = object[@"__type"];
    
    self.username = object[@"username"];
    [object removeObjectForKey:@"username"];
    self.firstName = object[@"firstname"];
    [object removeObjectForKey:@"firstname"];
    self.lastName = object[@"lastname"];
    [object removeObjectForKey:@"lastname"];
    self.email = object[@"email"];
    [object removeObjectForKey:@"email"];
    self.birthDate = object[@"birthdate"];
    [object removeObjectForKey:@"birthdate"];
    self.isEnabled = object[@"isenabled"];
    [object removeObjectForKey:@"isenabled"];
    self.location = object[@"location"];
    [object removeObjectForKey:@"location"];
    self.phone = object[@"phone"];
    [object removeObjectForKey:@"phone"];
    self.isEmailVerified = object[@"isemailverified"];
    [object removeObjectForKey:@"isemailverified"];
    self.isOnline = object[@"isonline"];
    [object removeObjectForKey:@"isonline"];
    
    _properties = [APHelperMethods arrayOfPropertiesFromJSONResponse:object].mutableCopy;
    
    [self updateSnapshot];
}

- (void) setCurrentUserPropertyValuesFromDictionary:(NSDictionary*) dictionary {
    
    if(dictionary[@"token"] != nil)
        _userToken = dictionary[@"token"];
    
    NSMutableDictionary *object = [[NSMutableDictionary alloc] init];
    
    if([[dictionary allKeys] containsObject:@"user"])
        object = [dictionary[@"user"] mutableCopy];
    
    else object = [dictionary mutableCopy];
    
    self.createdBy = (NSString*) object[@"__createdby"];
    _objectId = object[@"__id"];
    _lastModifiedBy = (NSString*) object[@"__lastmodifiedby"];
    _revision = (NSNumber*) object[@"__revision"];
    _utcDateCreated = [APHelperMethods deserializeJsonDateString:object[@"__utcdatecreated"]];
    _utcLastUpdatedDate = [APHelperMethods deserializeJsonDateString:object[@"__utclastupdateddate"]];
    _attributes = [object[@"__attributes"] mutableCopy];
    self.tags = object[@"__tags"];
    self.type = object[@"__type"];
    
    self.username = object[@"username"];
    [object removeObjectForKey:@"username"];
    self.firstName = object[@"firstname"];
    [object removeObjectForKey:@"firstname"];
    self.lastName = object[@"lastname"];
    [object removeObjectForKey:@"lastname"];
    self.email = object[@"email"];
    [object removeObjectForKey:@"email"];
    self.birthDate = object[@"birthdate"];
    [object removeObjectForKey:@"birthdate"];
    self.isEnabled = object[@"isenabled"];
    [object removeObjectForKey:@"isenabled"];
    self.location = object[@"location"];
    [object removeObjectForKey:@"location"];
    self.phone = object[@"phone"];
    [object removeObjectForKey:@"phone"];
    self.isEmailVerified = object[@"isemailverified"];
    [object removeObjectForKey:@"isemailverified"];
    self.isOnline = object[@"isonline"];
    [object removeObjectForKey:@"isonline"];
    
    _properties = [APHelperMethods arrayOfPropertiesFromJSONResponse:object].mutableCopy;
    
    [self updateSnapshot];
}

- (NSMutableDictionary*) postParameters {
    NSMutableDictionary *postParams = [NSMutableDictionary dictionary];

    if (self.username)
        [postParams setObject:self.username forKey:@"username"];
    if (self.password)
        [postParams setObject:self.password forKey:@"password"];
    if (self.firstName)
        [postParams setObject:self.firstName forKey:@"firstname"];
    if (self.email)
        [postParams setObject:self.email forKey:@"email"];
    if (self.birthDate)
        [postParams setObject:self.birthDate forKey:@"birthdate"];
    if (self.lastName)
        [postParams setObject:self.lastName forKey:@"lastname"];
    if (self.location)
        [postParams setObject:self.location forKey:@"location"];
    if (self.isEnabled)
        [postParams setObject:self.isEnabled forKey:@"isenabled"];
    if (self.isEmailVerified)
        [postParams setObject:self.isEmailVerified forKey:@"isemailverified"];
    if (self.phone)
        [postParams setObject:self.phone forKey:@"phone"];
    if (self.isOnline)
        [postParams setObject:self.isOnline forKey:@"isonline"];
    if (self.objectId)
        postParams[@"__id"] = self.objectId;
    if (_attributes)
        postParams[@"__attributes"] = self.attributes;
    if (self.createdBy)
        postParams[@"__createdby"] = self.createdBy;
    if (_revision)
        postParams[@"__revision"] = self.revision;
    if (self.type)
        postParams[@"__type"] = self.type;
    if (self.tags)
        postParams[@"__tags"] = self.tags;
    
    for(NSDictionary *prop in _properties) {
        [prop enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
            if([obj isKindOfClass:[NSDate class]]) {
                [postParams setObject:[APHelperMethods jsonDateStringFromDate:obj] forKey:key];
            } else {
                [postParams setObject:obj forKey:key];
            }
            *stop = YES;
        }];
    }
    
    return postParams;
}

- (NSMutableDictionary*) postParametersUpdate {
    
    NSMutableDictionary *postParams = [NSMutableDictionary dictionary];
    
    if (self.username && self.username != [_snapShot objectForKey:@"username"])
        [postParams setObject:self.username forKey:@"username"];
    if (self.firstName && self.firstName != [_snapShot objectForKey:@"firstname"])
        [postParams setObject:self.firstName forKey:@"firstname"];
    if (self.email && self.email != [_snapShot objectForKey:@"email"])
        [postParams setObject:self.email forKey:@"email"];
    if (self.birthDate && self.birthDate != [_snapShot objectForKey:@"birthdate"])
        [postParams setObject:self.birthDate forKey:@"birthdate"];
    if (self.lastName && self.lastName != [_snapShot objectForKey:@"lastname"])
        [postParams setObject:self.lastName forKey:@"lastname"];
    if (self.location && self.location != [_snapShot objectForKey:@"location"])
        [postParams setObject:self.location forKey:@"location"];
    if (self.isEnabled && self.isEnabled != [_snapShot objectForKey:@"isenabled"])
        [postParams setObject:self.isEnabled forKey:@"isenabled"];
    if (self.isEmailVerified && self.isEmailVerified != [_snapShot objectForKey:@"isemailverified"])
        [postParams setObject:self.isEmailVerified forKey:@"isemailverified"];
    if (self.phone && self.phone != [_snapShot objectForKey:@"phone"])
        [postParams setObject:self.phone forKey:@"phone"];
    if (self.isOnline && self.isOnline != [_snapShot objectForKey:@"isonline"])
        [postParams setObject:self.isOnline forKey:@"isonline"];
    
    if (_attributes && [_attributes count] > 0)
        for(id key in _attributes) {
            if(![[[_snapShot objectForKey:@"__attributes"] allKeys] containsObject:key])
                [postParams[@"__attributes"] setObject:[_attributes objectForKey:key] forKey:key];
            else if([[_snapShot objectForKey:@"__attributes"] objectForKey:key] != [_attributes objectForKey:key])
                [postParams[@"__attributes"] setObject:[_attributes objectForKey:key] forKey:key];
        }
    
    for(NSDictionary *prop in _properties) {
        [prop enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
            if([obj isKindOfClass:[NSDate class]]) {
                if(![[_snapShot allKeys] containsObject:key])
                    [postParams setObject:[APHelperMethods jsonDateStringFromDate:obj] forKey:key];
                else if([_snapShot objectForKey:key] != [prop objectForKey:key])
                    [postParams setObject:[APHelperMethods jsonDateStringFromDate:obj] forKey:key];
            } else {
                if(![[_snapShot allKeys] containsObject:key])
                    [postParams setObject:obj forKey:key];
                else if([_snapShot objectForKey:key] != [prop objectForKey:key])
                    [postParams setObject:obj forKey:key];
            }
            *stop = YES;
        }];
    }
    
    if(self.tagsToAdd && [self.tagsToAdd count] > 0)
        postParams[@"__addtags"] = [self.tagsToAdd allObjects];
    if(self.tagsToRemove && [self.tagsToRemove count] > 0)
        postParams[@"__removetags"] = [self.tagsToRemove allObjects];
    return postParams;
}

- (void) updateSnapshot {
    if(_snapShot == nil)
        _snapShot = [[NSMutableDictionary alloc] init];
        
    if(self.username)
        _snapShot[@"username"] = self.username;
    if(self.firstName)
        _snapShot[@"firstname"] = self.firstName;
    if(self.lastName)
        _snapShot[@"lastname"] = self.lastName;
    if(self.email)
        _snapShot[@"email"] = self.email;
    if(self.birthDate)
        _snapShot[@"birthdate"] = self.birthDate;
    if(self.isEnabled)
        _snapShot[@"isenabled"] = self.isEnabled;
    if(self.location)
        _snapShot[@"location"] = self.location;
    if(self.phone)
        _snapShot[@"phone"] = self.phone;
    if(self.isEmailVerified)
        _snapShot[@"isemailverified"] = self.isEmailVerified;
    if(self.isOnline)
        _snapShot[@"isonline"] = self.isOnline;
    if(_attributes)
        _snapShot[@"__attributes"] = [self.attributes mutableCopy];
    if(self.tags)
        _snapShot[@"__tags"] = [self.tags mutableCopy];
    if(_properties)
        _snapShot[@"__properties"] = [self.properties mutableCopy];
}

- (NSString*) description {
    NSString *description = [NSString stringWithFormat:@"User Token:%@, Object Id:%@, Created by:%@, Last modified by:%@, UTC date created:%@, UTC date updated:%@, Revision:%d, Properties:%@, Attributes:%@, type:%@, Tag:%@", self.userToken, self.objectId, self.createdBy, self.lastModifiedBy, self.utcDateCreated, self.utcLastUpdatedDate, [self.revision intValue], self.properties, self.attributes, self.type, self.tags];
    return description;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.objectId forKey:@"objectId"];
    [encoder encodeObject:self.createdBy forKey:@"createdBy"];
    [encoder encodeObject:self.lastModifiedBy forKey:@"lastModifiedBy"];
    [encoder encodeObject:self.utcDateCreated forKey:@"utcDateCreated"];
    [encoder encodeObject:self.utcLastUpdatedDate forKey:@"utcLastUpdatedDate"];
    [encoder encodeObject:self.revision forKey:@"revision"];
    [encoder encodeObject:self.properties forKey:@"properties"];
    [encoder encodeObject:self.attributes forKey:@"attributes"];
    [encoder encodeObject:self.type forKey:@"type"];
    [encoder encodeObject:self.tags forKey:@"tags"];
    [encoder encodeObject:self.userToken forKey:@"userToken"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.password forKey:@"pasword"];
    [encoder encodeObject:self.birthDate forKey:@"birthdate"];
    [encoder encodeObject:self.firstName forKey:@"firstName"];
    [encoder encodeObject:self.lastName forKey:@"lastName"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.location forKey:@"location"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeObject:self.isEmailVerified forKey:@"isEmailVerified"];
    [encoder encodeObject:self.isEnabled forKey:@"isEnabled"];
    [encoder encodeObject:self.isOnline forKey:@"isOnline"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        _objectId = [decoder decodeObjectForKey:@"objectId"];
        self.createdBy = [decoder decodeObjectForKey:@"createdBy"];
        _lastModifiedBy = [decoder decodeObjectForKey:@"lastModifiedBy"];
        _utcDateCreated = [decoder decodeObjectForKey:@"utcDateCreated"];
        _utcLastUpdatedDate = [decoder decodeObjectForKey:@"utcLastUpdatedDate"];
        _revision = [decoder decodeObjectForKey:@"revision"];
        _properties = [decoder decodeObjectForKey:@"properties"];
        _attributes = [decoder decodeObjectForKey:@"attributes"];
        _userToken = [decoder decodeObjectForKey:@"userToken"];
        self.type = [decoder decodeObjectForKey:@"type"];
        self.tags= [decoder decodeObjectForKey:@"tags"];
        self.username = [decoder decodeObjectForKey:@"username"];
        self.password = [decoder decodeObjectForKey:@"password"];
        self.birthDate = [decoder decodeObjectForKey:@"birthDate"];
        self.firstName = [decoder decodeObjectForKey:@"firstName"];
        self.lastName = [decoder decodeObjectForKey:@"lastName"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.location = [decoder decodeObjectForKey:@"location"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
        self.isEmailVerified = [decoder decodeObjectForKey:@"isEmailVerified"];
        self.isEnabled = [decoder decodeObjectForKey:@"isEnabled"];
        self.isOnline = [decoder decodeObjectForKey:@"isOnline"];
    }
    return self;
}

+ (void)saveCustomObject:(APUser *)object forKey:(NSString *)key {
    if(object != nil) {
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:encodedObject forKey:key];
        [defaults synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (APUser *)loadCustomObjectForKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:key] != nil) {
        NSData *encodedObject = [defaults objectForKey:key];
        APUser *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        return object;
    } else {
        return nil;
    }
}

@end
