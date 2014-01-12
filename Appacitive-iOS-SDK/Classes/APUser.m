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
#import "NSString+APString.h"
#import "APConstants.h"
#import "APNetworking.h"

#define USER_PATH @"v1.0/user/"

static APUser* currentUser = nil;
static NSDictionary *headerParams;

@implementation APUserDetails

- (NSMutableDictionary*) createParameters {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:@"user" forKey:@"__type"];//remove this later
    if (self.username) {
        [dictionary setObject:self.username forKey:@"username"];
    }
    if (self.password) {
        [dictionary setObject:self.password forKey:@"password"];
    }
    if (self.firstName) {
        [dictionary setObject:self.firstName forKey:@"firstname"];
    }
    if (self.email) {
        [dictionary setObject:self.email forKey:@"email"];
    }
    if (self.birthDate) {
        [dictionary setObject:self.birthDate forKey:@"birthdate"];
    }
    if (self.lastName) {
        [dictionary setObject:self.lastName forKey:@"lastname"];
    }
    if (self.location) {
        [dictionary setObject:self.location forKey:@"location"];
    }
    if (self.isEnabled) {
        [dictionary setObject:self.isEnabled forKey:@"isenabled"];
    }
    if (self.secretQuestion) {
        [dictionary setObject:self.secretQuestion forKey:@"secretquestion"];
    }
    if (self.isEmailVerified) {
        [dictionary setObject:self.isEmailVerified forKey:@"isemailverified"];
    }
    if (self.phone) {
        [dictionary setObject:self.phone forKey:@"phone"];
    }
    if (self.isOnline) {
        [dictionary setObject:self.isOnline forKey:@"isonline"];
    }
    return dictionary;
}

- (void) setPropertyValuesFromDictionary:(NSDictionary*) dictionary {
    NSDictionary *user;
    if([[dictionary allKeys] containsObject:@"user"])
        user = dictionary[@"user"];
    else
        user = dictionary;
    self.username = (NSString*) user[@"username"];
    self.firstName = (NSString*) user[@"firstname"];
    self.lastName = (NSString*) user[@"lastname"];
    self.email = (NSString*) user[@"email"];
    self.birthDate = (NSString*) user[@"birthdate"];
    self.isEnabled = (NSString*) user[@"isenabled"];
    self.location = (NSString*) user[@"location"];
    self.phone = (NSString*) user[@"phone"];
    self.secretQuestion = (NSString*) user[@"secretquestion"];
    self.isEmailVerified = (NSString*) user[@"isemailverified"];
    self.isOnline = (NSString*) user[@"isonline"];
}

@end

@implementation APUser

+ (NSDictionary*)getHeaderParams
{
    headerParams = [NSDictionary dictionaryWithObjectsAndKeys:
                    [Appacitive getApiKey], APIkeyHeaderKey,
                    [Appacitive environmentToUse], EnvironmentHeaderKey,
                    currentUser.userToken, UserAuthHeaderKey,
                    @"application/json", @"Content-Type",
                    nil];
    return headerParams;
}

+ (APUser *) currentUser {
    return currentUser;
}

+ (void) setCurrentUser:(APUser *)user {
    currentUser = user;
}

#pragma mark Authenticate methods

+ (void) authenticateUserWithUserName:(NSString*) userName password:(NSString*) password successHandler:(APUserSuccessBlock) successBlock {
    [APUser authenticateUserWithUserName:userName password:password successHandler:successBlock failureHandler:nil];
}

+ (void) authenticateUserWithUserName:(NSString*) userName password:(NSString*) password successHandler:(APUserSuccessBlock) successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingString:@"authenticate"];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   userName, @"username",
                                                                   password, @"password",
                                                                   nil]
                                                          options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        DLog(@"\n––––––––––JSON-ERROR–––––––––\n%@",jsonError);
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPBody:requestBody];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setAllHTTPHeaderFields:[APUser getHeaderParams]];
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        currentUser = [[APUser alloc] initWithTypeName:@"user"];
        [currentUser setPropertyValuesFromDictionary:result];
        if (successBlock) {
            successBlock(currentUser);
        }
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

