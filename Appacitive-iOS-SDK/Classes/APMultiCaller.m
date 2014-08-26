//
//  APMultiCaller.m
//  Appacitive-iOS-SDK
//
//  Created by Neil Unadkat on 12/08/14.
//  Copyright (c) 2014 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import "APMultiCaller.h"
#import "APNetworking.h"
#import "APLogger.h"

@interface APMultiCaller()

@property NSMutableArray * nodes;
@property NSMutableArray * edges;

// Using map tables because we are using custom objects as keys
@property NSMapTable * mapTables;
@end

@implementation APMultiCaller

NSString *const MULTI_PATH = @"object/multi";
-(instancetype) init{
    if(self = [super init]){
        self.nodes = [[NSMutableArray alloc] init];
        self.edges = [[NSMutableArray alloc] init];
        self.mapTables = [NSMapTable mapTableWithKeyOptions:NSMapTableStrongMemory valueOptions:NSMapTableStrongMemory];
    }
    return  self;
}

- (instancetype) initWithAPObjects:(NSArray *) objects{
    if(self = [self init]){
        for (int i =0 ; i < objects.count; i++) {
            [self addAPObject:(APObject *)[objects objectAtIndex:i]];
        }
    }
    return self;
}

-(instancetype) initWithAPConnections:(NSArray *) connections{
    if(self = [self init]){
        for (int i =0 ; i < connections.count; i++) {
            [self addAPConnection:(APConnection *)[connections objectAtIndex:i]];
        }

    }
    return self;
}

-(instancetype) initWithAPObjects:(NSArray *) objects andAPConnections:(NSArray *) connections{
    if(self = [self init]){
        for (int i =0 ; i < objects.count; i++) {
            [self addAPObject:(APObject *)[objects objectAtIndex:i]];
        }
        for (int i =0 ; i < connections.count; i++) {
            [self addAPConnection:(APConnection *)[connections objectAtIndex:i]];
        }

    }
    return self;
}

-(void) addAPObject:(APObject *)object{
    [self createAndAddNodeForAPObject:object];
    
}

- (APNode *) createAndAddNodeForAPObject:(APObject *) object{
    APNode * node = [self getNodeForAPObject:object];
    
    if( node == nil){
        node = [[APNode alloc] initWithName:[self getUniqueName] andObject:object];
        [self addAPNode:node forAPObject:object];
        [self.nodes addObject:node];
    }
    return node;
}

- (NSString *) getUniqueName{
    return [[NSUUID UUID] UUIDString];
}

- (APNode *) getNodeForAPObject:(APObject *) object{
    return [_mapTables objectForKey:object];
}


-(void) addAPNode:(APNode *)node forAPObject:(APObject * )object{
    [_mapTables setObject:node forKey:object];
}


-(void) addAPConnection:(APConnection *)connection{
    APEdge * edge = [[APEdge alloc] initWithConnection:connection];
    
    NSString * endpointAName = nil;
    NSString * endpointBName = nil;

    if(connection.objectA != nil){
        APNode * node = [self getNodeForAPObject:connection.objectA];
        if(node == nil){
            node = [self createAndAddNodeForAPObject:connection.objectA];
        }
        endpointAName = [node getName];
    }
    if(connection.objectB != nil){
        APNode * node = [self getNodeForAPObject:connection.objectB];
        if(node == nil){
            node = [self createAndAddNodeForAPObject:connection.objectB];
        }
        endpointBName = [node getName];
    }
    edge.endpointAName = endpointAName;
    edge.endpointBName = endpointBName;
    [self.edges addObject:edge];
}


-(void) save{
    [self saveWithSuccessHandler:nil andFailureHandlerBlock:nil];
}

-(void) saveWithFailureHandlerBlock:(APFailureBlock)failureHandlerBlock{
    [self saveWithSuccessHandler:nil andFailureHandlerBlock:failureHandlerBlock];
}

