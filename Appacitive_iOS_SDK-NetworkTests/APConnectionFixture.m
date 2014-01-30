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
//        [Appacitive initWithAPIKey:API_KEY];
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
//        NSString *pnum = [APQuery queryWithPageNumber:1];
//        NSString *psize = [APQuery queryWithPageSize:1];
//        NSString *query = [NSString stringWithFormat:@"%@&%@", pnum, psize];
//
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQueryString:query
//                              successHandler:^(NSArray *objects){
//                                  object1Id = ((APObject*)[objects lastObject]).objectId;
//                                  [APObject searchAllObjectsWithTypeName:@"sdk" withQueryString:query
//                                                        successHandler:^(NSArray *objects){
//                                                            object2Id = ((APObject*)[objects lastObject]).objectId;
//                                                            [connection createConnectionWithObjectAId:object1Id objectBId:object2Id labelA:@"sdktest" labelB:@"sdk" successHandler:^(){
//                                                                [connection fetchConnectionWithSuccessHandler:^(){
//                                                                    isFetchSuccessful = YES;
//                                                                    [connection deleteConnection];
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
//        NSString *pnum = [APQuery queryWithPageNumber:1];
//        NSString *psize = [APQuery queryWithPageSize:1];
//        NSString *query = [NSString stringWithFormat:@"%@&%@", pnum, psize];
//
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQueryString:query
//                              successHandler:^(NSArray *objects){
//                                  object1Id = ((APObject*)[objects lastObject]).objectId;
//                                  [APObject searchAllObjectsWithTypeName:@"sdk" withQueryString:query
//                                                        successHandler:^(NSArray *objects){
//                                                            object2Id = ((APObject*)[objects lastObject]).objectId;
//                                                            [connection createConnectionWithObjectAId:object1Id objectBId:object2Id labelA:@"sdktest" labelB:@"sdk" successHandler:^(){
//                                                                [connection updatePropertyWithKey:@"name" value:@"prop2"];
//                                                                [connection updateConnectionWithSuccessHandler:^() {
//                                                                    isUpdateSuccessful = YES;
//                                                                    [connection deleteConnection];
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
//        NSString *pnum = [APQuery queryWithPageNumber:1];
//        NSString *psize = [APQuery queryWithPageSize:1];
//        NSString *query = [NSString stringWithFormat:@"%@&%@", pnum, psize];
//
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQueryString:query
//                              successHandler:^(NSArray *objects){
//                                  object1Id = ((APObject*)[objects lastObject]).objectId;
//                                  [APObject searchAllObjectsWithTypeName:@"sdk" withQueryString:query
//                                                        successHandler:^(NSArray *objects){
//                                                            object2Id = ((APObject*)[objects lastObject]).objectId;
//                                                            [connection createConnectionWithObjectAId:object1Id objectBId:object2Id labelA:@"sdktest" labelB:@"sdk" successHandler:^(){
//                                                                [connection removePropertyWithKey:@"prop2"];
//                                                                [connection updateConnectionWithSuccessHandler:^() {
//                                                                    isDeleteSuccessful = YES;
//                                                                    [connection deleteConnection];
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
//        NSString *pnum = [APQuery queryWithPageNumber:1];
//        NSString *psize = [APQuery queryWithPageSize:1];
//        NSString *query = [NSString stringWithFormat:@"%@&%@", pnum, psize];
//
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQueryString:query
//                              successHandler:^(NSArray *objects){
//                                  object1Id = ((APObject*)[objects lastObject]).objectId;
//                                  [APObject searchAllObjectsWithTypeName:@"sdk" withQueryString:query
//                                                        successHandler:^(NSArray *objects){
//                                                            object2Id = ((APObject*)[objects lastObject]).objectId;
//                                                            [connection createConnectionWithObjectAId:object1Id objectBId:object2Id labelA:@"sdktest" labelB:@"sdk" successHandler:^(){
//                                                                [connection removeAttributeWithKey:@"att1"];
//                                                                [connection updateConnectionWithSuccessHandler:^() {
//                                                                    isUpdateSuccessful = YES;
//                                                                    [connection deleteConnection];
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
//        NSString *pnum = [APQuery queryWithPageNumber:1];
//        NSString *psize = [APQuery queryWithPageSize:1];
//        NSString *query = [NSString stringWithFormat:@"%@&%@", pnum, psize];
//
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQueryString:query
//                              successHandler:^(NSArray *objects){
//                                  object1Id = ((APObject*)[objects lastObject]).objectId;
//                                  [APObject searchAllObjectsWithTypeName:@"sdk" withQueryString:query
//                                                        successHandler:^(NSArray *objects){
//                                                            object2Id = ((APObject*)[objects lastObject]).objectId;
//                                                            [connection createConnectionWithObjectAId:object1Id objectBId:object2Id labelA:@"sdktest" labelB:@"sdk" successHandler:^(){
//                                                                [connection removeAttributeWithKey:@"beDeleted"];
//                                                                [connection updateConnectionWithSuccessHandler:^{
//                                                                    isDeleteSuccessful = YES;
//                                                                    [connection deleteConnection];
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
//        NSString *pnum = [APQuery queryWithPageNumber:1];
//        NSString *psize = [APQuery queryWithPageSize:1];
//
//        NSString *query = [NSString stringWithFormat:@"%@&%@", pnum, psize];
//        APConnection *connection = [APConnection connectionWithRelationType:@"testconnection"];
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQueryString:query
//                              successHandler:^(NSArray *objects){
//                                  object1Id = ((APObject*)[objects lastObject]).objectId;
//                                  [APObject searchAllObjectsWithTypeName:@"sdk" withQueryString:query
//                                                        successHandler:^(NSArray *objects){
//                                                            object2Id = ((APObject*)[objects lastObject]).objectId;
//                                                            [connection createConnectionWithObjectAId:object1Id objectBId:object2Id labelA:@"sdktest" labelB:@"sdk" successHandler:^(){
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
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQueryString:nil
//                              successHandler:^(NSArray *objects){
//                                  object1Id = ((APObject*)[objects lastObject]).objectId;
//                                  [connection createConnectionWithObjectA:sdkObj objectBId:object1Id labelA:@"sdk" labelB:@"sdktest" successHandler:^(){
//                                      isConnectionCreated = YES;
//                                      [connection deleteConnection];
//                                      [sdkObj deleteObject];
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
//
//#pragma mark - SEARCH_TESTS
//
//    it(@"search for valid relation types", ^{
//        __block BOOL isSearchingSuccesful = NO;
//        [APConnections
//         searchAllConnectionsWithRelationType:@"testconnection"
//         successHandler:^(NSArray *objects){
//             isSearchingSuccesful = YES;
//         } failureHandler:^(APError *error){
//             isSearchingSuccesful = NO;
//         }];
//        [[expectFutureValue(theValue(isSearchingSuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"search all relations with objectid and label", ^{
//        __block BOOL isSearchingSuccesful = NO;
//        __block APObject *object;
//        NSString *pnum = [APQuery queryWithPageNumber:1];
//        NSString *psize = [APQuery queryWithPageSize:1];
//        NSString *query = [NSString stringWithFormat:@"%@&%@", pnum, psize];
//        
//        [APObject searchAllObjectsWithTypeName:@"sdk" withQueryString:query successHandler:^(NSArray *objects) {
//            object = [objects lastObject];
//            [APConnections searchAllConnectionsWithRelationType:@"testconnection" byObjectId:object.objectId withLabel:@"sdk" successHandler:^(NSArray *objects){
//                 isSearchingSuccesful = YES;
//             } failureHandler:^(APError *error){
//                 isSearchingSuccesful = NO;
//             }];
//        }];
//        
//        [[expectFutureValue(theValue(isSearchingSuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    
//    it(@"search all relations of reltion tpye with objectids", ^{
//        __block BOOL isSearchingSuccesful = NO;
//        __block APObject *object1;
//        __block APObject *object2;
//        NSString *pnum = [APQuery queryWithPageNumber:1];
//        NSString *psize = [APQuery queryWithPageSize:1];
//        NSString *query = [NSString stringWithFormat:@"%@&%@", pnum, psize];
//        
//        [APObject searchAllObjectsWithTypeName:@"sdk" withQueryString:query successHandler:^(NSArray *objects) {
//            object1 = [objects lastObject];
//            [APObject searchAllObjectsWithTypeName:@"sdktest" withQueryString:query successHandler:^(NSArray *objects) {
//                object2 = [objects lastObject];
//                [APConnections searchAllConnectionsWithRelationType:@"testconnection" fromObjectId:object1.objectId toObjectId:object2.objectId successHandler:^(NSArray *objects){
//                    isSearchingSuccesful = YES;
//            } failureHandler:^(APError *error){
//                isSearchingSuccesful = NO;
//            }];
//            }];
//        }];
//        
//        [[expectFutureValue(theValue(isSearchingSuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"search for invalid connections", ^{
//        __block BOOL isSearchingUnsuccesful = NO;
//        [APConnections
//         searchAllConnectionsWithRelationType:@"relationThatDoesNotExist"
//         successHandler:^(NSArray *objects){
//             isSearchingUnsuccesful = NO;
//         } failureHandler:^(APError *error){
//             isSearchingUnsuccesful = YES;
//         }];
//        [[expectFutureValue(theValue(isSearchingUnsuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
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
//        __block BOOL isSearchingSuccesful = NO;
//        NSArray * objectIds = [NSArray arrayWithObjects:@"12094464603586988",@"926377",@"926372",@"926364",nil];
//        NSString * objectId = @"926345";
//        [APConnections searchAllConnectionsFromObjectId:objectId toObjectIds:objectIds successHandler:^(NSArray *objects){
//            NSLog(@"Success block %@" , [objects description]);
//            isSearchingSuccesful = YES;
//        }failureHandler:^(APError *error) {
//            NSLog(@"Failure block %@" , [error description]);
//            isSearchingSuccesful = NO;
//        }];
//        [[expectFutureValue(theValue(isSearchingSuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"search for invalid objectIds", ^{
//        __block BOOL isSearchingUnsuccesful = NO;
//        NSArray * objectIds = [NSArray arrayWithObjects:@"15896369232480359",@"15896362656860262",@"15896351207458582",@"15896338793367317",nil];
//        NSString *objectId = @"-34432233";
//        [APConnections searchAllConnectionsFromObjectId:objectId toObjectIds:objectIds successHandler:^(NSArray *objects){
//            NSLog(@"Success block %@" , [objects description]);
//            isSearchingUnsuccesful = NO;
//        }failureHandler:^(APError *error) {
//            NSLog(@"Failure block %@" , [error description]);
//            isSearchingUnsuccesful = YES;
//        }];
//        [[expectFutureValue(theValue(isSearchingUnsuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//#pragma mark - DELETE_TESTS
//    
//    it(@"delete multiple connections with valid relation name and valid objectid", ^{
//        __block BOOL isConnectionDeletionSuccessful = NO;
//        __block NSString *object1Id;
//        __block NSString *object2Id;
//        __block NSString *object3Id;
//        __block NSString *object4Id;
//        NSString *pnum = [APQuery queryWithPageNumber:1];
//        NSString *psize = [APQuery queryWithPageSize:2];
//        __block NSString *query = [NSString stringWithFormat:@"%@&%@", pnum, psize];
//        __block APConnection *connection1 = [[APConnection alloc] initWithRelationType:@"testconnection"];
//        __block APConnection *connection2 = [[APConnection alloc] initWithRelationType:@"testconnection"];
//        
//        [APObject searchAllObjectsWithTypeName:@"sdk" withQueryString:query
//          successHandler:^(NSArray *objects){
//              object1Id = ((APObject*)[objects lastObject]).objectId;
//              object3Id = ((APObject*)[objects firstObject]).objectId;
//              [APObject searchAllObjectsWithTypeName:@"sdktest" withQueryString:query
//                    successHandler:^(NSArray *objects){
//                        object2Id = ((APObject*)[objects lastObject]).objectId;
//                        object4Id = ((APObject*)[objects firstObject]).objectId;
//                        [connection1 createConnectionWithObjectAId:object1Id objectBId:object2Id labelA:@"sdk" labelB:@"sdktest" successHandler:^{
//                            [connection2 createConnectionWithObjectAId:object3Id objectBId:object4Id labelA:@"sdk" labelB:@"sdktest" successHandler:^{
//                                [APConnections deleteConnectionsWithRelationType:@"testconnection" objectIds:@[connection1.objectId,connection2.objectId]
//                                      successHandler:^{
//                                          isConnectionDeletionSuccessful = YES;
//                                      } failureHandler:^(APError *error){
//                                          isConnectionDeletionSuccessful = NO;
//                                          if(connection1.objectId != nil)
//                                              [connection1 deleteConnection];
//                                          if(connection2.objectId != nil)
//                                              [connection2 deleteConnection];
//                                      }];
//                            } failureHandler:^(APError *error) {
//                                isConnectionDeletionSuccessful = NO;
//                                if(connection1.objectId != nil)
//                                    [connection1 deleteConnection];
//                                if(connection2.objectId != nil)
//                                    [connection2 deleteConnection];
//                            }];
//                        } failureHandler:^(APError *error) {
//                            isConnectionDeletionSuccessful = NO;
//                            if(connection1.objectId != nil)
//                                [connection1 deleteConnection];
//                            if(connection2.objectId != nil)
//                                [connection2 deleteConnection];
//                        }];
//                    }];
//          } failureHandler:^(APError *error) {
//              DLog(@"ERROR:%@",error.description);
//          }];
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
//        NSString *pnum = [APQuery queryWithPageNumber:1];
//        NSString *psize = [APQuery queryWithPageSize:1];
//        NSString *query = [NSString stringWithFormat:@"%@&%@", pnum, psize];
//
//        APConnection *connection = [APConnection connectionWithRelationType:@"testconnection"];
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQueryString:query
//                              successHandler:^(NSArray *objects){
//                                  object1Id = ((APObject*)[objects lastObject]).objectId;
//                                  [APObject searchAllObjectsWithTypeName:@"sdk" withQueryString:query
//                                                        successHandler:^(NSArray *objects){
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
//        __block BOOL isFetchSuccesful = NO;
//        __block APObject *object;
//        NSString *pnum = [APQuery queryWithPageNumber:1];
//        NSString *psize = [APQuery queryWithPageSize:1];
//        NSString *query = [NSString stringWithFormat:@"%@&%@", pnum, psize];
//        
//        [APObject searchAllObjectsWithTypeName:@"sdk" withQueryString:query
//             successHandler:^(NSArray *objects){
//                 object = [objects lastObject];
//                 [APConnections
//                  fetchConnectedObjectsOfType:object.type withObjectId:object.objectId withRelationType:@"testconnection2"
//                  successHandler:^(NSArray *objects){
//                      isFetchSuccesful = YES;
//                  } failureHandler:^(APError *error){
//                      isFetchSuccesful = NO;
//                  }];
//             } failureHandler:^(APError *error){
//                 isFetchSuccesful = NO;
//             }];
//        [[expectFutureValue(theValue(isFetchSuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"fetch a connection with valid object id", ^{
//
//        __block BOOL isFetchSuccesful = NO;
//        __block NSString* object1Id;
//        __block NSString* object2Id;
//        __block APConnection* connection = [[APConnection alloc] initWithRelationType:@"testconnection"];
//        
//        NSString *pnum = [APQuery queryWithPageNumber:1];
//        NSString *psize = [APQuery queryWithPageSize:1];
//        NSString *query = [NSString stringWithFormat:@"%@&%@", pnum, psize];
//        
//        [APObject searchAllObjectsWithTypeName:@"sdk" withQueryString:query
//                              successHandler:^(NSArray *objects){
//                                  object1Id = ((APObject*)[objects lastObject]).objectId;
//                                  [APObject searchAllObjectsWithTypeName:@"sdktest" withQueryString:query
//                                                        successHandler:^(NSArray *objects){
//                                                            object2Id = ((APObject*)[objects lastObject]).objectId;
//                                                            [connection createConnectionWithObjectAId:object1Id objectBId:object2Id labelA:@"sdk" labelB:@"sdktest" successHandler:^{
//                                                                [APConnections
//                                                                 fetchConnectionWithRelationType:@"testconnection" objectId:connection.objectId successHandler:^(NSArray *objects){
//                                                                     isFetchSuccesful = YES;
//                                                                     [connection deleteConnection];
//                                                                 } failureHandler:^(APError *error){
//                                                                     isFetchSuccesful = NO;
//                                                                     [connection deleteConnection];
//                                                                 }];
//                                                            } failureHandler:^(APError *error) {
//                                                                isFetchSuccesful = NO;
//                                                            }];
//                                             } failureHandler:^(APError *error){
//                                                 isFetchSuccesful = NO;
//                                             }];
//                              }];
//        [[expectFutureValue(theValue(isFetchSuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"fetch a connection with invalid object id", ^{
//        __block BOOL isFetchUnsuccesful = NO;
//        
//        [APConnections
//         fetchConnectionWithRelationType:@"testconnection"
//         objectId:@"-2313"
//         successHandler:^(NSArray *objects){
//             isFetchUnsuccesful = NO;
//         } failureHandler:^(APError *error){
//             isFetchUnsuccesful = YES;
//         }];
//        
//        [[expectFutureValue(theValue(isFetchUnsuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//});
//SPEC_END
//
