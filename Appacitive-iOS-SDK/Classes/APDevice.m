//
//  APDevice.m
//  Appacitive-iOS-SDK
//
//  Created by Pratik on 23-12-13.
//  Copyright (c) 2013 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import "APDevice.h"
#import "APHelperMethods.h"
#import "APNetworking.h"
#import "Appacitive.h"
#import "APConstants.h"
#import "APUser.h"
#import "APLogger.h"

#define DEVICE_PATH @"device/"

@implementation APDevice

static NSDictionary* headerParams;
static APDevice* currentDevice;

+ (NSDictionary*)getHeaderParams
{
    headerParams = [NSDictionary dictionaryWithObjectsAndKeys:
                    [Appacitive getApiKey], APIkeyHeaderKey,
                    [Appacitive getCurrentEnvironment], EnvironmentHeaderKey,
                    [APUser currentUser].userToken, UserAuthHeaderKey,
                    @"application/json", @"Content-Type",
                    nil];
    return headerParams;
}

#pragma mark - Initialization methods
- (instancetype) init {
    self = [super initWithTypeName:@"device"];
    self.isActive = @"false";
    self.deviceType = @"ios";
    return self;
}

- (instancetype)initWithDeviceToken:(NSString *)deviceToken deviceType:(NSString *)deviceType {
    self = [super initWithTypeName:@"device"];
    if(deviceType != nil)
        self.deviceType = deviceType;
    if(deviceToken != nil)
        self.deviceToken = deviceToken;
    self.type = @"device";
    self.isActive = @"false";
    return self;
}

#pragma mark - Register methods

+ (void) registerCurrentDeviceWithPushDeviceToken:(NSData *)token enablePushNotifications:(BOOL)answer{
    [self registerCurrentDeviceWithPushDeviceToken:token enablePushNotifications:answer successHandler:nil failureHandler:nil];
}

+ (void) registerCurrentDeviceWithPushDeviceToken:(NSData *)token enablePushNotifications:(BOOL)answer failureHandler:(APFailureBlock)failureBlock {
    [self registerCurrentDeviceWithPushDeviceToken:token enablePushNotifications:answer successHandler:nil failureHandler:failureBlock];
}

