//
//  APObject.h
//  Appacitive-iOS-SDK
//
//  Created by Kauserali Hafizji on 29/08/12.
//  Copyright (c) 2012 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import "APResponseBlocks.h"

@class APError;

extern NSString *const OBJECT_PATH;

@protocol APObjectPropertyMapping <NSObject>

@required

- (void) setPropertyValuesFromDictionary:(NSDictionary*) dictionary;

@end
/**
 An APObject is a basic unit to store information in.
 It represents an instance of a type.
 Data can be stored in key-value pairs in the properties and attributes fields.
 */
@interface APObject : NSObject <APObjectPropertyMapping> {
    
@protected
    NSString *_lastModifiedBy;
    NSDate *_utcDateCreated;
    NSDate *_utcLastUpdatedDate;
    NSNumber *_revision;
    NSMutableArray *_properties;
    NSMutableDictionary *_attributes;
    NSUInteger _tagsHash;
    NSUInteger _attrHash;
    NSUInteger _propHash;
}

@property (nonatomic, strong) NSString *createdBy;
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong, readonly) NSString *lastModifiedBy;
@property (nonatomic, strong, readonly) NSDate *utcDateCreated;
@property (nonatomic, strong, readonly) NSDate *utcLastUpdatedDate;
@property (nonatomic, strong, readonly) NSNumber *revision;
@property (nonatomic, strong, readonly) NSMutableArray *properties;
@property (nonatomic, strong, readonly) NSMutableDictionary *attributes;
@property (nonatomic, strong) NSString *typeId;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSMutableSet *tagsToAdd;
@property (strong, nonatomic) NSMutableSet *tagsToRemove;
@property (nonatomic, readonly) NSUInteger tagsHash;
@property (nonatomic, readonly) NSUInteger attrHash;
@property (nonatomic, readonly) NSUInteger propHash;

@property (nonatomic, weak) id<APObjectPropertyMapping> delegate;

/** @name Getting the APObject */

/**
 Initialize and return an autoreleased APObject for the provided type name.
 
 @param typeName The type this object represents.
 */
- (instancetype) initWithTypeName:(NSString*)typeName;

/**
 @see deleteObjectWithSuccessHandler:failureHandler:
 */
- (void) deleteObject;

/**
 @see deleteObjectWithSuccessHandler:failureHandler:
 */
- (void) deleteObjectWithFailureHandler:(APFailureBlock)failureBlock;

/**
 Deletes and APObject.
 
 This method will delete the object on the remote server. It will not nullify the current properties or attributes.
 
 @param successBlock Block invoked when delete operation is successful
 @param failureBlock Block invoked when delete operation fails.
 */
- (void) deleteObjectWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

/**
 @see deleteObjectWithConnectingConnectionsSuccessHandler:failureHandler:
 */
- (void) deleteObjectWithConnectingConnections;

/**
 @see deleteObjectWithConnectingConnectionsSuccessHandler:failureHandler:
 */
- (void) deleteObjectWithConnectingConnections:(APFailureBlock)failureBlock;

/**
 Deletes an APObject along with any connections it has.
 
 @param successBlock Block invoked when delete operation is successful
 @param failureBlock Block invoked when delete operation is unsuccessful
 */
- (void) deleteObjectWithConnectingConnectionsSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

/** @name Fetch APObjects */

/**
 @see fetchWithSuccessHandler:failureHandler:
 */
- (void) fetch;

/**
 @see fetchWithSuccessHandler:failureHandler:
 */
- (void) fetchWithFailureHandler:(APFailureBlock)failureBlock;

/**
 Method used to fetch an APObject.
 
 This method will use the type and objectId properties to fetch the object. If the objectId and type is not set, results are unexpected.
 
 @param failureBlock Block invoked when the fetch operation fails.
 */
- (void) fetchWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

/** @name Methods to store key-value pairs */

/**
 Method used to add a property to the APObject.
 
 @param keyName key of the data item to be stored.
 @param object Corresponding value to the key.
 */
- (void) addPropertyWithKey:(NSString*) keyName value:(id) object;

/**
 Method used to update an existing property.
 Call update after this method call to persist the update.
 
 @param keyName key of the data item to be updated.
 @param object Corresponding value to the key.
 */
- (void) updatePropertyWithKey:(NSString*) keyName value:(id) object;

/**
 Method used to delete a property.
 Call update after this method call to persist the change.
 
 @param keyName key of the data item to be removed.
 */
- (void) removePropertyWithKey:(NSString*) keyName;

/**
 Method used to retrieve a property using its key.
 
 @param keyName key of the date item to be removed.
 */
- (instancetype) getPropertyWithKey:(NSString*) keyName;

/**
 Method used to add an attibute to the APObject.
 Attributes are used to store extra information.
 
 @param keyName key of the data item to be stored.
 @param object Corresponding value to the key.
 */
