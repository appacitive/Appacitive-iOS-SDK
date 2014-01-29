//
//  APDevice.m
//  Appacitive-iOS-SDK
//
//  Created by Pratik on 23-12-13.
//  Copyright (c) 2013 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import "APDevice.h"
#import "APHelperMethods.h"
#import "NSString+APString.h"
#import "APNetworking.h"
#import "Appacitive.h"
#import "APConstants.h"
#import "APUser.h"

#define DEVICE_PATH @"v1.0/device/"

@implementation APDevice
static NSDictionary* headerParams;

+ (NSDictionary*)getHeaderParams
{
    headerParams = [NSDictionary dictionaryWithObjectsAndKeys:
                    [Appacitive getApiKey], APIkeyHeaderKey,
                    [Appacitive environmentToUse], EnvironmentHeaderKey,
                    [APUser currentUser].userToken, UserAuthHeaderKey,
                    @"application/json", @"Content-Type",
                    nil];
    return headerParams;
}

#pragma mark - Initialization methods
- (instancetype) init {
    return self = [super initWithTypeName:@"device"];
}

- (instancetype)initWithDeviceToken:(NSString *)deviceToken deviceType:(NSString *)deviceType {
    self = [super initWithTypeName:@"device"];
    if(deviceToken != nil && deviceType != nil) {
        self.deviceType = deviceType;
        self.deviceToken = deviceToken;
        self.type = @"device";
    }
    return self;
}

#pragma mark - Register methods
- (void) registerDevice {
    [self registerDeviceWithSuccessHandler:nil failureHandler:nil];
}

- (void) registerDeviceWithFailureHandler:(APFailureBlock)failureBlock {
    [self registerDeviceWithSuccessHandler:nil failureHandler:failureBlock];
}

- (void) registerDeviceWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    NSString *path = HOST_NAME;
    path = [path stringByAppendingPathComponent:DEVICE_PATH];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/register",path]];
    NSMutableDictionary *bodyDict = [self postParameters];
    [bodyDict addEntriesFromDictionary:[self createRequestBody]];
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:bodyDict options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        DLog(@"\n––––––––––JSON-ERROR–––––––––\n%@",jsonError);
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPBody:requestBody];
    [urlRequest setAllHTTPHeaderFields:[APDevice getHeaderParams]];
    [urlRequest setHTTPMethod:@"PUT"];
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            [self setPropertyValuesFromDictionary:result];
            successBlock();
        }
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
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
    [self registerDeviceWithSuccessHandler:successBlock failureHandler:failureBlock];
}

#pragma mark - Fetch methods
- (void) fetch {
    [self fetchWithQueryString:nil successHandler:nil failureHandler:nil];
}

- (void) fetchWithFailureHandler:(APFailureBlock)failureBlock {
    [self fetchWithQueryString:nil successHandler:nil failureHandler:failureBlock];
}

- (void) fetchWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    [self fetchWithQueryString:nil successHandler:successBlock failureHandler:failureBlock];
}

- (void) fetchWithQueryString:(NSString*)queryString successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    NSString *path = [DEVICE_PATH stringByAppendingFormat:@"%@", self.objectId];
    NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
    if (queryString) {
        NSDictionary *queryStringParams = [queryString queryParameters];
        [queryStringParams enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
            [queryParams setObject:obj forKey:key];
        }];
    }
    path = [path stringByAppendingQueryParameters:queryParams];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        [self setPropertyValuesFromDictionary:result];
        if (successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
        if(failureBlock != nil) {
            failureBlock(error);
        }
    }];
    
}

#pragma mark - Update methods
- (void) updateObject {
    [self updateObjectWithRevisionNumber:nil successHandler:nil failureHandler:nil];
}

- (void) updateObjectWithFailureHandler:(APFailureBlock)failureBlock {
    [self updateObjectWithRevisionNumber:nil successHandler:nil failureHandler:failureBlock];
}

- (void) updateObjectWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    [self updateObjectWithRevisionNumber:nil successHandler:successBlock failureHandler:failureBlock];
}

