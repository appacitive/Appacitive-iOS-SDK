//#import "Appacitive.h"
//#import "APObject.h"
//#import "APError.h"
//#import "APQuery.h"
//
//SPEC_BEGIN(APObjectFixture)
//
//describe(@"APObject", ^{
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
//#pragma mark - SEARCH_TESTS
//    
//    it(@"search API call with valid type name", ^{
//        __block BOOL isSearchSuccessful = NO;
//        
//        [APObject searchAllObjectsWithTypeName:@"sdktest"
//                                     successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords) {
//                                         NSLog(@"PagingInfo:\nPageNumber:%d\nPageSize:%d\nTotalRecords:%d",pageNumber,pageSize, totalrecords);
//                                         isSearchSuccessful = YES;
//                                     }failureHandler:^(APError *error){
//                                         isSearchSuccessful = NO;
//                                     }];
//        [[expectFutureValue(theValue(isSearchSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"search API call with invalid type name", ^{
//        
//        __block BOOL isSearchUnsuccessful = NO;
//        [APObject searchAllObjectsWithTypeName:@"invalidTypeName"
//                                     successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//                                         isSearchUnsuccessful = NO;
//                                     }failureHandler:^(APError *error){
//                                         isSearchUnsuccessful = YES;
//                                     }];
//        [[expectFutureValue(theValue(isSearchUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"search API call with nil type name", ^{
//        
//        __block BOOL isSearchUnsuccessful = NO;
//        [APObject searchAllObjectsWithTypeName:nil
//                                     successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//                                         isSearchUnsuccessful = NO;
//                                     }failureHandler:^(APError *error){
//                                         isSearchUnsuccessful = YES;
//                                     }];
//        [[expectFutureValue(theValue(isSearchUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"search API call with valid query string", ^(){
//        __block BOOL isSearchSuccessful = NO;
//        APQuery *queryObj = [[APQuery alloc] init];
//        queryObj.pageNumber = 1;
//        queryObj.pageSize = 1;
//        NSString *query = [queryObj stringValue];
//        [APObject searchAllObjectsWithTypeName:@"sdktest"
//                               withQuery:query
//                               successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords) {
//                                   isSearchSuccessful = YES;
//                               } failureHandler:^(APError *error) {
//                                   isSearchSuccessful = NO;
//                               }];
//        [[expectFutureValue(theValue(isSearchSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"search API call with invalid query string", ^(){
//        __block BOOL isSearchUnSuccessful = NO;
//        [APObject searchAllObjectsWithTypeName:@"sdktest"
//                              withQuery:@"query=++1"
//                               successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords) {
//                                   isSearchUnSuccessful = NO;
//                               } failureHandler:^(APError *error) {
//                                   isSearchUnSuccessful = YES;
//                               }];
//        [[expectFutureValue(theValue(isSearchUnSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//
//    });
//    
//#pragma mark - FETCH_TESTS
//
//    it(@"fetch API call with valid objectId and valid type name", ^{
//       __block BOOL isFetchSuccessful = NO;
//        __block NSString *objectId;
//        APQuery *queryObj = [[APQuery alloc] init];
//        queryObj.pageNumber = 1;
//        queryObj.pageSize = 1;
//        NSString *query = [queryObj stringValue];
//        
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQuery:query
//                                  successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//                                      objectId = ((APObject*)[objects lastObject]).objectId;
//                                      [APObject fetchObjectWithObjectId:objectId typeName:@"sdktest"
//                                                successHandler:^(NSArray *objects){
//                                                    isFetchSuccessful = YES;
//                                                }failureHandler:^(APError *error){
//                                                    isFetchSuccessful = NO;
//                                        }];
//                                  }failureHandler:^(APError *error){
//                                      isFetchSuccessful = NO;
//                                  }];
//        [[expectFutureValue(theValue(isFetchSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"fetch API call with valid object with specified fields", ^{
//        __block BOOL isFetchSuccessful = NO;
//        __block APObject *object;
//        APQuery *queryObj = [[APQuery alloc] init];
//        queryObj.pageNumber = 1;
//        queryObj.pageSize = 1;
//        __block NSString *query = [queryObj stringValue];
//        
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQuery:query
//                                successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords){
//                                    object = [objects lastObject];
//                                    [object fetchWithPropertiesToFetch:@[@"name",@"createdby"] successHandler:^(){
//                                        isFetchSuccessful = YES;
//                                        NSLog(@"%@",[object description]);
//                                    }failureHandler:^(APError *error){
//                                        isFetchSuccessful = NO;
//                                    }];
//                                }failureHandler:^(APError *error){
//                                    isFetchSuccessful = NO;
//                                }];
//        [[expectFutureValue(theValue(isFetchSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"fetch API call with invalid objectId and invalid type name", ^{
//        
//        __block BOOL isFetchUnsuccessful = NO;
//        
//        [APObject fetchObjectWithObjectId:@"0" typeName:@"typeThatDoesNotExist"
//                           successHandler:^(NSArray *objects){
//                               isFetchUnsuccessful = NO;
//                           }failureHandler:^(APError *error){
//                               isFetchUnsuccessful = YES;
//                           }];
//        [[expectFutureValue(theValue(isFetchUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"muti fetch API call with valid object ids and valid type name", ^(){
//        __block BOOL isMultiFetchSuccessful = NO;
//        
//        APQuery *queryObj = [[APQuery alloc] init];
//        queryObj.pageNumber = 1;
//        queryObj.pageSize = 1;
//        NSString *query = [queryObj stringValue];
//        
//        [APObject searchAllObjectsWithTypeName:@"sdktest"
//                                  withQuery:query
//                                  successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords) {
//                                      NSMutableArray *objectIds = [NSMutableArray arrayWithCapacity:objects.count];
//                                      for(APObject *obj in objects) {
//                                          [objectIds addObject:obj.objectId];
//                                      }
//                                      
//                                      [APObject fetchObjectsWithObjectIds:objectIds
//                                                         typeName:@"sdktest"
//                                                         successHandler:^(NSArray *objects){
//                                                             isMultiFetchSuccessful = YES;
//                                                         } failureHandler:^(APError *error) {
//                                                             isMultiFetchSuccessful = NO;
//                                                         }];
//                                  } failureHandler:^(APError *error) {
//                                      isMultiFetchSuccessful = NO;
//                                  }];
//        [[expectFutureValue(theValue(isMultiFetchSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"multi fetch for invalid object ids and invalid type name", ^(){
//        __block BOOL isMultiFetchUnsuccessful = NO;
//        [APObject fetchObjectsWithObjectIds:@[@"-123", @"-1"]
//                             typeName:@"sdktest"
//                             successHandler:^(NSArray *objects){
//                                 isMultiFetchUnsuccessful = NO;
//                             } failureHandler:^(APError *error){
//                                 isMultiFetchUnsuccessful = YES;
//                             }];
//        [[expectFutureValue(theValue(isMultiFetchUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"fetch API call with valid object id", ^(){
//        __block BOOL isFetchSuccessful= NO;
//        __block APObject *object;
//        
//        APQuery *queryObj = [[APQuery alloc] init];
//        queryObj.pageNumber = 1;
//        queryObj.pageSize = 1;
//        NSString *query = [queryObj stringValue];
//        
//        [APObject searchAllObjectsWithTypeName:@"sdktest"
//                            withQuery:query
//                            successHandler:^(NSArray *objects, NSInteger pageNumber, NSInteger pageSize, NSInteger totalrecords) {
//                                APObject *object = [objects lastObject];
//                                [object fetchWithSuccessHandler:^{
//                                    if(object.properties == nil)
//                                        isFetchSuccessful = NO;
//                                    else
//                                        isFetchSuccessful = YES;
//                                } failureHandler:^(APError *error) {
//                                    isFetchSuccessful = NO;
//                                }];
//                            } failureHandler:^(APError *error){
//                                object = nil;
//                            }];
//        [[expectFutureValue(theValue(isFetchSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//        
//    });
//
//    it(@"fetch API call with invalid object id", ^(){
//        __block BOOL isFetchUnsuccessful = NO;
//        
//        APObject *object = [APObject objectWithTypeName:@"sdktest" objectId:@"-200"];
//        [object fetchWithFailureHandler:^(APError *error) {
//            isFetchUnsuccessful = YES;
//        }];
//        [[expectFutureValue(theValue(isFetchUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//#pragma mark - TESTING_GET_PROPERTIES_METHOD
//    
//    it(@"retrieving a valid property with key", ^{
//        
//        APObject *object = [APObject objectWithTypeName:@"sdktest"];
//        [object addPropertyWithKey:@"test" value:@"Another test"];
//        
//        id property = [object getPropertyWithKey:@"test"];
//        [property shouldNotBeNil];
//    });
//    
//#pragma mark - TESTING_UPDATE_PROPERTIES_METHOD
//
//    it(@"updating a property of an APObject", ^{
//        
//        __block BOOL isUpdateSuccessful = NO;
//        
//        APObject *object = [[APObject alloc] initWithTypeName:@"sdktest"];
//        [object setCreatedBy:@"Sandeep Dhull"];
//        [object addPropertyWithKey:@"__id" value:@"12345"];
//        [object addPropertyWithKey:@"Name" value:@"Tavisca"];
//        [object addPropertyWithKey:@"Category" value:@"arts"];
//        [object addPropertyWithKey:@"Description" value:@"Tavisca artists works here"];
//        [object addPropertyWithKey:@"Address" value:@"Eon It Park Kharadi"];
//        [object addPropertyWithKey:@"GeoCodes" value:@"18.551678,73.954275"];
//        
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [object updatePropertyWithKey:@"name" value:@"TestName"];
//            [object updateObjectWithSuccessHandler:^() {
//                isUpdateSuccessful = YES;
//                [object deleteObject];
//            } failureHandler:^(APError *error) {
//                [object deleteObject];
//                isUpdateSuccessful = NO;
//            }];
//        }failureHandler:^(APError *error){
//            [object deleteObject];
//            isUpdateSuccessful = NO;
//        }];
//        
//        [[expectFutureValue(theValue(isUpdateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"setting values for a multivalued property of an APObject", ^{
//        __block BOOL isUpdateSuccessful = NO;
//        
//        APObject *object = [[APObject alloc] initWithTypeName:@"game"];
//        [object addPropertyWithKey:@"medals" value:[NSArray arrayWithObjects:@"bronze",@"silver",nil]];
//        [object addPropertyWithKey:@"points" value:@5.0];
//        [object addPropertyWithKey:@"level" value:@1];
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            isUpdateSuccessful = YES;
//                [object deleteObject];
//        }failureHandler:^(APError *error){
//                [object deleteObject];
//            isUpdateSuccessful = NO;
//        }];
//        
//        [[expectFutureValue(theValue(isUpdateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//        });
//    
//    it(@"updating a multivalued property of an APObject", ^{
//        
//        __block BOOL isUpdateSuccessful = NO;
//        
//        APObject *object = [[APObject alloc] initWithTypeName:@"game"];
//        [object addPropertyWithKey:@"medals" value:[NSArray arrayWithObjects:@"bronze",@"silver",nil]];
//        [object addPropertyWithKey:@"points" value:@5.0];
//        [object addPropertyWithKey:@"level" value:@1];
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [object addValues:@[@"gold"] toMultivaluedProperty:@"medals"];
//            [object updateObjectWithSuccessHandler:^{
//                isUpdateSuccessful = YES;
//                [object deleteObject];
//            } failureHandler:^(APError *error) {
//                isUpdateSuccessful = NO;
//                [object deleteObject];
//            }];
//        }failureHandler:^(APError *error){
//            [object deleteObject];
//            isUpdateSuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isUpdateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"updating a multivalued property of an APObject by resetting the original value", ^{
//
//        __block BOOL isUpdateSuccessful = NO;
//
//        APObject *object = [[APObject alloc] initWithTypeName:@"game"];
//        [object addPropertyWithKey:@"medals" value:[NSArray arrayWithObjects:@"bronze",@"silver",nil]];
//        [object addPropertyWithKey:@"points" value:@5.0];
//        [object addPropertyWithKey:@"level" value:@1];
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [object updatePropertyWithKey:@"medals" value:[NSArray arrayWithObjects:@"gold",@"platinum", nil]];
//            [object updatePropertyWithKey:@"points" value:@"9"];
//            [object updatePropertyWithKey:@"level" value:@"11"];
//            [object updateObjectWithSuccessHandler:^{
//                [object deleteObject];
//                isUpdateSuccessful = YES;
//            } failureHandler:^(APError *error) {
//                [object deleteObject];
//                isUpdateSuccessful = NO;
//            }];
//        }failureHandler:^(APError *error){
//            [object deleteObject];
//            isUpdateSuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isUpdateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"updating a multivalued property of an APObject by adding and then ressting the value", ^{
//        
//        __block BOOL isUpdateSuccessful = NO;
//        
//        APObject *object = [[APObject alloc] initWithTypeName:@"game"];
//        [object addPropertyWithKey:@"medals" value:[NSArray arrayWithObjects:@"bronze",@"silver",nil]];
//        [object addPropertyWithKey:@"points" value:@5.0];
//        [object addPropertyWithKey:@"level" value:@1];
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [object addValues:@[@"copper"] toMultivaluedProperty:@"medals"];
//            [object updatePropertyWithKey:@"medals" value:[NSArray arrayWithObjects:@"gold",@"platinum", nil]];
//            [object incrementValueOfProperty:@"points" byValue:@1.5];
//            [object updatePropertyWithKey:@"points" value:@"9"];
//            [object decrementValueOfProperty:@"level" byValue:@3];
//            [object updatePropertyWithKey:@"level" value:@"11"];
//            [object updateObjectWithSuccessHandler:^{
//                [object deleteObject];
//                isUpdateSuccessful = YES;
//
//            } failureHandler:^(APError *error) {
//                [object deleteObject];
//                isUpdateSuccessful = NO;
//
//            }];
//        }failureHandler:^(APError *error){
//            [object deleteObject];
//            isUpdateSuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isUpdateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"updating a multivalued property of an APObject by resetting and then adding the value", ^{
//        
//        __block BOOL isUpdateSuccessful = NO;
//        
//        APObject *object = [[APObject alloc] initWithTypeName:@"game"];
//        [object addPropertyWithKey:@"medals" value:[NSArray arrayWithObjects:@"bronze",@"silver",nil]];
//        [object addPropertyWithKey:@"points" value:@5.0];
//        [object addPropertyWithKey:@"level" value:@1];
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [object updatePropertyWithKey:@"medals" value:[NSArray arrayWithObjects:@"gold",@"platinum", nil]];
//            [object addValues:@[@"copper"] toMultivaluedProperty:@"medals"];
//            [object updatePropertyWithKey:@"points" value:@"9"];
//            [object incrementValueOfProperty:@"points" byValue:@1.5];
//            [object updatePropertyWithKey:@"level" value:@"11"];
//            [object decrementValueOfProperty:@"level" byValue:@3];
//            [object updateObjectWithSuccessHandler:^{
//                [object deleteObject];
//                isUpdateSuccessful = YES;
//            } failureHandler:^(APError *error) {
//                [object deleteObject];
//                isUpdateSuccessful = NO;
//            }];
//        }failureHandler:^(APError *error){
//            [object deleteObject];
//            isUpdateSuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isUpdateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"updating a multivalued property of an APObject by resetting and then adding the value", ^{
//
//        __block BOOL isUpdateSuccessful = NO;
//
//        APObject *object = [[APObject alloc] initWithTypeName:@"game"];
//        [object addPropertyWithKey:@"medals" value:[NSArray arrayWithObjects:@"bronze",@"silver",nil]];
//        [object addPropertyWithKey:@"points" value:@5.0];
//        [object addPropertyWithKey:@"level" value:@1];
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [object updatePropertyWithKey:@"medals" value:[NSArray arrayWithObjects:@"gold",@"platinum",@"copper", nil]];
//            [object removeValues:@[@"copper",@"gold"] fromMultivaluedProperty:@"medals"];
//            [object updatePropertyWithKey:@"points" value:@"9"];
//            [object incrementValueOfProperty:@"points" byValue:@1.5];
//            [object updatePropertyWithKey:@"level" value:@"11"];
//            [object decrementValueOfProperty:@"level" byValue:@3];
//            [object updateObjectWithSuccessHandler:^{
//                [object deleteObject];
//                isUpdateSuccessful = YES;
//            } failureHandler:^(APError *error) {
//                [object deleteObject];
//                isUpdateSuccessful = NO;
//            }];
//        }failureHandler:^(APError *error){
//            [object deleteObject];
//            isUpdateSuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isUpdateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"updating a decimal counter property of an APObject", ^{
//        
//        __block BOOL isUpdateSuccessful = NO;
//        
//        APObject *object = [[APObject alloc] initWithTypeName:@"game"];
//        [object addPropertyWithKey:@"medals" value:[NSArray arrayWithObjects:@"bronze",@"silver",nil]];
//        [object addPropertyWithKey:@"points" value:@5.0];
//        [object addPropertyWithKey:@"level" value:@1];
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [object incrementValueOfProperty:@"points" byValue:@5.0];
//            [object updateObjectWithSuccessHandler:^{
//                isUpdateSuccessful = YES;
//                [object deleteObject];
//            } failureHandler:^(APError *error) {
//                isUpdateSuccessful = NO;
//                [object deleteObject];
//            }];
//        }failureHandler:^(APError *error){
//            [object deleteObject];
//            isUpdateSuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isUpdateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"updating an integer counter property of an APObject", ^{
//        
//        __block BOOL isUpdateSuccessful = NO;
//        
//        APObject *object = [[APObject alloc] initWithTypeName:@"game"];
//        [object addPropertyWithKey:@"medals" value:[NSArray arrayWithObjects:@"bronze",@"silver",nil]];
//        [object addPropertyWithKey:@"points" value:@5.0];
//        [object addPropertyWithKey:@"level" value:@1];
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [object incrementValueOfProperty:@"level" byValue:@1];
//            [object updateObjectWithSuccessHandler:^{
//                isUpdateSuccessful = YES;
//                [object deleteObject];
//            } failureHandler:^(APError *error) {
//                isUpdateSuccessful = NO;
//                [object deleteObject];
//            }];
//        }failureHandler:^(APError *error){
//            [object deleteObject];
//            isUpdateSuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isUpdateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//
//#pragma mark - TESTING_DELETE_PROPERTIES_METHOD
//    
//    it(@"deleting a property of an APObject", ^{
//        
//        __block BOOL isDeleteSuccessful = NO;
//        APObject *object = [[APObject alloc] initWithTypeName:@"sdktest"];
//        [object setCreatedBy:@"Sandeep Dhull"];
//        [object addPropertyWithKey:@"name" value:@"Tavisca"];
//        
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [object removePropertyWithKey:@"name"];
//            [object updateObjectWithSuccessHandler:^(NSDictionary *result){
//                [object deleteObject];
//                isDeleteSuccessful = YES;
//            } failureHandler:^(APError *error) {
//                [object deleteObject];
//                isDeleteSuccessful = NO;
//            }];
//        }failureHandler:^(APError *error){
//            [object deleteObject];
//            isDeleteSuccessful = NO;
//        }];
//        
//        [[expectFutureValue(theValue(isDeleteSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//#pragma mark - TESTING_UPDATE_ATTRIBUTES_METHOD
//    
//    it(@"updating an attribute of an APObject", ^{
//        
//        __block BOOL isUpdateSuccessful = NO;
//        APObject *object = [[APObject alloc] initWithTypeName:@"sdktest"];
//        [object setCreatedBy:@"Sandeep Dhull"];
//        [object addPropertyWithKey:@"Name" value:@"Tavisca"];
//        [object addPropertyWithKey:@"Category" value:@"arts"];
//        [object addPropertyWithKey:@"Description" value:@"Tavisca artists works here"];
//        [object addPropertyWithKey:@"Address" value:@"Eon It Park Kharadi"];
//        [object addPropertyWithKey:@"GeoCodes" value:@"18.551678,73.954275"];
//        
//        [object addAttributeWithKey:@"Test" value:@"value"];
//        [object addAttributeWithKey:@"Test2" value:@"value"];
//        
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [object updateAttributeWithKey:@"Test" value:@"value3"];
//            [object updateObjectWithSuccessHandler:^(NSDictionary *result){
//                isUpdateSuccessful = YES;
//                [object deleteObject];
//            } failureHandler:^(APError *error) {
//                isUpdateSuccessful = NO;
//                [object deleteObject];
//            }];
//        }failureHandler:^(APError *error){
//            isUpdateSuccessful = NO;
//            [object deleteObject];
//        }];
//        
//        [[expectFutureValue(theValue(isUpdateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//#pragma mark - TESTING_DELETE_ATTRIBUTES_METHOD
//    
//    it(@"deleting an attribute of an APObject", ^{
//        
//        __block BOOL isDeleteSuccessful = NO;
//        APObject *object = [[APObject alloc] initWithTypeName:@"sdktest"];
//        [object setCreatedBy:@"Sandeep Dhull"];
//        [object addPropertyWithKey:@"Name" value:@"Tavisca"];
//        [object addPropertyWithKey:@"Category" value:@"arts"];
//        [object addPropertyWithKey:@"Description" value:@"Tavisca artists works here"];
//        [object addPropertyWithKey:@"Address" value:@"Eon It Park Kharadi"];
//        [object addPropertyWithKey:@"GeoCodes" value:@"18.551678,73.954275"];
//
//        [object addAttributeWithKey:@"Test" value:@"value"];
//        [object addAttributeWithKey:@"Test2" value:@"value"];
//        
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [object removeAttributeWithKey:@"test"];
//            [object updateObjectWithSuccessHandler:^(NSDictionary *result){
//                [object deleteObject];
//                isDeleteSuccessful = YES;
//            } failureHandler:^(APError *error) {
//                [object deleteObject];
//                isDeleteSuccessful = NO;
//            }];
//        }failureHandler:^(APError *error){
//            [object deleteObject];
//            isDeleteSuccessful = NO;
//        }];
//        
//        [[expectFutureValue(theValue(isDeleteSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//#pragma mark - UPDATE_TESTS
//    
//    it(@"updating an empty object", ^{
//        __block BOOL isUpdateSuccessful = YES;
//        __block APObject *object = [[APObject alloc] initWithTypeName:@"sdktest"];
//        [object setCreatedBy:@"Sandeep Dhull"];
//        [object addPropertyWithKey:@"Name" value:@"Tavisca"];
//        [object addPropertyWithKey:@"Category" value:@"arts"];
//        [object addPropertyWithKey:@"Description" value:@"Tavisca artists works here"];
//        [object addPropertyWithKey:@"Address" value:@"Eon It Park Kharadi"];
//        [object addPropertyWithKey:@"GeoCodes" value:@"18.551678,73.954275"];
//        
//        [object addAttributeWithKey:@"Test" value:@"value"];
//        [object addAttributeWithKey:@"Test2" value:@"value"];
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result) {
//            object = [[APObject alloc] initWithTypeName:@"sdktest"];
//            [object updateObjectWithSuccessHandler:^{
//                isUpdateSuccessful = YES;
//                [object deleteObject];
//            } failureHandler:^(APError *error) {
//                isUpdateSuccessful = NO;
//                [object deleteObject];
//            }];
//        } failureHandler:^(APError *error) {
//            isUpdateSuccessful = NO;
//            [object deleteObject];
//        }];
//        
//        [[expectFutureValue(theValue(isUpdateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(NO)];
//    });
//    
//    it(@"updating a non null value object with null value property", ^{
//        __block BOOL isSaveSuccessful = NO;
//        
//        __block APObject *object = [[APObject alloc] initWithTypeName:@"sdktest"];
//        [object setCreatedBy:@"Sandeep Dhull"];
//        [object addPropertyWithKey:@"Name" value:@"Sandeep"];
//        [object addPropertyWithKey:@"Category" value:@"Dhull"];
//        [object addPropertyWithKey:@"Description" value:@"desc"];
//        [object addPropertyWithKey:@"Address" value:@"address"];
//        [object addPropertyWithKey:@"GeoCodes" value:@"18.551678,73.954275"];
//        
//        [object addAttributeWithKey:@"Test" value:@"value"];
//        [object addAttributeWithKey:@"Test2" value:@"value"];
//        
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [[object properties] setValue:[NSNull null] forKey:@"Name"];
//            [object updateObjectWithSuccessHandler:^(NSDictionary *result){
//                isSaveSuccessful = YES;
//                [object deleteObject];
//            } failureHandler:^(APError *error) {
//                isSaveSuccessful = NO;
//                [object deleteObject];
//            }];
//        }failureHandler:^(APError *error){
//            isSaveSuccessful = NO;
//            [object deleteObject];
//        }];
//        [[expectFutureValue(theValue(isSaveSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"updating an object with a valid revision number", ^{
//        __block BOOL isSaveSuccessful = NO;
//        
//        APObject *object = [[APObject alloc] initWithTypeName:@"sdktest"];
//        [object setCreatedBy:@"Sandeep Dhull"];
//        [object addPropertyWithKey:@"Name" value:@"Sandeep"];
//        [object addPropertyWithKey:@"Category" value:@"Dhull"];
//        [object addPropertyWithKey:@"Description" value:@"desc"];
//        [object addPropertyWithKey:@"Address" value:@"address"];
//        [object addPropertyWithKey:@"GeoCodes" value:@"18.551678,73.954275"];
//        
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [[object properties] setValue:[NSNull null] forKey:@"Name"];
//            [object updateObjectWithRevisionNumber:@1 successHandler:^(NSDictionary *result){
//                isSaveSuccessful = YES;
//                [object deleteObject];
//            } failureHandler:^(APError *error) {
//                isSaveSuccessful = NO;
//                [object deleteObject];
//            }];
//        }failureHandler:^(APError *error){
//            isSaveSuccessful = NO;
//            [object deleteObject];
//        }];
//        [[expectFutureValue(theValue(isSaveSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"updating an object with an invalid revision number", ^{
//        __block BOOL isSaveSuccessful = NO;
//        
//        APObject *object = [[APObject alloc] initWithTypeName:@"sdktest"];
//        [object setCreatedBy:@"Sandeep Dhull"];
//        [object addPropertyWithKey:@"Name" value:@"Sandeep"];
//        [object addPropertyWithKey:@"Category" value:@"Dhull"];
//        [object addPropertyWithKey:@"Description" value:@"desc"];
//        [object addPropertyWithKey:@"Address" value:@"address"];
//        [object addPropertyWithKey:@"GeoCodes" value:@"18.551678,73.954275"];
//        
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [[object properties] setValue:[NSNull null] forKey:@"Name"];
//            [object updateObjectWithRevisionNumber:@-99 successHandler:^(NSDictionary *result){
//                isSaveSuccessful = YES;
//                [object deleteObject];
//            } failureHandler:^(APError *error) {
//                isSaveSuccessful = NO;
//                [object deleteObject];
//            }];
//        }failureHandler:^(APError *error){
//            isSaveSuccessful = NO;
//            [object deleteObject];
//        }];
//        [[expectFutureValue(theValue(isSaveSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(NO)];
//    });
//    
//    it(@"updating a null property object with null value property", ^{
//        __block BOOL isSaveSuccessful = NO;
//        
//        APObject *object = [[APObject alloc] initWithTypeName:@"sdktest"];
//        [object setCreatedBy:@"Sandeep Dhull"];
//        [object addPropertyWithKey:@"name" value:[NSNull null]];
//        
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [[object properties] setValue:[NSNull null] forKey:@"name"];
//            [object updateObjectWithSuccessHandler:^(NSDictionary *result){
//                isSaveSuccessful = YES;
//                [object deleteObject];
//            } failureHandler:^(APError *error) {
//                isSaveSuccessful = NO;
//                [object deleteObject];
//            }];
//        }failureHandler:^(APError *error){
//            isSaveSuccessful = NO;
//            [object deleteObject];
//        }];
//        [[expectFutureValue(theValue(isSaveSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"updating tags", ^{
//        __block BOOL isSaveSuccessful = NO;
//        
//        APObject *object = [[APObject alloc] initWithTypeName:@"sdktest"];
//        [object setCreatedBy:@"Sandeep Dhull"];
//        [object addPropertyWithKey:@"Name" value:@"name"];
//        [object addTag:@"tag1"];
//        
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [object removeTag:@"tag1"];
//            [object addTag:@"tag2"];
//            [object updateObjectWithSuccessHandler:^(NSDictionary *result){
//                isSaveSuccessful = YES;
//                [object deleteObject];
//            } failureHandler:^(APError *error) {
//                isSaveSuccessful = NO;
//                [object deleteObject];
//            }];
//        }failureHandler:^(APError *error){
//            isSaveSuccessful = NO;
//            [object deleteObject];
//        }];
//        [[expectFutureValue(theValue(isSaveSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//#pragma mark - SAVE_TESTS
//    
//    it(@"save API call with valid type name", ^{
//        
//        __block BOOL isSaveSuccessful = NO;
//        APObject *object = [[APObject alloc] initWithTypeName:@"sdktest"];
//        [object setCreatedBy:@"Sandeep Dhull"];
//        [object addPropertyWithKey:@"Name" value:@"Tavisca"];
//        [object addPropertyWithKey:@"Category" value:@"arts"];
//        [object addPropertyWithKey:@"Description" value:@"Tavisca artists works here"];
//        [object addPropertyWithKey:@"Address" value:@"Eon It Park Kharadi"];
//        [object addPropertyWithKey:@"GeoCodes" value:@"18.551678,73.954275"];
//        
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            isSaveSuccessful = YES;
//            [object deleteObject];
//        }failureHandler:^(APError *error){
//            isSaveSuccessful = NO;
//            [object deleteObject];
//        }];
//        
//        [[expectFutureValue(theValue(isSaveSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"saving an object with improper type name", ^{
//        __block BOOL isSaveUnsuccessful = NO;
//        APObject *object = [[APObject alloc] initWithTypeName:@"typeThatDoesNotExist"];
//        
//        [object setCreatedBy:@"Sandeep Dhull"];
//        [object setCreatedBy:@"Sandeep Dhull"];
//        [object addPropertyWithKey:@"Name" value:@"Tavisca"];
//        [object addPropertyWithKey:@"Category" value:@"arts"];
//        [object addPropertyWithKey:@"Description" value:@"Tavisca artists works here"];
//        [object addPropertyWithKey:@"Address" value:@"Eon It Park Kharadi"];
//        [object addPropertyWithKey:@"GeoCodes" value:@"18.551678,73.954275"];
//        
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            isSaveUnsuccessful = NO;
//            [object deleteObject];
//        }failureHandler:^(APError *error){
//            isSaveUnsuccessful = YES;
//            [object deleteObject];
//        }];
//        [[expectFutureValue(theValue(isSaveUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//#pragma mark - DELETE_TESTS
//    
//    it(@"delete API call with improper type name", ^{
//        __block BOOL isDeleteUnsuccessful = NO;
//        APObject *object = [[APObject alloc] initWithTypeName:@"typeThatDoesNotExist"];
//        [object addPropertyWithKey:@"something" value:@"2319381902900"];
//        [object deleteObjectWithSuccessHandler:^(void){
//            isDeleteUnsuccessful = NO;
//        }failureHandler:^(APError *error){
//            isDeleteUnsuccessful = YES;
//        }];
//        [[expectFutureValue(theValue(isDeleteUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"delete call for a proper object id", ^{
//        __block BOOL isDeleteSuccessful = NO;
//        
//        APObject *object = [[APObject alloc] initWithTypeName:@"sdktest"];
//        
//        [object setCreatedBy:@"Sandeep Dhull"];
//        [object setCreatedBy:@"Sandeep Dhull"];
//        [object addPropertyWithKey:@"Name" value:@"Tavisca"];
//        [object addPropertyWithKey:@"Category" value:@"arts"];
//        [object addPropertyWithKey:@"Description" value:@"Tavisca artists works here"];
//        [object addPropertyWithKey:@"Address" value:@"Eon It Park Kharadi"];
//        [object addPropertyWithKey:@"GeoCodes" value:@"18.551678,73.954275"];
//        
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [object deleteObjectWithSuccessHandler:^{
//                isDeleteSuccessful = YES;
//                [object deleteObject];
//            } failureHandler:^(APError *error) {
//                isDeleteSuccessful = NO;
//                [object deleteObject];
//            }];
//        }failureHandler:^(APError *error){
//            isDeleteSuccessful = NO;
//            [object deleteObject];
//        }];
//        [[expectFutureValue(theValue(isDeleteSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//});
//SPEC_END
//
