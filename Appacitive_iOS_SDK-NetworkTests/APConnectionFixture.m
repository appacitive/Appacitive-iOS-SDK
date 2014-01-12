#import "Appacitive.h"
#import "APObject.h"
#import "APError.h"
#import "APQuery.h"
#import "APConnection.h"
#import "APHelperMethods.h"

SPEC_BEGIN(APConnectionTests)

describe(@"APConnectionTests", ^{

    beforeAll(^() {
        [Appacitive initWithAPIKey:API_KEY];
        [Appacitive useLiveEnvironment:NO];
        [[expectFutureValue([Appacitive getApiKey]) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
    });
    
    afterAll(^(){
    });
//
//#pragma mark TESTING_RETRIEVE_PROPERTY
//    
//    it(@"should not return a nil value for retrieving a valid property", ^{
//        APConnection *connection = [APConnection connectionWithRelationType:@"sdktest"];
//        [connection addPropertyWithKey:@"Test" value:@"Testing"];
//        
//        id property = [connection getPropertyWithKey:@"Test"];
//        [property shouldNotBeNil];
//    });
//    
//#pragma mark TESTING_FETCH_REQUEST
//    
//    it(@"should not return an error for fetching a connection with a valid object and relationtype", ^{
//        __block BOOL isFetchSuccessful = NO;
//        
//        APConnection *connection = [APConnection connectionWithRelationType:@"details"];
//        connection.objectId = @"43248483773317574";
//        [connection fetchConnectionWithSuccessHandler:^(){
//            isFetchSuccessful = YES;
//        } failureHandler:^(APError *error) {
//            isFetchSuccessful = NO;
//        }];
//        
//        
//        [[expectFutureValue(theValue(isFetchSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//
//#pragma mark UPDATE_PROPERTY_TEST
//    
//    it(@"should not return an error for updating a property of a connection", ^{
//        __block BOOL isUpdateSuccessful = NO;
//        
//        __block APConnection *connection = [APConnection connectionWithRelationType:@"details"];
//        connection.objectId = @"43248483773317574";
//        [connection fetchConnectionWithSuccessHandler:^(){
//            [connection updatePropertyWithKey:@"prop1" value:@"updateprop2"];
//            [connection updateConnectionWithSuccessHandler:^() {
//                isUpdateSuccessful = YES;
//            } failureHandler:nil];
//        } failureHandler:nil];
//        
//        [[expectFutureValue(theValue(isUpdateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//#pragma mark DELETE_PROPERTY_TEST
//    
//    it(@"should not return an error for deleting a property of a connection", ^{
//        __block BOOL isDeleteSuccessful = NO;
//        
//        __block APConnection *connection = [APConnection connectionWithRelationType:@"details"];
//        connection.objectId = @"43248483773317574";
//        [connection fetchConnectionWithSuccessHandler:^(){
//            [connection removePropertyWithKey:@"prop2"];
//            [connection updateConnectionWithSuccessHandler:^() {
//                isDeleteSuccessful = YES;
//            } failureHandler:nil];
//        } failureHandler:nil];
//        
//        [[expectFutureValue(theValue(isDeleteSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//#pragma mark UPDATE_ATTRIBUTE_TEST
//    
//    it(@"should not return an error for updating an attribute of a connection", ^{
//        __block BOOL isUpdateSuccessful = NO;
//        
//        __block APConnection *connection = [APConnection connectionWithRelationType:@"details"];
//        connection.objectId = @"43248483773317574";
//        [connection fetchConnectionWithSuccessHandler:^(){
//            [connection updateAttributeWithKey:@"new" value:@"updateatt"];
//            [connection updateConnectionWithSuccessHandler:^() {
//                isUpdateSuccessful = YES;
//            } failureHandler:nil];
//        } failureHandler:nil];
//        
//        [[expectFutureValue(theValue(isUpdateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//#pragma mark DELETE_ATTRIBUTE_TEST
//    
//    it(@"should not return an error for deleting an attribute of a connection", ^{
//        __block BOOL isDeleteSuccessful = NO;
//        __block APConnection *connection = [APConnection connectionWithRelationType:@"test3"];
//        __block NSString *objectId1;
//        __block NSString *objectId2;
//        NSString *pnum = [APQuery queryWithPageNumber:1];
//        NSString *psize = [APQuery queryWithPageSize:1];
//        NSString *query = [NSString stringWithFormat:@"%@&%@", pnum, psize];
//        
//        [APObjects searchObjectsWithTypeName:@"sdktest" withQueryString:query
//                              successHandler:^(NSDictionary *result){
//                                  NSArray *objects = result[@"objects"];
//                                  NSDictionary *dict = [objects lastObject];
//                                  objectId1 = dict[@"__id"];
//                                  [APObjects searchObjectsWithTypeName:@"sdk" withQueryString:query
//                                                        successHandler:^(NSDictionary *result){
//                                                            NSArray *objects = result[@"objects"];
//                                                            NSDictionary *dict = [objects lastObject];
//                                                            objectId2 = dict[@"__id"];
//                                                            
//                                                            [connection createConnectionWithObjectAId:objectId1 objectBId:objectId2 labelA:@"sdktest" labelB:@"sdk" successHandler:^(){
//                                                                [connection addAttributeWithKey:@"beDeleted" value:@"yes"];
//                                                            }failureHandler:^(APError *error) {
//                                                                
//                                                            }];
//                                                        } failureHandler:^(APError *error){
//                                                            
//                                                        }];
//                              } failureHandler:^(APError *error){
//                                  
//                              }];
//        
//            [connection removeAttributeWithKey:@"beDeleted"];
//            [connection updateConnectionWithSuccessHandler:^() {
//                isDeleteSuccessful = YES;
//            } failureHandler:nil];
//        [[expectFutureValue(theValue(isDeleteSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//
//#pragma mark CREATION_TESTS
//    
//    it(@"should not return an error while creating the connection with proper objectIds", ^{
//        __block BOOL isConnectionCreated = NO;
//        __block NSString *objectId1;
//        __block NSString *objectId2;
//        
//        NSString *pnum = [APQuery queryWithPageNumber:1];
//        NSString *psize = [APQuery queryWithPageSize:1];
//        
//        NSString *query = [NSString stringWithFormat:@"%@&%@", pnum, psize];
//        APConnection *connection = [APConnection connectionWithRelationType:@"test3"];
//        [APObjects searchObjectsWithTypeName:@"sdktest" withQueryString:query
//                              successHandler:^(NSDictionary *result){
//                                  NSArray *objects = result[@"objects"];
//                                  NSDictionary *dict = [objects lastObject];
//                                  objectId1 = dict[@"__id"];
//                                  [APObjects searchObjectsWithTypeName:@"sdk" withQueryString:query
//                                                        successHandler:^(NSDictionary *result){
//                                                            NSArray *objects = result[@"objects"];
//                                                            NSDictionary *dict = [objects lastObject];
//                                                            objectId2 = dict[@"__id"];
//                                                            
//                                                            [connection createConnectionWithObjectAId:objectId1 objectBId:objectId2 labelA:@"sdktest" labelB:@"sdk" successHandler:^(){
//                                                                isConnectionCreated = YES;
//                                                                [connection deleteConnection];
//                                                            }failureHandler:^(APError *error) {
//                                                                isConnectionCreated = NO;
//                                                            }];
//                                                        } failureHandler:^(APError *error){
//                                                            isConnectionCreated = NO;
//                                                        }];
//                              } failureHandler:^(APError *error){
//                                  isConnectionCreated = NO;
//                              }];
//        [[expectFutureValue(theValue(isConnectionCreated)) shouldEventuallyBeforeTimingOutAfter(10.0)] equal:theValue(YES)];
//    });
//
//    it(@"should not return an error while creating the connection with proper objectIds", ^{
//        __block BOOL isConnectionCreated = NO;
//        __block NSString *objectId1;
//        
//        __block APObject *sdkObj = [[APObject alloc] initWithTypeName:@"sdk"];
//        [sdkObj addPropertyWithKey:@"name" value:@"noname"];
//        __block APConnection *connection = [APConnection connectionWithRelationType:@"test3"];
//        
//        [APObjects searchObjectsWithTypeName:@"sdktest" withQueryString:nil
//                              successHandler:^(NSDictionary *result){
//                                    NSArray *objects = result[@"objects"];
//                                    NSDictionary *dict = [objects lastObject];
//                                    objectId1 = dict[@"__id"];
//                                    
//                                    [connection createConnectionWithObjectA:sdkObj objectBId:objectId1 labelA:@"sdk" labelB:@"sdktest" successHandler:^(){
//                                        isConnectionCreated = YES;
//                                        [sdkObj deleteObjectWithConnectingConnectionsSuccessHandler:^{
//                                            DLog(@"\n––––––––Object deleted––––––––\n");
//                                        } failureHandler:^(APError *error) {
//                                            DLog(@"\n––––––––––ERRO–––––––––––\n%@\n",error.description);
//                                        }];
//                                    }failureHandler:^(APError *error) {
//                                        isConnectionCreated = NO;
//                                        [sdkObj deleteObject];
//                                    }];
//                              } failureHandler:^(APError *error){
//                                  isConnectionCreated = NO;
//                                  [sdkObj deleteObject];
//                              }];
//        [[expectFutureValue(theValue(isConnectionCreated)) shouldEventuallyBeforeTimingOutAfter(10.0)] equal:theValue(YES)];
//    });

//
//    it(@"should return an error for creating a connection with invalid relation type", ^{
//        __block BOOL isConnectionCreatFailed = NO;
//        
//        APConnection *connection = [APConnection connectionWithRelationType:@"relationThatDoesNotExist"];
//        [connection createConnectionWithObjectAId:@"0"
//                        objectBId:@"0"
//                        labelA:@"Location"
//                        labelB:@"Comment"
//                        successHandler:^(void){
//                            isConnectionCreatFailed = NO;
//                        } failureHandler:^(APError *error) {
//                            isConnectionCreatFailed = YES;
//                        }];
//        
//        [[expectFutureValue(theValue(isConnectionCreatFailed)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    
//    it(@"should return an error while creating a connection with invalid object id and comment id", ^{
//        __block BOOL isConnectionCreated = NO;
//        APConnection *connection = [APConnection connectionWithRelationType:@"LocationComment"];
//        [connection createConnectionWithObjectAId:@"0"
//                    objectBId:@"0"
//                    labelA:@"Location"
//                    labelB:@"Comment"
//                    successHandler:^(void){
//                        isConnectionCreated = NO;
//                    }failureHandler:^(APError *error) {
//                        isConnectionCreated = YES;
//                    }];
//        [[expectFutureValue(theValue(isConnectionCreated)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//
//#pragma mark SEARCH_TESTS
//    
//    it(@"should not return an error while search for valid relation types", ^{
//        __block BOOL isSearchingSuccesful = NO;
//        [APConnections
//            searchForAllConnectionsWithRelationType:@"test"
//            successHandler:^(NSDictionary *result){
//                isSearchingSuccesful = YES;
//            } failureHandler:^(APError *error){
//                isSearchingSuccesful = NO;
//            }];
//        [[expectFutureValue(theValue(isSearchingSuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    
//
//    it(@"should return an error while search for invalid connections", ^{
//        __block BOOL isSearchingUnsuccesful = NO;
//        [APConnections
//            searchForAllConnectionsWithRelationType:@"relationThatDoesNotExist"
//            successHandler:^(NSDictionary *result){
//                isSearchingUnsuccesful = NO;
//            } failureHandler:^(APError *error){
//                isSearchingUnsuccesful = YES;
//            }];
//        [[expectFutureValue(theValue(isSearchingUnsuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    pending_(@"should not return an error with search call along with valid query string", ^(){
//    
//    });
//    
//    pending_(@"should return an error with search call along with invalid query string", ^(){
//        
//    });
//    
//#pragma mark INTERCONNECTS_TESTS
//    
//    it(@"should return not an error while search for valid objectIds", ^{
//        __block BOOL isSearchingSuccesful = NO;
//        NSArray * objectIds = [NSArray arrayWithObjects:@"12094464603586988",@"926377",@"926372",@"926364",nil];
//        NSString * objectId = @"926345";
//        [APConnections searchAllConnectionsFromObjectId:objectId toObjectIds:objectIds withSuccessHandler:^(NSDictionary *results){
//            NSLog(@"Success block %@" , [results description]);
//            isSearchingSuccesful = YES;
//        }failureHandler:^(APError *error) {
//            NSLog(@"Failure block %@" , [error description]);
//            isSearchingSuccesful = NO;
//        }];
//        [[expectFutureValue(theValue(isSearchingSuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"should return an error while search for invalid objectIds", ^{
//        __block BOOL isSearchingUnsuccesful = NO;
//        NSArray * objectIds = [NSArray arrayWithObjects:@"15896369232480359",@"15896362656860262",@"15896351207458582",@"15896338793367317",nil];
//        NSString * objectId = @"-34432233";
//        [APConnections searchAllConnectionsFromObjectId:objectId toObjectIds:objectIds withSuccessHandler:^(NSDictionary *results){
//            NSLog(@"Success block %@" , [results description]);
//            isSearchingUnsuccesful = NO;
//        }failureHandler:^(APError *error) {
//            NSLog(@"Failure block %@" , [error description]);
//            isSearchingUnsuccesful = YES;
//        }];
//        [[expectFutureValue(theValue(isSearchingUnsuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//#pragma mark DELETE_TESTS
//
//    it(@"should not return an error for the delete call with valid relation name and valid objectid", ^{
//        __block BOOL isConnectionDeletionSuccessful = NO;
//        
//        __block NSString *objectId1;
//        __block NSString *objectId2;
//        NSString *query = [NSString stringWithFormat:@"pnum=1&psize=1"];
//        APConnection *connection1 = [[APConnection alloc] initWithRelationType:@"test2"];
//        APConnection *connection2 = [[APConnection alloc] initWithRelationType:@"test2"];
//        [APObjects searchObjectsWithTypeName:@"sdktest" withQueryString:query
//                              successHandler:^(NSDictionary *result){
//                                  NSArray *objects = result[@"objects"];
//                                  NSDictionary *dict = [objects lastObject];
//                                  objectId1 = dict[@"__id"];
//                                  [APObjects searchObjectsWithTypeName:@"sdk" withQueryString:query
//                                                        successHandler:^(NSDictionary *result){
//                                                            NSArray *objects = result[@"objects"];
//                                                            NSDictionary *dict = [objects lastObject];
//                                                            objectId2 = dict[@"__id"];
//                                                            [connection1 createConnectionWithObjectAId:objectId1 objectBId:objectId2 labelA:@"sdktest" labelB:@"sdk"];
//                                                            [connection2 createConnectionWithObjectAId:objectId2 objectBId:objectId1 labelA:@"sdk" labelB:@"sdktest"];
//                                                        }];
//                              }];
//        [APConnections
//         deleteConnectionsWithRelationType:@"test2"
//         objectIds:@[objectId1,objectId2]
//         successHandler:^{
//             isConnectionDeletionSuccessful = YES;
//         } failureHandler:^(APError *error){
//             isConnectionDeletionSuccessful = NO;
//         }];
//        
//    [[expectFutureValue(theValue(isConnectionDeletionSuccessful)) shouldEventuallyBeforeTimingOutAfter(10.0)] equal:theValue(YES)];
//    });
//
//    
//    it(@"should return an error for delete call using invalid relation type and object id", ^{
//        __block BOOL isConnectionDeletionSuccessful = NO;
//        [APConnections
//            deleteConnectionsWithRelationType:@"relationThatDoesNotExist"
//            objectIds:@[@-12,@-21]
//            successHandler:^{
//                isConnectionDeletionSuccessful = YES;
//            } failureHandler:^(APError *error){
//                isConnectionDeletionSuccessful = NO;
//            }];
//        [[expectFutureValue(theValue(!isConnectionDeletionSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    
//    it(@"should not return an error while deleting a connection with valid objectid", ^{
//        __block BOOL isConnectionDeleted = NO;
//        __block NSString *objectId1;
//        __block NSString *objectId2;
//        
//        NSString *pnum = [APQuery queryWithPageNumber:1];
//        NSString *psize = [APQuery queryWithPageSize:1];
//        NSString *query = [NSString stringWithFormat:@"%@&%@", pnum, psize];
//        
//        APConnection *connection = [APConnection connectionWithRelationType:@"test3"];
//        [APObjects searchObjectsWithTypeName:@"sdktest" withQueryString:query
//                              successHandler:^(NSDictionary *result){
//                                  NSArray *objects = result[@"objects"];
//                                  NSDictionary *dict = [objects lastObject];
//                                  objectId1 = dict[@"__id"];
//                                  [APObjects searchObjectsWithTypeName:@"sdk" withQueryString:query
//                                                        successHandler:^(NSDictionary *result){
//                                                            NSArray *objects = result[@"objects"];
//                                                            NSDictionary *dict = [objects lastObject];
//                                                            objectId2 = dict[@"__id"];
//                                                            
//                                                            [connection createConnectionWithObjectAId:objectId1 objectBId:objectId2 labelA:@"sdktest" labelB:@"sdk" successHandler:^(){
//                                                                
//                                                                [connection deleteConnectionWithSuccessHandler:^{
//                                                                    isConnectionDeleted = YES;
//                                                                } failureHandler:^(APError *error){
//                                                                    isConnectionDeleted = NO;
//                                                                }];
//                                                            } failureHandler:^(APError *error){
//                                                                isConnectionDeleted = NO;
//                                                            }];
//                                                            
//                                                        }failureHandler:^(APError *error) {
//                                                        }];
//                              } failureHandler:^(APError *error){
//                                  
//                              }];
////        [APConnections
////            searchForConnectionsWithRelationType:@"test4"
////            withQueryString:query
////            successHandler:^(NSDictionary *result) {
////                NSArray *connections = result[@"connections"];
////                NSDictionary *dict = [connections lastObject];
////                
////                APConnection *connectionObject = [APConnection connectionWithRelationType:@"sdktest"];
////                connectionObject.objectId = dict[@"__id"];
////                
////                [connectionObject deleteConnectionWithSuccessHandler:^{
////                    isConnectionDeleted = YES;
////                } failureHandler:^(APError *error){
////                    isConnectionDeleted = NO;
////                }];
////            } failureHandler:^(APError *error){
////                isConnectionDeleted = NO;
////            }];
//       
//        [[expectFutureValue(theValue(isConnectionDeleted)) shouldEventuallyBeforeTimingOutAfter(10.0)] equal:theValue(YES)];
//    });
//
//#pragma mark FETCH_TESTS
//    
//    it(@"should not return an error for fetch call with valid object id", ^{
//        
//        __block BOOL isFetchSuccesful = NO;
//        
//        NSString *pnum = [APQuery queryWithPageNumber:1];
//        NSString *psize = [APQuery queryWithPageSize:1];
//        NSString *query = [NSString stringWithFormat:@"%@&%@", pnum, psize];
//        
//        [APConnections searchForConnectionsWithRelationType:@"test4"
//                        withQueryString:query
//                        successHandler:^(NSDictionary *result){
//                            NSArray *connections = result[@"connections"];
//                            NSDictionary *dict = [connections lastObject];
//                            NSString *connectionId = dict[@"__id"];
//                            [APConnections
//                                fetchConnectionWithRelationType:@"test4"
//                                objectId:connectionId
//                                successHandler:^(NSDictionary *result){
//                                    isFetchSuccesful = YES;
//                                } failureHandler:^(APError *error){
//                                    isFetchSuccesful = NO;
//                                }];
//                        } failureHandler:^(APError *error){
//                            isFetchSuccesful = NO;
//                        }];
//        
//        [[expectFutureValue(theValue(isFetchSuccesful)) shouldEventuallyBeforeTimingOutAfter(10.0)] equal:theValue(YES)];
//    });
//
//    it(@"should return an error for fetch call with invalid object id", ^{
//        __block BOOL isFetchUnsuccesful = NO; 
//        
//        [APConnections
//            fetchConnectionWithRelationType:@"test2"
//            objectId:@"-2313"
//            successHandler:^(NSDictionary *result){
//                isFetchUnsuccesful = NO;
//            } failureHandler:^(APError *error){
//                isFetchUnsuccesful = YES;
//            }];
//
//        [[expectFutureValue(theValue(isFetchUnsuccesful)) shouldEventuallyBeforeTimingOutAfter(10.0)] equal:theValue(YES)];
//    });
});
SPEC_END

