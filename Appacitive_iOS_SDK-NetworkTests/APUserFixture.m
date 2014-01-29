//#import "Appacitive.h"
//#import "APError.h"
//#import "APUser.h"
//
//SPEC_BEGIN(APUserTests)
//
//describe(@"APUserTests", ^{
//    
//    beforeAll(^() {
//        [Appacitive initWithAPIKey:API_KEY];
//        [Appacitive useLiveEnvironment:NO];
//        [[expectFutureValue([Appacitive getApiKey]) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
//    });
//    
//    beforeEach(^{
//        [APUser authenticateUserWithUserName:@"ppatel"
//                                    password:@"1qaz1qaz"
//         successHandler:^(APUser *user) {
//         }];
//    });
//    
//    afterAll(^(){
//    });
//
//#pragma mark - AUTHENTICATE_TEST
//    
//    it(@"authenticating a user with a valid user id", ^{
//        __block BOOL isUserAuthenticateSuccesful = NO;
//
//        [APUser authenticateUserWithUserName:@"ppatel" password:@"1qaz1qaz"
//                successHandler:^(APUser* user) {
//                    isUserAuthenticateSuccesful = YES;
//                } failureHandler:^(APError *error) {
//                    isUserAuthenticateSuccesful = NO;
//                }];
//        [[expectFutureValue(theValue(isUserAuthenticateSuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"validating user session with a valid user token", ^{
//        __block BOOL isUserAuthenticateSuccesful = NO;
//        
//        [APUser authenticateUserWithUserName:@"ppatel"
//                                    password:@"1qaz1qaz"
//                              successHandler:^(APUser* user) {
//                                  [APUser validateCurrentUserSessionWithSuccessHandler:^(NSDictionary *result) {
//                                      isUserAuthenticateSuccesful = (BOOL)[result objectForKey:@"result"];
//                                  }];
//                              } failureHandler:^(APError *error) {
//                                  isUserAuthenticateSuccesful = NO;
//                              }];
//        [[expectFutureValue(theValue(isUserAuthenticateSuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"logging out a user", ^{
//        __block BOOL isUserLoggedOut = NO;
//        
//        [APUser authenticateUserWithUserName:@"ppatel"
//                                    password:@"1qaz1qaz"
//                              successHandler:^(APUser *user) {
//                                  [APUser logOutCurrentUserWithSuccessHandler:^{
//                                      if([APUser currentUser] == nil)
//                                          isUserLoggedOut = YES;
//                                  } failureHandler:^(APError *error) {
//                                      isUserLoggedOut = NO;
//                                  }];
//                              }
//                              failureHandler:^(APError *error) {
//                                  isUserLoggedOut = NO;
//                              }];
//        [[expectFutureValue(theValue(isUserLoggedOut)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"authenticating with a valid facebook id", ^{
//        __block BOOL isUserAuthenticateSuccesful = NO;
//
//        [APUser authenticateUserWithFacebook:@"CAADCQgMXRJ8BAJtHbFwoISRl6bANKbQG479K1jRxNCnZC0leDZCTEYxVqzc1gtRPY0jVoVHgkZBG8X5KDJBoSgYoWNgiQUXZBwq6PIBbRBCWPZCnFtGZBfNC4hzN56EZBsSnZCSUFxa2eQJqeiGDZB2lrekk4C8fQoBKAQUmfW4UceAssUkdMuoQQnHq6Te0ecEwZD"
//                        successHandler:^(APUser *user){
//                            isUserAuthenticateSuccesful = YES;
//                        } failureHandler:^(APError* error) {
//                            isUserAuthenticateSuccesful = NO;
//                        }];
//        [[expectFutureValue(theValue(isUserAuthenticateSuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"authenticating with a valid twitter oauth token and oauth secret", ^{
//        __block BOOL isUserAuthenticateSuccesful = NO;
//        
//        [APUser authenticateUserWithTwitter:@"86197729-p6a3vPdCxWnzcXGdCc61Fn792b8P7vvsCcHbMS2oe"
//                oauthSecret:@"qTIkQt5punO5dClxuHLolVsXuF8q6VXA3pBfjTWiUUHgI"
//                successHandler:^(APUser *user){
//                    isUserAuthenticateSuccesful = YES;
//                } failureHandler:^(APError *error) {
//                    isUserAuthenticateSuccesful = NO;
//                }];
//        
//        [[expectFutureValue(theValue(isUserAuthenticateSuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"authenticating with a valid twitter oauth token, oauth secret, consumer key and consumer secret", ^{
//        __block BOOL isUserAuthenticateSuccesful = NO;
//        
//        [APUser authenticateUserWithTwitter:@"86197729-p6a3vPdCxWnzcXGdCc61Fn792b8P7vvsCcHbMS2oe"
//                                oauthSecret:@"qTIkQt5punO5dClxuHLolVsXuF8q6VXA3pBfjTWiUUHgI"
//                                consumerKey:@"eygSW2TOkWexHIJwvhK2w"
//                                consumerSecret:@"VYz5yyF9LMbvivnRea8mLp85CwsX0QLuEvEJrzvrsMU"
//                                successHandler:^(APUser *user){
//                                    isUserAuthenticateSuccesful = YES;
//                                } failureHandler:^(APError *error) {
//                                    isUserAuthenticateSuccesful = NO;
//                                }];
//
//        [[expectFutureValue(theValue(isUserAuthenticateSuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//#pragma mark - CREATE_USER
//    
//    it(@"creating a user", ^{
//        __block BOOL isUserCreated = NO;
//        APUser *user = [[APUser alloc] init];
//        [user addPropertyWithKey:@"testProp" value:@"testPropVal"];
//        [user addAttributeWithKey:@"testAttr" value:@"testAttrVal"];
//        [user setTags:@[@"testUSer", @"dummyUser"]];
//        user.username = @"aTestUser";
//        user.birthDate = @"1982-11-17";
//        user.firstName = @"aTest";
//        user.lastName = @"User";
//        user.email = @"aTestUser@appacitive.com";
//        user.password = @"secretPhrase";
//        user.phone = @"9090909090";
//        
//        [user saveObjectWithSuccessHandler:^(NSDictionary *result) {
//            isUserCreated = YES;
//            [user deleteObject];
//        } failureHandler:^(APError *error) {
//             isUserCreated = NO;
//        }];
//
//        [[expectFutureValue(theValue(isUserCreated)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"deleting a user", ^{
//        __block BOOL isUserDeleted = NO;
//        
//        APUser *user = [[APUser alloc] init];
//        user.username = @"test123";
//        user.birthDate = @"1982-11-17";
//        user.firstName = @"giles1";
//        user.lastName = @"giles1";
//        user.email = @"giles1@test.com";
//        user.password = @"test1234";
//        user.phone = @"12345";
//        
//        [user createUserWithSuccessHandler:^() {
//            [user deleteObjectWithSuccessHandler:^{
//                isUserDeleted = YES;
//            } failureHandler:^(APError* error) {
//                isUserDeleted = NO;
//            }];
//        } failureHandler:^(APError* error) {
//            isUserDeleted = NO;
//        }];
//        [[expectFutureValue(theValue(isUserDeleted)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//   
//    it(@"checkin-in a user to a location", ^{
//        __block BOOL isLocationSet = NO;
//        
//        APUser *user = [[APUser alloc] init];
//        user.username = @"test1234";
//        user.birthDate = @"1982-11-17";
//        user.firstName = @"giles1";
//        user.lastName = @"giles1";
//        user.email = @"giles1@test.com";
//        user.password = @"test1234";
//        user.phone = @"12345";
//        
//        [user createUserWithSuccessHandler:^() {
//            [APUser setUserLocationToLatitude:@"2" longitude:@"2" forUserWithUserId:user.objectId successHandler:^{
//                isLocationSet = YES;
//                [user deleteObject];
//            } failureHandler:^(APError* error) {
//                isLocationSet = NO;
//                [user deleteObject];
//            }];
//        } failureHandler:^(APError* error) {
//            isLocationSet = NO;
//        }];
//        [[expectFutureValue(theValue(isLocationSet)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"resetting a user's password", ^{
//        __block BOOL isPasswordReset = NO;
//        
//        APUser *user = [[APUser alloc] init];
//        user.username = @"test123456";
//        user.birthDate = @"1982-11-17";
//        user.firstName = @"giles1";
//        user.lastName = @"giles1";
//        user.email = @"giles1@test.com";
//        user.password = @"test1234";
//        user.phone = @"12345";
//        
//        [user createUserWithSuccessHandler:^() {
//            [user sendResetPasswordEmailWithSubject:@"YourNewPassword" successHandler:^{
//                isPasswordReset = YES;
//                [user deleteObject];
//            } failureHandler:^(APError *error) {
//                isPasswordReset = NO;
//                [user deleteObject];
//            }];
//        } failureHandler:^(APError* error) {
//            isPasswordReset = NO;
//        }];
//        [[expectFutureValue(theValue(isPasswordReset)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"changing a user's password", ^{
//        __block BOOL isPasswordChanged = NO;
//        
//        APUser *user = [[APUser alloc] init];
//        user.username = @"test12345";
//        user.birthDate = @"1982-11-17";
//        user.firstName = @"giles1";
//        user.lastName = @"giles1";
//        user.email = @"giles1@test.com";
//        user.password = @"test1234";
//        user.phone = @"12345";
//                             
//        [user createUserWithSuccessHandler:^() {
//            [user changePasswordFromOldPassword:@"test1234" toNewPassPassword:@"newpass123" successHandler:^{
//                isPasswordChanged = YES;
//                [user deleteObject];
//            } failureHandler:^(APError *error) {
//                isPasswordChanged = NO;
//                [user deleteObject];
//            }];
//        } failureHandler:^(APError* error) {
//            isPasswordChanged = NO;
//        }];
//        [[expectFutureValue(theValue(isPasswordChanged)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//});
//
//SPEC_END
//
