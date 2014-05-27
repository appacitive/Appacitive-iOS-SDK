//
//  Acl.m
//  Appacitive-iOS-SDK
//
//  Created by Pratik on 28-04-14.
//  Copyright (c) 2014 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import "APAccessControl.h"

@implementation APAccessControl

- (void) allowUsers:(NSArray*)users permissions:(NSArray*)permissions {
    for(NSString *user in users) {
        NSMutableDictionary *aclDict = [[NSMutableDictionary alloc] init];
        if([[_userAccessDict allKeys] containsObject:user]) {
            aclDict = [_userAccessDict objectForKey:user];
            for(NSString *permission in permissions) {
                if([[aclDict objectForKey:@"deny"] containsObject:permission]) {
                    [[aclDict objectForKey:@"deny"] removeObject:permission];
                }
                if([[aclDict objectForKey:@"reset"] containsObject:permission]) {
                    [[aclDict objectForKey:@"reset"] removeObject:permission];
                }
                if(![[aclDict objectForKey:@"allow"] containsObject:permission]) {
                    [[aclDict objectForKey:@"allow"] addObject:permission];
                }
            }
        } else {
            [aclDict setObject:permissions forKey:@"allow"];
            if(_userAccessDict == nil) {
                _userAccessDict = [[NSMutableDictionary alloc] init];
            }
            [_userAccessDict setObject:aclDict forKey:user];
        }
    }
}

- (void) allowUserGroups:(NSArray*)userGroups permissions:(NSArray*)permissions {
    for(NSString *user in userGroups) {
        NSMutableDictionary *aclDict = [[NSMutableDictionary alloc] init];
        if([[_groupAccessDict allKeys] containsObject:user]) {
            aclDict = [_groupAccessDict objectForKey:user];
            for(NSString *permission in permissions) {
                if([[aclDict objectForKey:@"deny"] containsObject:permission]) {
                    [[aclDict objectForKey:@"deny"] removeObject:permission];
                }
                if([[aclDict objectForKey:@"reset"] containsObject:permission]) {
                    [[aclDict objectForKey:@"reset"] removeObject:permission];
                }
                if(![[aclDict objectForKey:@"allow"] containsObject:permission]) {
                    [[aclDict objectForKey:@"allow"] addObject:permission];
                }
            }
        } else {
            [aclDict setObject:permissions forKey:@"allow"];
            if(_groupAccessDict == nil) {
                _groupAccessDict = [[NSMutableDictionary alloc] init];
            }
            [_groupAccessDict setObject:aclDict forKey:user];
        }
    }
}

- (void) denyUsers:(NSArray*)users permissions:(NSArray*)permissions {
    for(NSString *user in users) {
        NSMutableDictionary *aclDict = [[NSMutableDictionary alloc] init];
        if([[_userAccessDict allKeys] containsObject:user]) {
            aclDict = [_userAccessDict objectForKey:user];
            for(NSString *permission in permissions) {
                if([[aclDict objectForKey:@"allow"] containsObject:permission]) {
                    [[aclDict objectForKey:@"allow"] removeObject:permission];
                }
                if([[aclDict objectForKey:@"reset"] containsObject:permission]) {
                    [[aclDict objectForKey:@"reset"] removeObject:permission];
                }
                if(![[aclDict objectForKey:@"deny"] containsObject:permission]) {
                    [[aclDict objectForKey:@"deny"] addObject:permission];
                }
            }
        } else {
            [aclDict setObject:permissions forKey:@"deny"];
            if(_userAccessDict == nil) {
                _userAccessDict = [[NSMutableDictionary alloc] init];
            }
            [_userAccessDict setObject:aclDict forKey:user];
        }
    }
}

