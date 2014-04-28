#import "Appacitive.h"
#import "APEmail.h"
#import "APError.h"

SPEC_BEGIN(APEmailTests)

describe(@"APEmailTests", ^{
    
    beforeAll(^() {
        [Appacitive registerAPIKey:API_KEY useLiveEnvironment:YES];
        [Appacitive useLiveEnvironment:NO];
        [[expectFutureValue([Appacitive getApiKey]) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
    });
    
    afterAll(^(){
    });

#pragma mark - SEND_MAIL_TESTS
    
    it(@"sending a simple email", ^{
        __block BOOL isMailSent = NO;
        
        APEmail *myMail = [[APEmail alloc] init];
        myMail.toRecipients = [NSArray arrayWithObjects:@"ppatel@tapstudio.com", nil];
        myMail.fromSender = @"ppatel@tapstudio.com";
        myMail.subjectText = @"TestMail";
        myMail.bodyText = @"Test mail from Appacitive API";
        
        [myMail sendEmailWithSuccessHandler:^{
            isMailSent = YES;
        } failureHandler:^(APError *error) {
            isMailSent = NO;
        }];
        [[expectFutureValue(theValue(isMailSent)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
    });
    
    it(@"sending a templated email", ^{
        __block BOOL isMailSent = NO;
        
        APEmail *myTemplatedEmail = [[APEmail alloc] init];
        myTemplatedEmail.toRecipients = [NSArray arrayWithObjects:@"ppatel@tapstudio.com", nil];
        myTemplatedEmail.fromSender = @"ppatel@tapstudio.com";
        myTemplatedEmail.subjectText = @"TestMail";
        myTemplatedEmail.bodyText = @"Test mail from Appacitive API";
        
        myTemplatedEmail.templateBody = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         @"John Doe", @"userfullname",
                                         @"jdoe", @"username",
                                         @"johnDoe", @"accName",
                                         @"SampleApp",@"applicationName", nil];
        
        [myTemplatedEmail sendTemplatedEmailUsingTemplate:@"newmailtemplate" successHandler:^() {
            isMailSent = YES;
        }failureHandler:^(APError *error) {
            isMailSent = NO;
        }];
        
        [[expectFutureValue(theValue(isMailSent)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
    });
    

    it(@"sending a simple email with smtp config", ^{
        __block BOOL isMailSent = NO;

        APEmail *myMail = [[APEmail alloc] init];
        myMail.toRecipients = [NSArray arrayWithObjects:@"user2@gmail", nil];
        myMail.fromSender = @"user@gmail.com.com";
        myMail.subjectText = @"TestMail";
        myMail.bodyText = @"Test mail from Appacitive API";
        
        [myMail sendEmailUsingSMTPConfig:[APEmail makeSMTPConfigurationDictionaryWithUsername:@"user@gmail.com" password:@"S3cr3t" host:@"smtp.gmail.com" port:@465 enableSSL:YES]
                          successHandler:^{
            isMailSent = YES;
        } failureHandler:^(APError *error) {
            isMailSent = NO;
        }];
        [[expectFutureValue(theValue(isMailSent)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
    });
    
    
    it(@"sending a templated email with smtp config", ^{
        __block BOOL isMailSent = NO;

        APEmail *myTemplatedEmail = [[APEmail alloc] init];
        myTemplatedEmail.toRecipients = [NSArray arrayWithObjects:@"user2@gmail.com", nil];
        myTemplatedEmail.fromSender = @"user@gmail.com";
        myTemplatedEmail.subjectText = @"TestMail";
        myTemplatedEmail.bodyText = @"Test mail from Appacitive API";

        myTemplatedEmail.templateBody = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         @"John Doe", @"userfullname",
                                         @"jdoe", @"username",
                                         @"johnDoe", @"accName",
                                         @"Sample App",@"applicationName", nil];

        [myTemplatedEmail sendTemplatedEmailUsingTemplate:@"newmailtemplate"
                                          usingSMTPConfig:[APEmail makeSMTPConfigurationDictionaryWithUsername:@"user@gmail.com" password:@"S3cr3t" host:@"smtp.gmail.com" port:@465 enableSSL:YES] successHandler:^() {
            isMailSent = YES;
        }failureHandler:^(APError *error) {
            isMailSent = NO;
        }];

        [[expectFutureValue(theValue(isMailSent)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
    });
    
});
SPEC_END

