//
//  APUser.m
//  Appacitive-iOS-SDK
//
//  Created by Kauserali on 07/01/13.
//  Copyright (c) 2013 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import "APUser.h"
#import "Appacitive.m"
#import "APHelperMethods.h"
#import "NSString+APString.h"
#import "APConstants.h"

//#define USER_PATH @"User/"

static APUser* currentUser = nil;

@implementation APUser

+ (APUser *) currentUser {
    return currentUser;
}

+ (void) setCurrentUser:(APUser *)user {
    currentUser = user;
}

#pragma mark Authenticate methods

+ (void) authenticateUserWithUserName:(NSString*) userName password:(NSString*) password successHandler:(APSuccessBlock) successBlock {
    [APUser authenticateUserWithUserName:userName password:password successHandler:successBlock failureHandler:nil];
}

+ (void) authenticateUserWithUserName:(NSString*) userName password:(NSString*) password successHandler:(APSuccessBlock) successBlock failureHandler:(APFailureBlock)failureBlock {

    Appacitive *sharedObject = [Appacitive sharedObject];
    APFailureBlock failureBlockCopy = [failureBlock copy];
    if (sharedObject.session) {
        APSuccessBlock successBlockCopy = [successBlock copy];
  
        NSURL *url = [NSURL URLWithString:@"https://apis.appacitive.com/user/authenticate"];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       [Appacitive getApiKey], @"apikey",
                                       userName, @"username",
                                       password, @"password",
                                       nil];
        
        if(NSClassFromString(@"NSURLSession")) {
            NSURLSessionConfiguration *sessionConfig =
            [NSURLSessionConfiguration defaultSessionConfiguration];
            sessionConfig.allowsCellularAccess = YES;
            [sessionConfig setHTTPAdditionalHeaders: params];
            sessionConfig.timeoutIntervalForRequest = 30.0;
            sessionConfig.timeoutIntervalForResource = 60.0;
            sessionConfig.HTTPMaximumConnectionsPerHost = 1;
            
            NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
            
            [[session dataTaskWithURL:url
                    completionHandler:^(NSData *data,
                                        NSURLResponse *response,
                                        NSError *error) {
                if(!error) {
                    NSError *jsonError;
                    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                    if(!jsonError) {
                        APError *error = [APHelperMethods checkForErrorStatus:response];
                        
                        BOOL isErrorPresent = (error != nil);
                        
                        if (!isErrorPresent) {
                            currentUser = [[APUser alloc] initWithSchemaName:@"user"];
                            [currentUser setNewPropertyValuesFromDictionary:response];
                            if (successBlockCopy) {
                                successBlockCopy(response);
                            }
                        } else {
                            if (failureBlockCopy != nil) {
                                failureBlockCopy(error);
                            }
                        }
                    } else {
                        DLog(@"%@", jsonError);
                        if (failureBlockCopy != nil) {
                            failureBlockCopy((APError*) error);
                        }
                    }
                } else {
                    DLog(@"%@", error);
                    if (failureBlockCopy != nil) {
                        failureBlockCopy((APError*) error);
                    }
                }
            }] resume];
        } else {
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                if(!error) {
                    NSError *jsonError;
                    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                    if(!jsonError) {
                        APError *error = [APHelperMethods checkForErrorStatus:response];
                        
                        BOOL isErrorPresent = (error != nil);
                        
                        if (!isErrorPresent) {
                            currentUser = [[APUser alloc] initWithSchemaName:@"user"];
                            [currentUser setNewPropertyValuesFromDictionary:response];
                            if (successBlockCopy) {
                                successBlockCopy(response);
                            }
                        } else {
                            if (failureBlockCopy != nil) {
                                failureBlockCopy(error);
                            }
                        }
                    } else {
                        DLog(@"%@", jsonError);
                        if (failureBlockCopy != nil) {
                            failureBlockCopy((APError*) error);
                        }
                    }
                } else {
                    DLog(@"%@", error);
                    if (failureBlockCopy != nil) {
                        failureBlockCopy((APError*) error);
                    }
                }
            }];
        }
        
