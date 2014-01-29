//
//  APPush.h
//  Appacitive-iOS-SDK
//
//  Created by Pratik on 23-01-14.
//  Copyright (c) 2014 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import "APResponseBlocks.h"

typedef enum {
    kWPNotificationTypeToast,
    kWPNotificationTypeTile,
    kWPNotificationTypeRaw
} WPNotificationType;

typedef enum {
    kWPTileTypeFlip,
    kWPTileTypeCyclic,
    kWPTileTypeIconic
} WPTileType;

#pragma mark - IOSOptions Interface

@interface IOSOptions : NSObject

@property (strong, nonatomic, readonly) NSString *soundFile;


/**
 Method to initialize an ios platform options object with the sound file.
 
 @parma soundFile Name of the bundled sound file that will be used to alert the user on receiving a push notification.
 */
- (instancetype) initWithSoundFile:(NSString*)soundFile;

@end





#pragma mark - AndroidOptions Interface

@interface AndroidOptions : NSObject

@property (strong, nonatomic, readonly) NSString *title;


/**
 Method to initialize an android platform options object with the title text.
 
 @parma title Title text for the push notification.
 */
- (instancetype) initWithTitle:(NSString*)title;

@end





#pragma mark - WPTile Interface

@interface WPTile : NSObject

@property (nonatomic) WPTileType wpTileType;

/**
 Method to initialize a windows phone tile notification object with the tile type.
 
 @parma wpTileType Type of the tile to be used for notification viz. Flip/Cyclic/Iconic.
 */
- (instancetype) initWithTileNotificationType:(WPTileType)wpTileType;

@end





#pragma mark - FlipTile Interface

@interface FlipTile : WPTile

@property (strong, nonatomic) NSString* tileID;
@property (strong, nonatomic) NSString* frontTitle;
@property (strong, nonatomic) NSString* frontBackgroundImage;
@property (strong, nonatomic) NSString* frontCount;
@property (strong, nonatomic) NSString* smallBackgroundImage;
@property (strong, nonatomic) NSString* wideBackgroundImage;
@property (strong, nonatomic) NSString* backTitle;
@property (strong, nonatomic) NSString* backContent;
@property (strong, nonatomic) NSString* backBackgroundImage;
@property (strong, nonatomic) NSString* wideBackContent;
@property (strong, nonatomic) NSString* wideBackBackgroundImage;

/**
 Method to initialize a windows phone Flip tile.
 */
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

/**
 Method to initialize a windows phone Iconic tile.
 */
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

/**
 Method to initialize a windows phone Cyclic tile with font title and images.
 
 @param frontTitle title of the front side of tile.
 @param images An array of images to be used for Cyclic tile notification.
 */
- (instancetype) initWithFrontTitle:(NSString*)frontTitle images:(NSArray*)images;

/**
 Method to initialize a windows phone Cyclic tile.
 */
- (instancetype) init;

@end







#pragma mark - WPNotification Interface

@interface WPNotification : NSObject
{
    WPNotificationType _wpNotificationType;
}
@property (nonatomic, readonly) WPNotificationType wpNotificationType;

/**
 Method to initialize a windows phone notification object.
 
 @param wpNotificationType Type of notification viz. Raw/Toast/Tile.
 */
- (instancetype) initWithNotificationType:(WPNotificationType)wpNotificationType;

@end




#pragma mark - ToastNotification Interface

@interface ToastNotification : WPNotification

@property (strong, nonatomic) NSString* text1;
@property (strong, nonatomic) NSString* text2;
@property (strong, nonatomic) NSString* path;

/**
 Method to initialize a windows phone toast notification.
 */
- (instancetype) init;

/**
 Method to initialize a windows phone toast notification with text1, text2 and the path.
 
 @param text1 Text1 for the toast notification.
 @param text2 Text2 for the toast notification.
 @prama path The anvigate path for the toast notification.
 */
- (instancetype) initWithText1:(NSString*)text1 text2:(NSString*)text2 path:(NSString*)path;

@end





#pragma mark - WPTileNotification Interface

@interface TileNotification : WPNotification
{
    WPTile* _wp7Tile;
    WPTile* _wp75Tile;
}
@property (nonatomic, strong) WPTile* wp8Tile;
@property (nonatomic, strong) WPTile* wp7Tile;
@property (nonatomic, strong) WPTile* wp75Tile;

/**
 Method to creaet a new Flip tile notification.
 
 @param tile The flip tile to be used for creating the tile notification object.
 @return Returns an object of 'TileNotification' type.
 */
- (TileNotification*) createNewFlipTile:(FlipTile*)tile;

/**
 Method to create a new iconic tile notification.

 @param tile The iconic tile to be used for creating the tile notification.
 @param flipTile The flip tile to be used for devices that are on platform WindowsPhone-7.5 and below.
 */
- (TileNotification*) createNewIconicTile:(IconicTile*)tile flipTileForWP75AndBelow:(FlipTile*)fliptile;

/**
 Method to create a new cyclic tile notification.
 
 @param tile The cyclic tile to be used for creating the tile notification.
 @param flipTile The flip tile to be used for devices that are on platform WindowsPhone-7.5 and below.
 */
- (TileNotification*) createNewCyclicTile:(IconicTile*)tile flipTileForWP75AndBelow:(FlipTile*)fliptile;


/**
 Method to initialize a windows phone tile notification object.
 */
- (instancetype) init;


@end




#pragma mark - RawNotification Interface

@interface RawNotification : WPNotification

@property (strong, nonatomic) NSString* rawData;

/**
 Method to initialize a windows phone raw notification object.
 */
- (instancetype) init;
@end




#pragma mark - WindowsPhoneOptions Interface

@interface WindowsPhoneOptions : NSObject

@property (strong, nonatomic) WPNotification* notification;

/**
 Method to initialize a windows phone options object with toast notification type.
 
 @param notification A ToastNotification object reference.
 */
- (instancetype) initWithToastNotification:(ToastNotification*)notification;

/**
 Method to initialize a windows phone options object with tile notification type.
 
 @param notification A TileNotification object reference.
 */
- (instancetype) initWithTileNotification:(TileNotification*)notification;

/**
 Method to initialize a windows phone options object with raw notification type.
 
 @param notification A RawNotification object reference.
 */
- (instancetype) initWithRawNotification:(RawNotification*)notification;

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
@property (nonatomic, strong) NSArray *channels;
@property (nonatomic, readonly) NSString *message;
@property (nonatomic, strong) NSMutableDictionary *data;
@property (nonatomic, strong) NSNumber *expireAfter;
@property (nonatomic, strong) NSString *badge;
@property (nonatomic, strong) APPlatformOptions *platformOptions;

/**
 Method to initialize an APPushNotification object with the message text.
 
 @param message Message text to be used for the notification.
 */
- (instancetype) initWithMessage:(NSString*)message;

/**
 @see sendPushWithSuccessHandler:failureHandler
 */
- (void) sendPush;

/**
 Method to send a push notification request to the Appacitive API.
 
 @param successBlock Block invoked when the sendPush operation is successful.
 @param failureBlock Block invoked when the sendPush operation fails.
 */
- (void) sendPushWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

@end

