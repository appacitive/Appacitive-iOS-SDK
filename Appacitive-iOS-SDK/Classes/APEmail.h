//
//  APEmail.h
//  Appacitive-iOS-SDK
//
//  Created by Pratik on 16-12-13.
//  Copyright (c) 2013 Appacitive Software Pvt. Ltd. All rights reserved.
//

#import "APResponseBlocks.h"

@interface APEmail : NSObject

@property (nonatomic, strong) NSArray* toRecipients;
@property (nonatomic, strong) NSArray* ccRecipients;
@property (nonatomic, strong) NSArray* bccRecipients;
@property (nonatomic, strong) NSString* fromSender;
@property (nonatomic, strong) NSString* replyToEmail;
@property (nonatomic, strong) NSString* subjectText;
@property (nonatomic, strong) NSString* bodyText;
@property (nonatomic) BOOL isHTMLBody;
@property (nonatomic, strong) NSMutableDictionary* templateBody;

/**
 Method to initiate an email object with minimum number of requierd properties.
 
 @param recipients An array of email addresses of the recipients of the email.
 @param subject Subject for the email.
 @param body Content of the email.
 */
- (instancetype) initWithRecipients:(NSArray*)recipients subject:(NSString*)subject body:(NSString*)body;

/**
 @see sendEmailWithSuccessHandler:failureHandler:
 */
- (void) sendEmail;

/**
 Method to send a simple email
 
 @param successBlock Block invoked when the email sending operation is successful.
 @param failureBlock Block invoked when the email sending operation is unsuccessful.
 @note To send an email the following properties of the email object MUST be set: toRecipients, subjectText, bodyText
 */
- (void) sendEmailWithSuccessHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

/**
 @see sendEmailWithSMTPConfig:successHandler:failureHandler:
 */
- (void) sendEmailUsingSMTPConfig:(NSDictionary*)smtpConfig;

/**
 Method to send a simple email
 
 @param smtpConfig (Optional) a dictionary with smtp configuration parameters.
 @param successBlock Block invoked when the email sending operation is successful.
 @param failureBlock Block invoked when the email sending operation is unsuccessful.
 @note To send an email the following properties of the email object MUST be set: @b toRecipients, @b subjectText, @b bodyText.
 
 To make a SMTP configuration dictionary, use the 'getSMTPConfigurationDictionaryWithUsername:password:host:port:enableSSL:' method.
 */
- (void) sendEmailUsingSMTPConfig:(NSDictionary*)smtpConfig successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

/**
 @see sendTemplatedEmailUsingTemplate:usingSMTPConfig:successHandler:failureHandler
 */
- (void) sendTemplatedEmailUsingTemplate:(NSString *)templateName usingSMTPConfig:(NSDictionary*)smtpConfig;

/**
 @see sendTemplatedEmailUsingTemplate:usingSMTPConfig:successHandler:failureHandler
 */
- (void) sendTemplatedEmailUsingTemplate:(NSString *)templateName;

/**
 @see sendTemplatedEmailUsingTemplate:usingSMTPConfig:successHandler:failureHandler
 */
- (void) sendTemplatedEmailUsingTemplate:(NSString *)templateName successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;


/**
 Mehtod to send a templated email
 
 @param templateName name of the template configured on the Appacitive portal.
 
 */
- (void) sendTemplatedEmailUsingTemplate:(NSString *)templateName usingSMTPConfig:(NSDictionary*)smtpConfig successHandler:(APSuccessBlock)successBlock failureHandler:(APFailureBlock)failureBlock;

/**
 Helper method to create a dictionary object properties and save it to configDictObject
 */
+ (NSDictionary*) getSMTPConfigurationDictionaryWithUsername:(NSString*)username password:(NSString*)password host:(NSString*)host port:(NSNumber*)port enableSSL:(BOOL)enableSSL;


@end