//        //Using MKNetworkKit
//        NSString *path = [USER_PATH stringByAppendingString:@"authenticate"];
//
//        MKNetworkOperation *op = [sharedObject operationWithPath:path
//                                                params:@{@"username":userName, @"password":password}.mutableCopy
//                                                httpMethod:@"POST" ssl:YES];
//        op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
//        [APHelperMethods addHeadersToMKNetworkOperation:op];
//        
//        [op onCompletion:^(MKNetworkOperation *completedOperation){
//            APError *error = [APHelperMethods checkForErrorStatus:completedOperation.responseJSON];
//            
//            BOOL isErrorPresent = (error != nil);
//            
//            if (!isErrorPresent) {
//                currentUser = [[APUser alloc] initWithSchemaName:@"user"];
//                [currentUser setNewPropertyValuesFromDictionary:completedOperation.responseJSON];
//                if (successBlockCopy) {
//                    successBlockCopy(completedOperation.responseJSON);
//                }
//            } else {
//                if (failureBlockCopy != nil) {
//                    failureBlockCopy(error);
//                }
//            }
//            
//        } onError:^(NSError *error){
//            if (failureBlockCopy != nil) {
//                failureBlockCopy((APError*) error);
//            }
//        }];
//        [sharedObject enqueueOperation:op];
        
    } else {
        DLog(@"Initialize the Appactive object with your API_KEY in the - application: didFinishLaunchingWithOptions: method of the AppDelegate");
        if (failureBlockCopy != nil) {
            failureBlockCopy([APHelperMethods errorForSessionNotCreated]);
        }
    }
}

+ (void) authenticateUserWithFacebook:(NSString *)accessToken successHandler:(APSuccessBlock)successBlock {
    [APUser authenticateUserWithFacebook:accessToken successHandler:successBlock failureHandler:nil];
}

+ (void) authenticateUserWithFacebook:(NSString *) accessToken successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    Appacitive *sharedObject = [Appacitive sharedObject];
    APFailureBlock failureBlockCopy = [failureBlock copy];
    
    if (sharedObject.session) {
        APSuccessBlock successBlockCopy = [successBlock copy];
        
        NSURL *url = [NSURL URLWithString:@"https://apis.appacitive.com/user/authenticate"];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       [Appacitive getApiKey], @"apikey",
                                       YES,@"createNew",
                                       @"facebook",@"type",
                                       accessToken, @"accesstoken",
                                       nil];
        
        if(NSClassFromString(@"NSURLSession")) {
            NSURLSessionConfiguration *sessionConfig =
            [NSURLSessionConfiguration defaultSessionConfiguration];
            sessionConfig.allowsCellularAccess = YES;
            [sessionConfig setHTTPAdditionalHeaders: params];
            sessionConfig.timeoutIntervalForRequest = 30.0;
            sessionConfig.timeoutIntervalForResource = 60.0;
            sessionConfig.HTTPMaximumConnectionsPerHost = 1;
            
            NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
            
            [[session dataTaskWithURL:url
                    completionHandler:^(NSData *data,
                                        NSURLResponse *response,
                                        NSError *error) {
                        if(!error) {
                            NSError *jsonError;
                            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                            if(!jsonError) {
                                APError *error = [APHelperMethods checkForErrorStatus:response];
                                
                                BOOL isErrorPresent = (error != nil);
                                
                                if (!isErrorPresent) {
                                    currentUser = [[APUser alloc] initWithSchemaName:@"user"];
                                    [currentUser setNewPropertyValuesFromDictionary:response];
                                    [currentUser setLoggedInWithFacebook:YES];
                                    if (successBlockCopy) {
                                        successBlockCopy();
                                    }
                                } else {
                                    if (failureBlockCopy != nil) {
                                        failureBlockCopy(error);
                                    }
                                }
                            } else {
                                DLog(@"%@", jsonError);
                                if (failureBlockCopy != nil) {
                                    failureBlockCopy((APError*) error);
                                }
                            }
                        } else {
                            DLog(@"%@", error);
                            if (failureBlockCopy != nil) {
                                failureBlockCopy((APError*) error);
                            }
                        }
                    }] resume];
        } else {
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                if(!error) {
                    NSError *jsonError;
                    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                    if(!jsonError) {
                        APError *error = [APHelperMethods checkForErrorStatus:response];
                        
                        BOOL isErrorPresent = (error != nil);
                        
                        if (!isErrorPresent) {
                            currentUser = [[APUser alloc] initWithSchemaName:@"user"];
                            [currentUser setNewPropertyValuesFromDictionary:response];
                            [currentUser setLoggedInWithFacebook:YES];
                            if (successBlockCopy) {
                                successBlockCopy();
                            }
                        } else {
                            if (failureBlockCopy != nil) {
                                failureBlockCopy(error);
                            }
                        }
                    } else {
                        DLog(@"%@", jsonError);
                        if (failureBlockCopy != nil) {
                            failureBlockCopy((APError*) error);
                        }
                    }
                } else {
                    DLog(@"%@", error);
                    if (failureBlockCopy != nil) {
                        failureBlockCopy((APError*) error);
                    }
                }
            }];
        }