- (void) denyUserGroups:(NSArray*)userGroups permissions:(NSArray*)permissions {
    for(NSString *user in userGroups) {
        NSMutableDictionary *aclDict = [[NSMutableDictionary alloc] init];
        if([[_groupAccessDict allKeys] containsObject:user]) {
            aclDict = [_groupAccessDict objectForKey:user];
            for(NSString *permission in permissions) {
                if([[aclDict objectForKey:@"allow"] containsObject:permission]) {
                    [[aclDict objectForKey:@"allow"] removeObject:permission];
                }
                if([[aclDict objectForKey:@"reset"] containsObject:permission]) {
                    [[aclDict objectForKey:@"reset"] removeObject:permission];
                }
                if(![[aclDict objectForKey:@"deny"] containsObject:permission]) {
                    [[aclDict objectForKey:@"deny"] addObject:permission];
                }
            }
        } else {
            [aclDict setObject:permissions forKey:@"deny"];
            if(_groupAccessDict == nil) {
                _groupAccessDict = [[NSMutableDictionary alloc] init];
            }
            [_groupAccessDict setObject:aclDict forKey:user];
        }
    }
}

- (void) resetUsers:(NSArray*)users permissions:(NSArray*)permissions {
    for(NSString *user in users) {
        NSMutableDictionary *aclDict = [[NSMutableDictionary alloc] init];
        if([[_userAccessDict allKeys] containsObject:user]) {
            aclDict = [_userAccessDict objectForKey:user];
            for(NSString *permission in permissions) {
                if([[aclDict objectForKey:@"deny"] containsObject:permission]) {
                    [[aclDict objectForKey:@"deny"] removeObject:permission];
                }
                if([[aclDict objectForKey:@"allow"] containsObject:permission]) {
                    [[aclDict objectForKey:@"allow"] removeObject:permission];
                }
                if(![[aclDict objectForKey:@"reset"] containsObject:permission]) {
                    [[aclDict objectForKey:@"reset"] addObject:permission];
                }
            }
        } else {
            [aclDict setObject:permissions forKey:@"reset"];
            if(_userAccessDict == nil) {
                _userAccessDict = [[NSMutableDictionary alloc] init];
            }
            [_userAccessDict setObject:aclDict forKey:user];
        }
    }
}

- (void) resetUserGroups:(NSArray*)userGroups permissions:(NSArray*)permissions {
    for(NSString *user in userGroups) {
        NSMutableDictionary *aclDict = [[NSMutableDictionary alloc] init];
        if([[_groupAccessDict allKeys] containsObject:user]) {
            aclDict = [_groupAccessDict objectForKey:user];
            for(NSString *permission in permissions) {
                if([[aclDict objectForKey:@"deny"] containsObject:permission]) {
                    [[aclDict objectForKey:@"deny"] removeObject:permission];
                }
                if([[aclDict objectForKey:@"allow"] containsObject:permission]) {
                    [[aclDict objectForKey:@"allow"] removeObject:permission];
                }
                if(![[aclDict objectForKey:@"reset"] containsObject:permission]) {
                    [[aclDict objectForKey:@"reset"] addObject:permission];
                }
            }
        } else {
            [aclDict setObject:permissions forKey:@"reset"];
            if(_groupAccessDict == nil) {
                _groupAccessDict = [[NSMutableDictionary alloc] init];
            }
            [_groupAccessDict setObject:aclDict forKey:user];
        }
    }
}


- (NSArray*)getFormattedAccessList {
    NSMutableArray *aclList = [[NSMutableArray alloc] init];
    for(id key in _userAccessDict) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setValue:key forKey:@"sid"];
        [dict setValue:@"user" forKey:@"type"];
        [dict setValue:[[_userAccessDict valueForKey:key] valueForKey:@"allow"] forKey:@"allow"];
        [dict setValue:[[_userAccessDict valueForKey:key] valueForKey:@"deny"] forKey:@"deny"];
        [dict setValue:[[_userAccessDict valueForKey:key] valueForKey:@"reset"] forKey:@"reset"];
        [aclList addObject:dict];
    }
    for(id key in _groupAccessDict) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setValue:key forKey:@"sid"];
        [dict setValue:@"group" forKey:@"type"];
        [dict setValue:[[_userAccessDict valueForKey:key] valueForKey:@"allow"] forKey:@"allow"];
        [dict setValue:[[_userAccessDict valueForKey:key] valueForKey:@"deny"] forKey:@"deny"];
        [dict setValue:[[_userAccessDict valueForKey:key] valueForKey:@"reset"] forKey:@"reset"];
        [aclList addObject:dict];
    }
    return aclList;
}

@end