+ (void) registerCurrentDeviceWithPushDeviceToken:(NSData *)token enablePushNotifications:(BOOL)answer successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    NSString *cleanToken = [APDevice GetUUID];
    if(token != nil) {
        cleanToken = [[token description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
        cleanToken = [cleanToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    if(currentDevice == nil) {
        currentDevice = [[APDevice alloc] initWithDeviceToken:cleanToken deviceType:@"ios"];
        currentDevice.isActive = @"false";
        if(answer == YES)
            currentDevice.isActive = @"true";
        NSString *path = HOST_NAME;
    path = [path stringByAppendingPathComponent:DEVICE_PATH];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/register",path]];
    NSMutableDictionary *bodyDict = [currentDevice postParameters];
    [bodyDict addEntriesFromDictionary:[currentDevice createRequestBody]];
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:bodyDict options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––JSON-ERROR–––––––––\n%@", [jsonError description]] withType:APMessageTypeError];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPBody:requestBody];
    [urlRequest setAllHTTPHeaderFields:[APDevice getHeaderParams]];
    [urlRequest setHTTPMethod:@"PUT"];
    [currentDevice updateSnapshot];
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            [currentDevice setPropertyValuesFromDictionary:result];
            [APDevice saveCustomObject:currentDevice forKey:@"currentAPDevice"];
            successBlock();
        }
    } failureHandler:^(APError *error) {
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
    } else {
        if([currentDevice.isActive isEqual:BooleanStringFromBOOL(answer)]) {
            if(answer == YES) {
                if(currentDevice.deviceToken != cleanToken) {
                    currentDevice.deviceToken = cleanToken;
                    currentDevice.isActive = BooleanStringFromBOOL(answer);
                    [currentDevice updateObjectWithSuccessHandler:^{
                        [APDevice saveCustomObject:currentDevice forKey:@"currentAPDevice"];
                        if (successBlock != nil) {
                            successBlock();
                        }
                    } failureHandler:failureBlock];
                }
            }
        } else {
            if(currentDevice.deviceToken != cleanToken)
                currentDevice.deviceToken = cleanToken;
            currentDevice.isActive = BooleanStringFromBOOL(answer);
            [currentDevice updateObjectWithSuccessHandler:^{
                [APDevice saveCustomObject:currentDevice forKey:@"currentAPDevice"];
                if (successBlock != nil) {
                    successBlock();
                }
            } failureHandler:failureBlock];
        }
    }
}

+ (void) deregisterCurrentDevice {
    [self deregisterCurrentDeviceWithSuccessHandler:nil failureHandler:nil];
}

+ (void) deregisterCurrentDeviceWithFailureHandler:(APFailureBlock)failureBlock {
    [self deregisterCurrentDeviceWithSuccessHandler:nil failureHandler:failureBlock];
}

+ (void) deregisterCurrentDeviceWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    currentDevice.isActive = @"false";
    [currentDevice updateObjectWithSuccessHandler:successBlock failureHandler:failureBlock];
}

#pragma mark - Save methods
- (void) saveObject {
    [self saveObjectWithSuccessHandler:nil failureHandler:nil];
}

- (void) saveObjectWithFailureHandler:(APFailureBlock)failureBlock {
    [self saveObjectWithSuccessHandler:nil failureHandler:failureBlock];
}

- (void) saveObjectWithSuccessHandler:(APResultSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    [self updateObjectWithSuccessHandler:successBlock failureHandler:failureBlock];
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
    NSString *path = [DEVICE_PATH stringByAppendingFormat:@"%@", self.objectId];
    
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
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––JSON-ERROR–––––––––\n%@", [jsonError description]] withType:APMessageTypeError];
    [urlRequest setHTTPBody:requestBody];
    [self updateSnapshot];
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
        [self setPropertyValuesFromDictionary:result];
        if (successBlock != nil) {
            successBlock(self);
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

    if(deleteConnections == YES) {
        path = [path stringByAppendingString:@"?deleteconnections=true"];
    } else {
        path = [path stringByAppendingString:@"?deleteconnections=false"];
    }
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"DELETE"];
    [urlRequest setAllHTTPHeaderFields:[APDevice getHeaderParams]];
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
- (NSMutableDictionary*)createRequestBody {
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
    if(self.isActive)
        [requestBody setObject:self.isActive forKey:@"isactive"];
    return requestBody;
}

- (void) setPropertyValuesFromDictionary:(NSDictionary*)dictionary {
    
    NSMutableDictionary *object = [[NSMutableDictionary alloc] init];
    
    if([[dictionary allKeys] containsObject:@"device"])
        object = [dictionary[@"device"] mutableCopy];
    
    else object = [dictionary mutableCopy];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"currentAPDevice"] != nil) {
        APDevice *savedDevice = [APDevice loadCustomObjectForKey:@"currentAPDevice"];
        if(savedDevice.objectId == object[@"__id"]) {
            [savedDevice setPropertyValuesForCurrentDeviceFromDictionary:object];
            [APDevice saveCustomObject:savedDevice forKey:@"currentAPDevice"];
        }
    }
    
    _deviceToken = object[@"devicetoken"];
    [object removeObjectForKey:@"devicetoken"];
    self.deviceLocation = object[@"location"];
    [object removeObjectForKey:@"location"];
    self.deviceType = object[@"devicetype"];
    [object removeObjectForKey:@"devicetype"];
    self.isActive = object[@"isactive"];
    [object removeObjectForKey:@"isactive"];
    self.channels = object[@"channels"];
    [object removeObjectForKey:@"channels"];
    self.badge = object[@"badge"];
    [object removeObjectForKey:@"badge"];
    
    self.createdBy = (NSString*)object[@"__createdby"];
    _objectId = object[@"__id"];
    _lastModifiedBy = (NSString*)object[@"__lastmodifiedby"];
    _revision = (NSNumber*)object[@"__revision"];
    _utcDateCreated = [APHelperMethods deserializeJsonDateString:object[@"__utcdatecreated"]];
    _utcLastUpdatedDate = [APHelperMethods deserializeJsonDateString:object[@"__utclastupdateddate"]];
    _attributes = [object[@"__attributes"] mutableCopy];
    self.tags = object[@"__tags"];
    self.type = object[@"__type"];
    _properties = [APHelperMethods arrayOfPropertiesFromJSONResponse:object].mutableCopy;
    
    [self updateSnapshot];
}