//        //Using MKNetworkKit
//        NSString *path = [USER_PATH stringByAppendingString:@"authenticate"];
//        
//        MKNetworkOperation *op = [sharedObject operationWithPath:path
//                                               params:@{@"createNew":@YES, @"type":@"facebook", @"accesstoken":accessToken}.mutableCopy
//                                               httpMethod:@"POST" ssl:YES];
//        op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
//        [APHelperMethods addHeadersToMKNetworkOperation:op];
//        
//        [op onCompletion:^(MKNetworkOperation *completedOperation){
//            APError *error = [APHelperMethods checkForErrorStatus:completedOperation.responseJSON];
//            
//            BOOL isErrorPresent = (error != nil);
//            
//            if (!isErrorPresent) {
//                currentUser = [[APUser alloc] initWithSchemaName:@"user"];
//                [currentUser setNewPropertyValuesFromDictionary:completedOperation.responseJSON];
//                [currentUser setLoggedInWithFacebook:YES];
//                if (successBlockCopy) {
//                    successBlockCopy();
//                }
//            } else {
//                if (failureBlockCopy != nil) {
//                    failureBlockCopy(error);
//                }
//            }
//            
//        } onError:^(NSError *error){
//            if (failureBlockCopy != nil) {
//                failureBlockCopy((APError*) error);
//            }
//        }];
//        [sharedObject enqueueOperation:op];
    } else {
        DLog(@"Initialize the Appactive object with your API_KEY in the - application: didFinishLaunchingWithOptions: method of the AppDelegate");
        if (failureBlockCopy != nil) {
            failureBlockCopy([APHelperMethods errorForSessionNotCreated]);
        }
    }
}

+ (void) authenticateUserWithTwitter:(NSString*) oauthToken oauthSecret:(NSString*) oauthSecret successHandler:(APSuccessBlock) successBlock {
    [APUser authenticateUserWithTwitter:oauthToken oauthSecret:oauthSecret successHandler:successBlock failureHandler:nil];
}

