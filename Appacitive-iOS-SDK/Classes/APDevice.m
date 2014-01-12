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
#define PUSH_PATH @"v1.0/push/"

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

- (instancetype)initWithDeviceToken:(NSString *)deviceToken deviceType:(NSString *)deviceType {
    if(deviceToken != nil && deviceType != nil) {
        self.deviceType = deviceType;
        self.deviceToken = deviceToken;
    }
    return self;
}

- (void) registerDevice
{
    [self registerDeviceWithSuccessHandler:nil failureHandler:nil];
}

- (void) registerDeviceWithSuccessHandler:(APDeviceSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
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
            APDevice *device = [[APDevice alloc] init];
            [device setPropertyValuesFromDictionary:result];
            successBlock(device);
        }
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

- (void) deleteDevice {
    [self deleteDeviceWithSuccessHandler:nil failureHandler:nil];
}

- (void) deleteDeviceWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    [self deleteDeviceWithSuccessHandler:successBlock failureHandler:failureBlock deleteConnectingConnections:NO];
}
- (void) deleteDeviceWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock deleteConnectingConnections:(BOOL)deleteConnections {
    
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

#pragma mark update methods

- (void) updateDevice {
    [self updateDeviceWithSuccessHandler:nil failureHandler:nil];
}


- (void) updateDeviceWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [DEVICE_PATH stringByAppendingFormat:@"%@/%@", self.type, self.objectId.description];
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
            successBlock(result);
        }
    } failureHandler:^(APError *error) {
        if(failureBlock != nil) {
            failureBlock(error);
        }
    }];
    
}

#pragma mark fetch methods

- (void) fetchDevice {
    [self fetchDeviceWithSuccessHandler:nil failureHandler:nil];
}


- (void) fetchDeviceWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [DEVICE_PATH stringByAppendingFormat:@"%@/%@", self.type, self.objectId];
    
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


- (NSMutableDictionary*) createRequestBody
{
    NSMutableDictionary *requestBody = [[NSMutableDictionary alloc] init];
    
    if (self.deviceToken) {
        [requestBody setObject:self.deviceToken forKey:@"devicetoken"];
    }
    
    if(self.deviceType) {
        [requestBody setObject:self.deviceType forKey:@"devicetype"];
    }
    
    if(self.deviceLocation) {
        [requestBody setObject:self.deviceLocation forKey:@"location"];
    }
    
    if(self.channels) {
        [requestBody setObject:self.channels forKey:@"channels"];
    }
    
    if(self.timeZone) {
        [requestBody setObject:self.timeZone forKey:@"timezone"];
    }
    
    if(self.isAvctive) {
        [requestBody setObject:self.isAvctive forKey:@"isactive"];
    }
    
    return requestBody;
}

#pragma mark private methods

