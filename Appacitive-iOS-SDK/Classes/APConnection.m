//
//  APConnection.m
//  Appacitive-iOS-SDK
//
//  Created by Kauserali Hafizji on 03/09/12.
//  Copyright (c) 2012 Appacitive Software Pvt. Ltd.. All rights reserved.
//

#import "APConnection.h"
#import "APObject.h"
#import "APError.h"
#import "APHelperMethods.h"
#import "NSString+APString.h"
#import "APNetworking.h"

@implementation APConnection

#define CONNECTION_PATH @"v1.0/connection/"

#pragma mark initialization methods

+ (instancetype) connectionWithRelationType:(NSString*)relationType {
    return [[APConnection alloc] initWithRelationType:relationType];
}

- (instancetype) initWithRelationType:(NSString*)relationType {
    self = [super init];
    if(self) {
        self.relationType = relationType;
    }
    return self;
}


#pragma mark create connection methods

- (void) create {
    [self createConnectionWithSuccessHandler:nil failureHandler:nil];
}

- (void) createConnectionWithFailureHandler:(APFailureBlock)failureBlock {
    [self createConnectionWithSuccessHandler:nil failureHandler:nil];
}

- (void) createConnectionWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [CONNECTION_PATH stringByAppendingString:self.relationType];
    
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[self parameters] options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        DLog(@"\n––––––––––JSON-ERROR–––––––––\n%@",jsonError);
    [urlRequest setHTTPBody:requestBody];
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

- (void) createConnectionWithObjectA:(APObject*)objectA objectB:(APObject*)objectB {
    [self createConnectionWithObjectA:objectA objectB:objectB successHandler:nil failureHandler:nil];
}

- (void) createConnectionWithObjectA:(APObject*)objectA objectB:(APObject*)objectB failureHandler:(APFailureBlock)failureBlock {
    [self createConnectionWithObjectA:objectA objectB:objectB successHandler:nil failureHandler:failureBlock];
}

- (void) createConnectionWithObjectA:(APObject*)objectA objectB:(APObject*)objectB successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    self.objectAId = objectA.objectId;
    self.objectBId = objectB.objectId;
    self.labelA = objectA.type;
    self.labelB = objectB.type;
    [self createConnectionWithSuccessHandler:successBlock failureHandler:failureBlock];
}

- (void) createConnectionWithObjectA:(APObject*)objectA objectB:(APObject*)objectB labelA:(NSString*)labelA labelB:(NSString*)labelB {
    [self createConnectionWithObjectA:objectA objectB:objectB labelA:labelA labelB:labelB successHandler:nil failureHandler:nil];
}

- (void) createConnectionWithObjectA:(APObject*)objectA objectB:(APObject*)objectB labelA:(NSString*)labelA labelB:(NSString*)labelB failureHandler:(APFailureBlock)failureBlock {
    [self createConnectionWithObjectA:objectA objectB:objectB labelA:labelA labelB:labelB successHandler:nil failureHandler:failureBlock];
}

- (void) createConnectionWithObjectA:(APObject*)objectA objectB:(APObject*)objectB labelA:(NSString*)labelA labelB:(NSString*)labelB successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    self.objectAId = objectA.objectId;
    self.objectBId = objectB.objectId;
    self.labelA = labelA;
    self.labelB = labelB;
    [self createConnectionWithSuccessHandler:successBlock failureHandler:failureBlock];
}

- (void) createConnectionWithObjectAId:(NSString *)objectAId objectBId:(NSString *)objectBId labelA:(NSString *)labelA labelB:(NSString *)labelB {
    [self createConnectionWithObjectAId:objectAId objectBId:objectBId labelA:labelA labelB:labelB successHandler:nil failureHandler:nil];
}

- (void) createConnectionWithObjectAId:(NSString *)objectAId objectBId:(NSString *)objectBId labelA:(NSString *)labelA labelB:(NSString *)labelB failureHandler:(APFailureBlock)failureBlock {
    [self createConnectionWithObjectAId:objectAId objectBId:objectBId labelA:labelA labelB:labelB successHandler:nil failureHandler:failureBlock];
}

