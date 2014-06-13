#import "AppacitiveSDK.h"

SPEC_BEGIN(APDeviceTests)

describe(@"APDeviceTests", ^{

    beforeAll(^() {
        [Appacitive registerAPIKey:API_KEY useLiveEnvironment:YES];
        [Appacitive useLiveEnvironment:NO];
        [[APLogger sharedLogger] enableLogging:YES];
        [[APLogger sharedLogger] enableVerboseMode:YES];
        [[expectFutureValue([Appacitive getApiKey]) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
    });

    beforeEach(^{
        __block bool isUserAuthenticateSuccessful;
        [APUser authenticateUserWithUsername:@"ppatel" password:@"qweqwe" sessionExpiresAfter:nil limitAPICallsTo:nil
                              successHandler:^(APUser* user) {
                                  isUserAuthenticateSuccessful = YES;
                              } failureHandler:^(APError *error) {
                                  isUserAuthenticateSuccessful = NO;
                              }];
        [[expectFutureValue(theValue(isUserAuthenticateSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
    });

    afterAll(^(){
    });

#pragma mark - REGISTER_DEVICE_TEST

    it(@"registering a device", ^{
        __block BOOL isDeviceCreated = NO;
        
        APDevice *mydevice = [[APDevice alloc] initWithDeviceToken:@"9999999999" deviceType:@"ios"];
        [mydevice saveObjectWithSuccessHandler:^(NSDictionary *result) {
            isDeviceCreated = YES;
            [mydevice deleteObject];
        } failureHandler:^(APError *error) {
            isDeviceCreated = NO;
        }];

        [[expectFutureValue(theValue(isDeviceCreated)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
    });

    
    it(@"registering current device", ^{
        __block BOOL isDeviceCreated = NO;

        [APDevice registerCurrentDeviceWithPushDeviceToken:nil enablePushNotifications:NO successHandler:^{
            isDeviceCreated = YES;
        } failureHandler:^(APError *error) {
            NSLog(@"ERROR: %@",[error description]);
            isDeviceCreated = NO;
        }];

        [[expectFutureValue(theValue(isDeviceCreated)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
    });
    
#pragma mark - DELETE_DEVICE_TEST

    it(@"deleting a device", ^{
        __block BOOL isDeviceDeleted = NO;

        APDevice *mydevice = [[APDevice alloc] initWithDeviceToken:@"9999999999" deviceType:@"ios"];
        [mydevice saveObjectWithSuccessHandler:^(NSDictionary *result) {
            [mydevice deleteObjectWithConnectingConnectionsSuccessHandler:^{
                isDeviceDeleted = YES;
            } failureHandler:^(APError *error) {
                isDeviceDeleted = NO;
            }];
        } failureHandler:^(APError *error) {
            isDeviceDeleted = NO;
        }];
        
        [[expectFutureValue(theValue(isDeviceDeleted)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
    });

#pragma mark - UPDATE_DEVICE_TEST

    it(@"updating a device", ^{
        __block BOOL isDeviecUpdated = NO;
        
        APDevice *mydevice = [[APDevice alloc] initWithDeviceToken:@"9999999999" deviceType:@"ios"];
        [mydevice saveObjectWithSuccessHandler:^(NSDictionary *result) {
            [mydevice addAttributeWithKey:@"testCase" value:@"testCase"];
            [mydevice updateObjectWithSuccessHandler:^(){
                [mydevice deleteObject];
                isDeviecUpdated = YES;
                [mydevice deleteObject];
            } failureHandler:^(APError *error) {
                isDeviecUpdated = NO;
                [mydevice deleteObject];
            }];
        } failureHandler:^(APError *error) {
            [mydevice deleteObject];
            isDeviecUpdated = NO;
        }];
        
        [[expectFutureValue(theValue(isDeviecUpdated)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
    });
    
#pragma mark - FETCH_DEVICE_TEST
    
    it(@"fetching a device", ^{
        __block BOOL isDeviecUpdated = NO;
        
        APDevice *mydevice = [[APDevice alloc] initWithDeviceToken:@"9999999999" deviceType:@"ios"];
        [mydevice saveObjectWithSuccessHandler:^(NSDictionary *result) {
            [mydevice fetchWithSuccessHandler:^() {
                isDeviecUpdated = YES;
                [mydevice deleteObject];
            } failureHandler:^(APError *error) {
                isDeviecUpdated = NO;
                [mydevice deleteObject];
            }];
        } failureHandler:^(APError *error) {
            [mydevice deleteObject];
            isDeviecUpdated = NO;
        }];
        
        [[expectFutureValue(theValue(isDeviecUpdated)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
    });
    
    
#pragma mark - PUSH_TESTS
    
    it(@"sending a broadcast push message", ^{
        __block BOOL isPushSent = NO;
        
        APPushNotification *notification = [[APPushNotification alloc] initWithMessage:@"TestPush"];
        notification.isBroadcast = YES;
        [notification sendPushWithSuccessHandler:^{
            isPushSent = YES;
        } failureHandler:^(APError *error) {
            isPushSent = NO;
        }];
        
        [[expectFutureValue(theValue(isPushSent)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
        
    });
    
    it(@"sending a push message with query and platform options", ^{
        __block BOOL isPushSent = NO;
        
        APPushNotification *notification = [[APPushNotification alloc] initWithMessage:@"TestPush"];
        notification.isBroadcast = NO;
        notification.query = @"type=ios";
        notification.channels = [[NSArray arrayWithObjects:@"A", @"B", nil] mutableCopy];
        APPlatformOptions *platformOptions = [[APPlatformOptions alloc] init];
        
        [platformOptions setWindowsPhoneOptions:[[WindowsPhoneOptions alloc] initWithTileNotification:[[TileNotification alloc] init]]];
        notification.platformOptions = platformOptions;
        [notification sendPushWithSuccessHandler:^{
            isPushSent = YES;
        } failureHandler:^(APError *error) {
            isPushSent = NO;
        }];
        
        [[expectFutureValue(theValue(isPushSent)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
    });
    
});
SPEC_END

