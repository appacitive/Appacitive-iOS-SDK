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
//#pragma mark SEARCH_TESTS
//    
//    it(@"should return non-nil for search API call with valid type name", ^{
//        __block BOOL isSearchSuccessful = NO;
//        
//        [APObjects searchAllObjectsWithTypeName:@"sdktest"
//                                     successHandler:^(NSDictionary *result){
//                                         isSearchSuccessful = YES;
//                                     }failureHandler:^(APError *error){
//                                         isSearchSuccessful = NO;
//                                     }];
//        [[expectFutureValue(theValue(isSearchSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"should return an error for search API call with invalid type name", ^{
//        
//        __block BOOL isSearchUnsuccessful = NO;
//        [APObjects searchAllObjectsWithTypeName:@"invalidTypeName"
//                                     successHandler:^(NSDictionary *result){
//                                         isSearchUnsuccessful = NO;
//                                     }failureHandler:^(APError *error){
//                                         isSearchUnsuccessful = YES;
//                                     }];
//        [[expectFutureValue(theValue(isSearchUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"should return an error for search API call with nil type name", ^{
//        
//        __block BOOL isSearchUnsuccessful = NO;
//        [APObjects searchAllObjectsWithTypeName:nil
//                                     successHandler:^(NSDictionary *result){
//                                         isSearchUnsuccessful = NO;
//                                     }failureHandler:^(APError *error){
//                                         isSearchUnsuccessful = YES;
//                                     }];
//        [[expectFutureValue(theValue(isSearchUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"should not return an error for search API call with valid query string", ^(){
//        __block BOOL isSearchSuccessful = NO;
//        NSString *query = [APQuery queryWithPageNumber:1];
//        [APObjects searchObjectsWithTypeName:@"sdktest"
//                               withQueryString:query
//                               successHandler:^(NSDictionary *result) {
//                                   isSearchSuccessful = YES;
//                               } failureHandler:^(APError *error) {
//                                   isSearchSuccessful = NO;
//                               }];
//        [[expectFutureValue(theValue(isSearchSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"should return an error for search API call with invalid query string", ^(){
//        __block BOOL isSearchUnSuccessful = NO;
//        [APObjects searchObjectsWithTypeName:@"sdktest"
//                              withQueryString:@"query=++1"
//                               successHandler:^(NSDictionary *result) {
//                                   isSearchUnSuccessful = NO;
//                               } failureHandler:^(APError *error) {
//                                   isSearchUnSuccessful = YES;
//                               }];
//        [[expectFutureValue(theValue(isSearchUnSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//
//    });
//    
//#pragma mark FETCH_TESTS
//
//    it(@"should return valid object for fetch API call with valid objectId and valid type name", ^{
//       __block BOOL isFetchSuccessful = NO;
//        __block NSString *objectId;
//        NSString *pnumString = [APQuery queryWithPageNumber:1];
//        NSString *psizeString = [APQuery queryWithPageSize:1];
//        
//        NSString *query = [NSString stringWithFormat:@"%@&%@", pnumString, psizeString];
//        
//        [APObjects searchObjectsWithTypeName:@"sdktest" withQueryString:query
//                                  successHandler:^(NSDictionary *result){
//                                      NSArray *objects = result[@"objects"];
//                                      NSDictionary *dict = [objects lastObject];
//                                      objectId = dict[@"__id"];
//                                      [APObjects fetchObjectWithObjectId:objectId typeName:@"sdktest"
//                                                successHandler:^(NSDictionary *result){
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
//    it(@"should return valid object for fetch API call with valid object with specified fields", ^{
//        __block BOOL isFetchSuccessful = NO;
//        __block NSString *objectId;
//        
//        NSString *pnumString = [APQuery queryWithPageNumber:1];
//        NSString *psizeString = [APQuery queryWithPageSize:1];
//        NSString *fields = [APQuery queryWithFields:[NSArray arrayWithObjects:@"name",nil]];
//        
//        NSString *queryString = [NSString stringWithFormat:@"%@&%@&%@", pnumString, psizeString, fields];
//        
//        [APObjects searchObjectsWithTypeName:@"sdktest" withQueryString:queryString
//                              successHandler:^(NSDictionary *result){
//                                  NSArray *objects = result[@"objects"];
//                                  NSDictionary *dict = [objects lastObject];
//                                  objectId = dict[@"__id"];
//                                  [APObjects fetchObjectWithObjectId:objectId typeName:@"sdktest"
//                                                      successHandler:^(NSDictionary *result){
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
//    it(@"should return an error for fetch API call with invalid objectId and invalid type name", ^{
//        
//        __block BOOL isFetchUnsuccessful = NO;
//        
//        [APObjects fetchObjectWithObjectId:@"0" typeName:@"typeThatDoesNotExist"
//                           successHandler:^(NSDictionary *result){
//                               isFetchUnsuccessful = NO;
//                           }failureHandler:^(APError *error){
//                               isFetchUnsuccessful = YES;
//                           }];
//        [[expectFutureValue(theValue(isFetchUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"should not return an error for muti fetch API call with valid object ids and valid type name", ^(){
//        __block BOOL isMultiFetchSuccessful = NO;
//        
//        NSString *query = [APQuery queryWithPageSize:2];
//        [APObjects searchObjectsWithTypeName:@"sdktest"
//                                  withQueryString:query
//                                  successHandler:^(NSDictionary *result){
//                                      NSArray *objects = result[@"objects"];
//                                      NSMutableArray *objectIds = [NSMutableArray arrayWithCapacity:objects.count];
//                                      for(NSDictionary *dict in objects) {
//                                          [objectIds addObject:dict[@"__id"]];
//                                      }
//                                      
//                                      [APObjects fetchObjectsWithObjectIds:objectIds
//                                                         typeName:@"sdktest"
//                                                         successHandler:^(NSDictionary *result){
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
//    it(@"should return an error for multi fetch for invalid object ids and invalid type name", ^(){
//        __block BOOL isMultiFetchUnsuccessful = NO;
//        [APObjects fetchObjectsWithObjectIds:@[@-123, @-1]
//                             typeName:@"sdktest"
//                             successHandler:^(NSDictionary *result){
//                                 isMultiFetchUnsuccessful = NO;
//                             } failureHandler:^(APError *error){
//                                 isMultiFetchUnsuccessful = YES;
//                             }];
//        [[expectFutureValue(theValue(isMultiFetchUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"should not return an error for fetch API call with valid object id", ^(){
//        
//        __block APObject *object;
//        NSString *query = [APQuery queryWithPageSize:1];
//        
//        [APObjects searchObjectsWithTypeName:@"sdktest"
//                            withQueryString:query
//                            successHandler:^(NSDictionary *result) {
//                                NSArray *objects = result[@"objects"];
//                                NSDictionary *dict = objects[0];
//                                
//                                NSString *objectId = dict[@"__id"];
//                                
//                                object = [APObjects objectWithTypeName:@"sdktest"];
//                                object.objectId = objectId;
//                                [object fetch];
//                            } failureHandler:^(APError *error){
//                                object = nil;
//                            }];
//        [[expectFutureValue(object.properties) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
//        
//    });
//    
//    it(@"should return an error for fetch API call with invalid object id", ^(){
//        __block BOOL isFetchUnsuccessful = NO;
//        
//        APObject *object = [APObjects objectWithTypeName:@"sdktest"];
//        object.objectId = @"-200";
//        [object fetchWithFailureHandler:^(APError *error) {
//            isFetchUnsuccessful = YES;
//        }];
//        [[expectFutureValue(theValue(isFetchUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//#pragma mark TESTING_GET_PROPERTIES_METHOD
//    
//    it(@"should not return an error for retrieving a valid property with key", ^{
//        
//        APObject *object = [APObjects objectWithTypeName:@"sdktest"];
//        [object addPropertyWithKey:@"test" value:@"Another test"];
//        
//        id property = [object getPropertyWithKey:@"test"];
//        [property shouldNotBeNil];
//    });
//    
//#pragma mark TESTING_UPDATE_PROPERTIES_METHOD
//    
//    it(@"should return an error for updating an empty object", ^{
//        __block BOOL isUpdateUnsuccessful;
//        APObject *newObject = [[APObject alloc] initWithTypeName:@"NewObject"];
//        [newObject updateObjectWithSuccessHandler:^{
//            isUpdateUnsuccessful = NO;
//        } failureHandler:^(APError *error) {
//            isUpdateUnsuccessful = YES;
//        }];
//       [[expectFutureValue(theValue(isUpdateUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    
//    it(@"should not return an error for updating a property of an APObject", ^{
//        
//        __block BOOL isUpdateSuccessful = NO;
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
//            } failureHandler:^(APError *error) {
//                isUpdateSuccessful = NO;
//            }];
//        }failureHandler:^(APError *error){
//            isUpdateSuccessful = NO;
//        }];
//        
//        [[expectFutureValue(theValue(isUpdateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//#pragma mark TESTING_DELETE_PROPERTIES_METHOD
//    
//    it(@"should not return an error for deleting a property of an APObject", ^{
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
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [object removePropertyWithKey:@"address"];
//            [object updateObjectWithSuccessHandler:^(NSDictionary *result){
//                isDeleteSuccessful = YES;
//            } failureHandler:^(APError *error) {
//                isDeleteSuccessful = NO;
//            }];
//        }failureHandler:^(APError *error){
//            isDeleteSuccessful = NO;
//        }];
//        
//        [[expectFutureValue(theValue(isDeleteSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//#pragma mark TESTING_UPDATE_ATTRIBUTES_METHOD
//    
//    it(@"should not return an error for updating an attribute of an APObject", ^{
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
//            } failureHandler:^(APError *error) {
//                isUpdateSuccessful = NO;
//            }];
//        }failureHandler:^(APError *error){
//            isUpdateSuccessful = NO;
//        }];
//        
//        [[expectFutureValue(theValue(isUpdateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//#pragma mark TESTING_DELETE_ATTRIBUTES_METHOD
//    
//    it(@"should not return an error for updating an attribute of an APObject", ^{
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
//                isDeleteSuccessful = YES;
//            } failureHandler:^(APError *error) {
//                isDeleteSuccessful = NO;
//            }];
//        }failureHandler:^(APError *error){
//            isDeleteSuccessful = NO;
//        }];
//        
//        [[expectFutureValue(theValue(isDeleteSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//#pragma mark UPDATE_TESTS
//    
//    it(@"Should return an error for updating an empty object", ^{
//        __block BOOL isSaveUnsuccessful = NO;
//        
//        APObject *object = [[APObject alloc] initWithTypeName:@"sdktest"];
//        
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            isSaveUnsuccessful = NO;
//        }failureHandler:^(APError *error){
//            isSaveUnsuccessful = YES;
//        }];
//        [[expectFutureValue(theValue(isSaveUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"Should not return an error for updating a non null value object with null value property", ^{
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
//        [object addAttributeWithKey:@"Test" value:nil];
//        [object addAttributeWithKey:@"Test2" value:nil];
//        
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [object setValue:nil forKey:@"Name"];
//            [object updateObjectWithSuccessHandler:^(NSDictionary *result){
//                isSaveSuccessful = YES;
//            } failureHandler:^(APError *error) {
//                isSaveSuccessful = NO;
//            }];
//        }failureHandler:^(APError *error){
//            isSaveSuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isSaveSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"Should not return an error for updating a null property object with null value property", ^{
//        __block BOOL isSaveSuccessful = NO;
//        
//        APObject *object = [[APObject alloc] initWithTypeName:@"sdktest"];
//        [object setCreatedBy:@"Sandeep Dhull"];
//        [object addPropertyWithKey:@"Name" value:nil];
//        [object addPropertyWithKey:@"Category" value:nil];
//        [object addPropertyWithKey:@"Description" value:nil];
//        [object addPropertyWithKey:@"Address" value:nil];
//        [object addPropertyWithKey:@"GeoCodes" value:nil];
//        
//        [object addAttributeWithKey:@"Test" value:nil];
//        [object addAttributeWithKey:@"Test2" value:nil];
//        
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [object setValue:nil forKey:@"Name"];
//            [object updateObjectWithSuccessHandler:^(NSDictionary *result){
//                isSaveSuccessful = YES;
//            } failureHandler:^(APError *error) {
//                isSaveSuccessful = NO;
//            }];
//        }failureHandler:^(APError *error){
//            isSaveSuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isSaveSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"Should not return an error for updating tags", ^{
//        __block BOOL isSaveSuccessful = NO;
//        
//        APObject *object = [[APObject alloc] initWithTypeName:@"sdktest"];
//        [object setCreatedBy:@"Sandeep Dhull"];
//        [object addPropertyWithKey:@"Name" value:@"name"];
//        [object addTag:@"tag1"];
//        [object addAttributeWithKey:@"Test" value:nil];
//        [object addAttributeWithKey:@"Test2" value:nil];
//        
//        [object saveObjectWithSuccessHandler:^(NSDictionary *result){
//            [object removeTag:@"tag1"];
//            [object addTag:@"tag2"];
//            [object updateObjectWithSuccessHandler:^(NSDictionary *result){
//                isSaveSuccessful = YES;
//            } failureHandler:^(APError *error) {
//                isSaveSuccessful = NO;
//            }];
//        }failureHandler:^(APError *error){
//            isSaveSuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isSaveSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//#pragma mark SAVE_TESTS
//    
//    it(@"should not return an error for save API call with valid type name", ^{
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
//        }failureHandler:^(APError *error){
//            isSaveSuccessful = NO;
//        }];
//        
//        [[expectFutureValue(theValue(isSaveSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"Test case for saving an APObject with improper type name Failed", ^{
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
//        }failureHandler:^(APError *error){
//            isSaveUnsuccessful = YES;
//        }];
//        [[expectFutureValue(theValue(isSaveUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//#pragma mark DELETE_TESTS
//    
//    it(@"should return an error for delete API call with improper type name", ^{
//        __block BOOL isDeleteUnsuccessful = NO;
//        APObject *object = [[APObject alloc] initWithTypeName:@"typeThatDoesNotExist"];
//        [object setObjectId:@"2319381902900"];
//        [object deleteObjectWithSuccessHandler:^(void){
//            isDeleteUnsuccessful = NO;
//        }failureHandler:^(APError *error){
//            isDeleteUnsuccessful = YES;
//        }];
//        [[expectFutureValue(theValue(isDeleteUnsuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"should not return an error for delete call for a proper object id", ^{
//        __block BOOL isDeleteSuccessful = NO;
//        
//        APObject *object = [[APObject alloc] initWithTypeName:@"sdktest"];
//        
//        [object setObjectId:@"12345"];
//        
//        [object deleteObjectWithConnectingConnectionsSuccessHandler:^(){
//            isDeleteSuccessful = YES;
//        } failureHandler:^(APError *error) {
//            isDeleteSuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isDeleteSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//
//