#import "Appacitive.h"
#import "APEmail.h"
#import "APError.h"

SPEC_BEGIN(APEmailTests)

describe(@"APEmailTests", ^{
    
    beforeAll(^() {
        [Appacitive initWithAPIKey:API_KEY];
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
                                         @"Pratik Patel", @"userfullname",
                                         @"ppatel", @"username",
                                         @"ipratikpatel", @"accName",
                                         @"DealHunter",@"applicationName", nil];
        
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
        myMail.toRecipients = [NSArray arrayWithObjects:@"pratik644@gmail", nil];
        myMail.fromSender = @"theodorebagwell123@gmail.com";
        myMail.subjectText = @"TestMail";
        myMail.bodyText = @"Test mail from Appacitive API";
        
        [myMail sendEmailUsingSMTPConfig:[APEmail makeSMTPConfigurationDictionaryWithUsername:@"theodore.bagwell123@gmail.com" password:@"l10nk1n6" host:@"smtp.gmail.com" port:@465 enableSSL:YES]
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
        myTemplatedEmail.toRecipients = [NSArray arrayWithObjects:@"pratik644@gmail.com", nil];
        myTemplatedEmail.fromSender = @"theodorebagwell123@gmail.com";
        myTemplatedEmail.subjectText = @"TestMail";
        myTemplatedEmail.bodyText = @"Test mail from Appacitive API";

        myTemplatedEmail.templateBody = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         @"Pratik Patel", @"userfullname",
                                         @"ppatel", @"username",
                                         @"ipratikpatel", @"accName",
                                         @"DealHunter",@"applicationName", nil];

        [myTemplatedEmail sendTemplatedEmailUsingTemplate:@"newmailtemplate"
                                          usingSMTPConfig:[APEmail makeSMTPConfigurationDictionaryWithUsername:@"theodore.bagwell123@gmail.com" password:@"l10nk1n6" host:@"smtp.gmail.com" port:@465 enableSSL:YES] successHandler:^() {
            isMailSent = YES;
        }failureHandler:^(APError *error) {
            isMailSent = NO;
        }];

        [[expectFutureValue(theValue(isMailSent)) shouldEventuallyBeforeTimingOutAfter(5.0)] equal:theValue(YES)];
    });
    
});
SPEC_END