- (void) createConnectionWithObjectAId:(NSString *)objectAId objectBId:(NSString *)objectBId labelA:(NSString *)labelA labelB:(NSString *)labelB successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [CONNECTION_PATH stringByAppendingString:self.relationType];
    
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSError *jsonError = nil;
    self.objectAId = objectAId;
    self.objectBId = objectBId;
    self.labelA = labelA;
    self.labelB = labelB;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[self parameters] options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        DLog(@"\n––––––––––JSON-ERROR–––––––––\n%@",jsonError);
    [urlRequest setHTTPBody:requestBody];
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

- (void) createConnectionWithObjectA:(APObject*)objectA objectBId:(NSString*)objectBId labelA:(NSString*)labelA labelB:(NSString*)labelB {
    [self createConnectionWithObjectA:objectA objectBId:objectBId labelA:labelA labelB:labelB successHandler:nil failureHandler:nil];
}

- (void) createConnectionWithObjectA:(APObject *)objectA objectBId:(NSString *)objectBId labelA:(NSString *)labelA labelB:(NSString *)labelB failureHandler:(APFailureBlock)failureBlock {
    [self createConnectionWithObjectA:objectA objectBId:objectBId labelA:labelA labelB:labelB successHandler:nil failureHandler:failureBlock];
}

