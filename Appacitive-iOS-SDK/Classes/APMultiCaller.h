//
//  APMultiCaller.h
//  Appacitive-iOS-SDK
//
//  Created by Neil Unadkat on 12/08/14.
//  Copyright (c) 2014 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APObject.h"
#import "APConnection.h"

@interface APMultiCaller : NSObject

//@property (nonatomic,strong) NSArray *nodes;
//@property (nonatomic,strong) NSArray *edges;


- (void) addAPObject:(APObject *) object;
- (void) addAPConnection :(APConnection *) connection;

- (instancetype) initWithAPObjects:(NSArray *) objects;
- (instancetype) initWithAPConnections:(NSArray *) connections;
- (instancetype) initWithAPObjects:(NSArray *) objects andAPConnections:(NSArray *) connections;



/**
 @see saveWithSuccessHandler:andFailureHandlerBlock:
 */
- (void) save;

/**
 @see saveWithSuccessHandler:andFailureHandlerBlock:
 */
- (void) saveWithFailureHandlerBlock:(APFailureBlock) failureHandlerBlock;

/**
 Save all the objects and connections on the remote server.
 This method will save an object in the background. If save is successful the properties will be updated and the successBlock will be invoked. If not the failure block is invoked.
 @param successBlock Block invoked when the save operation is successful
 @param failureBlock Block invoked when the save operation fails.
 
 */
- (void) saveWithSuccessHandler:(APSuccessBlock) successBlock andFailureHandlerBlock:(APFailureBlock) failureHandlerBlock;


@end

@interface APNode : NSObject
-(instancetype) initWithName:(NSString *) name andObject:(APObject *) obj;
- (NSMutableDictionary *) getPostObject;
- (NSString *) getName;
@end



@interface APEdge : NSObject

@property NSString * endpointAName ;
@property NSString * endpointBName ;

-(instancetype) initWithConnection:(APConnection *) con;
- (NSMutableDictionary *) getPostObject;

@end