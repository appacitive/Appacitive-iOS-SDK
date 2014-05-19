//
//  APFile.m
//  Appacitive-iOS-SDK
//
//  Created by Kauserali Hafizji on 10/09/12.
//  Copyright (c) 2012 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import "APFile.h"
#import "Appacitive.h"
#import "APHelperMethods.h"
#import "APError.h"
#import "APConstants.h"
#import "APNetworking.h"
#import "APLogger.h"

#define FILE_PATH @"file/"

@implementation APFile

#pragma mark - Uplaod file methods

+ (void) getUploadURLForFileWithName:(NSString *)name urlExpiresAfter:(NSNumber *)minutes contentType:(NSString*)contentType successHandler:(APURLSuccessBlock)successBlock {
    [self getUploadURLForFileWithName:name urlExpiresAfter:minutes contentType:contentType successHandler:successBlock failureHandler:nil];
}

+ (void) getUploadURLForFileWithName:(NSString *)name urlExpiresAfter:(NSNumber *)minutes contentType:(NSString*)contentType successHandler:(APURLSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [HOST_NAME stringByAppendingString:FILE_PATH];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@uploadurl?contenttype=%@&filename=%@&expires=%@",path,contentType,name,minutes]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    urlRequest.HTTPMethod = @"GET";
    
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        NSURL *fileUploadURL = [NSURL URLWithString:[result objectForKey:@"url"]];
        if(successBlock != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                successBlock(fileUploadURL);
            });
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failureBlock(error);
            });
        }
    }];
}

+ (void) uploadFileWithName:(NSString *)name data:(NSData *)fileData urlExpiresAfter:(NSNumber *)minutes {
    [self uploadFileWithName:name data:fileData urlExpiresAfter:minutes contentType:nil successHandler:nil failureHandler:nil];
}

+ (void) uploadFileWithName:(NSString *)name data:(NSData *)fileData urlExpiresAfter:(NSNumber *)minutes contentType:(NSString *)contentType {
    [self uploadFileWithName:name data:fileData urlExpiresAfter:minutes contentType:contentType successHandler:nil failureHandler:nil];
}

+ (void) uploadFileWithName:(NSString *)name data:(NSData *)fileData urlExpiresAfter:(NSNumber *)minutes contentType:(NSString *)contentType successHandler:(APResultSuccessBlock)successBlock {
    [self uploadFileWithName:name data:fileData urlExpiresAfter:minutes contentType:contentType successHandler:successBlock failureHandler:nil];
}

+ (void) uploadFileWithName:(NSString *)name data:(NSData *)fileData urlExpiresAfter:(NSNumber *)minutes contentType:(NSString *)contentType successHandler:(APResultSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    NSString *path = [HOST_NAME stringByAppendingString:FILE_PATH];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@uploadurl?contenttype=%@&filename=%@&expires=%@",path,contentType,name,minutes]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    urlRequest.HTTPMethod = @"GET";
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        NSDictionary *fetchUploadUrlResponse = result;
        NSURL *fileUploadURL = [NSURL URLWithString:[fetchUploadUrlResponse objectForKey:@"url"]];
        NSMutableURLRequest *fileUploadRequest = [NSMutableURLRequest requestWithURL:fileUploadURL];
        [fileUploadRequest setHTTPMethod:@"PUT"];
        NSString *stringContentType = @"application/octet-stream";
        if (contentType) {
            stringContentType = contentType;
        }
        [fileUploadRequest addValue:stringContentType forHTTPHeaderField: @"Content-Type"];
        NSMutableData *body = [NSMutableData data];
        [body appendData:[NSData dataWithData:fileData]];
        [fileUploadRequest setHTTPBody:body];
        
        if([[[UIDevice currentDevice] systemVersion] intValue] >=7 ) {
            NSURLSession *urlSession = [APNetworking getSharedNSURLSession];
            [[urlSession uploadTaskWithRequest:fileUploadRequest fromData:body completionHandler:^(NSData *data, NSURLResponse *res, NSError *error) {
                NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)res;
                if ([httpResponse statusCode] == 200 && successBlock != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        successBlock(responseJSON);
                    });
                }
                if(error!=nil) {
                    [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––––ERROR––––––––––––\n%@", error] withType:APMessageTypeError];
                    if (failureBlock != nil) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            failureBlock((APError*)error);
                        });
                    }
                }
            }] resume];
        } else {
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            [NSURLConnection sendAsynchronousRequest:fileUploadRequest queue:queue completionHandler:^(NSURLResponse *res, NSData *data, NSError *connectionError) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)res;
                if([httpResponse statusCode] == 200 && successBlock != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        successBlock(result);
                    });
                }
                if(connectionError!=nil) {
                    [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––––ERROR––––––––––––\n%@", [connectionError description]] withType:APMessageTypeError];
                    if (failureBlock != nil) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            failureBlock((APError*)connectionError);
                        });
                    }
                }
            }];
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failureBlock(error);
            });
        }
    }];
}