+ (void) authenticateUserWithFacebook:(NSString *)accessToken successHandler:(APUserSuccessBlock)successBlock {
    [APUser authenticateUserWithFacebook:accessToken successHandler:successBlock failureHandler:nil];
}

+ (void) authenticateUserWithFacebook:(NSString *) accessToken successHandler:(APUserSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingString:@"authenticate"];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   @"true",@"createNew",
                                                                   @"facebook",@"type",
                                                                   accessToken, @"accesstoken",
                                                                   nil] options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        DLog(@"\n––––––––––JSON-ERROR–––––––––\n%@",jsonError);
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPBody:requestBody];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setAllHTTPHeaderFields:[APUser getHeaderParams]];
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest
                              successHandler:^(NSDictionary *result) {
                                  currentUser = [[APUser alloc] initWithTypeName:@"user"];
                                  [currentUser setPropertyValuesFromDictionary:result];
                                  [currentUser setLoggedInWithFacebook:YES];
                                  if (successBlock) {
                                      successBlock(currentUser);
                                  }
                              } failureHandler:^(APError *error) {
                                  if (failureBlock != nil) {
                                      failureBlock(error);
                                  }
                              }];
}

+ (void) authenticateUserWithTwitter:(NSString*) oauthToken oauthSecret:(NSString*) oauthSecret successHandler:(APUserSuccessBlock) successBlock {
    [APUser authenticateUserWithTwitter:oauthToken oauthSecret:oauthSecret successHandler:successBlock failureHandler:nil];
}

+ (void) authenticateUserWithTwitter:(NSString*) oauthToken oauthSecret:(NSString*) oauthSecret successHandler:(APUserSuccessBlock) successBlock failureHandler:(APFailureBlock) failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingString:@"authenticate"];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   @"true",@"createNew",
                                                                   @"twitter",@"type",
                                                                   oauthToken, @"oauthtoken",
                                                                   oauthSecret, @"oauthsecret",
                                                                   nil] options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        DLog(@"\n––––––––––JSON-ERROR–––––––––\n%@",jsonError);
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPBody:requestBody];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setAllHTTPHeaderFields:[APUser getHeaderParams]];
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest
                              successHandler:^(NSDictionary *result) {
                                  currentUser = [[APUser alloc] initWithTypeName:@"user"];
                                  [currentUser setPropertyValuesFromDictionary:result];
                                  [currentUser setLoggedInWithFacebook:YES];
                                  if (successBlock) {
                                      successBlock(currentUser);
                                  }
                              } failureHandler:^(APError *error) {
                                  if (failureBlock != nil) {
                                      failureBlock(error);
                                  }
                              }];
}

+ (void) authenticateUserWithTwitter:(NSString *)oauthToken oauthSecret:(NSString *)oauthSecret consumerKey:(NSString*)consumerKey consumerSecret :(NSString*) consumerSecret successHandler:(APUserSuccessBlock)successBlock {
    [APUser authenticateUserWithTwitter:oauthToken oauthSecret:oauthSecret consumerKey:consumerKey consumerSecret:consumerSecret successHandler:successBlock failureHandler:nil];
}

+ (void) authenticateUserWithTwitter:(NSString *)oauthToken oauthSecret:(NSString *)oauthSecret consumerKey:(NSString*)consumerKey consumerSecret :(NSString*) consumerSecret successHandler:(APUserSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingString:@"authenticate"];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                   @"true",@"createNew",
                                                                   @"twitter",@"type",
                                                                   oauthToken, @"oauthtoken",
                                                                   oauthSecret, @"oauthsecret",
                                                                   consumerKey, @"consumerKey",
                                                                   consumerSecret, @"consumerSecret",
                                                                   nil] options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        DLog(@"\n––––––––––JSON-ERROR–––––––––\n%@",jsonError);
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPBody:requestBody];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setAllHTTPHeaderFields:[APUser getHeaderParams]];
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        currentUser = [[APUser alloc] initWithTypeName:@"user"];
        [currentUser setPropertyValuesFromDictionary:result];
        [currentUser setLoggedInWithFacebook:YES];
        if (successBlock) {
            successBlock(currentUser);
        }
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

#pragma mark Create methods

