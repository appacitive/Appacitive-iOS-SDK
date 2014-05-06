//#import "Appacitive.h"
//#import "APGraphNode.h"
//#import "APError.h"
//#import "APDevice.h"
//
//SPEC_BEGIN(APGraphNodeFixture)
//
//describe(@"APGraphNode", ^{
//
//    beforeAll(^() {
//        [Appacitive registerAPIKey:API_KEY useLiveEnvironment:YES];
//        [Appacitive useLiveEnvironment:NO];
//        [[expectFutureValue([Appacitive getApiKey]) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
//    });
//
//    afterAll(^(){
//    });
//
//#pragma mark - GRAPH_QUERY_TESTS
//
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
//
//    it(@"valid projection graph query", ^{
//        __block BOOL isProjectionQuerySuccessful = NO;
//        APGraphNode *node = [[APGraphNode alloc] init];
//        [node applyProjectionGraphQuery:@"deals_for_user" usingPlaceHolders:nil forObjectsIds:[NSArray arrayWithObjects:@"53918589455041342", nil] successHandler:^(APGraphNode *node) {
//            isProjectionQuerySuccessful = YES;
//        } failureHandler:^(APError *error) {
//            isProjectionQuerySuccessful = NO;
//        }];
//        
//        [[expectFutureValue(theValue(isProjectionQuerySuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//});
//SPEC_END
//
