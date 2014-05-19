//
//  APError.m
//  Appacitive-iOS-SDK
//
//  Created by Kauserali Hafizji on 29/08/12.
//  Copyright (c) 2012 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import "APError.h"

@implementation APError

- (NSString*) description {
    return [NSString stringWithFormat:@"Error: %@, Code: %@, ReferenceId: %@, Version: %@", self.localizedDescription, self.statusCode, self.referenceId, self.version];
}
@end