+ (void) createUserWithDetails:(APUserDetails *)userDetails successHandler:(APUserSuccessBlock) successBlock {
    [APUser createUserWithDetails:userDetails successHandler:successBlock failuderHandler:nil];
}

+ (void) createUserWithDetails:(APUserDetails *)userDetails successHandler:(APUserSuccessBlock) successBlock failuderHandler:(APFailureBlock) failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingString:@"create"];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[userDetails createParameters] options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        DLog(@"\n––––––––––JSON-ERROR–––––––––\n%@",jsonError);
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPBody:requestBody];
    [urlRequest setHTTPMethod:@"PUT"];
    [urlRequest setAllHTTPHeaderFields:[APUser getHeaderParams]];
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        APUser *user = [[APUser alloc] initWithTypeName:@"user"];
        [user setPropertyValuesFromDictionary:result];
        if (successBlock) {
            successBlock(user);
        }
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

#pragma mark Retrieve User methods

+ (void) getUserById:(NSString *)userId successHandler:(APUserSuccessBlock) successBlock {
    [self getUserById:userId successHandler:successBlock failuderHandler:nil];
}

+ (void) getUserById:(NSString *)userId successHandler:(APUserSuccessBlock)successBlock failuderHandler:(APFailureBlock) failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@",userId];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setAllHTTPHeaderFields:[APUser getHeaderParams]];
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        APUser *user = [[APUser alloc] initWithTypeName:@"user"];
        [user setPropertyValuesFromDictionary:result];
        if (successBlock) {
            successBlock(user);
        }
        
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

+ (void) getUserByUserName:(NSString *)userName successHandler:(APUserSuccessBlock)successBlock {
    [self getUserByUserName:userName successHandler:successBlock failuderHandler:nil];
}

+ (void) getUserByUserName:(NSString *)userName successHandler:(APUserSuccessBlock)successBlock failuderHandler:(APFailureBlock) failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@?useridtype=username",userName];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setAllHTTPHeaderFields:[APUser getHeaderParams]];
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        APUser *user = [[APUser alloc] initWithTypeName:@"user"];
        [user setPropertyValuesFromDictionary:result];
        
        if (successBlock) {
            successBlock(user);
        }
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

+ (void) getCurrentUserWithsuccessHandler:(APUserSuccessBlock)successBlock {
    [self getCurrentUserWithsuccessHandler:successBlock failuderHandler:nil];
}

+ (void) getCurrentUserWithsuccessHandler:(APUserSuccessBlock)successBlock failuderHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingString:@"me?useridtype=token"];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setAllHTTPHeaderFields:[APUser getHeaderParams]];
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        APUser *user = [[APUser alloc] initWithTypeName:@"user"];
        [user setPropertyValuesFromDictionary:result];
        
        if (successBlock) {
            successBlock(user);
        }
        
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

#pragma mark update methods

- (void) updateUserWithUserId:(NSString *)userID {
    [self updateUserWithUserId:userID successHandler:nil failuderHandler:nil];
}

- (void) updateUserWithUserId:(NSString *)userID successHandler:(APUserSuccessBlock)successBlock failuderHandler:(APFailureBlock) failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@",userID];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSError *jsonError = nil;
    NSMutableDictionary *updateData = [[NSMutableDictionary alloc] initWithDictionary:[self postParametersUpdate]];
    [updateData addEntriesFromDictionary:[self.userDetails mutableCopy]];
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:updateData options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        DLog(@"\n––––––––––JSON-ERROR–––––––––\n%@",jsonError);
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPBody:requestBody];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setAllHTTPHeaderFields:[APUser getHeaderParams]];
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        APUser *user = [[APUser alloc] initWithTypeName:@"user"];
        [user setPropertyValuesFromDictionary:result];
        
        if (successBlock) {
            successBlock(user);
        }
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

#pragma mark delete methods

- (void) deleteUser {
    [self deleteUserWithSuccessHandler:nil failuderHandler:nil];
}