- (void) createConnectionWithObjectA:(APObject *)objectA objectBId:(NSString *)objectBId labelA:(NSString *)labelA labelB:(NSString *)labelB successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock
{
    __block NSString *path = [CONNECTION_PATH stringByAppendingString:self.relationType];
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [objectA saveObjectWithSuccessHandler:^(NSDictionary *result) {
        [objectA setPropertyValuesFromDictionary:result];
        path = [HOST_NAME stringByAppendingPathComponent:path];
        NSURL *url = [NSURL URLWithString:path];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
        NSError *jsonError = nil;
        self.objectAId = objectA.objectId;
        self.objectBId = objectBId;
        self.labelA = labelA;
        self.labelB = labelB;
        NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[self parameters] options:kNilOptions error:&jsonError];
        if(jsonError != nil)
            DLog(@"\n––––––––––JSON-ERROR–––––––––\n%@",jsonError);
        [urlRequest setHTTPBody:requestBody];
        [urlRequest setHTTPMethod:@"PUT"];
        
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
    } failureHandler:^(APError *error) {
        DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

- (void) createConnectionWithObjectAId:(NSString*)objectAId objectB:(APObject*)objectB labelA:(NSString*)labelA labelB:(NSString*)labelB {
    [self createConnectionWithObjectAId:objectAId objectB:objectB labelA:labelA labelB:labelB successHandler:nil failureHandler:nil];
}


- (void) createConnectionWithObjectAId:(NSString*)objectAId objectB:(APObject*)objectB labelA:(NSString*)labelA labelB:(NSString*)labelB failureHandler:(APFailureBlock)failureBlock {
    [self createConnectionWithObjectAId:objectAId objectB:objectB labelA:labelA labelB:labelB successHandler:nil failureHandler:failureBlock];
}


- (void) createConnectionWithObjectAId:(NSString*)objectAId objectB:(APObject*)objectB labelA:(NSString*)labelA labelB:(NSString*)labelB successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    __block NSString *path = [CONNECTION_PATH stringByAppendingString:self.relationType];
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [objectB saveObjectWithSuccessHandler:^(NSDictionary *result) {
        [objectB setPropertyValuesFromDictionary:result];
        path = [HOST_NAME stringByAppendingPathComponent:path];
        NSURL *url = [NSURL URLWithString:path];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
        NSError *jsonError = nil;
        self.objectAId = objectAId;
        self.objectBId = objectB.objectId;
        self.labelA = labelA;
        self.labelB = labelB;
        NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[self parameters] options:kNilOptions error:&jsonError];
        if(jsonError != nil)
            DLog(@"\n––––––––––JSON-ERROR–––––––––\n%@",jsonError);
        [urlRequest setHTTPBody:requestBody];
        [urlRequest setHTTPMethod:@"PUT"];
        
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
    } failureHandler:^(APError *error) {
        DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

#pragma mark update connection methods

- (void) updateConnection {
    [self updateConnectionWithSuccessHandler:nil failureHandler:nil];
}

- (void) updateConnectionWithFailureHandler:(APFailureBlock)failureBlock {
    [self updateConnectionWithSuccessHandler:nil failureHandler:failureBlock];
}

- (void) updateConnectionWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [CONNECTION_PATH stringByAppendingFormat:@"%@/%@", self.relationType, self.objectId.description];
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[self postParamertersUpdate] options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        DLog(@"\n––––––––––JSON-ERROR–––––––––\n%@",jsonError);
    [urlRequest setHTTPBody:requestBody];
    [urlRequest setHTTPMethod:@"POST"];
    
    
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

#pragma mark fetch connection methods

- (void) fetchConnection {
    [self fetchConnectionWithSuccessHandler:nil failureHandler:nil];
}

- (void) fetchConnectionWithFailureHandler:(APFailureBlock)failureBlock {
    [self fetchConnectionWithSuccessHandler:nil failureHandler:failureBlock];
}

- (void) fetchConnectionWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [CONNECTION_PATH stringByAppendingFormat:@"%@/%@", self.relationType, self.objectId.description];
    
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    
    
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

#pragma mark delete methods

- (void) deleteConnection {
    [self deleteConnectionWithSuccessHandler:nil failureHandler:nil];
}

- (void) deleteConnectionWithFailureHandler:(APFailureBlock)failureBlock {
    [self deleteConnectionWithSuccessHandler:nil failureHandler:failureBlock];
}

- (void) deleteConnectionWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [CONNECTION_PATH stringByAppendingFormat:@"%@/%@", self.relationType, self.objectId];
    
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"DELETE"];
    
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

#pragma mark add properties method

- (void) addPropertyWithKey:(NSString*) keyName value:(id) object {
    if (!self.properties) {
        _properties = [NSMutableArray array];
    }
    [_properties addObject:@{keyName: object}];
}

#pragma mark add attributes method

- (void) addAttributeWithKey:(NSString*) keyName value:(id) object {
    if (!self.attributes) {
        _attributes = [NSMutableDictionary dictionary];
    }
    [_attributes setObject:object forKey:keyName];
}

- (void) updateAttributeWithKey:(NSString*) keyName value:(id) object {
    [_attributes setObject:object forKey:keyName];
}

- (void) removeAttributeWithKey:(NSString*) keyName {
    [_attributes removeObjectForKey:keyName];
    //[_attributes setObject:[NSNull null] forKey:keyName];
}

#pragma mark update properties method

- (void) updatePropertyWithKey:(NSString*) keyName value:(id) object {
    [self.properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary *dict = (NSMutableDictionary *)obj;
        if ([dict objectForKey:keyName] != nil) {
            [dict setObject:object forKey:keyName];
            *stop = YES;
        }
    }];
}

#pragma mark delete property

- (void) removePropertyWithKey:(NSString*) keyName {
    [self.properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary *dict = (NSMutableDictionary *)obj;
        if ([dict objectForKey:keyName] != nil) {
            [dict setObject:[NSNull null] forKey:keyName];
            *stop = YES;
        }
    }];
}

#pragma mark retrieve property

- (instancetype) getPropertyWithKey:(NSString*) keyName {
    __block id property;
    [self.properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary *dict = (NSMutableDictionary *)obj;
        if ([dict objectForKey:keyName] != nil) {
            property = [dict objectForKey:keyName];
            *stop = YES;
        }
    }];
    return property;
}

#pragma mark methods to add/remove tags

- (void) addTag:(NSString*)tag
{
    if(tag != nil)
    {
        [self.tagsToAdd addObject:[tag lowercaseString]];
    }
}