- (void) setPropertyValuesForCurrentDeviceFromDictionary:(NSDictionary*)dictionary {
    
    NSMutableDictionary *object = [[NSMutableDictionary alloc] init];
    
    if([[dictionary allKeys] containsObject:@"device"])
        object = [dictionary[@"device"] mutableCopy];
    
    else object = [dictionary mutableCopy];
    
    _deviceToken = object[@"devicetoken"];
    [object removeObjectForKey:@"devicetoken"];
    self.deviceLocation = object[@"location"];
    [object removeObjectForKey:@"location"];
    self.deviceType = object[@"devicetype"];
    [object removeObjectForKey:@"devicetype"];
    self.isActive = object[@"isactive"];
    [object removeObjectForKey:@"isactive"];
    self.channels = object[@"channels"];
    [object removeObjectForKey:@"channels"];
    self.badge = object[@"badge"];
    [object removeObjectForKey:@"badge"];
    
    self.createdBy = (NSString*)object[@"__createdby"];
    _objectId = object[@"__id"];
    _lastModifiedBy = (NSString*)object[@"__lastmodifiedby"];
    _revision = (NSNumber*)object[@"__revision"];
    _utcDateCreated = [APHelperMethods deserializeJsonDateString:object[@"__utcdatecreated"]];
    _utcLastUpdatedDate = [APHelperMethods deserializeJsonDateString:object[@"__utclastupdateddate"]];
    _attributes = [object[@"__attributes"] mutableCopy];
    self.tags = object[@"__tags"];
    self.type = object[@"__type"];
    _properties = [APHelperMethods arrayOfPropertiesFromJSONResponse:object].mutableCopy;
    
    [self updateSnapshot];
}

- (NSMutableDictionary*)postParameters {
    
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
    
    if (self.deviceToken)
        postParams[@"devicetoken"] = self.deviceToken;
    if (self.deviceType)
        postParams[@"devicetype"] = self.deviceType;
    if (self.deviceLocation)
        postParams[@"devicelocation"] = self.deviceLocation;
    if (self.channels)
        postParams[@"channels"] = self.channels;
    if (self.isActive)
        postParams[@"isActive"] = self.isActive;
    if (self.timeZone)
        postParams[@"timezone"] = self.timeZone;
    if (self.badge)
        postParams[@"badge"] = self.tags;
    
    for(NSDictionary *prop in self.properties) {
        [prop enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
            [postParams setObject:obj forKey:key];
            *stop = YES;
        }];
    }
    return postParams;
}