- (void) deleteUserWithSuccessHandler:(APSuccessBlock)successBlock failuderHandler:(APFailureBlock) failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@",self.objectId];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"DELETE"];
    [urlRequest setAllHTTPHeaderFields:[APUser getHeaderParams]];
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        if(currentUser != nil) {
            if(self.objectId == currentUser.objectId) {
                currentUser = nil;
            }
        }
        if(successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
        if(failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

- (void) deleteUserWithUserName:(NSString*)userName
{
    [self deleteUserWithUserName:userName successHandler:nil failuderHandler:nil];
}

- (void) deleteUserWithUserName:(NSString*)userName successHandler:(APSuccessBlock)successBlock failuderHandler:(APFailureBlock) failureBlock
{
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@?useridtype=username",userName];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"DELETE"];
    [urlRequest setAllHTTPHeaderFields:[APUser getHeaderParams]];
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        if (successBlock) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

+ (void) deleteCurrentlyLoggedInUser{
    [self deleteCurrentlyLoggedInUserWithSuccessHandler:nil failuderHandler:nil];
}

+ (void) deleteCurrentlyLoggedInUserWithSuccessHandler:(APSuccessBlock)successBlock failuderHandler:(APFailureBlock)failureBlock {
    [currentUser deleteObjectWithSuccessHandler:successBlock failureHandler:failureBlock];
    currentUser = nil;
}

#pragma mark Location Tracking Methods

+ (void) setUserLocationToLatitude:(NSString *)latitude longitude:(NSString *)longitude forUserWithUserId:(NSString *)userId {
    [self setUserLocationToLatitude:latitude longitude:longitude forUserWithUserId:userId successHandler:nil failuderHandler:nil];
}

+ (void) setUserLocationToLatitude:(NSString *)latitude longitude:(NSString *)longitude forUserWithUserId:(NSString *)userId successHandler:(APSuccessBlock)successBlock failuderHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@/checkin?lat=%@&long=%@",userId,latitude,longitude];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setAllHTTPHeaderFields:[APUser getHeaderParams]];
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        if (successBlock) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

#pragma mark session management methods

+ (void) validateCurrentUserSessionWithSuccessHandler:(APResultSuccessBlock)successBlock {
    [self validateCurrentUserSessionWithSuccessHandler:successBlock failuderHandler:nil];
}

+ (void) validateCurrentUserSessionWithSuccessHandler:(APResultSuccessBlock)successBlock failuderHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"validate"];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    [urlRequest setAllHTTPHeaderFields:[APUser getHeaderParams]];
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        NSString *responseJSON = [NSString stringWithFormat:@"%@",[result objectForKey:@"result"]];
        if([responseJSON isEqualToString:@"1"])
        {
            if (successBlock) {
                successBlock(result);
            }
        }
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

+ (void) logoutCurrentlyLoggedInUser
{
    [self logoutCurrentlyLoggedInUserWithSuccessHandler:nil failuderHandler:nil];
}

+(void) logoutCurrentlyLoggedInUserWithSuccessHandler:(APSuccessBlock)successBlock failuderHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"invalidate"];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setAllHTTPHeaderFields:[APUser getHeaderParams]];
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        currentUser = nil;
        if (successBlock) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

#pragma mark password management methods

- (void) changePasswordFromOldPassword:(NSString *)oldPassword toNewPassPassword:(NSString *)newPassword {
    [self changePasswordFromOldPassword:oldPassword toNewPassPassword:newPassword successHandler:nil failureHandler:nil];
}

- (void) changePasswordFromOldPassword:(NSString *)oldPassword toNewPassPassword:(NSString *)newPassword successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"%@/changePassword",self.objectId];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSError *jsonError = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                oldPassword, @"oldpassword",
                                                                newPassword, @"newpassword", nil]
                                                       options:0 error:&jsonError];
    if(jsonError != nil)
        DLog(@"\n––––––––––JSON-ERROR–––––––––\n%@",jsonError);
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:postData];
    [urlRequest setAllHTTPHeaderFields:[APUser getHeaderParams]];
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        if (successBlock) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

+ (void) sendResetPasswordEmailWithEmailSubject:(NSString *)emailSubject {
    [self sendResetPasswordEmailWithEmailSubject:emailSubject successHandler:nil failureHandler:nil];
}

