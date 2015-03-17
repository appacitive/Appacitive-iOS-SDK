//#import "AppacitiveSDK.h"
//
//SPEC_BEGIN(APUserTests)
//
//describe(@"APUserTests", ^{
//    
//    beforeAll(^() {
//        
//        [Appacitive registerAPIKey:API_KEY useLiveEnvironment:NO];
//        [[expectFutureValue([Appacitive getApiKey]) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
//        [APLogger sharedLoggerWithLoggingEnabled:YES verboseMode:YES];
//    });
//
//    beforeEach(^{
////        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
////        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
//        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:@""];
//        __block BOOL isUserAuthenticateSuccessful = NO;
//        [APUser authenticateUserWithFacebook:@"CAACe3GpyeHABAFrZBtxj3hIUNTY6Y8vZCQoxrtCI3BQD7DZBrDCjfHDsqEw11HM3nsoFM4cNOqB9nZArkrKlmo0xXUHNaU9P9VEZBLSiWaB2qZCUYYRI6Y7rW2u3leutqz0q9tSfnoEclEkoJzNjydgCoVj2L2N0U1uCAV1UUoZAApXPtjFMtPtGnbZCUQZBUa1SFp1o6nZCcO4kTgXX3i60CpI0koCO0h5OVtXW4SZCtP7MgZDZD" signUp:NO
//                              successHandler:^(APUser *user){
//                                  isUserAuthenticateSuccessful = YES;
//                              } failureHandler:^(APError* error) {
//                                  isUserAuthenticateSuccessful = NO;
//                              }];
//        [[expectFutureValue(theValue(isUserAuthenticateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
////
////    afterAll(^(){
////    });
////
////    it(@"fetching a user with a invalid user id", ^{
////        __block BOOL isUserFetched = YES;
////        APUser *user = [[APUser alloc] init];
////        [user fetchUserById:@"539185894550413421l" successHandler:^(){
////            isUserFetched = YES;
////        } failureHandler:^(APError *error) {
////            isUserFetched = NO;
////        }];
////        [[expectFutureValue(theValue(isUserFetched)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(NO)];
////    });
////
////    it(@"authenticating a user with a valid user id", ^{
////        __block BOOL isUserAuthenticateSuccessful = NO;
////
////        [APUser authenticateUserWithUsername:@"ppatel" password:@"asdasd" sessionExpiresAfter:nil limitAPICallsTo:nil
////                successHandler:^(APUser* user) {
////                    isUserAuthenticateSuccessful = YES;
////                } failureHandler:^(APError *error) {
////                    isUserAuthenticateSuccessful = NO;
////                }];
////        [[expectFutureValue(theValue(isUserAuthenticateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
////    });
////
////
////    
////    it(@"validating user session with a valid user token", ^{
////        __block BOOL isUserAuthenticateSuccessful = NO;
////        
////        [APUser authenticateUserWithUsername:@"ppatel"
////                                    password:@"asdasd" sessionExpiresAfter:nil limitAPICallsTo:nil
////                              successHandler:^(APUser* user) {
////                                  [APUser validateCurrentUserSessionWithSuccessHandler:^(NSDictionary *result) {
////                                      isUserAuthenticateSuccessful = (BOOL)[result objectForKey:@"result"];
////                                  }];
////                              } failureHandler:^(APError *error) {
////                                  isUserAuthenticateSuccessful = NO;
////                              }];
////        [[expectFutureValue(theValue(isUserAuthenticateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
////    });
////
////    it(@"logging out a user", ^{
////        __block BOOL isUserLoggedOut = NO;
////        
////        [APUser authenticateUserWithUsername:@"ppatel"
////                                    password:@"asdasd" sessionExpiresAfter:nil limitAPICallsTo:nil
////                              successHandler:^(APUser *user) {
////                                  [APUser logOutCurrentUserWithSuccessHandler:^{
////                                      if([APUser currentUser] == nil)
////                                          isUserLoggedOut = YES;
////                                  } failureHandler:^(APError *error) {
////                                      isUserLoggedOut = NO;
////                                  }];
////                              }
////                              failureHandler:^(APError *error) {
////                                  isUserLoggedOut = NO;
////                              }];
////        [[expectFutureValue(theValue(isUserLoggedOut)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
////    });
////
//    it(@"authenticating with a valid facebook id", ^{
//        __block BOOL isUserAuthenticateSuccessful = NO;
//
//        [APUser authenticateUserWithFacebook:@"CAACe3GpyeHABAFrZBtxj3hIUNTY6Y8vZCQoxrtCI3BQD7DZBrDCjfHDsqEw11HM3nsoFM4cNOqB9nZArkrKlmo0xXUHNaU9P9VEZBLSiWaB2qZCUYYRI6Y7rW2u3leutqz0q9tSfnoEclEkoJzNjydgCoVj2L2N0U1uCAV1UUoZAApXPtjFMtPtGnbZCUQZBUa1SFp1o6nZCcO4kTgXX3i60CpI0koCO0h5OVtXW4SZCtP7MgZDZD" signUp:NO sessionExpiresAfter:nil limitAPICallsTo:nil
//                        successHandler:^(APUser *user){
//                            isUserAuthenticateSuccessful = YES;
//                        } failureHandler:^(APError* error) {
//                            isUserAuthenticateSuccessful = NO;
//                        }];
//        [[expectFutureValue(theValue(isUserAuthenticateSuccessful)) shouldEventuallyBeforeTimingOutAfter(10.0)] equal:theValue(YES)];
//    });
////
////    it(@"authenticating with a valid twitter oauth token and oauth secret", ^{
////        __block BOOL isUserAuthenticateSuccessful = NO;
////        
////        [APUser authenticateUserWithTwitter:@"86197729-p6a3vPdCxWnzcXGdCc61Fn792b8P7vvsCcHbMS2oe"
////                oauthSecret:@"qTIkQt5punO5dClxuHLolVsXuF8q6VXA3pBfjTWiUUHgI" signUp:NO sessionExpiresAfter:nil limitAPICallsTo:nil
////                successHandler:^(APUser *user){
////                    isUserAuthenticateSuccessful = YES;
////                } failureHandler:^(APError *error) {
////                    isUserAuthenticateSuccessful = NO;
////                }];
////        
////        [[expectFutureValue(theValue(isUserAuthenticateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
////    });
////
////    it(@"authenticating with a valid twitter oauth token, oauth secret, consumer key and consumer secret", ^{
////        __block BOOL isUserAuthenticateSuccessful = NO;
////        
////        [APUser authenticateUserWithTwitter:@"86197729-p6a3vPdCxWnzcXGdCc61Fn792b8P7vvsCcHbMS2oe"
////                                oauthSecret:@"qTIkQt5punO5dClxuHLolVsXuF8q6VXA3pBfjTWiUUHgI"
////                                consumerKey:@"eygSW2TOkWexHIJwvhK2w"
////                                consumerSecret:@"VYz5yyF9LMbvivnRea8mLp85CwsX0QLuEvEJrzvrsMU" signUp:NO sessionExpiresAfter:nil limitAPICallsTo:nil
////                                successHandler:^(APUser *user){
////                                    isUserAuthenticateSuccessful = YES;
////                                } failureHandler:^(APError *error) {
////                                    isUserAuthenticateSuccessful = NO;
////                                }];
////
////        [[expectFutureValue(theValue(isUserAuthenticateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
////    });
////
////
////    it(@"creating a user", ^{
////        __block BOOL isUserCreated = NO;
////        APUser *user = [[APUser alloc] init];
////        [user addPropertyWithKey:@"testProp" value:@"testPropVal"];
////        [user addAttributeWithKey:@"testAttr" value:@"testAttrVal"];
////        [user setTags:@[@"testUSer", @"dummyUser"]];
////        user.username = @"aTestUser";
////        user.birthDate = @"1982-11-17";
////        user.firstName = @"aTest";
////        user.lastName = @"User";
////        user.email = @"aTestUser@appacitive.com";
////        user.password = @"secretPhrase";
////        user.phone = @"9090909090";
////        
////        [user saveObjectWithSuccessHandler:^(NSDictionary *result) {
////            isUserCreated = YES;
////            [user deleteObject];
////        } failureHandler:^(APError *error) {
////             isUserCreated = NO;
////        }];
////
////        [[expectFutureValue(theValue(isUserCreated)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
////    });
////
////    it(@"deleting a user", ^{
////        __block BOOL isUserDeleted = NO;
////        
////        APUser *user = [[APUser alloc] init];
////        user.username = @"test123";
////        user.birthDate = @"1982-11-17";
////        user.firstName = @"giles1";
////        user.lastName = @"giles1";
////        user.email = @"giles1@test.com";
////        user.password = @"test1234";
////        user.phone = @"12345";
////        
////        [user createUserWithSuccessHandler:^() {
////            [user deleteObjectWithSuccessHandler:^{
////                isUserDeleted = YES;
////            } failureHandler:^(APError* error) {
////                isUserDeleted = NO;
////            }];
////        } failureHandler:^(APError* error) {
////            isUserDeleted = NO;
////        }];
////        [[expectFutureValue(theValue(isUserDeleted)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
////    });
////    
////    it(@"updating a user", ^{
////        __block BOOL isUserUpdated = NO;
////
////        APUser *user = [[APUser alloc] init];
////        user.username = @"test123";
////        user.birthDate = @"1982-11-17";
////        user.firstName = @"giles1";
////        user.lastName = @"giles1";
////        user.email = @"giles1@test.com";
////        user.password = @"test1234";
////        user.phone = @"12345";
////        [user addAttributeWithKey:@"myattribute" value:@"myattribval"];
////        [user setTags:@[@"dummy",@"fake"]];
////        
////        [user createUserWithSuccessHandler:^() {
////            
////            user.lastName = @"newlastname";
////            [user updatePropertyWithKey:@"myproperty2" value:@"mypropval2"];
////            [user addAttributeWithKey:@"myattr2" value:@"myattrval2"];
////            [user removeTag:@"fake"];
////            
////            [user updateObjectWithSuccessHandler:^{
////                [user deleteObject];
////                isUserUpdated = YES;
////            } failureHandler:^(APError* error) {
////                isUserUpdated = NO;
////                [user deleteObject];
////            }];
////        } failureHandler:^(APError* error) {
////            isUserUpdated = NO;
////        }];
////        [[expectFutureValue(theValue(isUserUpdated)) shouldEventuallyBeforeTimingOutAfter(5555555.0)] equal:theValue(YES)];
////    });
////
////    it(@"checkin-in a user to a location", ^{
////        __block BOOL isLocationSet = NO;
////        
////        APUser *user = [[APUser alloc] init];
////        user.username = @"test1234";
////        user.birthDate = @"1982-11-17";
////        user.firstName = @"giles1";
////        user.lastName = @"giles1";
////        user.email = @"giles1@test.com";
////        user.password = @"test1234";
////        user.phone = @"12345";
////        
////        [user createUserWithSuccessHandler:^() {
////            [APUser setUserLocationToLatitude:@"2" longitude:@"2" forUserWithUserId:user.objectId successHandler:^{
////                isLocationSet = YES;
////                [user deleteObject];
////            } failureHandler:^(APError* error) {
////                isLocationSet = NO;
////                [user deleteObject];
////            }];
////        } failureHandler:^(APError* error) {
////            isLocationSet = NO;
////        }];
////        [[expectFutureValue(theValue(isLocationSet)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
////    });
////
////    it(@"resetting a user's password", ^{
////        __block BOOL isPasswordReset = NO;
////        
////        APUser *user = [[APUser alloc] init];
////        user.username = @"test123456";
////        user.birthDate = @"1982-11-17";
////        user.firstName = @"giles1";
////        user.lastName = @"giles1";
////        user.email = @"ppatel@appacitive.com";
////        user.password = @"test1234";
////        user.phone = @"12345";
////        
////        [user createUserWithSuccessHandler:^() {
////            [APUser sendResetPasswordEmailForUserWithUsername:@"ppatel" withSubject:@"YourNewPassword" successHandler:^{
////                isPasswordReset = YES;
////                [user deleteObject];
////            } failureHandler:^(APError *error) {
////                isPasswordReset = NO;
////                [user deleteObject];
////            }];
////        } failureHandler:^(APError* error) {
////            isPasswordReset = NO;
////        }];
////        [[expectFutureValue(theValue(isPasswordReset)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
////    });
////
////    it(@"changing a user's password", ^{
////        __block BOOL isPasswordChanged = NO;
////        
////        APUser *user = [[APUser alloc] init];
////        user.username = @"test12345";
////        user.birthDate = @"1982-11-17";
////        user.firstName = @"giles1";
////        user.lastName = @"giles1";
////        user.email = @"giles1@test.com";
////        user.password = @"test1234";
////        user.phone = @"12345";
////                             
////        [user createUserWithSuccessHandler:^() {
////            [user changePasswordFromOldPassword:@"test1234" toNewPassword:@"newpass123" successHandler:^{
////                isPasswordChanged = YES;
////                [user deleteObject];
////            } failureHandler:^(APError *error) {
////                isPasswordChanged = NO;
////                [user deleteObject];
////            }];
////        } failureHandler:^(APError* error) {
////            isPasswordChanged = NO;
////        }];
////        [[expectFutureValue(theValue(isPasswordChanged)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
////    });
////    it(@"linking a facebook account", ^{
////        __block BOOL isPasswordChanged = NO;
////
////        APUser *user = [[APUser alloc] init];
////        user.username = @"test12345";
////        user.firstName = @"giles1";
////        user.email = @"giles1@test.com";
////        user.password = @"qweqwe";
////
////        [user createUserWithSuccessHandler:^() {
////            [user linkFacebookAccountWithAccessToken:@"CAACEdEose0cBANKCD3n6Gq1hSeLIF0ZBbRehHLT5GsJZCxfCJPnglYU3zZBMAB7ZBgEMBEFbZBtZA7FHZAx7HhyYZCBTQlzSFaxzVsK6RPeuX6NlNMPrTHp3ozoyXwIcRmGOpJ8xZBUApJGjEDBZAPHivF5RZBk9H3au7TroZCetmaLt7ZCxdwCkgZCb4EFRQoUmSrZAwwZD" successHandler:^{
////                isPasswordChanged = YES;
////                [user deleteObject];
////            } failureHandler:^(APError *error) {
////                isPasswordChanged = NO;
////                [user deleteObject];
////            }];
////        } failureHandler:^(APError* error) {
////            isPasswordChanged = NO;
////        }];
////        [[expectFutureValue(theValue(isPasswordChanged)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
////    });
////    
////    it(@"linking a twitter account", ^{
////        __block BOOL isPasswordChanged = NO;
////        
////        APUser *user = [[APUser alloc] init];
////        user.username = @"test12345";
////        user.firstName = @"giles1";
////        user.email = @"giles1@test.com";
////        user.password = @"qweqwe";
////        
////        [user createUserWithSuccessHandler:^() {
////            [user linkTwitterAccountWithOauthToken:@"asdasdasd" oauthSecret:@"asdadsasd" successHandler:^{
////                isPasswordChanged = YES;
////                [user deleteObject];
////            } failureHandler:^(APError *error) {
////                isPasswordChanged = NO;
////                [user deleteObject];
////            }];
////        } failureHandler:^(APError* error) {
////            isPasswordChanged = NO;
////        }];
////        [[expectFutureValue(theValue(isPasswordChanged)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
////    });
////    
////    it(@"linking a twitter account with consumerKey and consumerSecret", ^{
////        __block BOOL isPasswordChanged = NO;
////        
////        APUser *user = [[APUser alloc] init];
////        user.username = @"test12345";
////        user.firstName = @"giles1";
////        user.email = @"giles1@test.com";
////        user.password = @"qweqwe";
////        
////        [user createUserWithSuccessHandler:^() {
////            [user linkTwitterAccountWithOauthToken:@"asdasd" oauthSecret:@"asdasd" consumerKey:@"asdasd" consumerSecret:@"asdasd" successHandler:^{
////                isPasswordChanged = YES;
////                [user deleteObject];
////            } failureHandler:^(APError *error) {
////                isPasswordChanged = NO;
////                [user deleteObject];
////            }];
////        } failureHandler:^(APError* error) {
////            isPasswordChanged = NO;
////        }];
////        [[expectFutureValue(theValue(isPasswordChanged)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
////    });
////    
////    it(@"getting linked account", ^{
////        __block BOOL isPasswordChanged = NO;
////        
////        [[APUser currentUser] getLinkedAccountWithServiceName:@"facebook" successHandler:^(NSDictionary *result) {
////            isPasswordChanged = YES;
////        } failureHandler:^(APError *error) {
////            isPasswordChanged = NO;
////        }];
////        [[expectFutureValue(theValue(isPasswordChanged)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
////    });
////    
////    it(@"linking all linked accounts", ^{
////        __block BOOL isPasswordChanged = NO;
////        
////            [[APUser currentUser] getAllLinkedAccountsWithSuccessHandler:^(NSDictionary *result) {
////                isPasswordChanged = YES;
////            } failureHandler:^(APError *error) {
////                isPasswordChanged = NO;
////            }];
////            [[expectFutureValue(theValue(isPasswordChanged)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
////    });
////    
////    it(@"delinking a facebook account", ^{
////        __block BOOL isPasswordChanged = NO;
////        
////        [[APUser currentUser] delinkAccountWithServiceName:@"twitter" successHandler:^() {
////            isPasswordChanged = YES;
////        } failureHandler:^(APError* error) {
////            isPasswordChanged = NO;
////        }];
////        [[expectFutureValue(theValue(isPasswordChanged)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
////    });
////
////
//});
//SPEC_END
//
