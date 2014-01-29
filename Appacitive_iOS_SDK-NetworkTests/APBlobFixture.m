//#import "Appacitive.h"
//#import "APObject.h"
//#import "APError.h"
//#import "APQuery.h"
//#import "APFile.h"
//
//SPEC_BEGIN(APBlobTests)
//
//describe(@"APBlobTests", ^{
//    
//    beforeAll(^() {
//        [Appacitive initWithAPIKey:API_KEY];
//        [Appacitive useLiveEnvironment:NO];
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
//        APFile *apFile = [[APFile alloc] init];
//        [apFile uploadFileWithName:@"Image2"
//                data:myData
//                validUrlForTime:@10
//                contentType:@"image/png"
//                successHandler:^(NSDictionary *dictionary){
//                    NSLog(@"%@", dictionary.description);
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
//        __block BOOL isDownloadSuccesful = NO;
//        
//        APFile *apFile = [[APFile alloc] init];
//        [apFile downloadFileWithName:@"Image2.png" validUrlForTime:@10 successHandler:^(NSData *data) {
//            isDownloadSuccesful = YES;
//            UIImage *image = [[UIImage alloc] initWithData:data];
//            NSLog(@"\nImageSize:%f X %f\n",image.size.width, image.size.height);
//        } failureHandler:^(APError *error) {
//            isDownloadSuccesful = NO;
//        }];
//        [[expectFutureValue(theValue(isDownloadSuccesful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
//});
//SPEC_END
//