- (void) updateObjectWithRevisionNumber:(NSNumber*)revision successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    NSString *path = [[NSString alloc] init];
    if(revision != nil)
        path = [DEVICE_PATH stringByAppendingFormat:@"%@?revision=%@", self.objectId,revision];
    else
        path = [DEVICE_PATH stringByAppendingFormat:@"%@", self.objectId];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[self postParametersUpdate] options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        DLog(@"\n––––––––––JSON-ERROR–––––––––\n%@",jsonError);
    [urlRequest setHTTPBody:requestBody];
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        [self setPropertyValuesFromDictionary:result];
        
        if(successBlock != nil) {
            [self setPropertyValuesFromDictionary:result];
            successBlock(self);
        }
    } failureHandler:^(APError *error) {
        
        if(failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

#pragma mark - Delete methods
- (void) deleteObject {
    [self deleteObjectWithSuccessHandler:nil failureHandler:nil];
}

- (void) deleteObjectWithFailureHandler:(APFailureBlock)failureBlock {
    [self deleteObjectWithSuccessHandler:nil failureHandler:failureBlock deleteConnectingConnections:NO];
}

- (void) deleteObjectWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    [self deleteObjectWithSuccessHandler:successBlock failureHandler:failureBlock deleteConnectingConnections:NO];
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
    path = [DEVICE_PATH stringByAppendingFormat:@"%@",self.objectId];
    NSDictionary *queryParams = @{@"deleteconnections":deleteConnections?@"true":@"false"};
    path = [path stringByAppendingQueryParameters:queryParams];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"DELETE"];
    [urlRequest setAllHTTPHeaderFields:[APDevice getHeaderParams]];
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        if(successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
        if(failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

#pragma mark - Private methods
- (NSMutableDictionary*) createRequestBody {
    NSMutableDictionary *requestBody = [[NSMutableDictionary alloc] init];
    if (self.deviceToken)
        [requestBody setObject:self.deviceToken forKey:@"devicetoken"];
    if(self.deviceType)
        [requestBody setObject:self.deviceType forKey:@"devicetype"];
    if(self.deviceLocation)
        [requestBody setObject:self.deviceLocation forKey:@"location"];
    if(self.channels)
        [requestBody setObject:self.channels forKey:@"channels"];
    if(self.timeZone)
        [requestBody setObject:self.timeZone forKey:@"timezone"];
    if(self.isAvctive)
        [requestBody setObject:self.isAvctive forKey:@"isactive"];
    return requestBody;
}

- (void) setPropertyValuesFromDictionary:(NSDictionary*) dictionary {
    
    NSDictionary *object = [[NSDictionary alloc] init];
    if([[dictionary allKeys] containsObject:@"device"])
        object = dictionary[@"device"];
    else object = dictionary;
    _deviceToken = object[@"devicetoken"];
    self.deviceLocation = object[@"location"];
    self.deviceType = object[@"devicetype"];
    self.isAvctive = object[@"isactive"];
    self.channels = object[@"channels"];
    self.badge = object[@"badge"];
    self.createdBy = (NSString*) object[@"__createdby"];
    _objectId = object[@"__id"];
    _lastModifiedBy = (NSString*) object[@"__lastmodifiedby"];
    _revision = (NSNumber*) object[@"__revision"];
    self.typeId = object[@"__typeid"];
    _utcDateCreated = [APHelperMethods deserializeJsonDateString:object[@"__utcdatecreated"]];
    _utcLastUpdatedDate = [APHelperMethods deserializeJsonDateString:object[@"__utclastupdateddate"]];
    _attributes = [object[@"__attributes"] mutableCopy];
    self.tags = object[@"__tags"];
    self.type = object[@"__type"];
    _properties = [APHelperMethods arrayOfPropertiesFromJSONResponse:object].mutableCopy;
}

- (NSMutableDictionary*) postParameters {
    NSMutableDictionary *postParams = [NSMutableDictionary dictionary];
    if (self.objectId)
        postParams[@"__id"] = self.objectId;
    if (self.attributes)
        postParams[@"__attributes"] = self.attributes;
    if (self.createdBy)
        postParams[@"__createdby"] = self.createdBy;
    if (self.revision)
        postParams[@"__revision"] = self.revision;
    if (self.type)
        postParams[@"__type"] = self.type;
    if (self.tags)
        postParams[@"__tags"] = self.tags;
    for(NSDictionary *prop in self.properties) {
        [prop enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
            [postParams setObject:obj forKey:key];
            *stop = YES;
        }];
    }
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
    if (self.deviceLocation != nil)
        postParams[@"devicelocation"] = self.deviceLocation;
    if (self.deviceToken != nil)
        postParams[@"devicetoken"] = self.deviceToken;
    if (self.deviceType != nil)
        postParams[@"devicetype"] = self.deviceType;
    if(self.channels != nil && [self.channels count] >0)
        postParams[@"channels"] = self.channels;
    if (self.tagsToAdd != nil && [self.tagsToAdd count] > 0)
        postParams[@"__addtags"] = [self.tagsToAdd allObjects];
    if (self.tagsToRemove !=nil && [self.tagsToRemove count] > 0)
        postParams[@"__removetags"] = [self.tagsToRemove allObjects];
    if (self.timeZone != nil)
        postParams[@"timezone"] = self.timeZone;
    if(self.isAvctive != nil)
        postParams[@"isactive"] = self.isAvctive;
    return postParams;
}

@end

