#import "AppacitiveSDK.h"

SPEC_BEGIN(APGraphNodeFixture)

describe(@"APGraphNode", ^{

    beforeAll(^() {
//        [Appacitive registerAPIKey:API_KEY useLiveEnvironment:YES];
        [Appacitive registerAPIKey:@"u0cZFykv+UFWF/zUeCLETiomOUTwhpVIsW6E62gOtKk=" useLiveEnvironment:NO];
        [Appacitive useLiveEnvironment:NO];
        [[APLogger sharedLogger] enableLogging:YES];
        [[APLogger sharedLogger] enableVerboseMode:YES];
        [[expectFutureValue([Appacitive getApiKey]) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
        [APNetworking resetDefaultHTTPHeaders];
    });
    
    afterAll(^(){
    });

#pragma mark - GRAPH_QUERY_TESTS

//    it(@"valid filter graph query", ^{
//        __block BOOL isFilterQuerySuccessful = NO;
//
//        [APGraphNode applyFilterGraphQuery:@"sdktest" usingPlaceHolders:nil successHandler:^(NSArray *objects) {
//            NSLog(@"%@",objects);
//            isFilterQuerySuccessful = YES;
//        } failureHandler:^(APError *error) {
//            isFilterQuerySuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isFilterQuerySuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
    it(@"valid projection graph query", ^{
        __block BOOL isProjectionQuerySuccessful = NO;
//        [APGraphNode applyProjectionGraphQuery:@"deals_for_user" usingPlaceHolders:nil forObjectsIds:[NSArray arrayWithObjects:@"54862743435608393",@"54862742699508036",@"53918589455041342", nil] successHandler:^(NSArray *nodes) {
//            isProjectionQuerySuccessful = YES;
//        } failureHandler:^(APError *error) {
//            isProjectionQuerySuccessful = NO;
//        }];
        [APGraphNode applyProjectionGraphQuery:@"getMessagesForUser" usingPlaceHolders:@{@"deleted":@"0"} forObjectsIds:@[@"44506930614501775",@"44012857005835404",@"45095900523135297",@"44012636240741433",@"44012579887121346",@"44012698284983073",@"44012525777454241"] successHandler:^(NSArray *objects) {
            isProjectionQuerySuccessful = YES;
        }];
        [[expectFutureValue(theValue(isProjectionQuerySuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
    });

});
SPEC_END

