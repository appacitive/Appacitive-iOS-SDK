//#import "AppacitiveSDK.h"
//
//SPEC_BEGIN(APUserGroupTests)
//
//describe(@"APUserGroupTests", ^{
//
//    beforeAll(^() {
//        [Appacitive registerAPIKey:API_KEY useLiveEnvironment:NO];
//        [[expectFutureValue([Appacitive getApiKey]) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
//        [APLogger sharedLoggerWithLoggingEnabled:YES verboseMode:YES];
//    });
//
//    beforeEach(^{
//        __block BOOL isUserAuthenticateSuccessful = NO;
//        [APUser authenticateUserWithUsername:@"ppatel" password:@"asdasd" sessionExpiresAfter:nil limitAPICallsTo:nil
//                              successHandler:^(APUser* user) {
//                                  isUserAuthenticateSuccessful = YES;
//                              } failureHandler:^(APError *error) {
//                                  isUserAuthenticateSuccessful = NO;
//                              }];
//        [[expectFutureValue(theValue(isUserAuthenticateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    afterAll(^(){
//    });
//
//    it(@"Adding users to a user group", ^{
//        __block BOOL isSuccessful = NO;
//        
//        [APUserGroup addUsers:@[@"ppatel",@"aTestUser"] toUserGroup:@"vendors" successHandler:^{
//            isSuccessful = YES;
//        } failureHandler:^(APError *error) {
//            isSuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"Removing users from a user group", ^{
//        __block BOOL isSuccessful = NO;
//
//        [APUserGroup removeUsers:@[@"ppatel",@"aTestUSer"] fromUserGroup:@"vendors" successHandler:^{
//            isSuccessful = YES;
//        } failureHandler:^(APError *error) {
//            isSuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//});
//SPEC_END
//
