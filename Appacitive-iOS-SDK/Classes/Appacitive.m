//
//  Appacitive.m
//  Appacitive-iOS-SDK
//
//  Created by Kauserali Hafizji on 29/08/12.
//  Copyright (c) 2012 Appacitive Software Pvt. All rights reserved.
//

#import "Appacitive.h"
#import "APConstants.h"
//#define HOST_NAME @"apis.appacitive.com"

NSString *const SessionReceivedNotification = @"SessionReceivedNotification";
NSString *const ErrorRetrievingSessionNotification = @"ErrorRetrievingSessionNotification";

@interface Appacitive() {
    
}
@end

static Appacitive *sharedObject = nil;
static NSString* _apiKey;

@implementation Appacitive

+ (id) appacitiveWithApiKey:(NSString*)apiKey {
    if (apiKey != nil && ![apiKey isEqualToString:@""]) {
        @synchronized(self) {
            if (sharedObject == nil) {
                sharedObject = [[Appacitive alloc] initWithApiKey:apiKey];
            }
        }
    }
    return sharedObject;
}

+ (NSString*) getApiKey
{
    return _apiKey;
}

+ (id) sharedObject {
    return sharedObject;
}

+ (void) setSharedObject:(Appacitive *)object {
    sharedObject = object;
}

- (id) initWithApiKey:(NSString*)apiKey {
//    self = [super initWithHostName:HOST_NAME];
    if (self) {
        _apiKey = apiKey;
        [self fetchSession];
        _enableLiveEnvironment = NO;
    }
    return self;
}

- (void) fetchSession {
    NSURL *url = [NSURL URLWithString:@"https://apis.appacitive.com/application/session"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   _apiKey, @"apikey",
                                   @NO, @"isnonsliding",
                                   @-1, @"usagecount",
                                   @60, @"windowtime",
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
                        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                        if(!jsonError) {
                            NSDictionary *session = dictionary[@"session"];
                            _session = session[@"sessionkey"];
                            [[NSNotificationCenter defaultCenter] postNotificationName:SessionReceivedNotification object:self];
                        } else {
                            DLog(@"%@", jsonError);
                            [[NSNotificationCenter defaultCenter] postNotificationName:ErrorRetrievingSessionNotification object:self];
                        }
                } else {
                    DLog(@"%@", error);
                    [[NSNotificationCenter defaultCenter] postNotificationName:ErrorRetrievingSessionNotification object:self];
            }
        }] resume];
    } else {
        
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if(!error) {
                NSError *jsonError;
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                if(!jsonError) {
                    NSDictionary *session = dictionary[@"session"];
                    _session = session[@"sessionkey"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:SessionReceivedNotification object:self];
                } else {
                    DLog(@"%@", jsonError);
                    [[NSNotificationCenter defaultCenter] postNotificationName:ErrorRetrievingSessionNotification object:self];
                }
            } else {
                DLog(@"%@", error);
                [[NSNotificationCenter defaultCenter] postNotificationName:ErrorRetrievingSessionNotification object:self];
            }
        }];
    }
    
//    //MKNetworkKit
//    MKNetworkOperation *op = [self operationWithPath:@"application/session"
//                                              params:params
//                                              httpMethod:@"PUT" ssl:YES];
//    op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
//    [op onCompletion:^(MKNetworkOperation *completedOperation){
//        
//        NSDictionary *dictionary = (NSDictionary*) completedOperation.responseJSON;
//        NSDictionary *session = dictionary[@"session"];
//        _session = session[@"sessionkey"];
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:SessionReceivedNotification object:self];
//    } onError:^(NSError *error){
//        DLog(@"%@", error);
//        [[NSNotificationCenter defaultCenter] postNotificationName:ErrorRetrievingSessionNotification object:self];
//    }];
//    [self enqueueOperation:op];
}

- (NSString*) environmentToUse {
    if (_enableLiveEnvironment) {
        return @"live";
    }
    return @"sandbox";
}
@end