- (void) removeTag:(NSString*)tag
{
    if(tag != nil)
    {
        [self.tagsToRemove addObject:[tag lowercaseString]];
        [self.tagsToAdd minusSet:self.tagsToRemove];
    }
}

#pragma mark private methods

- (void) setPropertyValuesFromDictionary:(NSDictionary*) dictionary {
    NSDictionary *connection = [[NSDictionary alloc] init];
    if([[dictionary allKeys] containsObject:@"connection"])
        connection = dictionary[@"connection"];
    else
        connection = dictionary;
    _objectAId = (NSString*)connection[@"__endpointa"][@"objectid"];
    _objectBId = (NSString*)connection[@"__endpointb"][@"objectid"];
    _createdBy = (NSString*) connection[@"__createdby"];
    _objectId = (NSString*) connection[@"__id"];
    _labelA = (NSString*) connection[@"__endpointa"][@"label"];
    _labelB = (NSString*) connection[@"__endpointb"][@"label"];
    _typeA = (NSString*) connection[@"__endpointa"][@"type"];
    _typeB = (NSString*) connection[@"__endpointb"][@"type"];
    _lastModifiedBy = (NSString*) connection[@"__lastmodifiedby"];
    _relationId = (NSString*) connection[@"__relationid"];
    _relationType = (NSString*) connection[@"__relationtype"];
    _revision = (NSNumber*) connection[@"__revision"];
    _tags = connection[@"__tags"];
    _utcDateCreated = [APHelperMethods deserializeJsonDateString:connection[@"__utcdatecreated"]];
    _utcLastModifiedDate = [APHelperMethods deserializeJsonDateString:connection[@"__utclastupdateddate"]];
    
    _attributes = [connection[@"__attributes"] mutableCopy];
    _properties = [APHelperMethods arrayOfPropertiesFromJSONResponse:connection].mutableCopy;
}

- (NSMutableDictionary*) parameters {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (self.objectAId) {
        if (!parameters[@"__endpointa"]) {
            parameters[@"__endpointa"] = [NSMutableDictionary dictionary];
        }
        parameters[@"__endpointa"][@"objectid"] = [NSString stringWithFormat:@"%@", self.objectAId];
    }
    
    if (self.objectBId) {
        if (!parameters[@"__endpointb"]) {
            parameters[@"__endpointb"] = [NSMutableDictionary dictionary];
        }
        parameters[@"__endpointb"][@"objectid"] = [NSString stringWithFormat:@"%@", self.objectBId];
    }
    
    if (self.attributes)
        parameters[@"__attributes"] = self.attributes;
    
    if (self.createdBy)
        parameters[@"__createdby"] = self.createdBy;
    
    for(NSDictionary *prop in self.properties) {
        [prop enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
            [parameters setObject:obj forKey:key];
            *stop = YES;
        }];
    }
    
    if (self.labelA) {
        if (!parameters[@"__endpointa"]) {
            parameters[@"__endpointa"] = [NSMutableDictionary dictionary];
        }
        parameters[@"__endpointa"][@"label"] = self.labelA;
    }
    
    if (self.labelB) {
        if (!parameters[@"__endpointb"]) {
            parameters[@"__endpointb"] = [NSMutableDictionary dictionary];
        }
        parameters[@"__endpointb"][@"label"] = self.labelB;
    }
    
    if (self.typeA) {
        if (!parameters[@"__endpointa"]) {
            parameters[@"__endpointa"] = [NSMutableDictionary dictionary];
        }
        parameters[@"__endpointa"][@"type"] = self.typeA;
    }
    
    if (self.typeB) {
        if (!parameters[@"__endpointb"]) {
            parameters[@"__endpointb"] = [NSMutableDictionary dictionary];
        }
        parameters[@"__endpointb"][@"type"] = self.typeB;
    }
    
    if (self.relationType)
        parameters[@"__relationtype"] = self.relationType;
    
    if (self.revision)
        parameters[@"__revision"] = self.revision;
    
    if (self.tags)
        parameters[@"__tags"] = self.tags;
    return parameters;
}

