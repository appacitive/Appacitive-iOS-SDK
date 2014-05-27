//
//  APNetworking.m
//  Appacitive-iOS-SDK
//
//  Created by Pratik on 31-12-13.
//  Copyright (c) 2013 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import "APNetworking.h"
#import "Appacitive.h"
#import "APConstants.h"
#import "APHelperMethods.h"
#import "APLogger.h"

@implementation APNetworking

static NSURLSession *sharedNSURLSession = nil;
static NSMutableDictionary *headerParams = nil;
static NSMutableDictionary *additionalHeaders = nil;

+ (void)addHTTPHeaderValue:(NSString*)value forKey:(NSString*)key {
    if(additionalHeaders == nil)
        additionalHeaders = [[NSMutableDictionary alloc] init];
    [additionalHeaders addEntriesFromDictionary:@{key:value}];
}

+ (void)resetDefaultHTTPHeaders {
    additionalHeaders = nil;
}

+ (NSURLSession*)getSharedNSURLSession {
    if(sharedNSURLSession != nil)
        return sharedNSURLSession;
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    headerParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                    [Appacitive getApiKey], APIkeyHeaderKey,
                    [Appacitive getCurrentEnvironment], EnvironmentHeaderKey,
                    @"application/json", @"Content-Type",
                    nil];
    sessionConfig.HTTPAdditionalHeaders = headerParams;
    sessionConfig.allowsCellularAccess = YES;
    sessionConfig.timeoutIntervalForRequest = 30.0;
    sessionConfig.timeoutIntervalForResource = 60.0;
    sharedNSURLSession = [NSURLSession sessionWithConfiguration:sessionConfig];
    return sharedNSURLSession;
}