+(void) sendResetPasswordEmailWithEmailSubject:(NSString *)emailSubject successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [USER_PATH stringByAppendingFormat:@"sendresetpasswordemail"];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    
    NSError *jsonError = nil;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                currentUser.userDetails.username, @"username",
                                                                emailSubject,@"subject", nil]
                                                       options:0 error:&jsonError];
    if(jsonError != nil)
        DLog(@"\n––––––––––JSON-ERROR–––––––––\n%@",jsonError);
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:postData];
    [urlRequest setAllHTTPHeaderFields:[APUser getHeaderParams]];
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        if (successBlock) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

#pragma mark private methods

- (void) setLoggedInWithFacebook:(BOOL)loggedInWithFacebook {
    _loggedInWithFacebook = YES;
}

- (void) setLoggedInWithTwitter:(BOOL)loggedInWithTwitter {
    _loggedInWithTwitter = YES;
}

- (void) setPropertyValuesFromDictionary:(NSDictionary*) dictionary {
    if(dictionary[@"token"] != nil)
        _userToken = dictionary[@"token"];
    NSDictionary *object = [[NSDictionary alloc] init];
    if([[dictionary allKeys] containsObject:@"user"])
        object = dictionary[@"user"];
    else
        object = dictionary;
    
    self.createdBy = (NSString*) object[@"__createdby"];
    self.objectId = object[@"__id"];
    _lastModifiedBy = (NSString*) object[@"__lastmodifiedby"];
    _revision = (NSNumber*) object[@"__revision"];
    self.typeId = object[@"__typeid"];
    _utcDateCreated = [APHelperMethods deserializeJsonDateString:object[@"__utcdatecreated"]];
    _utcLastUpdatedDate = [APHelperMethods deserializeJsonDateString:object[@"__utclastupdateddate"]];
    _attributes = [object[@"__attributes"] mutableCopy];
    self.tags = object[@"__tags"];
    self.type = object[@"__type"];
    
    self.userDetails = [[APUserDetails alloc] init];
    [self.userDetails setPropertyValuesFromDictionary:object];
    
    _properties = [APHelperMethods arrayOfPropertiesFromJSONResponse:object].mutableCopy;
}

- (NSMutableDictionary*) postParameters {
    NSMutableDictionary *postParams = [NSMutableDictionary dictionary];
    
    if (self.objectId)
        postParams[@"__id"] = self.objectId.description;
    
    if (self.attributes)
        postParams[@"__attributes"] = self.attributes;
    
    if (self.createdBy)
        postParams[@"__createdby"] = self.createdBy;
    
    if (self.revision)
        postParams[@"__revision"] = self.revision;
    
    for(NSDictionary *prop in self.properties) {
        [prop enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
            [postParams setObject:obj forKey:key];
            *stop = YES;
        }];
    }
    
    if (self.type)
        postParams[@"__type"] = self.type;
    
    if (self.tags)
        postParams[@"__tags"] = self.tags;
    return postParams;
}

- (NSMutableDictionary*) postParametersUpdate {
    NSMutableDictionary *postParams = [NSMutableDictionary dictionary];
    
    if (self.attributes && [self.attributes count] > 0)
        postParams[@"__attributes"] = self.attributes;
    
    for(NSDictionary *prop in self.properties) {
        [prop enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
            [postParams setObject:obj forKey:key];
            *stop = YES;
        }];
    }
    
    if(self.tagsToAdd && [self.tagsToAdd count] > 0)
        postParams[@"__addtags"] = [self.tagsToAdd allObjects];
    
    if(self.tagsToRemove && [self.tagsToRemove count] > 0)
        postParams[@"__removetags"] = [self.tagsToRemove allObjects];
    
    return postParams;
}

- (NSString*) description {
    NSString *description = [NSString stringWithFormat:@"User Token:%@, Object Id:%@, Created by:%@, Last modified by:%@, UTC date created:%@, UTC date updated:%@, Revision:%d, Properties:%@, Attributes:%@, TypeId:%d, type:%@, Tag:%@", self.userToken, self.objectId, self.createdBy, self.lastModifiedBy, self.utcDateCreated, self.utcLastUpdatedDate, [self.revision intValue], self.properties, self.attributes, [self.typeId intValue], self.type, self.tags];
    return description;
}

@end
