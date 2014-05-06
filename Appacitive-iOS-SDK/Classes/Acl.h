//
//  Acl.h
//  Appacitive-iOS-SDK
//
//  Created by Pratik on 28-04-14.
//  Copyright (c) 2014 Appacitive Software Pvt. Ltd. All rights reserved.
//

typedef enum {
    kPermissionCreate,
    kPermissionRead,
    kPermissionUpdate,
    kPermissionDelete,
    kPermissionManageAccess
} permission;

@interface Acl : NSObject {
    NSMutableDictionary *_userAccessDict;
    NSMutableDictionary *_groupAccessDict;
}

- (void) allowUsers:(NSArray*)users permissions:(NSArray*)permissions;

- (void) allowUserGroups:(NSArray*)userGroups permissions:(NSArray*)permissions;

- (void) denyUsers:(NSArray*)user permissions:(NSArray*)permissions;

- (void) denyUserGroups:(NSArray*)userGroups permissions:(NSArray*)permissions;

- (void) resetUsers:(NSArray*)user permissions:(NSArray*)permissions;

- (void) resetUserGroups:(NSArray*)userGroups permissions:(NSArray*)permissions;

- (NSArray*) getCombinedAccessList;

@end