+ (void) authenticateUserWithTwitter:(NSString*) oauthToken oauthSecret:(NSString*) oauthSecret successHandler:(APSuccessBlock) successBlock failureHandler:(APFailureBlock) failureBlock {
    Appacitive *sharedObject = [Appacitive sharedObject];
    APFailureBlock failureBlockCopy = [failureBlock copy];
    
    if (sharedObject.session) {
        APSuccessBlock successBlockCopy = [successBlock copy];
        
        NSURL *url = [NSURL URLWithString:@"https://apis.appacitive.com/user/authenticate"];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       [Appacitive getApiKey], @"apikey",
                                       YES,@"createNew",
                                       @"twitter",@"type",
                                       oauthToken, @"oauthtoken",
                                       oauthSecret, @"oauthsecret",
                                       nil];
        
        if(NSClassFromString(@"NSURLSession")) {
            NSURLSessionConfiguration *sessionConfig =
            [NSURLSessionConfiguration defaultSessionConfiguration];
            sessionConfig.allowsCellularAccess = YES;
            [sessionConfig setHTTPAdditionalHeaders: params];
            sessionConfig.timeoutIntervalForRequest = 30.0;
            sessionConfig.timeoutIntervalForResource = 60.0;
            sessionConfig.HTTPMaximumConnectionsPerHost = 1;
            
            NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
            
            [[session dataTaskWithURL:url
                    completionHandler:^(NSData *data,
                                        NSURLResponse *response,
                                        NSError *error) {
                        if(!error) {
                            NSError *jsonError;
                            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                            if(!jsonError) {
                                APError *error = [APHelperMethods checkForErrorStatus:response];
                                
                                BOOL isErrorPresent = (error != nil);
                                
                                if (!isErrorPresent) {
                                    currentUser = [[APUser alloc] initWithSchemaName:@"user"];
                                    [currentUser setNewPropertyValuesFromDictionary:response];
                                    [currentUser setLoggedInWithFacebook:YES];
                                    if (successBlockCopy) {
                                        successBlockCopy();
                                    }
                                } else {
                                    if (failureBlockCopy != nil) {
                                        failureBlockCopy(error);
                                    }
                                }
                            } else {
                                DLog(@"%@", jsonError);
                                if (failureBlockCopy != nil) {
                                    failureBlockCopy((APError*) error);
                                }
                            }
                        } else {
                            DLog(@"%@", error);
                            if (failureBlockCopy != nil) {
                                failureBlockCopy((APError*) error);
                            }
                        }
                    }] resume];
        } else {
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                if(!error) {
                    NSError *jsonError;
                    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                    if(!jsonError) {
                        APError *error = [APHelperMethods checkForErrorStatus:response];
                        
                        BOOL isErrorPresent = (error != nil);
                        
                        if (!isErrorPresent) {
                            currentUser = [[APUser alloc] initWithSchemaName:@"user"];
                            [currentUser setNewPropertyValuesFromDictionary:response];
                            [currentUser setLoggedInWithFacebook:YES];
                            if (successBlockCopy) {
                                successBlockCopy();
                            }
                        } else {
                            if (failureBlockCopy != nil) {
                                failureBlockCopy(error);
                            }
                        }
                    } else {
                        DLog(@"%@", jsonError);
                        if (failureBlockCopy != nil) {
                            failureBlockCopy((APError*) error);
                        }
                    }
                } else {
                    DLog(@"%@", error);
                    if (failureBlockCopy != nil) {
                        failureBlockCopy((APError*) error);
                    }
                }
            }];
        }
        
//        //Using MKNetworkKit
//        NSString *path = [USER_PATH stringByAppendingString:@"authenticate"];
//        
//        NSMutableDictionary *queryParams = [NSMutableDictionary dictionary];
//        [queryParams setObject:NSStringFromBOOL(sharedObject.enableDebugForEachRequest) forKey:@"debug"];
//        path = [path stringByAppendingQueryParameters:queryParams];
//        
//        MKNetworkOperation *op = [sharedObject
//                                  operationWithPath:path
//                                  params:@{@"createNew":@YES, @"type":@"twitter", @"oauthtoken":oauthToken, @"oauthtokensecret":oauthSecret}.mutableCopy
//                                  httpMethod:@"POST" ssl:YES];
//        op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
//        
//        [APHelperMethods addHeadersToMKNetworkOperation:op];
//        
//        [op onCompletion:^(MKNetworkOperation *completedOperation){
//            APError *error = [APHelperMethods checkForErrorStatus:completedOperation.responseJSON];
//            
//            BOOL isErrorPresent = (error != nil);
//            
//            if (!isErrorPresent) {
//                currentUser = [[APUser alloc] initWithSchemaName:@"user"];
//                [currentUser setNewPropertyValuesFromDictionary:completedOperation.responseJSON];
//                [currentUser setLoggedInWithTwitter:YES];
//                if (successBlockCopy) {
//                    successBlockCopy();
//                }
//            } else {
//                if (failureBlockCopy != nil) {
//                    failureBlockCopy(error);
//                }
//            }
//        } onError:^(NSError *error) {
//            if (failureBlockCopy != nil) {
//                failureBlockCopy((APError*)error);
//            }
//        }];
//        [sharedObject enqueueOperation:op];
        
    } else {
        DLog(@"Initialize the Appactive object with your API_KEY in the - application: didFinishLaunchingWithOptions: method of the AppDelegate");
        if (failureBlockCopy != nil) {
            failureBlockCopy([APHelperMethods errorForSessionNotCreated]);
        }
    }
}

+ (void) authenticateUserWithTwitter:(NSString *)oauthToken oauthSecret:(NSString *)oauthSecret consumerKey:(NSString*)consumerKey consumerSecret :(NSString*) consumerSecret successHandler:(APSuccessBlock)successBlock {
    [APUser authenticateUserWithTwitter:oauthToken oauthSecret:oauthSecret consumerKey:consumerKey consumerSecret:consumerSecret successHandler:successBlock failureHandler:nil];
}

