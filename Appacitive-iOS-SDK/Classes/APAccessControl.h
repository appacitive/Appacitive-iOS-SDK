//
//  Acl.h
//  Appacitive-iOS-SDK
//
//  Created by Pratik on 28-04-14.
//  Copyright (c) 2014 Appacitive Software Pvt. Ltd. All rights reserved.
//

/**
 Acl stands for access control list. This class provides methods to manage access permissions to users and user groups on your objects.
 */

@interface APAccessControl : NSObject {
    NSMutableDictionary *_userAccessDict;
    NSMutableDictionary *_groupAccessDict;
}

/**
 Method to set allow permission(s) on user objects.
 
 @param users       An array of users' username or objectId.
 @param permissions Array of strings with possible valid values - read, create, update, delete and manageaccess.
 */
- (void) allowUsers:(NSArray*)users permissions:(NSArray*)permissions;

/**
 Method to set allow permission(s) on user group objects.
 
 @param userGroups  An array of usergroup ids or usergroup names.
 @param permissions Array of strings with possible valid values - read, create, update, delete and manageaccess.
 */
- (void) allowUserGroups:(NSArray*)userGroups permissions:(NSArray*)permissions;

/**
 Method to set deny permissions on user objects.
 
 @param users       An array of users' username or objectId.
 @param permissions Array of strings with possible valid values - read, create, update, delete and manageaccess.
 */
- (void) denyUsers:(NSArray*)users permissions:(NSArray*)permissions;

/**
 Method to set deny permission(s) on user group objects.
 
 @param userGroups  An array of usergroup ids or usergroup names.
 @param permissions Array of strings with possible valid values - read, create, update, delete and manageaccess.
 */
- (void) denyUserGroups:(NSArray*)userGroups permissions:(NSArray*)permissions;


/**
 Method to reset permissions on user objects.
 
 @param users       An array of users' username or objectId.
 @param permissions Array of strings with possible valid values - read, create, update, delete and manageaccess.
 */
- (void) resetUsers:(NSArray*)users permissions:(NSArray*)permissions;

/**
 Method to reset permission(s) on user group objects.
 
 @param userGroups  An array of usergroup ids or usergroup names.
 @param permissions Array of strings with possible valid values - read, create, update, delete and manageaccess.
 */
- (void) resetUserGroups:(NSArray*)userGroups permissions:(NSArray*)permissions;


/**
 Method to get a NSArray formatted access list.
 
 @return An array of formatted access list.
 */
- (NSArray*) getFormattedAccessList;

@end