-(void) saveWithSuccessHandler:(APSuccessBlock)successBlock andFailureHandlerBlock:(APFailureBlock)failureHandlerBlock{
    NSString *path =[HOST_NAME stringByAppendingPathComponent:MULTI_PATH];
    
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"PUT"];
    NSError *jsonError = nil;
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:[self getPostData] options:kNilOptions error:&jsonError];
    if(jsonError != nil)
        [[APLogger sharedLogger] log:[NSString stringWithFormat:@"\n––––––––––JSON-ERROR–––––––––\n%@", [jsonError description]] withType:APMessageTypeError];
    [urlRequest setHTTPBody:requestBody];
    [APNetworking makeAsyncURLRequest:urlRequest callingSelector:__PRETTY_FUNCTION__ successHandler:^(NSDictionary *result) {
//        [self setPropertyValuesFromDictionary:result];
        if (successBlock != nil) {
            successBlock(result);
        }
    } failureHandler:^(APError *error) {
        if (failureHandlerBlock != nil) {
            failureHandlerBlock(error);
        }
    }];
}

- (NSDictionary *) getPostData{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
//    [dict setValue:[[NSMutableArray alloc] initWithCapacity:_nodes.count] forKey:@"nodes"];
    NSMutableArray * nodes = [[NSMutableArray alloc] initWithCapacity:_nodes.count];
    for (int i =0; i < _nodes.count; i++) {
        [nodes addObject:[[_nodes objectAtIndex:i] getPostObject]];
    }
    
    NSMutableArray * edges = [[NSMutableArray alloc] initWithCapacity:_edges.count];
    
    for (int i =0 ; i<_edges.count; i++) {
        APEdge * edge =[_edges objectAtIndex:i];
        NSMutableDictionary * obj = [edge getPostObject];
        if (edge.endpointAName != nil) {
            obj[@"connection"][@"__endpointa"][@"name"] = edge.endpointAName;
            obj[@"connection"][@"__endpointa"][@"objectid"] = nil;
            obj[@"connection"][@"__endpointa"][@"object"] = nil;
        }
        if (edge.endpointBName != nil) {
            obj[@"connection"][@"__endpointb"][@"name"] = edge.endpointBName;
            obj[@"connection"][@"__endpointb"][@"objectid"] = [NSNull null] ;
            obj[@"connection"][@"__endpointb"][@"object"] = [NSNull null];
        }
        
        [edges addObject:obj];
    }
    
    [dict setValue:nodes forKey:@"nodes"];
    [dict setValue:edges forKey:@"edges"];
    return dict;
}

@end


@interface APNode()
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) APObject * object;
@end

@implementation APNode

-(instancetype) initWithName:(NSString *) name andObject:(APObject *) obj{
    if(self = [self init]){
        self.name = name;
        self.object = obj;
    }
    return self;
}
-(NSString * )getName{
    return _name;
}

- (NSMutableDictionary *) getPostObject{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    [dict setValue:_name forKey:@"name"];
    NSDictionary * objParams = nil;
    
    //This needs to be done in case the JSON to be sent is for creating the object or updating.
    if(_object.objectId == nil){
        objParams = [_object postParameters];
    }
    else{
        objParams = [_object postParametersUpdate];
    }
    
    [dict setValue:objParams forKey:@"object"];
    
    return dict;
}

@end

@interface APEdge()
@property (nonatomic,strong) APConnection * connection;

@end

@implementation APEdge

-(instancetype) initWithConnection:(APConnection *) con{
    
    if(self = [self init]){
        self.connection = con;
    }
    return self;
}
- (NSMutableDictionary *) getPostObject{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSDictionary * objParams;
    
    if(_connection.objectId == nil){
        objParams = [_connection parameters];
    }
    else{
        objParams = [_connection postParamertersUpdate];
    }
    
    [dict setValue:objParams forKeyPath:@"connection"];
    return dict;
}


@end