- (void) setPropertyValuesFromDictionary:(NSDictionary*) dictionary {
    
    NSDictionary *object = [[NSDictionary alloc] init];
    if([[dictionary allKeys] containsObject:@"device"])
        object = dictionary[@"device"];
    else
        object = dictionary;
    _deviceToken = object[@"devicetoken"];
    self.deviceLocation = object[@"location"];
    self.deviceType = object[@"devicetype"];
    self.isAvctive = object[@"isactive"];
    self.channels = object[@"channels"];
    
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





#pragma mark - APPushNotification Interface

@implementation APPushNotification

- (instancetype) initWithMessage:(NSString*)message {
    if(message != nil) {
        _message = message;
        return self;
    }
    return nil;
}

- (void) sendPush {
    [self sendPushWithSuccessHandler:nil failureHandler:nil];
}

- (void) sendPushWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [HOST_NAME stringByAppendingPathComponent:PUSH_PATH];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"DELETE"];
    
    [self.data setObject:self.message forKey:@"alert"];
    
    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] init];
    [bodyDict setObject:self.isBroadcast?@"true":@"false" forKey:@"broadcast"];
    [bodyDict setObject:self.data forKey:@"data"];
    if(self.query != nil)
        [bodyDict setObject:self.query forKey:@"query"];
    if(self.channels != nil)
        [bodyDict setObject:self.channels forKey:@"channels"];
    if(self.platformOptions != nil)
        [bodyDict setObject:self.platformOptions forKey:@"platformoptions"];
    if(self.expireAfter != nil)
        [bodyDict setObject:self.expireAfter forKey:@"expireafter"];
    
    NSError *jsonError;
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:bodyDict options:kNilOptions error:&jsonError];
    
    if(jsonError != nil)
        DLog(@"\n––––––––––JSON-ERROR–––––––––\n%@",jsonError);
    
    [urlRequest setHTTPBody:bodyData];
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
        if(failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

@end




#pragma mark - IOSOptions Interface

@implementation IOSOptions

- (instancetype) initWithSoundFile:(NSString*)soundFile {
    if(soundFile != nil)
        _soundFile = soundFile;
    return self;
}

@end





#pragma mark - AndroidOptions Interface

@implementation AndroidOptions

- (instancetype) initWithTitle:(NSString*)title {
    if(title != nil)
        _title = title;
    return self;
}

@end





#pragma mark - WPTile Interface

@implementation WPTile

- (instancetype) initWithTileType:(WPTileType)wpTileType {
    _wpTileType = wpTileType;
    return self;
}

@end





#pragma mark - FlipTile Interface

@implementation FlipTile

- (instancetype) init {
    return self = [super initWithTileType:Flip];
}

@end






#pragma mark - IconicTile

@implementation IconicTile

- (instancetype) init {
    return self = [super initWithTileType:Iconic];
}

@end





#pragma mark - CyclicTile Interface

@implementation CyclicTile

- (instancetype) initWithFrontTitle:(NSString*)frontTitle images:(NSArray*)images {
    _frontTitle = frontTitle;
    for(int i=0; i<9; i++)
        _images[i] = images[i];
    return self;
}

- (instancetype) init {
    return self = [super initWithTileType:Cyclic];
}

@end







#pragma mark - WPNotification Interface

@implementation WPNotification

- (instancetype) initWithNotificationType:(WPNotificationType)wpNotificationType {
    _wpNotificationType = wpNotificationType;
    return self;
}

@end




#pragma mark - ToastNotification Interface

@implementation ToastNotification

- (instancetype) initWithText1:(NSString*)text1 text2:(NSString*)text2 path:(NSString*)path {
    self = [super initWithNotificationType:Toast];
    if (text1 != nil && text2 != nil && path != nil) {
        _text1 = text1;
        _text2 = text2;
        _path = path;
    }
    return self;
}

@end





#pragma mark - WPTileNotification Interface

@implementation TileNotification

- (instancetype) init {
    return self = [super init];
}

- (TileNotification*) createNewFlipTile:(FlipTile*)tile  {
    if (tile != nil) {
        _wp75Tile = tile;
        _wp7Tile = tile;
        _wp8Tile = tile;
    }
    return self;
}

- (TileNotification*) createNewIconicTile:(IconicTile*)tile  flipTileForWP75AndBelow:(FlipTile*)fliptile{
    if (tile != nil)
        _wp8Tile = tile;
    _wp75Tile = fliptile;
    _wp7Tile = fliptile;
    return self;
}

- (TileNotification*) createNewCyclicTile:(IconicTile*)tile flipTileForWP75AndBelow:(FlipTile*)fliptile {
    if (tile != nil )
        _wp8Tile = tile;
    _wp75Tile = fliptile;
    _wp7Tile = fliptile;
    return self;
}

- (void) setWp75Tile:(WPTile *)wp75Tile {
    if (wp75Tile != nil && wp75Tile.wpTileType != Flip)
        _wp75Tile = nil;
    _wp75Tile = wp75Tile;
}

- (void) setWp7Tile:(WPTile *)wp7Tile {
    if (wp7Tile != nil && wp7Tile.wpTileType != Flip)
        _wp7Tile = nil;
    _wp7Tile = wp7Tile;
}

@end




#pragma mark - RawNotification Interface

@implementation RawNotification

- (instancetype) init {
    return self = [super initWithNotificationType:Raw];
}

@end




#pragma mark - WindowsPhoneOptions Interface

@implementation WindowsPhoneOptions

- (instancetype) initWithToast:(ToastNotification*)notification {
    if(notification != nil)
        _notification = notification;
    return self;
}

- (instancetype) initWithTile:(TileNotification*)notification {
    if(notification != nil)
        _notification = notification;
    return self;
}

- (instancetype) initWithRaw:(RawNotification*)notification {
    if(notification != nil)
        _notification = notification;
    return self;
}

@end




#pragma mark - APPlatformOptions Interface

@implementation APPlatformOptions


@end


