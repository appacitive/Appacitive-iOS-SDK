//
//  APUser.h
//  Appacitive-iOS-SDK
//
//  Created by Kauserali on 07/01/13.
//  Copyright (c) 2013 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import "APResponseBlocks.h"
#import "APObject.h"

@interface APUserDetails : NSObject
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *birthDate;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *secretQuestion;
@property (nonatomic, strong) NSString *isEmailVerified;
@property (nonatomic, strong) NSString *isEnabled;
@property (nonatomic, strong) NSString *isOnline;

- (NSMutableDictionary*) createParameters;
- (void) setPropertyValuesFromDictionary:(NSDictionary*) dictionary;

@end

@interface APUser : APObject <APObjectPropertyMapping>

@property (nonatomic, strong, readonly) NSString *userToken;
@property (nonatomic, readonly) BOOL loggedInWithFacebook;
@property (nonatomic, readonly) BOOL loggedInWithTwitter;
@property (nonatomic, strong) APUserDetails *userDetails;
/**
 Returns the current authenticated user.
 
 @return APUser or nil
 */
+ (APUser*) currentUser;

/**
 Helper method to set the current user.
 
 @param user The new current user
 */
+ (void) setCurrentUser:(APUser*) user;

/** @name Authenticating a user */

/**
 @see authenticateUserWithUserName:password:successHandler:failureHandler:
 */
+ (void) authenticateUserWithUserName:(NSString*) userName password:(NSString*) password successHandler:(APUserSuccessBlock) successBlock;

/**
 Method to authenticate a user
 
 If successful the currentUser is set to the authenticated user.
 
 @param userName The username of the user to authenticate.
 @param password The password of the user to authenticate.
 @param successBlock Block invoked when authentication is successful.
 @param failureBlock Block invoked when authentication is unsuccessful.
 */
+ (void) authenticateUserWithUserName:(NSString*) userName password:(NSString*) password successHandler:(APUserSuccessBlock) successBlock failureHandler:(APFailureBlock) failureBlock;

/**
 @see authenticateUserWithFacebook:successHandler:failureHandler:
 */
+ (void) authenticateUserWithFacebook:(NSString *) accessToken successHandler:(APUserSuccessBlock) successBlock;

/**
 Method to authenticate a user with facebook.
 
 If successful the currentUser is set to the authenticated user.
 
 @param accessToken The access token retrieved after a succesful facebook login.
 @param successBlock Block invoked when authentication with facebook is successful.
 @param failureBlock Block invoked when authentication with facebook is unsuccessful.
 */
+ (void) authenticateUserWithFacebook:(NSString *) accessToken successHandler:(APUserSuccessBlock) successBlock failureHandler:(APFailureBlock) failureBlock;

/**
 @see authenticateUserWithTwitter:oauthSecret:successHandler:failureHandler:
 */
+ (void) authenticateUserWithTwitter:(NSString*) oauthToken oauthSecret:(NSString*) oauthSecret successHandler:(APUserSuccessBlock) successBlock;

/**
 Method to authenticate a user with Twitter.
 
 If successful the currentUser is set to the authenticated user.
 
 @param oauthToken The oauth token retrieved after twitter login.
 @param oauthSecret The oauth secret.
 @param successBlock Block invoked when login with twitter is successful.
 @param failureBlock Block invoked when login with twitter is unsuccessful.
 */
+ (void) authenticateUserWithTwitter:(NSString*) oauthToken oauthSecret:(NSString*) oauthSecret successHandler:(APUserSuccessBlock) successBlock failureHandler:(APFailureBlock) failureBlock;

/**
 @see authenticateUserWithTwitter:oauthSecret:consumerKey:consumerSecret:successHandler:failureHandler:
 */
+ (void) authenticateUserWithTwitter:(NSString *)oauthToken oauthSecret:(NSString *)oauthSecret consumerKey:(NSString*)consumerKey consumerSecret :(NSString*) consumerSecret successHandler:(APUserSuccessBlock)successBlock;

/**
 Method to authenticate a user with Twitter.
 
 If successful the currentUser is set to the authenticated user.
 
 @param oauthToken The oauth token retrieved after twitter login.
 @param oauthSecret The oauth secret.
 @param consumerKey The consumer key of the application created on twitter.
 @param consumerSecret The consumer secret of the application created on twitter.
 @param successBlock Block invoked when authentication with twitter is successful.
 @param failureBlock Block invoked when authentication with twitter is unsuccessful.
 */