+ (void) authenticateUserWithTwitter:(NSString *)oauthToken oauthSecret:(NSString *)oauthSecret consumerKey:(NSString*)consumerKey consumerSecret :(NSString*) consumerSecret successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    Appacitive *sharedObject = [Appacitive sharedObject];
    APFailureBlock failureBlockCopy = [failureBlock copy];
    
    if (sharedObject.session) {
        APSuccessBlock successBlockCopy = [successBlock copy];
        
        NSURL *url = [NSURL URLWithString:@"https://apis.appacitive.com/user/authenticate"];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       [Appacitive getApiKey], @"apikey",
                                       YES,@"createNew",
                                       @"twitter",@"type",
                                       oauthToken, @"oauthtoken",
                                       oauthSecret, @"oauthsecret",
                                       consumerKey, @"consumerKey",
                                       consumerSecret, @"consumerSecret",
                                       nil];
        
        if(NSClassFromString(@"NSURLSession")) {
            NSURLSessionConfiguration *sessionConfig =
            [NSURLSessionConfiguration defaultSessionConfiguration];
            sessionConfig.allowsCellularAccess = YES;
            [sessionConfig setHTTPAdditionalHeaders: params];
            sessionConfig.timeoutIntervalForRequest = 30.0;
            sessionConfig.timeoutIntervalForResource = 60.0;
            sessionConfig.HTTPMaximumConnectionsPerHost = 1;
            
            NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
            
            [[session dataTaskWithURL:url
                    completionHandler:^(NSData *data,
                                        NSURLResponse *response,
                                        NSError *error) {
                        if(!error) {
                            NSError *jsonError;
                            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                            if(!jsonError) {
                                APError *error = [APHelperMethods checkForErrorStatus:response];
                                
                                BOOL isErrorPresent = (error != nil);
                                
                                if (!isErrorPresent) {
                                    currentUser = [[APUser alloc] initWithSchemaName:@"user"];
                                    [currentUser setNewPropertyValuesFromDictionary:response];
                                    [currentUser setLoggedInWithFacebook:YES];
                                    if (successBlockCopy) {
                                        successBlockCopy();
                                    }
                                } else {
                                    if (failureBlockCopy != nil) {
                                        failureBlockCopy(error);
                                    }
                                }
                            } else {
                                DLog(@"%@", jsonError);
                                if (failureBlockCopy != nil) {
                                    failureBlockCopy((APError*) error);
                                }
                            }
                        } else {
                            DLog(@"%@", error);
                            if (failureBlockCopy != nil) {
                                failureBlockCopy((APError*) error);
                            }
                        }
                    }] resume];
        } else {
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                if(!error) {
                    NSError *jsonError;
                    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                    if(!jsonError) {
                        APError *error = [APHelperMethods checkForErrorStatus:response];
                        
                        BOOL isErrorPresent = (error != nil);
                        
                        if (!isErrorPresent) {
                            currentUser = [[APUser alloc] initWithSchemaName:@"user"];
                            [currentUser setNewPropertyValuesFromDictionary:response];
                            [currentUser setLoggedInWithFacebook:YES];
                            if (successBlockCopy) {
                                successBlockCopy();
                            }
                        } else {
                            if (failureBlockCopy != nil) {
                                failureBlockCopy(error);
                            }
                        }
                    } else {
                        DLog(@"%@", jsonError);
                        if (failureBlockCopy != nil) {
                            failureBlockCopy((APError*) error);
                        }
                    }
                } else {
                    DLog(@"%@", error);
                    if (failureBlockCopy != nil) {
                        failureBlockCopy((APError*) error);
                    }
                }
            }];
        }
        
        //Using MKNetworkKit
