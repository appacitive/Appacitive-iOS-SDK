//
//  APConstants.h
//  Appacitive-iOS-SDK
//
//  Created by Kauserali on 08/01/13.
//  Copyright (c) 2013 Appacitive Software Pvt. Ltd. All rights reserved.
//

#ifndef Appacitive_iOS_SDK_APConstants_h
#define Appacitive_iOS_SDK_APConstants_h

#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif

#define SessionHeaderKey @"Appacitive-Session"
#define EnvironmentHeaderKey @"Appacitive-Environment"
#define UserAuthHeaderKey @"Appacitive-User-Auth"
#endif