+ (void) authenticateUserWithTwitter:(NSString *)oauthToken oauthSecret:(NSString *)oauthSecret consumerKey:(NSString*)consumerKey consumerSecret :(NSString*) consumerSecret successHandler:(APUserSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

/** @name Create a new user */

/**
 @see createUserWithDetails:successHandler:failuderHandler:
 */
+ (void) createUserWithDetails:(APUserDetails *)userDetails successHandler:(APUserSuccessBlock) successBlock;

/**
 Method to create a new user
 
 If successful the an object of APUser is returned in the successBlock.
 
 @note This method does not set the current user as the new user.
 
 @param userDetails The details of the new user.
 @param successBlock Block invoked when the create request is successful.
 @param failureBlock Block invoked when the create request is unsuccessful.
 */
+ (void) createUserWithDetails:(APUserDetails *)userDetails successHandler:(APUserSuccessBlock) successBlock failuderHandler:(APFailureBlock) failureBlock;


/** @name Retrieve User */

/**
 @see getUserById:successHandler:failuderHandler:
 */
+ (void) getUserById:(NSString *)userId successHandler:(APUserSuccessBlock) successBlock;

/**
 Method to retrieve User by ID
 
 If successful, then an object of APUser is returned in the successBlock.
 
 @param userId The user Id of an existing user whose details need to be retrieved.
 */
+ (void) getUserById:(NSString *)userId successHandler:(APUserSuccessBlock)successBlock failuderHandler:(APFailureBlock) failureBlock;

/**
 @see getUserByUserName:successHandler:failuderHandler:
 */
+ (void) getUserByUserName:(NSString *)userName successHandler:(APUserSuccessBlock) successBlock;

/**
 Method to retrieve User by userName
 
 If successful, then an object of APUser is returned in the successBlock.
 
 @param userName The user name of an existing user  whose details need to be retrieved.
 */
+ (void) getUserByUserName:(NSString *)userName successHandler:(APUserSuccessBlock)successBlock failuderHandler:(APFailureBlock) failureBlock;

/**
 @see getCurrentUserWith:successHandler:failuderHandler:
 */
+ (void) getCurrentUserWithsuccessHandler:(APUserSuccessBlock) successBlock;

/**
 Method to retrieve of currently logged-in User
 
 If successful, then an object of APUser and an APUserDetails is returned in the successBlock.
 
 */
+ (void) getCurrentUserWithsuccessHandler:(APUserSuccessBlock)successBlock failuderHandler:(APFailureBlock) failureBlock;

/** @name Update User */

/**
 @see upadteUserWithUserId:successHandler:failuderHandler:
 */
- (void) updateUserWithUserId:(NSString*)userID;

/**
 Method to update a User
 
 If successful, then an object of APUser and an APUserDetails is returned in the successBlock.
 
 @param userid the id of the user whose details need to be updated.
 */
- (void) updateUserWithUserId:(NSString*)userID successHandler:(APUserSuccessBlock)successBlock failuderHandler:(APFailureBlock) failureBlock;

/** @name Delete User */

/**
 @see deleteUserWithUserId:successHandler:failuderHandler:
 */
- (void) deleteUser;

/**
 Method to delete a User
 
 */
- (void) deleteUserWithSuccessHandler:(APSuccessBlock)successBlock failuderHandler:(APFailureBlock) failureBlock;

/**
 @see deleteUserWithUserName:successHandler:failuderHandler:
 */
- (void) deleteUserWithUserName:(NSString*)userName;

/**
 Method to delete a User
 
 @param userid the id of the user whose details need to be deleted.
 */
- (void) deleteUserWithUserName:(NSString*)userName successHandler:(APSuccessBlock)successBlock failuderHandler:(APFailureBlock) failureBlock;

/**
 @see deleteCurrentlyLoggedInUserWithSuccessHandler:failureHandler:
 */
+ (void) deleteCurrentlyLoggedInUser;

/**
 Method to delete the currently logged-in User
 
 */
+ (void) deleteCurrentlyLoggedInUserWithSuccessHandler:(APSuccessBlock)successBlock failuderHandler:(APFailureBlock) failureBlock;

/**
 @see setLocationToLatitude:longitude:forUserWithUserId:successHandler:failuderHandler:
 */
+ (void) setUserLocationToLatitude:(NSString*)latitude longitude:(NSString*)longitude forUserWithUserId:(NSString*)userId;

/**
 Method to set user's location
 
 @param latitude Latitude of the user's current location coordinate
 @param longitude Longitude of the user's current location coordinate
 @param userid the id of the user whose location needs to be set.
 */
+ (void) setUserLocationToLatitude:(NSString*)latitude longitude:(NSString*)longitude forUserWithUserId:(NSString*)userId successHandler:(APSuccessBlock)successBlock failuderHandler:(APFailureBlock) failureBlock;

/**
 @see validateCurrentUserSessionsuccessHandler:failureHandler
 */
+ (void) validateCurrentUserSessionWithSuccessHandler:(APResultSuccessBlock)successBlock;

/**
 Method to validate user's session
 
 @param userToken token of the user whose session needs to be validated
 */
+ (void) validateCurrentUserSessionWithSuccessHandler:(APResultSuccessBlock)successBlock failuderHandler:(APFailureBlock) failureBlock;

/**
 @see logoutCurrentlyLoggedInUserWithSuccessHandler:successHandler:failureHandler:
 */
+ (void) logoutCurrentlyLoggedInUser;

/**
 Method to invalidate user's session
 
 */
+ (void) logoutCurrentlyLoggedInUserWithSuccessHandler:(APSuccessBlock)successBlock failuderHandler:(APFailureBlock) failureBlock;

/**
 @see changePasswordFromOldPassword:toNewPassword:successHandler:failureHandler:
 */
- (void) changePasswordFromOldPassword:(NSString*)oldPassword toNewPassPassword:(NSString*)newPassword;

/**
 Method to change Password for the currently logged-in user
 
 @param oldPassword The current/old password of the logged-in user
 */
- (void) changePasswordFromOldPassword:(NSString *)oldPassword toNewPassPassword:(NSString *)newPassword successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

/**
 @see sendResetPasswordEmailWithEmailSubject:succssHandler:failureHandler:
 */
+ (void) sendResetPasswordEmailWithEmailSubject:(NSString*)emailSubject;

/**
 Method to send a reset password email for the currently logged-in user
 
 @param emailSubject text for the subject field of the reset password email
 */
+ (void) sendResetPasswordEmailWithEmailSubject:(NSString *)emailSubject successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

@end