//        NSString *path = [USER_PATH stringByAppendingString:@"authenticate"];
//        
//        NSMutableDictionary *queryParams = [NSMutableDictionary dictionary];
//        [queryParams setObject:NSStringFromBOOL(sharedObject.enableDebugForEachRequest) forKey:@"debug"];
//        path = [path stringByAppendingQueryParameters:queryParams];
//        
//        MKNetworkOperation *op = [sharedObject
//                                  operationWithPath:path
//                                  params:@{@"createNew":@YES, @"type":@"twitter", @"oauthtoken":oauthToken, @"oauthtokensecret":oauthSecret,
//                                            @"consumerKey":consumerKey, @"consumerSecret":consumerSecret}.mutableCopy
//                                  httpMethod:@"POST" ssl:YES];
//        op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
//        
//        [APHelperMethods addHeadersToMKNetworkOperation:op];
//        
//        [op onCompletion:^(MKNetworkOperation *completedOperation){
//            APError *error = [APHelperMethods checkForErrorStatus:completedOperation.responseJSON];
//            
//            BOOL isErrorPresent = (error != nil);
//            
//            if (!isErrorPresent) {
//                currentUser = [[APUser alloc] initWithSchemaName:@"user"];
//                [currentUser setNewPropertyValuesFromDictionary:completedOperation.responseJSON];
//                [currentUser setLoggedInWithTwitter:YES];
//                if (successBlockCopy) {
//                    successBlockCopy();
//                }
//            } else {
//                if (failureBlockCopy != nil) {
//                    failureBlockCopy(error);
//                }
//            }
//        } onError:^(NSError *error) {
//            if (failureBlockCopy != nil) {
//                failureBlockCopy((APError*)error);
//            }
//        }];
//        [sharedObject enqueueOperation:op];
        
    } else {
        DLog(@"Initialize the Appactive object with your API_KEY in the - application: didFinishLaunchingWithOptions: method of the AppDelegate");
        if (failureBlockCopy != nil) {
            failureBlockCopy([APHelperMethods errorForSessionNotCreated]);
        }
    }
}

#pragma mark Create methods

+ (void) createUserWithDetails:(APUserDetails *)userDetails successHandler:(APUserSuccessBlock) successBlock {
    [APUser createUserWithDetails:userDetails successHandler:successBlock failuderHandler:nil];
}

+ (void) createUserWithDetails:(APUserDetails *)userDetails successHandler:(APUserSuccessBlock) successBlock failuderHandler:(APFailureBlock) failureBlock {
    
    Appacitive *sharedObject = [Appacitive sharedObject];
    APFailureBlock failureBlockCopy = [failureBlock copy];
    
    if (sharedObject.session) {
        APUserSuccessBlock successBlockCopy = [successBlock copy];
        
        NSURL *url = [NSURL URLWithString:@"https://apis.appacitive.com/user/create"];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       [Appacitive getApiKey], @"apikey",
                                       NSStringFromBOOL(sharedObject.enableDebugForEachRequest), @"debug",
                                       nil];
        
        if(NSClassFromString(@"NSURLSession")) {
            NSURLSessionConfiguration *sessionConfig =
            [NSURLSessionConfiguration defaultSessionConfiguration];
            sessionConfig.allowsCellularAccess = YES;
            [sessionConfig setHTTPAdditionalHeaders: params];
            sessionConfig.timeoutIntervalForRequest = 30.0;
            sessionConfig.timeoutIntervalForResource = 60.0;
            sessionConfig.HTTPMaximumConnectionsPerHost = 1;
            
            NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
            
            [[session dataTaskWithURL:url
                    completionHandler:^(NSData *data,
                                        NSURLResponse *response,
                                        NSError *error) {
                        if(!error) {
                            NSError *jsonError;
                            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                            if(!jsonError) {
                                APError *error = [APHelperMethods checkForErrorStatus:response];
                                
                                BOOL isErrorPresent = (error != nil);
                                
                                if (!isErrorPresent) {
                                    APUser *user = [[APUser alloc] initWithSchemaName:@"user"];
                                    [user setNewPropertyValuesFromDictionary:response];
                                    if (successBlockCopy) {
                                        successBlockCopy(user);
                                    }
                                } else {
                                    if (failureBlockCopy != nil) {
                                        failureBlockCopy(error);
                                    }
                                }
                            } else {
                                DLog(@"%@", jsonError);
                                if (failureBlockCopy != nil) {
                                    failureBlockCopy((APError*) error);
                                }
                            }
                        } else {
                            DLog(@"%@", error);
                            if (failureBlockCopy != nil) {
                                failureBlockCopy((APError*) error);
                            }
                        }
                    }] resume];
        } else {
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                if(!error) {
                    NSError *jsonError;
                    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                    if(!jsonError) {
                        APError *error = [APHelperMethods checkForErrorStatus:response];
                        
                        BOOL isErrorPresent = (error != nil);
                        
                        if (!isErrorPresent) {
                            APUser *user = [[APUser alloc] initWithSchemaName:@"user"];
                            [user setNewPropertyValuesFromDictionary:response];
                            if (successBlockCopy) {
                                successBlockCopy(user);
                            }
                        } else {
                            if (failureBlockCopy != nil) {
                                failureBlockCopy(error);
                            }
                        }
                    } else {
                        DLog(@"%@", jsonError);
                        if (failureBlockCopy != nil) {
                            failureBlockCopy((APError*) error);
                        }
                    }
                } else {
                    DLog(@"%@", error);
                    if (failureBlockCopy != nil) {
                        failureBlockCopy((APError*) error);
                    }
                }
            }];
        }
        
