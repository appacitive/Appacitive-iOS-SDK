//
//  APLogger.m
//  Appacitive-iOS-SDK
//
//  Created by Pratik on 13-05-14.
//  Copyright (c) 2014 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import "APLogger.h"
#import "APHelperMethods.h"

@interface APLogger()

@end

@implementation APLogger

static APLogger *sharedLogger;

- (instancetype) init {
    self = [super init];
    self.isLoggingEnabled = NO;
    self.isVerbose = NO;
    return self;
}

- (instancetype) initWithLoggingEnabled:(BOOL)logEnabled verboseMode:(BOOL)verboseMode {
    self = [super init];
    self.isLoggingEnabled = logEnabled;
    self.isVerbose = verboseMode;
    return self;
}

+ (instancetype) sharedLogger {
    if(!sharedLogger) {
        sharedLogger = [[APLogger alloc] init];
    }
    return sharedLogger;
}

+ (instancetype) sharedLoggerWithLoggingEnabled:(BOOL)logEnabled verboseMode:(BOOL)verboseMode {
    if(!sharedLogger) {
        sharedLogger = [[APLogger alloc] initWithLoggingEnabled:logEnabled verboseMode:verboseMode];
        return sharedLogger;
    }
    sharedLogger.isLoggingEnabled = logEnabled;
    sharedLogger.isVerbose = verboseMode;
    return sharedLogger;
}

+ (instancetype) logger {
    return [[APLogger alloc] init];
}

+ (instancetype) loggerWithLoggingEnabled:(BOOL)logEnabled verboseMode:(BOOL)verboseMode {
    return [[APLogger alloc] initWithLoggingEnabled:logEnabled verboseMode:verboseMode];
}

- (void) enableVerboseMode:(BOOL)answer {
    self.isVerbose = answer;
}

- (void) enableLogging:(BOOL)answer {
    self.isLoggingEnabled = answer;
}

- (void) log:(NSString *)message withType:(APMessageType)messageType {
    if(self.isLoggingEnabled) {
        if(messageType == APMessageTypeDebug) {
            if(self.isVerbose == YES)
                NSLog(@"%@",message);
        }
        else {
            NSLog(@"%@",message);
        }
    }
}

@end