- (NSMutableDictionary*) postParamertersUpdate {
    NSMutableDictionary *postParams = [NSMutableDictionary dictionary];
    
    if (self.attributes && [self.attributes count] > 0)
        postParams[@"__attributes"] = self.attributes;
    
    for(NSDictionary *prop in self.properties) {
        [prop enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
            [postParams setObject:obj forKey:key];
            *stop = YES;
        }];
    }
    
    if (self.tagsToAdd)
        postParams[@"addtags"] = [self.tagsToAdd allObjects];
    
    if (self.tagsToRemove)
        postParams[@"removetags"] = [self.tagsToRemove allObjects];
    
    return postParams;
}

- (NSString*) description {
    return [NSString stringWithFormat:@"ObjectAId:%@, ObjectBId:%@, Attributes:%@, CreatedBy:%@, Connection Id:%@, LabelA:%@, LabelB:%@, LastUpdatedBy:%@, Properties:%@, RelationId:%@, Relation Type:%@, Revision:%d, Tags:%@, UtcDateCreated:%@, UtcLastUpdatedDate:%@", self.objectAId, self.objectBId, self.attributes, self.createdBy, self.objectId, self.labelA, self.labelB, self.lastModifiedBy, self.properties, self.relationId, self.relationType, [self.revision intValue], self.tags ,self.utcDateCreated, self.utcLastModifiedDate];
}
@end


@implementation APConnections

#define CONNECTION_PATH @"v1.0/connection/"

#pragma mark search methods

+ (void) searchForAllConnectionsWithRelationType:(NSString*)relationType successHandler:(APResultSuccessBlock)successBlock {
    [APConnections searchForAllConnectionsWithRelationType:relationType successHandler:successBlock failureHandler:nil];
}

+ (void) searchForAllConnectionsWithRelationType:(NSString*)relationType successHandler:(APResultSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    [APConnections searchForConnectionsWithRelationType:relationType withQueryString:nil successHandler:successBlock failureHandler:failureBlock];
}

+ (void) searchForConnectionsWithRelationType:(NSString*)relationType withQueryString:(NSString*)queryString successHandler:(APResultSuccessBlock)successBlock {
    [APConnections searchForConnectionsWithRelationType:relationType withQueryString:queryString successHandler:successBlock failureHandler:nil];
}

+ (void) searchForConnectionsWithRelationType:(NSString*)relationType withQueryString:(NSString*)queryString successHandler:(APResultSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [CONNECTION_PATH stringByAppendingFormat:@"%@/find/all", relationType];
    
    if (queryString) {
        path = [path stringByAppendingFormat:@"?%@",queryString];
    }
    
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            successBlock(result);
        }
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

+ (void) searchAllConnectionsFromObjectId:(NSNumber *)objectAId toObjectId:(NSNumber *)objectBId {
    [APConnections searchAllConnectionsFromObjectId:objectAId toObjectId:objectBId withSuccessHandler:nil failureHandler:nil];
}

+ (void) searchAllConnectionsFromObjectId:(NSNumber *)objectAId toObjectId:(NSNumber *)objectBId withSuccessHandler:(APResultSuccessBlock)successBlock {
    [APConnections searchAllConnectionsFromObjectId:objectAId toObjectId:objectBId withSuccessHandler:successBlock failureHandler:nil];
}

+ (void) searchAllConnectionsFromObjectId:(NSNumber *)objectAId toObjectId:(NSNumber *)objectBId withSuccessHandler:(APResultSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [CONNECTION_PATH stringByAppendingString:[NSString stringWithFormat:@"find/%@/%@",objectAId,objectBId]];
    
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            successBlock(result);
        }
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

+ (void) searchAllConnectionsFromObjectId:(NSNumber *)objectId toObjectIds:(NSArray *)objectIds {
    [APConnections searchAllConnectionsFromObjectId:objectId toObjectIds:objectIds withSuccessHandler:nil failureHandler:nil];
}