- (NSMutableDictionary*)postParametersUpdate {
    NSMutableDictionary *postParams = [NSMutableDictionary dictionary];
    
    if (self.attributes && [self.attributes count] > 0) {
        for(id key in self.attributes) {
            if(![[[_snapShot objectForKey:@"__attributes"] allKeys] containsObject:key])
                [postParams[@"__attributes"] setObject:[self.attributes objectForKey:key] forKey:key];
            else if([[_snapShot objectForKey:@"__attributes"] objectForKey:key] != [self.attributes objectForKey:key])
                [postParams[@"__attributes"] setObject:[self.attributes objectForKey:key] forKey:key];
        }
    }
    
    for(NSDictionary *prop in self.properties) {
        [prop enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
            if(![[_snapShot allKeys] containsObject:key])
                [postParams setObject:obj forKey:key];
            else if([_snapShot objectForKey:key] != [prop objectForKey:key])
                [postParams setObject:obj forKey:key];
            *stop = YES;
        }];
    }
    
    if (self.deviceLocation != nil && self.deviceLocation != [_snapShot objectForKey:@"devicelocation"])
        postParams[@"devicelocation"] = self.deviceLocation;
    if (self.deviceToken != nil && self.deviceToken != [_snapShot objectForKey:@"devicetoken"] && self.objectId == currentDevice.objectId)
        postParams[@"devicetoken"] = self.deviceToken;
    if (self.deviceType != nil && self.deviceType != [_snapShot objectForKey:@"devicetype"] && self.objectId == currentDevice.objectId)
        postParams[@"devicetype"] = self.deviceType;
    if(self.channels != nil && [self.channels count] >0  && self.channels != [_snapShot objectForKey:@"channels"])
        postParams[@"channels"] = self.channels;
    if (self.timeZone != nil && self.timeZone != [_snapShot objectForKey:@"timezone"])
        postParams[@"timezone"] = self.timeZone;
    if(self.isActive != nil && self.isActive != [_snapShot objectForKey:@"isactive"])
        postParams[@"isactive"] = self.isActive;
    if (self.tagsToAdd != nil && [self.tagsToAdd count] > 0)
        postParams[@"__addtags"] = [self.tagsToAdd allObjects];
    if (self.tagsToRemove !=nil && [self.tagsToRemove count] > 0)
        postParams[@"__removetags"] = [self.tagsToRemove allObjects];
    
    return postParams;
}

- (void) updateSnapshot {
    if(_snapShot == nil)
        _snapShot = [[NSMutableDictionary alloc] init];
    if(self.deviceToken)
        _snapShot[@"devicetoken"] = self.deviceToken;
    if(self.deviceType)
        _snapShot[@"devicetype"] = self.deviceType;
    if(self.deviceLocation)
        _snapShot[@"devicelocation"] = self.deviceLocation;
    if(self.channels)
        _snapShot[@"channels"] = self.channels;
    if(self.timeZone)
        _snapShot[@"timezone"] = self.timeZone;
    if(self.isActive)
        _snapShot[@"isactive"] = self.isActive;
    if(self.attributes)
        _snapShot[@"__attributes"] = [self.attributes mutableCopy];
    if(self.tags)
        _snapShot[@"__tags"] = [self.tags mutableCopy];
    if(self.properties)
        _snapShot[@"__properties"] = [self.properties mutableCopy];
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
    [encoder encodeObject:self.deviceToken forKey:@"deviceToken"];
    [encoder encodeObject:self.deviceType forKey:@"deviceType"];
    [encoder encodeObject:self.deviceLocation forKey:@"deviceLocation"];
    [encoder encodeObject:self.channels forKey:@"channels"];
    [encoder encodeObject:self.timeZone forKey:@"timeZone"];
    [encoder encodeObject:self.isActive forKey:@"isActive"];
    [encoder encodeObject:self.badge forKey:@"badge"];
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
        self.type = [decoder decodeObjectForKey:@"type"];
        self.tags= [decoder decodeObjectForKey:@"tags"];
        self.deviceToken = [decoder decodeObjectForKey:@"deviceToken"];
        self.deviceType = [decoder decodeObjectForKey:@"deviceType"];
        self.deviceLocation = [decoder decodeObjectForKey:@"deviceLocation"];
        self.channels = [decoder decodeObjectForKey:@"channels"];
        self.timeZone = [decoder decodeObjectForKey:@"timeZone"];
        self.isActive = [decoder decodeObjectForKey:@"isActive"];
        self.badge = [decoder decodeObjectForKey:@"badge"];
    }
    return self;
}

+ (void)saveCustomObject:(APDevice *)object forKey:(NSString *)key {
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

+ (APDevice *)loadCustomObjectForKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:key] != nil) {
        NSData *encodedObject = [defaults objectForKey:key];
        APDevice *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        return object;
    } else {
        return nil;
    }
}

+ (void)restoreCurrentDevice {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"currentAPDevice"] != nil) {
        NSData *encodedObject = [defaults objectForKey:@"currentAPDevice"];
        currentDevice = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    }
}

+ (NSString *)GetUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}

@end
