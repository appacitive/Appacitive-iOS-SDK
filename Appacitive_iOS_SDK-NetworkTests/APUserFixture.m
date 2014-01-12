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
//#pragma mark AUTHENTICATE_TEST
//    
//    it(@"should not return an error for retrieving a user with a valid user id", ^{
//        __block BOOL isUserAuthenticateSuccesful = NO;
//
//        [APUser authenticateUserWithUserName:@"ppatel"
//                password:@"1qaz1qaz"
//                successHandler:^(APUser* user) {
//                    isUserAuthenticateSuccesful = YES;
//                } failureHandler:^(APError *error) {
//                    isUserAuthenticateSuccesful = NO;
//                }];
//        [[expectFutureValue(theValue(isUserAuthenticateSuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"should not return an error for validating user session with a valid user token", ^{
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
//    it(@"should not return an error for logging out a user", ^{
//        __block BOOL isUserLoggedOut = NO;
//        
//        [APUser authenticateUserWithUserName:@"ppatel"
//                                    password:@"1qaz1qaz"
//                              successHandler:^(APUser *user) {
//                                  [APUser logoutCurrentlyLoggedInUserWithSuccessHandler:^{
//                                      if([APUser currentUser] == nil)
//                                          isUserLoggedOut = YES;
//                                  } failuderHandler:^(APError *error) {
//                                      isUserLoggedOut = NO;
//                                  }];
//                              }
//                              failureHandler:^(APError *error) {
//                                  isUserLoggedOut = NO;
//                              }];
//        [[expectFutureValue(theValue(isUserLoggedOut)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"should not return an error for authenticating with a valid facebook id", ^{
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
//    it(@"should not return an error for authenticating with a valid twitter oauth token and oauth secret", ^{
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
//    it(@"should not return an error for authenticating with a valid twitter oauth token, oauth secret, consumer key and consumer secret", ^{
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
//#pragma mark CREATE_USER
//    
//    it(@"should not return an error for creating a user", ^{
//        __block BOOL isUserCreated = NO;
//        
//        APUserDetails *userDetails = [[APUserDetails alloc] init];
//        userDetails.username = @"test12";
//        userDetails.birthDate = @"1982-11-17";
//        userDetails.firstName = @"giles";
//        userDetails.lastName = @"giles";
//        userDetails.email = @"giles@test.com";
//        userDetails.password = @"test123";
//        userDetails.phone = @"1234";
//        
//        [APUser createUserWithDetails:userDetails
//                successHandler:^(APUser* user) {
//                    isUserCreated = YES;
//                    [user deleteUser];
//                } failuderHandler:^(APError* error) {
//                    isUserCreated = NO;
//                }];
//        [[expectFutureValue(theValue(isUserCreated)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"should not return an error for deleting a user", ^{
//        __block BOOL isUserDeleted = NO;
//        
//        APUserDetails *userDetails = [[APUserDetails alloc] init];
//        userDetails.username = @"test123";
//        userDetails.birthDate = @"1982-11-17";
//        userDetails.firstName = @"giles1";
//        userDetails.lastName = @"giles1";
//        userDetails.email = @"giles1@test.com";
//        userDetails.password = @"test1234";
//        userDetails.phone = @"12345";
//        
//        [APUser createUserWithDetails:userDetails successHandler:^(APUser* user) {
//            [user deleteUserWithSuccessHandler:^{
//                isUserDeleted = YES;
//            } failuderHandler:^(APError* error) {
//                isUserDeleted = NO;
//            }];
//        } failuderHandler:^(APError* error) {
//            isUserDeleted = NO;
//        }];
//        [[expectFutureValue(theValue(isUserDeleted)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//   
//    it(@"should not return an error for checkin-in a user to a location", ^{
//        __block BOOL isLocationSet = NO;
//        
//        APUserDetails *userDetails = [[APUserDetails alloc] init];
//        userDetails.username = @"test1234";
//        userDetails.birthDate = @"1982-11-17";
//        userDetails.firstName = @"giles1";
//        userDetails.lastName = @"giles1";
//        userDetails.email = @"giles1@test.com";
//        userDetails.password = @"test1234";
//        userDetails.phone = @"12345";
//        
//        [APUser createUserWithDetails:userDetails successHandler:^(APUser* user) {
//            [APUser setUserLocationToLatitude:@"2" longitude:@"2" forUserWithUserId:user.objectId successHandler:^{
//                isLocationSet = YES;
//                [user deleteUser];
//            } failuderHandler:^(APError* error) {
//                isLocationSet = NO;
//                [user deleteUser];
//            }];
//        } failuderHandler:^(APError* error) {
//            isLocationSet = NO;
//        }];
//        [[expectFutureValue(theValue(isLocationSet)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"should not return an error for resetting a user's password", ^{
//        __block BOOL isPasswordReset = NO;
//        
//        APUserDetails *userDetails = [[APUserDetails alloc] init];
//        userDetails.username = @"test123456";
//        userDetails.birthDate = @"1982-11-17";
//        userDetails.firstName = @"giles1";
//        userDetails.lastName = @"giles1";
//        userDetails.email = @"giles1@test.com";
//        userDetails.password = @"test1234";
//        userDetails.phone = @"12345";
//        
//        [APUser createUserWithDetails:userDetails successHandler:^(APUser* user) {
//            [APUser sendResetPasswordEmailWithEmailSubject:@"YourNewPassword" successHandler:^{
//                isPasswordReset = YES;
//                [user deleteUser];
//            } failureHandler:^(APError *error) {
//                isPasswordReset = NO;
//                [user deleteUser];
//            }];
//        } failuderHandler:^(APError* error) {
//            isPasswordReset = NO;
//        }];
//        [[expectFutureValue(theValue(isPasswordReset)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"should not return an error for changing a user's password", ^{
//        __block BOOL isPasswordChanged = NO;
//        
//        APUserDetails *userDetails = [[APUserDetails alloc] init];
//        userDetails.username = @"test12345";
//        userDetails.birthDate = @"1982-11-17";
//        userDetails.firstName = @"giles1";
//        userDetails.lastName = @"giles1";
//        userDetails.email = @"giles1@test.com";
//        userDetails.password = @"test1234";
//        userDetails.phone = @"12345";
//        
//        [APUser createUserWithDetails:userDetails successHandler:^(APUser* user) {
//            [user changePasswordFromOldPassword:@"test1234" toNewPassPassword:@"newpass123" successHandler:^{
//                isPasswordChanged = YES;
//                [user deleteUser];
//            } failureHandler:^(APError *error) {
//                isPasswordChanged = NO;
//                [user deleteUser];
//            }];
//        } failuderHandler:^(APError* error) {
//            isPasswordChanged = NO;
//        }];
//        [[expectFutureValue(theValue(isPasswordChanged)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//});
//
//SPEC_END

