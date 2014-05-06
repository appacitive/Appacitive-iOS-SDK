//#import "Appacitive.h"
//#import "APObject.h"
//#import "APError.h"
//#import "APQuery.h"
//#import "APConnection.h"
//#import "APHelperMethods.h"
//
//SPEC_BEGIN(APConnectionTests)
//
//describe(@"APConnectionTests", ^{
//    
//    beforeAll(^() {
//        [Appacitive registerAPIKey:API_KEY useLiveEnvironment:YES];
//        [Appacitive useLiveEnvironment:NO];
//        [[expectFutureValue([Appacitive getApiKey]) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
//    });
//    
//    afterAll(^(){
//    });
//
//#pragma mark - TESTING_RETRIEVE_PROPERTY
//
//    it(@"retrieve a valid property", ^{
//        APConnection *connection = [APConnection connectionWithRelationType:@"sdktest"];
//        [connection addPropertyWithKey:@"Test" value:@"Testing"];
//
//        id property = [connection getPropertyWithKey:@"Test"];
//        [property shouldNotBeNil];
//    });
//
//#pragma mark - TESTING_FETCH_REQUEST
//
//    it(@"fetch a connection with a valid object and relationtype", ^{
//        __block BOOL isFetchSuccessful = NO;
//        __block APConnection *connection = [APConnection connectionWithRelationType:@"testconnection"];
//        __block NSString *object1Id;
//        __block NSString *object2Id;
//        
//        APQuery *queryObj = [[APQuery alloc] init];
//        queryObj.pageNumber = 1;
//        queryObj.pageSize = 1;
//
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQuery:[queryObj stringValue]
//                              successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//                                  object1Id = ((APObject*)[objects lastObject]).objectId;
//                                  [APObject searchAllObjectsWithTypeName:@"sdk" withQuery:[queryObj stringValue]
//                                                        successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//                                                            object2Id = ((APObject*)[objects lastObject]).objectId;
//                                                            [connection createConnectionWithObjectAId:object1Id objectBId:object2Id labelA:@"sdktest" labelB:@"sdk" successHandler:^(){
//                                                                [connection fetchConnectionWithSuccessHandler:^(){
//                                                                    [connection deleteConnection];
//                                                                    isFetchSuccessful = YES;
//                                                                } failureHandler:^(APError *error) {
//                                                                    isFetchSuccessful = NO;
//                                                                }];
//                                                            }failureHandler:^(APError *error) {
//                                                            }];
//                                                        } failureHandler:^(APError *error){
//                                                        }];
//                              } failureHandler:^(APError *error){
//                              }];
//
//        [[expectFutureValue(theValue(isFetchSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//
//#pragma mark - UPDATE_PROPERTY_TEST
//
//    it(@"update a property of a connection", ^{
//        __block BOOL isUpdateSuccessful = NO;
//        __block APConnection *connection = [APConnection connectionWithRelationType:@"testconnection"];
//        [connection addPropertyWithKey:@"name" value:@"prop1"];
//        __block NSString *object1Id;
//        __block NSString *object2Id;
//        APQuery *queryObj = [[APQuery alloc] init];
//        queryObj.pageNumber = 1;
//        queryObj.pageSize = 1;
//        
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQuery:[queryObj stringValue]
//                              successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//                                  object1Id = ((APObject*)[objects lastObject]).objectId;
//                                  [APObject searchAllObjectsWithTypeName:@"sdk" withQuery:[queryObj stringValue]
//                                                        successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//                                                            object2Id = ((APObject*)[objects lastObject]).objectId;
//                                                            [connection createConnectionWithObjectAId:object1Id objectBId:object2Id labelA:@"sdktest" labelB:@"sdk" successHandler:^(){
//                                                                [connection updatePropertyWithKey:@"name" value:@"prop2"];
//                                                                [connection updateConnectionWithSuccessHandler:^() {                                                                    [connection deleteConnection];
//                                                                    isUpdateSuccessful = YES;
//                                                                } failureHandler:nil];
//                                                            } failureHandler:nil];
//                                                        }failureHandler:^(APError *error) {
//                                                        }];
//                              } failureHandler:^(APError *error){
//                              }];
//
//        [[expectFutureValue(theValue(isUpdateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//#pragma mark - DELETE_PROPERTY_TEST
//
//    it(@"delete a property of a connection", ^{
//        __block BOOL isDeleteSuccessful = NO;
//        __block APConnection *connection = [APConnection connectionWithRelationType:@"testconnection"];
//        [connection addPropertyWithKey:@"name" value:@"prop1"];
//        __block NSString *object1Id;
//        __block NSString *object2Id;
//        APQuery *queryObj = [[APQuery alloc] init];
//        queryObj.pageNumber = 1;
//        queryObj.pageSize = 1;
//
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQuery:[queryObj stringValue]
//                              successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords) {
//                                  object1Id = ((APObject*)[objects lastObject]).objectId;
//                                  [APObject searchAllObjectsWithTypeName:@"sdk" withQuery:[queryObj stringValue]
//                                                        successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords) {
//                                                            object2Id = ((APObject*)[objects lastObject]).objectId;
//                                                            [connection createConnectionWithObjectAId:object1Id objectBId:object2Id labelA:@"sdktest" labelB:@"sdk" successHandler:^(){
//                                                                [connection removePropertyWithKey:@"prop2"];
//                                                                [connection updateConnectionWithSuccessHandler:^() {
//                                                                    [connection deleteConnection];
//                                                                    isDeleteSuccessful = YES;
//                                                                } failureHandler:nil];
//                                                            } failureHandler:nil];
//                                                        }failureHandler:^(APError *error) {
//                                                        }];
//                              } failureHandler:^(APError *error){
//                              }];
//        [[expectFutureValue(theValue(isDeleteSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//#pragma mark - UPDATE_ATTRIBUTE_TEST
//
//    it(@"update an attribute of a connection", ^{
//        __block BOOL isUpdateSuccessful = NO;
//        __block APConnection *connection = [APConnection connectionWithRelationType:@"testconnection"];
//        [connection addAttributeWithKey:@"att1" value:@"attValue"];
//        __block NSString *object1Id;
//        __block NSString *object2Id;
//        APQuery *queryObj = [[APQuery alloc] init];
//        queryObj.pageNumber = 1;
//        queryObj.pageSize = 1;
//
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQuery:[queryObj stringValue]
//                              successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords) {
//                                  object1Id = ((APObject*)[objects lastObject]).objectId;
//                                  [APObject searchAllObjectsWithTypeName:@"sdk" withQuery:[queryObj stringValue]
//                                                        successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords) {
//                                                            object2Id = ((APObject*)[objects lastObject]).objectId;
//                                                            [connection createConnectionWithObjectAId:object1Id objectBId:object2Id labelA:@"sdktest" labelB:@"sdk" successHandler:^(){
//                                                                [connection removeAttributeWithKey:@"att1"];
//                                                                [connection updateConnectionWithSuccessHandler:^() {
//                                                                    [connection deleteConnection];
//                                                                    isUpdateSuccessful = YES;
//                                                                } failureHandler:nil];
//                                                            } failureHandler:nil];
//                                                        }failureHandler:^(APError *error) {
//                                                        }];
//                              } failureHandler:^(APError *error){
//                              }];
//
//        [[expectFutureValue(theValue(isUpdateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//#pragma mark - DELETE_ATTRIBUTE_TEST
//
//    it(@"delete an attribute of a connection", ^{
//        __block BOOL isDeleteSuccessful = NO;
//        __block APConnection *connection = [APConnection connectionWithRelationType:@"testconnection"];
//        [connection addAttributeWithKey:@"beDeleted" value:@"yes"];
//        __block NSString *object1Id;
//        __block NSString *object2Id;
//        APQuery *queryObj = [[APQuery alloc] init];
//        queryObj.pageNumber = 1;
//        queryObj.pageSize = 1;
//        NSString *query = [queryObj stringValue];
//
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQuery:query
//                              successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//                                  object1Id = ((APObject*)[objects lastObject]).objectId;
//                                  [APObject searchAllObjectsWithTypeName:@"sdk" withQuery:query
//                                                        successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//                                                            object2Id = ((APObject*)[objects lastObject]).objectId;
//                                                            [connection createConnectionWithObjectAId:object1Id objectBId:object2Id labelA:@"sdktest" labelB:@"sdk" successHandler:^(){
//                                                                [connection removeAttributeWithKey:@"beDeleted"];
//                                                                [connection updateConnectionWithSuccessHandler:^{
//                                                                    [connection deleteConnection];
//                                                                    isDeleteSuccessful = YES;
//                                                                } failureHandler:^(APError *error) {
//                                                                    isDeleteSuccessful = NO;
//                                                                }];
//                                                            }failureHandler:^(APError *error) {
//                                                            }];
//                                                        } failureHandler:^(APError *error){
//                                                        }];
//                              } failureHandler:^(APError *error){
//                              }];
//        [[expectFutureValue(theValue(isDeleteSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//
//#pragma mark - CREATION_TESTS
//
//    it(@"create a connection with proper objectIds", ^{
//        __block BOOL isConnectionCreated = NO;
//        __block NSString *object1Id;
//        __block NSString *object2Id;
//
//        APQuery *queryObj = [[APQuery alloc] init];
//        queryObj.pageNumber = 1;
//        queryObj.pageSize = 1;
//        NSString *query = [queryObj stringValue];
//
//        APConnection *connection = [APConnection connectionWithRelationType:@"testconnection"];
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQuery:query
//                              successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//                                  object1Id = ((APObject*)[objects lastObject]).objectId;
//                                  [APObject searchAllObjectsWithTypeName:@"sdk" withQuery:query
//                                                        successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//                                                            object2Id = ((APObject*)[objects lastObject]).objectId;
//                                                            [connection createConnectionWithObjectAId:object1Id objectBId:object2Id labelA:@"sdktest" labelB:@"sdk" successHandler:^(){
//                                                                [connection deleteConnection];
//                                                                isConnectionCreated = YES;
//                                                            }failureHandler:^(APError *error) {
//                                                                isConnectionCreated = NO;
//                                                            }];
//                                                        } failureHandler:^(APError *error){
//                                                            isConnectionCreated = NO;
//                                                        }];
//                              } failureHandler:^(APError *error){
//                                  isConnectionCreated = NO;
//                              }];
//        [[expectFutureValue(theValue(isConnectionCreated)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"create a connection with proper objectIds", ^{
//        __block BOOL isConnectionCreated = NO;
//        __block NSString *object1Id;
//
//        __block APObject *sdkObj = [[APObject alloc] initWithTypeName:@"sdk"];
//        [sdkObj addPropertyWithKey:@"name" value:@"noname"];
//        __block APConnection *connection = [APConnection connectionWithRelationType:@"testconnection"];
//
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQuery:nil
//                              successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//                                  object1Id = ((APObject*)[objects lastObject]).objectId;
//                                  [connection createConnectionWithObjectA:sdkObj objectBId:object1Id labelA:@"sdk" labelB:@"sdktest" successHandler:^(){
//                                      [connection deleteConnection];
//                                      [sdkObj deleteObject];
//                                      isConnectionCreated = YES;
//                                  }failureHandler:^(APError *error) {
//                                      isConnectionCreated = NO;
//                                  }];
//                              } failureHandler:^(APError *error){
//                                  isConnectionCreated = NO;
//                              }];
//        [[expectFutureValue(theValue(isConnectionCreated)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//
//    it(@"create a connection with invalid relation type", ^{
//        __block BOOL isConnectionCreatFailed = NO;
//
//        APConnection *connection = [APConnection connectionWithRelationType:@"relationThatDoesNotExist"];
//        [connection createConnectionWithObjectAId:@"0"
//                                        objectBId:@"0"
//                                           labelA:@"Location"
//                                           labelB:@"Comment"
//                                   successHandler:^(void){
//                                       isConnectionCreatFailed = NO;
//                                   } failureHandler:^(APError *error) {
//                                       isConnectionCreatFailed = YES;
//                                   }];
//
//        [[expectFutureValue(theValue(isConnectionCreatFailed)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//
//    it(@"create a connection with invalid object id and comment id", ^{
//        __block BOOL isConnectionCreated = NO;
//        APConnection *connection = [APConnection connectionWithRelationType:@"LocationComment"];
//        [connection createConnectionWithObjectAId:@"0"
//                                        objectBId:@"0"
//                                           labelA:@"Location"
//                                           labelB:@"Comment"
//                                   successHandler:^(void){
//                                       isConnectionCreated = NO;
//                                   }failureHandler:^(APError *error) {
//                                       isConnectionCreated = YES;
//                                   }];
//        [[expectFutureValue(theValue(isConnectionCreated)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"create a connection with two new objects", ^{
//        __block BOOL isConnectionCreated = NO;
//        APObject *object1 = [[APObject alloc] initWithTypeName:@"sdk"];
//        [object1 addPropertyWithKey:@"name" value:@"newnewtest"];
//        APObject *object2 = [[APObject alloc] initWithTypeName:@"sdktest"];
//        [object2 addPropertyWithKey:@"name" value:@"newnewtest"];
//        APConnection *connection = [APConnection connectionWithRelationType:@"testconnection2"];
//        [connection addPropertyWithKey:@"name" value:@"newnewtest"];
//        [connection createConnectionWithObjectA:object1
//                                        objectB:object2
//                                           labelA:@"sdk"
//                                           labelB:@"sdktest"
//                                   successHandler:^(void){
//                                       isConnectionCreated = YES;
//                                       if(object1.objectId != nil)
//                                           [object1 deleteObject];
//                                       if(object2.objectId != nil)
//                                           [object2 deleteObject];
//                                       if(connection.objectId != nil)
//                                           [connection deleteConnection];
//                                   }failureHandler:^(APError *error) {
//                                       isConnectionCreated = NO;
//                                       if(object1.objectId != nil)
//                                           [object1 deleteObject];
//                                       if(object2.objectId != nil)
//                                           [object2 deleteObject];
//                                       if(connection.objectId != nil)
//                                           [connection deleteConnection];
//                                   }];
//        if(object1.objectId != nil)
//        [object1 deleteObject];
//        if(object2.objectId != nil)
//        [object2 deleteObject];
//        if(connection.objectId != nil)
//        [connection deleteConnection];
//        [[expectFutureValue(theValue(isConnectionCreated)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"create a connection with a new and an existing object", ^{
//        __block BOOL isConnectionCreated = NO;
//        APObject *object1 = [[APObject alloc] initWithTypeName:@"sdk"];
//        [object1 addPropertyWithKey:@"name" value:@"newnewtest"];
//        APObject *object2 = [[APObject alloc] initWithTypeName:@"sdktest"];
//        [object2 addPropertyWithKey:@"name" value:@"newnewtest"];
//        __block APConnection *connection = [APConnection connectionWithRelationType:@"testconnection2"];
//        [object2 saveObjectWithSuccessHandler:^(NSDictionary *result) {
//            [connection addPropertyWithKey:@"name" value:@"newnewtest"];
//            [connection createConnectionWithObjectA:object1
//                                            objectBId:object2.objectId
//                                             labelA:@"sdk"
//                                             labelB:@"sdktest"
//                                     successHandler:^(void){
//                                         if(object1.objectId != nil)
//                                             [object1 deleteObject];
//                                         if(object2.objectId != nil)
//                                             [object2 deleteObject];
//                                         if(connection.objectId != nil)
//                                             [connection deleteConnection];
//                                         isConnectionCreated = YES;
//                                     }failureHandler:^(APError *error) {
//                                         isConnectionCreated = NO;
//                                         if(object1.objectId != nil)
//                                             [object1 deleteObject];
//                                         if(object2.objectId != nil)
//                                             [object2 deleteObject];
//                                         if(connection.objectId != nil)
//                                             [connection deleteConnection];
//                                     }];
//
//        } failureHandler:^(APError *error) {
//            isConnectionCreated = NO;
//            if(object1 != nil)
//                [object1 deleteObject];
//            if(object2 != nil)
//                [object2 deleteObject];
//            if(connection != nil)
//                [connection deleteConnection];
//        }];
//        
//        if(object1 != nil)
//            [object1 deleteObject];
//        if(object2 != nil)
//            [object2 deleteObject];
//        if(connection != nil)
//            [connection deleteConnection];
//        [[expectFutureValue(theValue(isConnectionCreated)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"create a connection with an existing and a new object", ^{
//        __block BOOL isConnectionCreated = NO;
//        APObject *object1 = [[APObject alloc] initWithTypeName:@"sdk"];
//        [object1 addPropertyWithKey:@"name" value:@"newnewtest"];
//        APObject *object2 = [[APObject alloc] initWithTypeName:@"sdktest"];
//        [object2 addPropertyWithKey:@"name" value:@"newnewtest"];
//        __block APConnection *connection = [APConnection connectionWithRelationType:@"testconnection2"];
//        [object1 saveObjectWithSuccessHandler:^(NSDictionary *result) {
//            [connection addPropertyWithKey:@"name" value:@"newnewtest"];
//            [connection createConnectionWithObjectAId:object1.objectId
//                                          objectB:object2
//                                             labelA:@"sdk"
//                                             labelB:@"sdktest"
//                                     successHandler:^(void){
//                                         isConnectionCreated = YES;
//                                         if(object1.objectId != nil)
//                                             [object1 deleteObject];
//                                         if(object2.objectId != nil)
//                                             [object2 deleteObject];
//                                         if(connection.objectId != nil)
//                                             [connection deleteConnection];
//                                     }failureHandler:^(APError *error) {
//                                         isConnectionCreated = NO;
//                                         if(object1.objectId != nil)
//                                             [object1 deleteObject];
//                                         if(object2.objectId != nil)
//                                             [object2 deleteObject];
//                                         if(connection.objectId != nil)
//                                             [connection deleteConnection];
//                                     }];
//            
//        } failureHandler:^(APError *error) {
//            isConnectionCreated = NO;
//            if(object1 != nil)
//                [object1 deleteObject];
//            if(object2 != nil)
//                [object2 deleteObject];
//            if(connection != nil)
//                [connection deleteConnection];
//        }];
//        
//        if(object1 != nil)
//            [object1 deleteObject];
//        if(object2 != nil)
//            [object2 deleteObject];
//        if(connection != nil)
//            [connection deleteConnection];
//        [[expectFutureValue(theValue(isConnectionCreated)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//#pragma mark - SEARCH_TESTS
//
//    it(@"search for valid relation types", ^{
//        __block BOOL isSearchingSuccessful = NO;
//        [APConnections
//         searchAllConnectionsWithRelationType:@"testconnection"
//         successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords) {
//             isSearchingSuccessful = YES;
//         } failureHandler:^(APError *error){
//             isSearchingSuccessful = NO;
//         }];
//        [[expectFutureValue(theValue(isSearchingSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"search all relations with objectid and label", ^{
//        __block BOOL isSearchingSuccessful = NO;
//        __block APObject *object;
//        APQuery *queryObj = [[APQuery alloc] init];
//        queryObj.pageNumber = 1;
//        queryObj.pageSize = 1;
//        NSString *query = [queryObj stringValue];
//        
//        [APObject searchAllObjectsWithTypeName:@"sdk" withQuery:query successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords) {
//            object = [objects lastObject];
//            [APConnections searchAllConnectionsWithRelationType:@"testconnection" byObjectId:object.objectId withLabel:@"sdk" withQuery:nil successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords) {
//                 isSearchingSuccessful = YES;
//             } failureHandler:^(APError *error){
//                 isSearchingSuccessful = NO;
//             }];
//        }];
//        
//        [[expectFutureValue(theValue(isSearchingSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    
//    it(@"search all relations of reltion tpye with objectids", ^{
//        __block BOOL isSearchingSuccessful = NO;
//        __block APObject *object1;
//        __block APObject *object2;
//        APQuery *queryObj = [[APQuery alloc] init];
//        queryObj.pageNumber = 1;
//        queryObj.pageSize = 1;
//        NSString *query = [queryObj stringValue];
//        
//        [APObject searchAllObjectsWithTypeName:@"sdk" withQuery:query successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords) {
//            object1 = [objects lastObject];
//            [APObject searchAllObjectsWithTypeName:@"sdktest" withQuery:query successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords) {
//                object2 = [objects lastObject];
//                [APConnections searchAllConnectionsWithRelationType:@"testconnection" fromObjectId:object1.objectId toObjectId:object2.objectId labelB:@"sdktest" withQuery:nil successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//                    isSearchingSuccessful = YES;
//            } failureHandler:^(APError *error){
//                isSearchingSuccessful = NO;
//            }];
//            }];
//        }];
//        
//        [[expectFutureValue(theValue(isSearchingSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"search for invalid connections", ^{
//        __block BOOL isSearchingUnsuccessful = NO;
//        [APConnections
//         searchAllConnectionsWithRelationType:@"relationThatDoesNotExist"
//         successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords) {
//             isSearchingUnsuccessful = NO;
//         } failureHandler:^(APError *error){
//             isSearchingUnsuccessful = YES;
//         }];
//        [[expectFutureValue(theValue(isSearchingUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    pending_(@"search call along with valid query string", ^(){
//
//    });
//
//    pending_(@"search call along with invalid query string", ^(){
//
//    });
//
//#pragma mark - INTERCONNECTS_TESTS
//
//    it(@"search for valid objectIds", ^{
//        __block BOOL isSearchingSuccessful = NO;
//        NSArray * objectIds = [NSArray arrayWithObjects:@"12094464603586988",@"926377",@"926372",@"926364",nil];
//        NSString * objectId = @"926345";
//        [APConnections searchAllConnectionsFromObjectId:objectId toObjectIds:objectIds withQuery:nil successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//            NSLog(@"Success block %@" , [objects description]);
//            isSearchingSuccessful = YES;
//        }failureHandler:^(APError *error) {
//            isSearchingSuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isSearchingSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"search for invalid objectIds", ^{
//        __block BOOL isSearchingUnsuccessful = NO;
//        NSArray * objectIds = [NSArray arrayWithObjects:@"15896369232480359",@"15896362656860262",@"15896351207458582",@"15896338793367317",nil];
//        NSString *objectId = @"-34432233";
//        [APConnections searchAllConnectionsFromObjectId:objectId toObjectIds:objectIds withQuery:nil successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//            NSLog(@"Success block %@" , [objects description]);
//            isSearchingUnsuccessful = NO;
//        }failureHandler:^(APError *error) {
//            isSearchingUnsuccessful = YES;
//        }];
//        [[expectFutureValue(theValue(isSearchingUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//#pragma mark - DELETE_TESTS
//    
//    it(@"delete multiple connections with valid relation name and valid objectid", ^{
//        __block BOOL isConnectionDeletionSuccessful = NO;
//        __block APObject *objectA1 = [[APObject alloc] initWithTypeName:@"sdk"];
//        __block APObject *objectA2 = [[APObject alloc] initWithTypeName:@"sdktest"];
//        __block APObject *objectB1 = [[APObject alloc] initWithTypeName:@"sdk"];
//        __block APObject *objectB2 = [[APObject alloc] initWithTypeName:@"sdktest"];
//        __block APConnection *connection1 = [[APConnection alloc] initWithRelationType:@"testconnection"];
//        __block APConnection *connection2 = [[APConnection alloc] initWithRelationType:@"testconnection"];
//        
//        [objectA1 saveObjectWithSuccessHandler:^(NSDictionary *result) {
//            [objectA2 saveObjectWithSuccessHandler:^(NSDictionary *result) {
//                [objectB1 saveObjectWithSuccessHandler:^(NSDictionary *result) {
//                    [objectB2 saveObjectWithSuccessHandler:^(NSDictionary *result) {
//                        [connection1 createConnectionWithObjectAId:objectA1.objectId objectBId:objectA2.objectId labelA:@"sdk" labelB:@"sdktest" successHandler:^{
//                            [connection2 createConnectionWithObjectAId:objectB1.objectId objectBId:objectB2.objectId labelA:@"sdk" labelB:@"sdktest" successHandler:^{
//                                [APConnections deleteConnectionsWithRelationType:@"testconnection" objectIds:@[connection1.objectId,connection2.objectId] successHandler:^{
//                                    isConnectionDeletionSuccessful = YES;
//                                    if(connection1.objectId != nil)
//                                        [connection1 deleteConnection];
//                                    if(connection2.objectId != nil)
//                                        [connection2 deleteConnection];
//                                    if(objectA1.objectId != nil)
//                                        [objectA1 deleteObject];
//                                    if(objectA2.objectId != nil)
//                                        [objectA2 deleteObject];
//                                    if(objectB1.objectId != nil)
//                                        [objectB1 deleteObject];
//                                    if(objectB2.objectId != nil)
//                                        [objectB2 deleteObject];
//                                } failureHandler:^(APError *error){
//                                    isConnectionDeletionSuccessful = NO;
//                                    if(connection1.objectId != nil)
//                                        [connection1 deleteConnection];
//                                    if(connection2.objectId != nil)
//                                        [connection2 deleteConnection];
//                                    if(objectA1.objectId != nil)
//                                        [objectA1 deleteObject];
//                                    if(objectA2.objectId != nil)
//                                        [objectA2 deleteObject];
//                                    if(objectB1.objectId != nil)
//                                        [objectB1 deleteObject];
//                                    if(objectB2.objectId != nil)
//                                        [objectB2 deleteObject];
//                                }];
//                            } failureHandler:^(APError *error) {
//                                isConnectionDeletionSuccessful = NO;
//                                if(connection1.objectId != nil)
//                                    [connection1 deleteConnection];
//                                if(connection2.objectId != nil)
//                                    [connection2 deleteConnection];
//                                if(objectA1.objectId != nil)
//                                    [objectA1 deleteObject];
//                                if(objectA2.objectId != nil)
//                                    [objectA2 deleteObject];
//                                if(objectB1.objectId != nil)
//                                    [objectB1 deleteObject];
//                                if(objectB2.objectId != nil)
//                                    [objectB2 deleteObject];
//                            }];
//                        } failureHandler:^(APError *error) {
//                            isConnectionDeletionSuccessful = NO;
//                            if(connection1.objectId != nil)
//                                [connection1 deleteConnection];
//                            if(connection2.objectId != nil)
//                                [connection2 deleteConnection];
//                            if(objectA1.objectId != nil)
//                                [objectA1 deleteObject];
//                            if(objectA2.objectId != nil)
//                                [objectA2 deleteObject];
//                            if(objectB1.objectId != nil)
//                                [objectB1 deleteObject];
//                            if(objectB2.objectId != nil)
//                                [objectB2 deleteObject];
//                        }];
//                    } failureHandler:^(APError *error) {
//                        isConnectionDeletionSuccessful = NO;
//                        if(connection1.objectId != nil)
//                            [connection1 deleteConnection];
//                        if(connection2.objectId != nil)
//                            [connection2 deleteConnection];
//                        if(objectA1.objectId != nil)
//                            [objectA1 deleteObject];
//                        if(objectA2.objectId != nil)
//                            [objectA2 deleteObject];
//                        if(objectB1.objectId != nil)
//                            [objectB1 deleteObject];
//                        if(objectB2.objectId != nil)
//                            [objectB2 deleteObject];
//                    }];
//                } failureHandler:^(APError *error) {
//                    isConnectionDeletionSuccessful = NO;
//                    if(connection1.objectId != nil)
//                        [connection1 deleteConnection];
//                    if(connection2.objectId != nil)
//                        [connection2 deleteConnection];
//                    if(objectA1.objectId != nil)
//                        [objectA1 deleteObject];
//                    if(objectA2.objectId != nil)
//                        [objectA2 deleteObject];
//                    if(objectB1.objectId != nil)
//                        [objectB1 deleteObject];
//                    if(objectB2.objectId != nil)
//                        [objectB2 deleteObject];
//                }];
//            } failureHandler:^(APError *error) {
//                isConnectionDeletionSuccessful = NO;
//                if(connection1.objectId != nil)
//                    [connection1 deleteConnection];
//                if(connection2.objectId != nil)
//                    [connection2 deleteConnection];
//                if(objectA1.objectId != nil)
//                    [objectA1 deleteObject];
//                if(objectA2.objectId != nil)
//                    [objectA2 deleteObject];
//                if(objectB1.objectId != nil)
//                    [objectB1 deleteObject];
//                if(objectB2.objectId != nil)
//                    [objectB2 deleteObject];
//            }];
//        } failureHandler:^(APError *error) {
//            isConnectionDeletionSuccessful = NO;
//            if(connection1.objectId != nil)
//                [connection1 deleteConnection];
//            if(connection2.objectId != nil)
//                [connection2 deleteConnection];
//            if(objectA1.objectId != nil)
//                [objectA1 deleteObject];
//            if(objectA2.objectId != nil)
//                [objectA2 deleteObject];
//            if(objectB1.objectId != nil)
//                [objectB1 deleteObject];
//            if(objectB2.objectId != nil)
//                [objectB2 deleteObject];
//        }];
//        
//        if(connection1.objectId != nil)
//            [connection1 deleteConnection];
//        if(connection2.objectId != nil)
//            [connection2 deleteConnection];
//        if(objectA1.objectId != nil)
//            [objectA1 deleteObject];
//        if(objectA2.objectId != nil)
//            [objectA2 deleteObject];
//        if(objectB1.objectId != nil)
//            [objectB1 deleteObject];
//        if(objectB2.objectId != nil)
//            [objectB2 deleteObject];
//        
//        [[expectFutureValue(theValue(isConnectionDeletionSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//
//    it(@"delete connection using invalid relation type and object id", ^{
//        __block BOOL isConnectionDeletionSuccessful = NO;
//        [APConnections
//         deleteConnectionsWithRelationType:@"relationThatDoesNotExist"
//         objectIds:@[@"-12",@"-21"]
//         successHandler:^{
//             isConnectionDeletionSuccessful = YES;
//         } failureHandler:^(APError *error){
//             isConnectionDeletionSuccessful = NO;
//         }];
//        [[expectFutureValue(theValue(!isConnectionDeletionSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//
//    it(@"deleting a connection with valid objectid", ^{
//        __block BOOL isConnectionDeleted = NO;
//        __block NSString *object1Id;
//        __block NSString *object2Id;
//
//        APQuery *queryObj = [[APQuery alloc] init];
//        queryObj.pageNumber = 1;
//        queryObj.pageSize = 1;
//        NSString *query = [queryObj stringValue];
//
//        APConnection *connection = [APConnection connectionWithRelationType:@"testconnection"];
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQuery:query
//                              successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//                                  object1Id = ((APObject*)[objects lastObject]).objectId;
//                                  [APObject searchAllObjectsWithTypeName:@"sdk" withQuery:query
//                                                        successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords) {
//                                                            object2Id = ((APObject*)[objects lastObject]).objectId;
//                                                            [connection createConnectionWithObjectAId:object1Id objectBId:object2Id labelA:@"sdktest" labelB:@"sdk" successHandler:^(){
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
//                              }];
//
//        [[expectFutureValue(theValue(isConnectionDeleted)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//#pragma mark - FETCH_TESTS
//
//    it(@"fetch connected objects", ^{
//        __block BOOL isFetchSuccessful = NO;
//        __block APObject *object;
//        APQuery *queryObj = [[APQuery alloc] init];
//        queryObj.pageNumber = 1;
//        queryObj.pageSize = 1;
//        NSString *query = [queryObj stringValue];
//        
//        [APObject searchAllObjectsWithTypeName:@"sdk" withQuery:query
//             successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//                 object = [objects lastObject];
//                 [APConnections
//                  fetchObjectsConnectedToObjectOfType:object.type withObjectId:object.objectId withRelationType:@"testconnection" fetchConnections:YES
//                  successHandler:^(NSArray *objects){
//                      isFetchSuccessful = YES;
//                  } failureHandler:^(APError *error){
//                      isFetchSuccessful = NO;
//                  }];
//             } failureHandler:^(APError *error){
//                 isFetchSuccessful = NO;
//             }];
//        [[expectFutureValue(theValue(isFetchSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"fetch a connection with valid object id", ^{
//
//        __block BOOL isFetchSuccessful = NO;
//        __block NSString* object1Id;
//        __block NSString* object2Id;
//        __block APConnection* connection = [[APConnection alloc] initWithRelationType:@"testconnection"];
//        
//        APQuery *queryObj = [[APQuery alloc] init];
//        queryObj.pageNumber = 1;
//        queryObj.pageSize = 1;
//        NSString *query = [queryObj stringValue];
//        
//        [APObject searchAllObjectsWithTypeName:@"sdk" withQuery:query
//                              successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//                                  object1Id = ((APObject*)[objects lastObject]).objectId;
//                                  [APObject searchAllObjectsWithTypeName:@"sdktest" withQuery:query
//                                                        successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//                                                            object2Id = ((APObject*)[objects lastObject]).objectId;
//                                                            [connection createConnectionWithObjectAId:object1Id objectBId:object2Id labelA:@"sdk" labelB:@"sdktest" successHandler:^{
//                                                                [APConnections
//                                                                 fetchConnectionWithRelationType:@"testconnection" connectionObjectId:connection.objectId successHandler:^(NSArray *objects){
//                                                                     isFetchSuccessful = YES;
//                                                                     [connection deleteConnection];
//                                                                 } failureHandler:^(APError *error){
//                                                                     isFetchSuccessful = NO;
//                                                                     [connection deleteConnection];
//                                                                 }];
//                                                            } failureHandler:^(APError *error) {
//                                                                isFetchSuccessful = NO;
//                                                            }];
//                                             } failureHandler:^(APError *error){
//                                                 isFetchSuccessful = NO;
//                                             }];
//                              }];
//        [[expectFutureValue(theValue(isFetchSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"fetch a connection with invalid object id", ^{
//        __block BOOL isFetchUnsuccessful = NO;
//        
//        [APConnections
//         fetchConnectionWithRelationType:@"testconnection"
//         connectionObjectId:@"-2313"
//         successHandler:^(NSArray *objects){
//             isFetchUnsuccessful = NO;
//         } failureHandler:^(APError *error){
//             isFetchUnsuccessful = YES;
//         }];
//        
//        [[expectFutureValue(theValue(isFetchUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//});
//SPEC_END
//
