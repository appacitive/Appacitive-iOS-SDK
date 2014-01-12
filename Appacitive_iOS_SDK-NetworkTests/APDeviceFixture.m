//#import "Appacitive.h"
//#import "APObject.h"
//#import "APError.h"
//#import "APDevice.h"
//#import "APUser.h"
//
//SPEC_BEGIN(APDeviceTests)
//
//describe(@"APDeviceTests", ^{
//
//    beforeAll(^() {
//        [Appacitive initWithAPIKey:API_KEY];
//        [Appacitive useLiveEnvironment:NO];
//        [APUser authenticateUserWithUserName:@"ppatel"
//                                            password:@"1qaz1qaz"
//                 successHandler:^(APUser *user) {
//                 }];
// 
//        [[expectFutureValue([Appacitive getApiKey]) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
//    });
//
//    afterAll(^(){
//    });
//
//#pragma mark REGISTER_DEVICE_TEST
//
//    it(@"should not return an error for uploading a file with a valid mime type", ^{
//        __block BOOL isDeviceCreated = NO;
//        
//        APDevice *mydevice = [[APDevice alloc] initWithDeviceToken:@"9999999999" deviceType:@"ios"];
//        [mydevice registerDeviceWithSuccessHandler:^(APDevice *device) {
//            isDeviceCreated = YES;
//            [device deleteDevice];
//        } failureHandler:^(APError *error) {
//            isDeviceCreated = NO;
//        }];
//       
//        [[expectFutureValue(theValue(isDeviceCreated)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//#pragma mark DELETE_DEVICE_TEST
//
//    it(@"should not return an error for downloading a file with a valid url", ^{
//        __block BOOL isDeviceDeleted = NO;
//
//        APDevice *mydevice = [[APDevice alloc] initWithDeviceToken:@"9999999999" deviceType:@"ios"];
//        [mydevice registerDeviceWithSuccessHandler:^(APDevice *device) {
//            [device deleteDeviceWithSuccessHandler:^{
//                isDeviceDeleted = YES;
//            } failureHandler:^(APError *error) {
//                isDeviceDeleted = NO;
//            } deleteConnectingConnections:YES];
//        } failureHandler:^(APError *error) {
//            isDeviceDeleted = NO;
//        }];
//        
//        [[expectFutureValue(theValue(isDeviceDeleted)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//});
//SPEC_END
//
