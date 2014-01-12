//
//  APGraphNode.h
//  Appacitive-iOS-SDK
//
//  Created by Pratik on 07-01-14.
//  Copyright (c) 2014 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import "APResponseBlocks.h"
#import "APObject.h"
#import "APConnection.h"

@interface APGraphNode : NSObject {
    APObject *_object;
    APConnection *_connection;
    NSDictionary *_map;
}

@property (strong, nonatomic, readonly) APObject* object;
@property (strong, nonatomic, readonly) APConnection* connection;
@property (strong, nonatomic, readonly) NSDictionary* map;

- (NSArray*) getChildrenOf:(NSString*)objectId;

/** @name Apply graph queries */

/**
 @see applyFilterGraphQuery:successHandler:failureHandler:
 */
+ (void) applyFilterGraphQuery:(NSString*)query usingPlaceHolders:(NSDictionary*)placeHolders successHandler:(APResultSuccessBlock)successBlock;

/**
 Searches for APObjects that satisfy the filter graph query.
 
 A filter query is a kind that does not have a starting point in the graph. All the APObjects that satisfy the query will be returned. To know more visit http://wwww.appacitive.com
 
 @param query A string representing the filter graph query.
 @param successBlock Block invoked when query is successfully executed.
 @param failureBlock Block invoked when query execution fails.
 */
+ (void) applyFilterGraphQuery:(NSString*)query usingPlaceHolders:(NSDictionary*)placeHolders successHandler:(APResultSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

/**
 @see applyProjectionGraphQuery:successHandler:failureHandler:
 */
- (void) applyProjectionGraphQuery:(NSString *)query usingPlaceHolders:(NSDictionary*)placeHolders forObjectsIds:(NSArray*)objectIDs successHandler:(APGraphNodeSuccessBlock)successBlock;

/**
 Searches for APObjects that satisfy the projection graph query.
 
 A projection query will search for results from a starting node in the graph. To know more visit http://wwww.appacitive.com
 
 @param query A string representing the projection graph query.
 @param successBlock Block invoked when query is successfully executed.
 @param failureBlock Block invoked when query execution fails.
 */
- (void) applyProjectionGraphQuery:(NSString *)query usingPlaceHolders:(NSDictionary*)placeHolders forObjectsIds:(NSArray*)objectIDs successHandler:(APGraphNodeSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

@end