#pragma mark - Download file methods

+ (void) getDownloadURLForFileWithName:(NSString *)name urlExpiresAfter:(NSNumber*)minutes successHandler:(APURLSuccessBlock)successBlock {
    [self getDownloadURLForFileWithName:name urlExpiresAfter:minutes successHandler:successBlock failureHandler:nil];
}

+ (void) getDownloadURLForFileWithName:(NSString *)name urlExpiresAfter:(NSNumber*)minutes successHandler:(APURLSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    NSString *path = [HOST_NAME stringByAppendingString:FILE_PATH];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@download/%@?expires=%@",path,name,minutes]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        NSString *uri = [result objectForKey:@"uri"];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(successBlock != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    successBlock([NSURL URLWithString:uri]);
                });
            }
        });
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failureBlock((APError*)error);
            });
        }
    }];
}

+ (void) downloadFileWithName:(NSString*)name urlExpiresAfter:(NSNumber*)minutes successHandler:(APFileDownloadSuccessBlock) successBlock {
    [self downloadFileWithName:name urlExpiresAfter:minutes successHandler:successBlock failureHandler:nil];
}


+ (void) downloadFileWithName:(NSString*)name urlExpiresAfter:(NSNumber*)minutes successHandler:(APFileDownloadSuccessBlock) successBlock failureHandler:(APFailureBlock)failureBlock {
    NSString *path = [HOST_NAME stringByAppendingString:FILE_PATH];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@download/%@?expires=%@",path,name,minutes]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        NSMutableURLRequest *fileDownloadRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[result objectForKey:@"uri"]]];
        NSUInteger cacheSizeMemory = 250*1024*1024;
        NSUInteger cacheSizeDisk = 250*1024*1024;
        NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"];
        [NSURLCache setSharedURLCache:sharedCache];
        [fileDownloadRequest setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
        [fileDownloadRequest setHTTPMethod:@"GET"];
        
        if([[[UIDevice currentDevice] systemVersion] intValue] >=7 ) {
            NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
            sessionConfig.allowsCellularAccess = YES;
            sessionConfig.timeoutIntervalForRequest = 30.0;
            sessionConfig.timeoutIntervalForResource = 60.0;
            sessionConfig.URLCache = [NSURLCache sharedURLCache];
            sessionConfig.requestCachePolicy = NSURLRequestReturnCacheDataElseLoad;
            NSURLSession *downloadSession = [NSURLSession sessionWithConfiguration:sessionConfig];
            [[downloadSession dataTaskWithRequest:fileDownloadRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                if(!error) {
                    if (successBlock != nil) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            successBlock(data);
                        });
                    }
                } else {
                    [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––––ERROR––––––––––––\n%@", [error description]] withType:APMessageTypeError];
                    if (failureBlock != nil) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            failureBlock((APError*)error);
                        });
                    }
                }
            }] resume];
        } else {
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            [NSURLConnection sendAsynchronousRequest:fileDownloadRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                if(!error) {
                    if (successBlock != nil) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            successBlock(data);
                        });
                    }
                }
                else {
                    [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––––ERROR––––––––––––\n%@", [error description]] withType:APMessageTypeError];
                    if (failureBlock != nil) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            failureBlock((APError*)error);
                        });
                    }
                }
            }];
        }
    } failureHandler:^(APError *error) {
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––––ERROR––––––––––––\n%@", [error description]] withType:APMessageTypeError];
        if (failureBlock != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failureBlock((APError*)error);
            });
        }
    }];
}

#pragma mark - delete file methods

+ (void) deleteFileWithName:(NSString *)name {
    [self deleteFileWithName:name successHandler:nil failureHandler:nil];
}

+ (void) deleteFileWithName:(NSString *)name successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://apis.appacitive.com/delete/%@",name]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            successBlock(result);
        }
    } failureHandler:^(APError *error) {
		[[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––––ERROR––––––––––––\n%@", [error description]] withType:APMessageTypeError];
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

@end
