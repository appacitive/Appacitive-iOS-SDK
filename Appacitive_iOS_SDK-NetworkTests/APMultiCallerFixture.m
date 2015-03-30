#import "AppacitiveSDK.h"

SPEC_BEGIN(APMultiCallerFixture)

__block NSArray * objectsToDelete;

describe(@"APMultiCallerFixture", ^{
    beforeAll(^() {
//        [Appacitive useLiveEnvironment:YES];
        [Appacitive registerAPIKey:API_KEY useLiveEnvironment:NO];
        [[APLogger sharedLogger] enableLogging:YES];
        [[APLogger sharedLogger] enableVerboseMode:YES];
        [[expectFutureValue([Appacitive getApiKey]) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
        
        objectsToDelete = [[NSMutableArray alloc] init];
    });

    
//    it(@"multi test creating a single article", ^{
//        
//        __block BOOL isSuccessful = NO;
//        
//        APMultiCaller * caller = [[APMultiCaller alloc] init];
//        
//        APObject * obj = [[APObject alloc] initWithTypeName:@"sdk"];
//        [obj addPropertyWithKey:@"name" value:@"multiTest"];
//        
//        [caller addAPObject:obj];
////
//        [caller saveWithSuccessHandler:^(NSDictionary * result){
//            isSuccessful = YES;
//            
//        }andFailureHandlerBlock : ^(APError * err){
//            isSuccessful = NO;
//        }];
//        
//        [[expectFutureValue(theValue(isSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//        
//    });
    
//    it(@"multi caller test creating a single connection", ^{
//    
//        __block BOOL isSuccessful = NO;
//        
//        APMultiCaller * caller = [[APMultiCaller alloc] init];
//        
//        APConnection * connection = [[APConnection alloc] initWithRelationType:@"testconnection"];
//        connection.objectAId = @"68441005258572092";
//        connection.labelA = @"sdk";
//        
//        connection.objectBId = @"68440976550658307";
//        connection.labelB = @"sdktest";
//        
//        [caller addAPConnection:connection];
//        
//        [caller saveWithSuccessHandler:^(NSDictionary * result){
//            isSuccessful = YES;
//            
//        }andFailureHandlerBlock : ^(APError * err){
//            isSuccessful = NO;
//        }];
//        
//        [[expectFutureValue(theValue(isSuccessful)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
//    });
    
//    it(@"multi caller test creating a new object and connecting it with another existing object",^{
//       
//        __block BOOL isSuccessful = NO;
//        APObject * existingObject = [[APObject alloc   ]initWithTypeName:@"test"];
//        [existingObject addPropertyWithKey:@"name" value:@"existing"];
//        
//        [existingObject saveObjectWithSuccessHandler: ^(NSDictionary * result)
//        {
//            
//            APMultiCaller *caller = [[APMultiCaller alloc] init];
//            APObject * newObject = [[APObject alloc] initWithTypeName:@"test2"];
//            [newObject addPropertyWithKey:@"name" value:@"new"];
//            
//            APConnection * newConnection = [[APConnection alloc] initWithRelationType:@"conn"];
//            newConnection.objectAId = existingObject.objectId;
//            newConnection.labelA = @"test";
//            
//            newConnection.objectB = newObject;
//            newConnection.labelB = @"test2";
//            
//            [caller addAPObject:newObject];
//            [caller addAPConnection:newConnection];
//            
//            [caller saveWithSuccessHandler: ^(NSDictionary * result){
//                isSuccessful = YES;
//                
//            }
//            andFailureHandlerBlock : ^(APError * err){
//                isSuccessful = NO;
//            }
//             ];
////            [[expectFutureValue(theValue(isSuccessful)) shouldEventuallyBeforeTimingOutAfter(10.0)] equal:theValue(YES)];
//        }failureHandler:^(APError * error){
//            isSuccessful = NO;
//        }
//         ];
//        [[expectFutureValue(theValue(isSuccessful)) shouldEventuallyBeforeTimingOutAfter(10.0)] equal:theValue(YES)];
//    });
    
    
    it(@"multi caller test deleting two existing",^{
        
        __block BOOL isSuccessful = NO;
        APObject * existingObject = [[APObject alloc   ]initWithTypeName:@"test"];
        [existingObject addPropertyWithKey:@"name" value:@"testing2"];
        
        APObject * existingObject2 = [[APObject alloc   ]initWithTypeName:@"test2"];
        [existingObject addPropertyWithKey:@"name" value:@"object2"];
        APConnection * connection = [[APConnection alloc] initWithRelationType:@"conn"];
        [connection setObjectA:existingObject];
        [connection setLabelA:@"test"];

        [connection setObjectB:existingObject2];
        [connection setLabelB:@"test2"];
        
        
        [connection createConnectionWithSuccessHandler:^{
            APMultiCaller *caller = [[APMultiCaller alloc] init];
            
            [caller addForDeletionAPObjectOfType:existingObject.type andId:existingObject.objectId andDeleteConnections:YES];
            [caller saveWithSuccessHandler: ^(NSDictionary * result){
                isSuccessful = YES;
                
            }
                   andFailureHandlerBlock : ^(APError * err){
                       isSuccessful = NO;
                   }
             ];
        } failureHandler:^(APError *error) {
            isSuccessful = NO;
        }];
        [[expectFutureValue(theValue(isSuccessful)) shouldEventuallyBeforeTimingOutAfter(20.0)] equal:theValue(YES)];
    });
    
});

SPEC_END