//        //UsingMKNetworkKit
//        NSString *path = [USER_PATH stringByAppendingString:@"create"];
//        
//        NSMutableDictionary *queryParams = [NSMutableDictionary dictionary];
//        [queryParams setObject:NSStringFromBOOL(sharedObject.enableDebugForEachRequest) forKey:@"debug"];
//        path = [path stringByAppendingQueryParameters:queryParams];
//        
//        MKNetworkOperation *op = [sharedObject operationWithPath:path params:[userDetails createParameters] httpMethod:@"PUT" ssl:YES];
//        op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
//        
//        [APHelperMethods addHeadersToMKNetworkOperation:op];
//        
//        [op onCompletion:^(MKNetworkOperation *completedOperation){
//            APError *error = [APHelperMethods checkForErrorStatus:completedOperation.responseJSON];
//            
//            BOOL isErrorPresent = (error != nil);
//            
//            if (!isErrorPresent) {
//                APUser *user = [[APUser alloc] initWithSchemaName:@"user"];
//                [user setNewPropertyValuesFromDictionary:completedOperation.responseJSON];
//                if (successBlockCopy) {
//                    successBlockCopy(user);
//                }
//            } else {
//                if (failureBlockCopy != nil) {
//                    failureBlockCopy(error);
//                }
//            }
//        } onError:^(NSError *error) {
//            if (failureBlockCopy != nil) {
//                failureBlockCopy((APError*)error);
//            }
//        }];
//        [sharedObject enqueueOperation:op];
        
    } else {
        DLog(@"Initialize the Appactive object with your API_KEY in the - application: didFinishLaunchingWithOptions: method of the AppDelegate");
        if (failureBlockCopy != nil) {
            failureBlockCopy([APHelperMethods errorForSessionNotCreated]);
        }
    }
}

#pragma mark private methods

- (void) setLoggedInWithFacebook:(BOOL)loggedInWithFacebook {
    _loggedInWithFacebook = YES;
}

- (void) setLoggedInWithTwitter:(BOOL)loggedInWithTwitter {
    _loggedInWithTwitter = YES;
}

- (void) setNewPropertyValuesFromDictionary:(NSDictionary*) dictionary {
    _userToken = dictionary[@"token"];
    
    NSDictionary *user = dictionary[@"user"];
    self.createdBy = (NSString*) user[@"__createdby"];
    self.objectId = (NSNumber*) user[@"__id"];
    _lastModifiedBy = (NSString*) user[@"__lastmodifiedby"];
    _revision = (NSNumber*) user[@"__revision"];
    self.schemaId = (NSNumber*) user[@"__schemaid"];
    _utcDateCreated = [APHelperMethods deserializeJsonDateString:user[@"__utcdatecreated"]];
    _utcLastUpdatedDate = [APHelperMethods deserializeJsonDateString:user[@"__utclastupdateddate"]];
    _attributes = user[@"__attributes"];
    self.tags = user[@"__tags"];
    self.schemaType = user[@"__schematype"];
    
    _properties = [APHelperMethods arrayOfPropertiesFromJSONResponse:user].mutableCopy;
}

- (NSString*) description {
    return [NSString stringWithFormat:@"User Token: %@, Object Id:%lld, Created by:%@, Last modified by:%@, UTC date created:%@, UTC date updated:%@, Revision:%d, Properties:%@, Attributes:%@, SchemaId:%d, SchemaType:%@, Tag:%@",_userToken, [self.objectId longLongValue], self.createdBy, self.lastModifiedBy, self.utcDateCreated, self.utcLastUpdatedDate, [self.revision intValue], self.properties, self.attributes, [self.schemaId intValue], self.schemaType, self.tags];
}
@end
