//#import "AppacitiveSDK.h"
//
//SPEC_BEGIN(APBlobTests)
//
//describe(@"APBlobTests", ^{
//    
//    beforeAll(^() {
//        [Appacitive registerAPIKey:API_KEY useLiveEnvironment:YES];
//        [Appacitive useLiveEnvironment:NO];
//        [[APLogger sharedLogger] enableLogging:YES];
//        [[APLogger sharedLogger] enableVerboseMode:YES];
//        [[expectFutureValue([Appacitive getApiKey]) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
//    });
//    
//    afterAll(^(){
//    });
//
//#pragma mark - UPLOAD_TESTS
//    
//    it(@"uploading a file with a valid mime type", ^{
//        __block BOOL isUploadSuccessful = NO;
//        
//        NSBundle *myBundle = [NSBundle bundleForClass:[self class]];
//        NSString *uploadPath = [myBundle pathForResource:@"test_image" ofType:@"png"];
//        NSData *myData = [NSData dataWithContentsOfFile:uploadPath];
//        [APFile uploadFileWithName:@"Image2"
//                data:myData
//                urlExpiresAfter:@10
//                contentType:@"image/png"
//                successHandler:^(NSDictionary *dictionary){
//                    NSLog(@"Response:%@", dictionary.description);
//                    isUploadSuccessful = YES;
//                } failureHandler:^(APError *error){
//                    isUploadSuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isUploadSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//    it(@"fetching a file upload URL", ^{
//        __block BOOL isUploadSuccessful = NO;
//        [APFile getUploadURLForFileWithName:@"Image2"
//                urlExpiresAfter:@10
//                contentType:@"image/png"
//                successHandler:^(NSURL* url){
//                    NSLog(@"\n**********UPLOAD URL:%@\n", [url description]);
//                    isUploadSuccessful = YES;
//                } failureHandler:^(APError *error){
//                    isUploadSuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isUploadSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//
//#pragma mark - DOWNLOAD_TESTS
//    
//    it(@"downloading a file with a valid url", ^{
//        __block BOOL isDownloadSuccessful = NO;
//        
//        [APFile downloadFileWithName:@"Image2.png" urlExpiresAfter:@10 successHandler:^(NSData *data) {
//            isDownloadSuccessful = YES;
//            UIImage *image = [[UIImage alloc] initWithData:data];
//            NSLog(@"\nIMAGE SIZE:%f X %f\n",image.size.width, image.size.height);
//        } failureHandler:^(APError *error) {
//            isDownloadSuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isDownloadSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//    it(@"fetching a file download url", ^{
//        __block BOOL isDownloadSuccessful = NO;
//
//        [APFile getDownloadURLForFileWithName:@"Image2.png" urlExpiresAfter:@10 successHandler:^(NSURL *url) {
//            isDownloadSuccessful = YES;
//            NSLog(@"\n**********DOWNLOAD URL:%@\n",[url description]);
//        } failureHandler:^(APError *error) {
//            isDownloadSuccessful = NO;
//        }];
//        [[expectFutureValue(theValue(isDownloadSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//    
//});
//SPEC_END
//
