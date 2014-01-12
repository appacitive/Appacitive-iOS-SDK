//#import "Appacitive.h"
//#import "APGraphNode.h"
//#import "APError.h"
//
//SPEC_BEGIN(APGraphNodeFixture)
//
//describe(@"APGraphNode", ^{
//
//    beforeAll(^() {
//        [Appacitive initWithAPIKey:API_KEY];
//        [Appacitive useLiveEnvironment:NO];
//        [[expectFutureValue([Appacitive getApiKey]) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
//        
//    });
//
//    afterAll(^(){
//    });
//
//#pragma mark GRAPH_QUERY_TESTS
//
//    it(@"should not return an error for a valid filter graph query", ^{
//        __block BOOL isFilterQuerySuccessful = NO;
//
//        [APGraphNode applyFilterGraphQuery:@"sdktest" usingPlaceHolders:nil successHandler:^(NSDictionary *result) {
//            NSLog(@"%@",result);
//            isFilterQuerySuccessful = YES;
//        } failureHandler:^(APError *error) {
//            isFilterQuerySuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isFilterQuerySuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    
//    it(@"should not return an error for a valid projection graph query", ^{
//        __block BOOL isProjectionQuerySuccessful = NO;
//        APGraphNode *node = [[APGraphNode alloc] init];
//        [node applyProjectionGraphQuery:@"deals_for_user" usingPlaceHolders:nil forObjectsIds:[NSArray arrayWithObjects:@"43248934317064873", nil] successHandler:^(APGraphNode *node) {
//            isProjectionQuerySuccessful = YES;
//        } failureHandler:^(APError *error) {
//            isProjectionQuerySuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isProjectionQuerySuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//});
//SPEC_END
//