+ (void) makeAsyncURLRequest:(NSMutableURLRequest*)urlRequest callingSelector:(const char*)callingSelector successHandler:(APResultSuccessBlock)requestSuccessBlock failureHandler:(APFailureBlock)requestFailureBlock {
    
    if(additionalHeaders != nil) {
        if(urlRequest.allHTTPHeaderFields != nil) {
            NSMutableDictionary *requestHeaders = [urlRequest.allHTTPHeaderFields mutableCopy];
            [requestHeaders addEntriesFromDictionary:additionalHeaders];
            [urlRequest setAllHTTPHeaderFields:requestHeaders];
        }
    }
    
    [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––––––––––––APPACITIVE–DEBUG-LOG–––––––––––––––––––– \nMETHOD: %s \nURL: %@ \nREQUEST HEADERS: %@ \nREQUEST DATA:%@ \n––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––", callingSelector, [urlRequest.URL description], [urlRequest.allHTTPHeaderFields description], urlRequest.HTTPBody ? [[NSJSONSerialization JSONObjectWithData:urlRequest.HTTPBody options:kNilOptions error:nil] description] : nil ] withType:APMessageTypeDebug];
    
    if([[[UIDevice currentDevice] systemVersion] intValue] >= 7) {
        if(!sharedNSURLSession) {
            [APNetworking getSharedNSURLSession];
        }
        [[sharedNSURLSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
             if(!error) {
                 NSError *jsonError = nil;
                 NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                 if(!jsonError) {
                     APError *error = [APHelperMethods checkForErrorStatus:responseJSON];
                     BOOL isErrorPresent = (error != nil);
                     if (!isErrorPresent) {
                         if(requestSuccessBlock)
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––––––––––––APPACITIVE–DEBUG-LOG–––––––––––––––––––– \nMETHOD: %s \nURL: %@ \nHTTP RESPONSE: %@ \nRESPONSE DATA: %@ \n––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––", callingSelector, [urlRequest.URL description], [response description], [responseJSON description]] withType:APMessageTypeDebug];
                                 requestSuccessBlock(responseJSON);
                             });
                     } else {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––––––––––––APPACITIVE–ERROR-LOG–––––––––––––––––––– \nMETHOD: %s \nURL: %@ \nHTTP RESPONSE: %@ \nRESPONSE DATA: %@ \nERROR: %@ \n––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––", callingSelector, [urlRequest.URL description], [responseJSON description], [response description], error] withType:APMessageTypeError];
                             if(requestFailureBlock)
                                 requestFailureBlock(error);
                         });
                     }
                 } else {
                     NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse*)response;
                     if([urlResponse statusCode] > 200 || [urlResponse statusCode] < 300 ) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             APError *error = [APHelperMethods getErrorInfo:urlResponse];
                             [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––––––––––––APPACITIVE–ERROR-LOG–––––––––––––––––––– \nMETHOD: %s \nURL: %@ \nHTTP RESPONSE: %@ \nRESPONSE DATA: %@ \nERROR: %@ \n––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––", callingSelector, [urlRequest.URL description], [response description], [responseJSON description], error] withType:APMessageTypeError];
                             if (requestFailureBlock != nil)
                                 requestFailureBlock(error);
                         });
                     } else {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––––––––––––APPACITIVE–ERROR-LOG–––––––––––––––––––– \nMETHOD: %s \nURL: %@ \nHTTP RESPONSE: %@ \nRESPONSE DATA: %@ \nERROR: %@ \n––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––", callingSelector, [urlRequest.URL description], [response description], [responseJSON description], error] withType:APMessageTypeError];
                             if (requestFailureBlock != nil)
                                 requestFailureBlock((APError*)jsonError);
                         });
                     }
                 }
             } else {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––––––––––––APPACITIVE–ERROR-LOG–––––––––––––––––––– \nMETHOD: %s \nURL: %@ \nHTTP RESPONSE: %@ \nERROR:%@ \n––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––", callingSelector, [urlRequest.URL description], [response description], error] withType:APMessageTypeError];
                     if (requestFailureBlock != nil)
                         requestFailureBlock((APError*)error);
                 });
             }
         }]
         resume];
    } else {
        [urlRequest setValue:[Appacitive getApiKey] forHTTPHeaderField:APIkeyHeaderKey];
        [urlRequest setValue:[Appacitive getCurrentEnvironment] forHTTPHeaderField:EnvironmentHeaderKey];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if(!error) {
                NSError *jsonError = nil;
                NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                if(!jsonError) {
                    APError *error = [APHelperMethods checkForErrorStatus:responseJSON];
                    BOOL isErrorPresent = (error != nil);
                    if (!isErrorPresent) {
                        if(requestSuccessBlock)
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––––––––––––APPACITIVE–DEBUG-LOG–––––––––––––––––––– \nMETHOD: %s \nURL: %@ \nHTTP RESPONSE: %@ \nRESPONSE DATA: %@ \n––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––", callingSelector, [urlRequest.URL description], [response description], [responseJSON description]] withType:APMessageTypeDebug];
                                requestSuccessBlock(responseJSON);
                            });
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––––––––––––APPACITIVE–ERROR-LOG–––––––––––––––––––– \nMETHOD: %s \nURL: %@ \nHTTP RESPONSE: %@ \nRESPONSE DATA: %@ \nERROR: %@ \n––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––", callingSelector, [urlRequest.URL description], [responseJSON description], [response description], error] withType:APMessageTypeError];
                            if(requestFailureBlock)
                                requestFailureBlock(error);
                        });
                    }
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        APError *error = [APHelperMethods checkForErrorStatus:nil];
                        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––––––––––––APPACITIVE–ERROR-LOG–––––––––––––––––––– \nMETHOD: %s \nURL: %@ \nHTTP RESPONSE: %@ \nRESPONSE DATA: %@ \nERROR: %@ \n––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––", callingSelector, [urlRequest.URL description], [response description], [responseJSON description], error] withType:APMessageTypeError];
                        if (requestFailureBlock != nil)
                            requestFailureBlock(error);
                    });
                }
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––––––––––––APPACITIVE–ERROR-LOG––––––––––––––––––––\nMETHOD: %s \nURL: %@ \nHTTP RESPONSE: %@ \nERROR:%@ \n––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––", callingSelector, [urlRequest.URL description], [response description], error] withType:APMessageTypeError];
                    if (requestFailureBlock != nil)
                        requestFailureBlock((APError*)error);
                });
            }
        }];
    }
}

@end
