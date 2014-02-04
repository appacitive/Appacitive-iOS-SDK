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
//                                     successHandler:^(NSArray *objects){
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
//                                     successHandler:^(NSArray *objects){
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
//                                     successHandler:^(NSArray *objects){
//                                         isSearchUnsuccessful = NO;
//                                     }failureHandler:^(APError *error){
//                                         isSearchUnsuccessful = YES;
//                                     }];
//        [[expectFutureValue(theValue(isSearchUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"search API call with valid query string", ^(){
//        __block BOOL isSearchSuccessful = NO;
//        NSString *query = [APQuery queryWithPageNumber:1];
//        [APObject searchAllObjectsWithTypeName:@"sdktest"
//                               withQueryString:query
//                               successHandler:^(NSArray *objects) {
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
//                              withQueryString:@"query=++1"
//                               successHandler:^(NSArray *objects) {
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
//        NSString *pnumString = [APQuery queryWithPageNumber:1];
//        NSString *psizeString = [APQuery queryWithPageSize:1];
//        
//        NSString *query = [NSString stringWithFormat:@"%@&%@", pnumString, psizeString];
//        
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQueryString:query
//                                  successHandler:^(NSArray *objects){
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
//        NSString *pnumString = [APQuery queryWithPageNumber:1];
//        NSString *psizeString = [APQuery queryWithPageSize:1];
//        NSString *fields = [APQuery queryWithFields:[NSArray arrayWithObjects:@"name",nil]];
//        __block NSString *queryString = [NSString stringWithFormat:@"%@&%@&%@", pnumString, psizeString, fields];
//        
//        [APObject searchAllObjectsWithTypeName:@"sdktest" withQueryString:queryString
//                              successHandler:^(NSArray *objects){
//                                  object = [objects lastObject];
//                                  [object fetchWithQueryString:queryString
//                                                      successHandler:^(){
//                                                          isFetchSuccessful = YES;
//                                                      }failureHandler:^(APError *error){
//                                                          isFetchSuccessful = NO;
//                                                      }];
//                              }failureHandler:^(APError *error){
//                                  isFetchSuccessful = NO;
//                              }];
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
//        NSString *query = [APQuery queryWithPageSize:2];
//        [APObject searchAllObjectsWithTypeName:@"sdktest"
//                                  withQueryString:query
//                                  successHandler:^(NSArray *objects){
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
//        NSString *query = [APQuery queryWithPageSize:1];
//        
//        [APObject searchAllObjectsWithTypeName:@"sdktest"
//                            withQueryString:query
//                            successHandler:^(NSArray *objects) {
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
