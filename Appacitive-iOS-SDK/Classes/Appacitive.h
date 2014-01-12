//
//  Appacitive.h
//  Appacitive-iOS-SDK
//
//  Created by Kauserali Hafizji on 29/08/12.
//  Copyright (c) 2012 Appacitive Software Pvt. All rights reserved.
//

/**
 Appacitive is the entry point to use the Appacitive SDK.
 Here you set your Appacitive application APIKey and your Appacitive application environment, which will be used to make all network requests to Appacitive back end.
 */

@interface Appacitive: NSObject

@property (nonatomic, strong, readonly) NSString *session;
@property (nonatomic, readwrite) BOOL enableDebugForEachRequest;

/**
 Returns the current ApiKey
 */
+ (NSString*) getApiKey;

/**
 Sets the APIkey
 */
+ (void) initWithAPIKey:(NSString*)apiKey;


/**
 By default the environment is set to sandbox. To change to live set the enableLiveEnvironment property of the Appacitive object.
 
 @return The environment to use
 */
+ (NSString*) environmentToUse;

/**
 Method to set application environment to live
 */
+ (void) useLiveEnvironment:(BOOL)answer;


@end