+ (void) searchAllConnectionsFromObjectId:(NSNumber *)objectId toObjectIds:(NSArray *)objectIds withSuccessHandler:(APResultSuccessBlock)successBlock {
    [APConnections searchAllConnectionsFromObjectId:objectId toObjectIds:objectIds withSuccessHandler:successBlock failureHandler:nil];
}

+ (void) searchAllConnectionsFromObjectId:(NSNumber *)objectId toObjectIds:(NSArray *)objectIds withSuccessHandler:(APResultSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [CONNECTION_PATH stringByAppendingString:@"interconnects"];
    
    NSMutableDictionary *postParams = [[NSMutableDictionary alloc] init];
    postParams[@"object1id"] = [NSString stringWithFormat:@"%@",objectId];
    postParams[@"object2ids"] = objectIds;
    
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:postParams options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        DLog(@"\n––––––––––JSON-ERROR–––––––––\n%@",jsonError);
    [urlRequest setHTTPBody:requestBody];
    [urlRequest setHTTPMethod:@"POST"];
    
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            successBlock(result);
        }
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

#pragma mark fetch methods

+ (void) fetchConnectionWithRelationType:(NSString*)relationType objectId:(NSString*)objectId successHandler:(APResultSuccessBlock)successBlock {
    [APConnections fetchConnectionsWithRelationType:relationType objectIds:@[objectId] successHandler:successBlock failureHandler:nil];
}

+ (void) fetchConnectionWithRelationType:(NSString*)relationType objectId:(NSString*)objectId successHandler:(APResultSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    [APConnections fetchConnectionsWithRelationType:relationType objectIds:@[objectId] successHandler:successBlock failureHandler:failureBlock];
}

+ (void) fetchConnectionsWithRelationType:(NSString*)relationType objectIds:(NSArray*)objectIds successHandler:(APResultSuccessBlock)successBlock {
    [APConnections fetchConnectionsWithRelationType:relationType objectIds:objectIds successHandler:successBlock failureHandler:nil];
}

+ (void) fetchConnectionsWithRelationType:(NSString*)relationType objectIds:(NSArray*)objectIds successHandler:(APResultSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    __block NSString *path = [CONNECTION_PATH stringByAppendingFormat:@"%@/multiget/", relationType];
    
    [objectIds enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *string = (NSString*) obj;
        path = [path stringByAppendingFormat:@"%@", string];
        if (idx != objectIds.count - 1) {
            path = [path stringByAppendingString:@","];
        }
    }];
    
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            successBlock(result);
        }
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

#pragma mark delete methods

+ (void) deleteConnectionsWithRelationType:(NSString*)relationType objectIds:(NSArray*)objectIds {
    [APConnections deleteConnectionsWithRelationType:relationType objectIds:objectIds successHandler:nil failureHandler:nil];
}

+ (void) deleteConnectionsWithRelationType:(NSString*)relationType objectIds:(NSArray*)objectIds failureHandler:(APFailureBlock)failureBlock {
    [APConnections deleteConnectionsWithRelationType:relationType objectIds:objectIds successHandler:nil failureHandler:nil];
}

+ (void) deleteConnectionsWithRelationType:(NSString*)relationType objectIds:(NSArray*)objectIds successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock {
    
    NSString *path = [CONNECTION_PATH stringByAppendingFormat:@"%@/bulkdelete", relationType];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:objectIds forKey:@"idlist"];
    
    path = [HOST_NAME stringByAppendingPathComponent:path];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        DLog(@"\n––––––––––JSON-ERROR–––––––––\n%@",jsonError);
    [urlRequest setHTTPBody:requestBody];
    
    APNetworking *nwObject = [[APNetworking alloc] init];
    [nwObject makeAsyncRequestWithURLRequest:urlRequest successHandler:^(NSDictionary *result) {
        if (successBlock != nil) {
            successBlock();
        }
    } failureHandler:^(APError *error) {
		DLog(@"\n––––––––––––ERROR––––––––––––\n%@", error);
        if (failureBlock != nil) {
            failureBlock(error);
        }
    }];
}

@end