- (void) addAttributeWithKey:(NSString*) keyName value:(id) object;

/**
 Method used to update an attribute.
 Call update after this method call to persist the change
 
 @param keyName key of the attribute to be updated.
 @param object Corresponding value to the key.
 */
- (void) updateAttributeWithKey:(NSString*) keyName value:(id) object;

/**
 Method used to remove an attribute.
 Call update after this method call to persist the change
 
 @param keyName key of the attribute to be removed.
 */
- (void) removeAttributeWithKey:(NSString*) keyName;

/** @name Save APObjects */

/**
 @see saveObjectWithSuccessHandler:failureHandler:
 */
- (void) saveObject;

/**
 @see saveObjectWithSuccessHandler:failureHandler:
 */
- (void) saveObjectWithFailureHandler:(APFailureBlock)failureBlock;

/**
 Save the object on the remote server.
 
 This method will save an object in the background. If save is successful the properties will be updated and the successBlock will be invoked. If not the failure block is invoked.
 
 @param successBlock Block invoked when the save operation is successful
 @param failureBlock Block invoked when the save operation fails.
 
 */
- (void) saveObjectWithSuccessHandler:(APResultSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

/** @name Update APObjects */

/**
 @see updateObjectWithSuccessHandler:failureHandler:
 */
- (void) updateObject;

/**
 @see updateObjectWithSuccessHandler:failureHandler:
 */
- (void) updateObjectWithFailureHandler:(APFailureBlock)failureBlock;

/**
 Method used to update an APObject.
 
 @param successBlock Block invoked when the update operation is successful.
 @param failureBlock Block invoked when the update operation fails.
 */
- (void) updateObjectWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

/**
 Method to add tags to object
 */
- (void) addTag:(NSString*)tag;

/**
 Method to remove tags from object
 */
- (void) removeTag:(NSString*)tag;

@end

@interface APObjects : NSObject

/** @name Searching for APObjects */

/**
 Initialize and return an autoreleased APObject for the provided type name.
 
 @param typeName The type this object represents.
 */
+ (APObject*) objectWithTypeName:(NSString*)typeName;

/**
 @see searchAllObjectsWithTypeName:successHandler:failureHandler:
 */
+ (void) searchAllObjectsWithTypeName:(NSString*) typeName successHandler:(APResultSuccessBlock)successBlock;

/**
 Searches for all APObjects of a particular type.
 
 @param typeName The type that the objects should belong to.
 @param successBlock Block invoked when the search call is successful.
 @param failureBlock Block invoked when search call fails.
 */
+ (void) searchAllObjectsWithTypeName:(NSString*) typeName successHandler:(APResultSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

/**
 @see searchObjectsWithTypeName:withQueryString:successHandler:failureHandler:
 */
+ (void) searchObjectsWithTypeName:(NSString*)typeName withQueryString:(NSString*)queryString successHandler:(APResultSuccessBlock)successBlock;

/**
 Searches for APObjects and filters the results according to the query string.
 
 @param typeName The type of the objects you want to search.
 @param queryString SQL kind of query to search for specific objects. For more info http://appacitive.com
 @param successBlock Block invoked when the search call is successful.
 @param failureBlock Block invoked when the search call fails.
 */
+ (void) searchObjectsWithTypeName:(NSString*)typeName withQueryString:(NSString*)queryString successHandler:(APResultSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

/** @name Deleting APObjects */

/**
 @see deleteObjectsWithIds:typeName:successHandler:failureHandler:
 */
+ (void) deleteObjectsWithIds:(NSArray*)objectIds typeName:(NSString*)typeName failureHandler:(APFailureBlock)failureBlock;

/**
 Deletes multiple APObjects.
 
 @param objectIds The ids of the objects to delete.
 @param typeName The type that the objects belong to.
 @param successBlock Block invoked when the multi delete operation succeeds.
 @param failureBlock Block invoked when the multi delete operation fails.
 */
+ (void) deleteObjectsWithIds:(NSArray*)objectIds typeName:(NSString*)typeName successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

/** @name Fetch APObjects */

/**
 @see fetchObjectsWithObjectIds:typeName:successHandler:failureHandler:
 */
+ (void) fetchObjectWithObjectId:(NSString*)objectId typeName:(NSString*)typeName successHandler:(APResultSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

/**
 Retrieves multiple APObjects of a particular type.
 
 @param objectIds The ids of the objects.
 @param typeName The type name the objects belong to.
 @param successBlock Block invoked when the retrieve operation succeeds.
 @param failureBlock Block invoked when the failure operation succeeds.
 */
+ (void) fetchObjectsWithObjectIds:(NSArray*)objectIds typeName:(NSString *)typeName successHandler:(APResultSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;


@end

