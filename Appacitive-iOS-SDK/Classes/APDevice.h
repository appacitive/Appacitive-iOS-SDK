//
//  APDevice.h
//  Appacitive-iOS-SDK
//
//  Created by Pratik on 23-12-13.
//  Copyright (c) 2013 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import "APObject.h"
#import "APResponseBlocks.h"

typedef enum {
    Toast,
    Tile,
    Raw
} WPNotificationType;

typedef enum {
    Flip,
    Cyclic,
    Iconic
} WPTileType;

@interface APDevice : APObject <APObjectPropertyMapping>

@property (nonatomic, strong) NSString *deviceToken;
@property (nonatomic, strong) NSString *deviceType;
@property (nonatomic, strong) NSString *deviceLocation;
@property (nonatomic, strong) NSMutableArray *channels;
@property (nonatomic, strong) NSString *timeZone;
@property (nonatomic, strong) NSString* isAvctive;

/** Create a basic instance of an APDevice Object with deviceToken and deviceType
 @param deviceToken device token provided by Appacitive
*/
- (instancetype) initWithDeviceToken:(NSString*)deviceToken deviceType:(NSString*)deviceType;

/**
 @see registerDeviceWithSuccessHandler:failureHandler:
 */
- (void) registerDevice;

/**
 Method to register a device to Appacitive
 
 @note On successfull registration, a device Object will be returned in the successblock
 */
- (void) registerDeviceWithSuccessHandler:(APDeviceSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

/**
 @see deleteDeviceWithSuccessHandler:failureHandler:
 */
- (void) deleteDevice;

/**
 @see deleteDeviceWithSuccessHandler:failureHandler:
 */
- (void) deleteDeviceWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

/**
 Method to delete device form Appacitive
 
 @param deleteConnections if set to yes, will delete all the coonections connecting to the deleted device
 */
- (void) deleteDeviceWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock deleteConnectingConnections:(BOOL)deleteConnections;


/**
 @see updateDeviceWithSuccessHandler:failureHandler:
*/
- (void) updateDevice;

/**
 Method to update the device object
 */
- (void) updateDeviceWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

/**
 @see fetchDeviceWithSuccessHandler:failureHandler:
 */
- (void) fetchDevice;

/**
 Method to fetch a device object
 */

- (void) fetchDeviceWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

@end





#pragma mark - IOSOptions Interface

@interface IOSOptions : NSObject

@property (strong, nonatomic, readonly) NSString *soundFile;

- (instancetype) initWithSoundFile:(NSString*)soundFile;

@end





#pragma mark - AndroidOptions Interface

@interface AndroidOptions : NSObject

@property (strong, nonatomic, readonly) NSString *title;

- (instancetype) initWithTitle:(NSString*)title;

@end





#pragma mark - WPTile Interface

@interface WPTile : NSObject

@property (nonatomic) WPTileType wpTileType;
- (instancetype) initWithTileType:(WPTileType)wpTileType;

@end





#pragma mark - FlipTile Interface

@interface FlipTile : WPTile

@property (strong, nonatomic) NSString* tileID;
@property (strong, nonatomic) NSString* frontTile;
@property (strong, nonatomic) NSString* frontBackgroundImage;
@property (strong, nonatomic) NSString* frontCount;
@property (strong, nonatomic) NSString* smallBackgroundImage;
@property (strong, nonatomic) NSString* wideBackgroundImage;
@property (strong, nonatomic) NSString* backTitle;
@property (strong, nonatomic) NSString* backContent;
@property (strong, nonatomic) NSString* backBackgroundImage;
@property (strong, nonatomic) NSString* wideBackContent;
@property (strong, nonatomic) NSString* wideBackBackgroundImage;
- (instancetype) init;

@end






#pragma mark - IconicTile : WPTile

@interface IconicTile : WPTile
    
@property (strong, nonatomic) NSString* tileId;
@property (strong, nonatomic) NSString* frontTitle;
@property (strong, nonatomic) NSString* iconImage;
@property (strong, nonatomic) NSString* smallIconImage;
@property (strong, nonatomic) NSString* backgroundColor;
@property (strong, nonatomic) NSString* wideContent1;
@property (strong, nonatomic) NSString* wideContent2;
@property (strong, nonatomic) NSString* wideContent3;
- (instancetype) init;
@end





#pragma mark - CyclicTile Interface

@interface CyclicTile : WPTile
{
    NSMutableArray *_images;
}
@property (strong, nonatomic, readonly) NSMutableArray *images;
@property (strong, nonatomic) NSString* tileId;
@property (strong, nonatomic) NSString* frontTitle;
- (instancetype) initWithFrontTitle:(NSString*)frontTitle images:(NSArray*)images;
- (instancetype) init;

@end







#pragma mark - WPNotification Interface

@interface WPNotification : NSObject
{
    WPNotificationType _wpNotificationType;
}
@property (nonatomic, readonly) WPNotificationType wpNotificationType;
- (instancetype) initWithNotificationType:(WPNotificationType)wpNotificationType;

@end




#pragma mark - ToastNotification Interface

@interface ToastNotification : WPNotification

@property (strong, nonatomic) NSString* text1;
@property (strong, nonatomic) NSString* text2;
@property (strong, nonatomic) NSString* path;
- (instancetype) initWithText1:(NSString*)text1 text2:(NSString*)text2 path:(NSString*)path;

@end





#pragma mark - WPTileNotification Interface

@interface TileNotification : WPNotification
{
    WPTile* _wp7Tile;
    WPTile* _wp75Tile;
}
- (TileNotification*) createNewFlipTile:(FlipTile*)tile;
- (TileNotification*) createNewIconicTile:(IconicTile*)tile flipTileForWP75AndBelow:(FlipTile*)fliptile;
- (TileNotification*) createNewCyclicTile:(IconicTile*)tile flipTileForWP75AndBelow:(FlipTile*)fliptile;
- (instancetype) init;
@property (nonatomic, strong) WPTile* wp8Tile;
@property (nonatomic, strong) WPTile* wp7Tile;
@property (nonatomic, strong) WPTile* wp75Tile;

@end




#pragma mark - RawNotification Interface

@interface RawNotification : WPNotification

@property (strong, nonatomic) NSString* rawData;
- (instancetype) init;
@end




#pragma mark - WindowsPhoneOptions Interface

@interface WindowsPhoneOptions : NSObject

@property (strong, nonatomic) WPNotification* notification;
- (instancetype) initWithToast:(ToastNotification*)notification;
- (instancetype) initWithTile:(TileNotification*)notification;
- (instancetype) initWithRaw:(RawNotification*)notification;

@end





#pragma mark - APPlatformOptions Interface

@interface APPlatformOptions : NSObject

@property (strong, nonatomic) IOSOptions *iosOptions;
@property (strong, nonatomic) AndroidOptions *androidOptions;
@property (strong, nonatomic) WindowsPhoneOptions *windowsPhoneOptions;

@end



#pragma mark - APPushNotification Interface

@interface APPushNotification : NSObject
{
    NSString *_message;
}
@property (nonatomic) BOOL isBroadcast;
@property (nonatomic, strong) NSArray *deviceIds;
@property (nonatomic, strong) NSString *query;
@property (nonatomic, strong) NSMutableArray *channels;
@property (nonatomic, readonly) NSString *message;
@property (nonatomic, strong) NSMutableDictionary *data;
@property (nonatomic, strong) NSNumber *expireAfter;
@property (nonatomic, strong) APPlatformOptions *platformOptions;

- (instancetype) initWithMessage:(NSString*)message;

- (void) sendPush;

- (void) sendPushWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

@end


