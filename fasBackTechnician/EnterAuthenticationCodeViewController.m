
//
//  EnterAuthenticationCodeViewController.m
//  FasBackTechnician
//
//  Created by User on 11/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "EnterAuthenticationCodeViewController.h"
#import "UIColor+Customcolor.h"
#import "StoryboardsAndSegues.h"
#import "ConstantColors.h"
#import "InviteCodeViewController.h"
#import "SetPasswordViewController.h"
#import "AppDelegate.h"
#import "ConfirmDetailsViewController.h"
#import "UIFont+PoppinsFont.h"

@interface EnterAuthenticationCodeViewController ()
{
    AppDelegate * appDelegate;
}
@end

@implementation EnterAuthenticationCodeViewController

static NSInteger const FIRST_DIGIT_TEXTFIELD_TAG = 1001;
static NSInteger const SECOND_DIGIT_TEXTFIELD_TAG = 1002;
static NSInteger const THIRD_DIGIT_TEXTFIELD_TAG = 1003;
static NSInteger const FOURTH_DIGIT_TEXTFIELD_TAG = 1004;
static NSInteger const FIFTH_DIGIT_TEXTFIELD_TAG = 1005;
static NSInteger const SIXTH_DIGIT_TEXTFIELD_TAG = 1006;

static NSInteger const WEBSERVICE_FROM_FORGOT_PASSWORD_TAG = 1101;
static NSInteger const WEBSERVICE_FROM_INVITE_CODE_TAG = 1102;
static NSInteger const WEBSERVICE_FROM_RESEND_CODE_TAG = 1103;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;

    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    [self changesInUI];
    isKeyboardVisible = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self restoreToDefaults];
    
    NSLog(@"%@",[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2]);

    

//    self.navigationController.navigationBarHidden = NO;
  
}


#pragma mark - General

-(void) restoreToDefaults
{
    [_firstDigitTextField becomeFirstResponder];
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(stackViewTapped:)];
    
    tapGesture1.numberOfTapsRequired = 1;
    
    [tapGesture1 setDelegate:self];
    
    [_viewOverTextFields addGestureRecognizer:tapGesture1];
    
    _firstDigitTextField.text = @"";
    _secondDigitTextField.text = @"";
    _thirdDigitTextField.text = @"";
    _fourthDigitTextField.text = @"";
    _fifthDigitTextField.text = @"";
    _sixthDigitTextfield.text = @"";
    
    _nextButton.enabled = NO;
    _nextButton.backgroundColor = [ConstantColors disabledButtonBackgroundColor];
    [_nextButton setTitleColor:[ConstantColors disabledButtonTextColor] forState:UIControlStateNormal  ];
    
    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
}


-(void) changesInUI
{
    _firstDigitTextField.tag = FIRST_DIGIT_TEXTFIELD_TAG;
    _secondDigitTextField.tag = SECOND_DIGIT_TEXTFIELD_TAG;
    _thirdDigitTextField.tag = THIRD_DIGIT_TEXTFIELD_TAG;
    _fourthDigitTextField.tag = FOURTH_DIGIT_TEXTFIELD_TAG;
    _fifthDigitTextField.tag = FIFTH_DIGIT_TEXTFIELD_TAG;
    _sixthDigitTextfield.tag = SIXTH_DIGIT_TEXTFIELD_TAG;
    
    _nextButton.layer.cornerRadius = 4;
    _cancelButton.layer.cornerRadius = 4;
    _cancelButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _cancelButton.layer.borderWidth = 1.0;
    
    
    [_firstDigitTextField setBorderForColor:[UIColor ColorWithHexaString:@"D2D5D6"] width:1 radius:1];
    [_secondDigitTextField setBorderForColor:[UIColor ColorWithHexaString:@"D2D5D6"] width:1 radius:1];
    [_thirdDigitTextField setBorderForColor:[UIColor ColorWithHexaString:@"D2D5D6"] width:1 radius:1];
    [_fourthDigitTextField setBorderForColor:[UIColor ColorWithHexaString:@"D2D5D6"] width:1 radius:1];
    [_fifthDigitTextField setBorderForColor:[UIColor ColorWithHexaString:@"D2D5D6"] width:1 radius:1];
    [_sixthDigitTextfield setBorderForColor:[UIColor ColorWithHexaString:@"D2D5D6"] width:1 radius:1];
    
//    CALayer *bottomBorderForResendButton = [CALayer layer];
//    bottomBorderForResendButton.frame = CGRectMake(0.0f, _resendCodeButton.frame.size.height - 4, _resendCodeButton.frame.size.width, 1.0f);
//    bottomBorderForResendButton.backgroundColor = [UIColor ColorWithHexaString:@"3B4042"].CGColor;
//    [_resendCodeButton.layer addSublayer:bottomBorderForResendButton];
    
    NSMutableAttributedString* resendButtonString = [[NSMutableAttributedString alloc] initWithString:@"RESEND CODE"];
    [resendButtonString addAttribute:NSUnderlineStyleAttributeName
                                 value:@(NSUnderlineStyleSingle)
                                 range:(NSRange){0,[resendButtonString length]}];
    
    [_resendCodeButton setAttributedTitle:resendButtonString forState:UIControlStateNormal];

    
    if (height == 480) {
        _topConstraintOfImageView.constant = 20;
        _widthOfImageView.constant = 70;
        _heightOfImageView.constant = 50;
        _resendCodeButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightSemibold];
    }
    else if (height == 568)
    {
        _enterInvitationCodeLabel.font = [UIFont poppinsSemiBoldFontWithSize:16];
        _PleaseEnterInviteCodeLabel.font = [UIFont poppinsNormalFontWithSize:10];
        _firstDigitTextField.font = [UIFont poppinsNormalFontWithSize:21];
        _secondDigitTextField.font = [UIFont poppinsNormalFontWithSize:21];
        _thirdDigitTextField.font = [UIFont poppinsNormalFontWithSize:21];
        _fourthDigitTextField.font = [UIFont poppinsNormalFontWithSize:21];
        _fifthDigitTextField.font = [UIFont poppinsNormalFontWithSize:21];
        _sixthDigitTextfield.font = [UIFont poppinsNormalFontWithSize:21];
        
        _cancelButton.titleLabel.font = [UIFont poppinsMediumFontWithSize:12];
        _nextButton.titleLabel.font = [UIFont poppinsMediumFontWithSize:12];
        
        _resendCodeButton.titleLabel.font = [UIFont poppinsMediumFontWithSize:12];

    }
    else if (height == 667)
    {
        
    }
    else
    {
        //736
    }
}

-(void)showAlertWithMessage : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Handling Keyboard

- (void)keyboardDidShow: (NSNotification *) notif{
    // Do something here
    isKeyboardVisible =YES;
}

- (void)keyboardDidHide: (NSNotification *) notif{
    // Do something here
    isKeyboardVisible = NO;
}

-(void) dismissKeyboard
{
    if (height < 600) {
    [_firstDigitTextField resignFirstResponder];
    [_secondDigitTextField resignFirstResponder];
    [_thirdDigitTextField resignFirstResponder];
    [_fourthDigitTextField resignFirstResponder];
    [_fifthDigitTextField resignFirstResponder];
    [_sixthDigitTextfield resignFirstResponder];
    }

}

#pragma mark - Call Web service

-(void) webserviceToAuthenticationCode
{
    [appDelegate initActivityIndicatorForviewController:self];

    UIViewController *previousViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    
//    if ([previousViewController isKindOfClass:[InviteCodeViewController class]]) {
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];

        NSString * authenticationCodeString = [NSString stringWithFormat:@"%@%@%@%@%@%@",_firstDigitTextField.text,_secondDigitTextField.text,_thirdDigitTextField.text,_fourthDigitTextField.text,_fifthDigitTextField.text,_sixthDigitTextfield.text];
        NSDictionary * postDataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:_emailId,@"Email",authenticationCodeString,@"AuthenticationCode",@"",@"isAuthenticationCodeVerified",uniqueIdentifier,@"DeviceID", nil];
        
        NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/Account/VerifyAuthenticationCode",[Webservice webserviceLink]];
        [webservice requestMethodForPost:stringWithUrl withData:postDataDictionary withTag:WEBSERVICE_FROM_INVITE_CODE_TAG];

//    }
//    else
//    {
//    // From forgot password
//        NSString * authenticationCodeString = [NSString stringWithFormat:@"%@%@%@%@%@%@",_firstDigitTextField.text,_secondDigitTextField.text,_thirdDigitTextField.text,_fourthDigitTextField.text,_fifthDigitTextField.text,_sixthDigitTextfield.text];
//    NSDictionary * postDataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"Email",authenticationCodeString,@"AuthenticationCode",@"",@"isAuthenticationCodeVerified", nil];
//    
//    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/VerifyAuthCodeForForgotPass",[Webservice webserviceLink]];
//    [webservice requestMethodForPost:stringWithUrl withData:postDataDictionary withTag:WEBSERVICE_FROM_FORGOT_PASSWORD_TAG];
//    }
}

#pragma mark - UIButton Actions

-(void)stackViewTapped : (UIGestureRecognizer *) gesture
{
    if (height < 600) {
        if (!isKeyboardVisible) {
            [self changesInUI];
            [self restoreToDefaults];
        }
    }
    else
    {
        [self changesInUI];
        [self restoreToDefaults];
    }
}

- (IBAction)cancelButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextButtonClicked:(id)sender {
//    InviteCodeViewController * inviteViewController = [InviteCodeViewController new];
    
    [self webserviceToAuthenticationCode];
//    UIViewController *previousViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
//    
//    if (![previousViewController isKindOfClass:[InviteCodeViewController class]]) {
//        [self performSegueWithIdentifier:[StoryboardsAndSegues segue_SetPassword] sender:nil];
//    }
//    else
//    {
//        [self performSegueWithIdentifier:[StoryboardsAndSegues segue_ConformDetailsPage] sender:nil];
//    }
}

- (IBAction)resendButtonClicked:(id)sender {
   
    [appDelegate initActivityIndicatorForviewController:self];

    NSDictionary * postDataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:_emailId,@"Email", nil];
    
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/Account/ResendAuthenticationCode",[Webservice webserviceLink]];
    [webservice requestMethodForPost:stringWithUrl withData:postDataDictionary withTag:WEBSERVICE_FROM_RESEND_CODE_TAG];
}

#pragma  mark - UITextFieldDelegates

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"str %@",string);
    //    if ((textField.text.length < 1) && (string.length > 0))
    //    {
    //
    //        NSInteger nextTag = textField.tag + 1;
    //        UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    //        if (! nextResponder){
    //            [textField resignFirstResponder];
    //        }
    //        textField.text = string;
    //        if (nextResponder)
    //            [nextResponder becomeFirstResponder];
    //
    //        return NO;
    //    }
    if ((textField.text.length == 0) && (string.length == 1) ) {
        NSLog(@"empty");
    }
    else if ((textField.text.length > 0) && (string.length == 1) ) {
        NSLog(@"has value");
        NSInteger nextTag = textField.tag + 1;
        UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
        if (! nextResponder){
            if (height < 600) {
            [textField resignFirstResponder];
            }
        }
        if (nextResponder)
        {
            textField = (UITextField *)[self.view viewWithTag:nextTag];
            [nextResponder becomeFirstResponder];
            textField.text = string;
            
            //            textField.backgroundColor = [UIColor redColor];
            
        }
        
        if (_sixthDigitTextfield.text.length != 0) {
            _nextButton.enabled = YES;
            _nextButton.backgroundColor = [ConstantColors enabledButtonBackGroundColor];
            [_nextButton setTitleColor:[ConstantColors enabledButtonTextColor] forState:UIControlStateNormal  ];


            if (height < 600) {
            [textField resignFirstResponder];
            }
        }
        //       for (UIView * eachSubView in _stackViewWhichContainsTextFields.subviews) {
        //           if ([eachSubView isKindOfClass:[UITextField class]]) {
        //               UITextField * eachTextField = (UITextField *)eachSubView;
        //               if (eachTextField.tag == nextTag + 1) {
        //                   eachTextField.backgroundColor = [UIColor redColor];
        //               }
        //               else
        //               {
        //                   eachTextField.backgroundColor = [UIColor clearColor];
        //               }
        //           }
        //       }
        return NO;
    }
    //    }else if ((textField.text.length >= 1) && (string.length > 0)){
    //        //FOR MAXIMUM 1 TEXT
    //
    //        NSInteger nextTag = textField.tag + 1;
    //        UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    //        if (! nextResponder){
    //            [textField resignFirstResponder];
    //        }
    //        textField.text = string;
    //        if (nextResponder)
    //            [nextResponder becomeFirstResponder];
    //
    //        return NO;
    //    }
    else if ((textField.text.length >= 1) && (string.length == 0)){
        // on deleteing value from Textfield
        
        NSInteger prevTag = textField.tag - 1;
        // Try to find prev responder
        UIResponder* prevResponder = [textField.superview viewWithTag:prevTag];
        //        if (! prevResponder){
        //            [textField resignFirstResponder];
        //        }
        textField.text = string;
        
        if (prevResponder)
            // Found next responder, so set it.
            [prevResponder becomeFirstResponder];
        textField = (UITextField *)[self.view viewWithTag:prevTag];
        for (id eachSubView in self.view.subviews) {
            if ([eachSubView isKindOfClass:[UITextField class]]) {
                UITextField * eachTextField = (UITextField *)eachSubView;
                if (eachTextField.tag == textField.tag) {
                    eachTextField.backgroundColor = [UIColor redColor];
                }
                else
                {
                    eachTextField.backgroundColor = [UIColor clearColor];
                }
            }
        }
        //        textField.backgroundColor = [UIColor redColor];
        return NO;
    }
    
    return YES;
}

#pragma mark - Webservice delagate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    NSLog(@"%@",parsedData);
    [appDelegate stopActivityIndicatorForViewController:self];
    if (msgType == WEBSERVICE_FROM_RESEND_CODE_TAG) {
        if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
            //
        }
        else
        {
            [self showAlertWithMessage:parsedData[@"Error"]];
        }
    }
    else if (msgType == WEBSERVICE_FROM_INVITE_CODE_TAG) // authenticate from invite code
    {
        if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
            UIViewController *previousViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
            dictionaryWithConfirmDetailsObjects = parsedData[@"ReturnObject"];
            if (![previousViewController isKindOfClass:[InviteCodeViewController class]]) {
                [self performSegueWithIdentifier:[StoryboardsAndSegues segue_SetPassword] sender:nil];
            }
            else
            {
                [self performSegueWithIdentifier:[StoryboardsAndSegues segue_ConformDetailsPage] sender:nil];
            }
        }
        else
        {
            [self showAlertWithMessage:parsedData[@"ErrorDescription"]];
        }
        
    }
    else // authnticate from forget password
    {
        
    }
    
}


-(void)errorRecieved:(NSString *)errorString withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];
    [self showAlertWithMessage:errorString];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_SetPassword]]) {
    SetPasswordViewController * setPasswordViewController = segue.destinationViewController;
    setPasswordViewController.emailId = _emailId;
    }
    else if ([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_ConformDetailsPage]])
    {
        ConfirmDetailsViewController * confirmDetailsViewController = segue.destinationViewController;
        confirmDetailsViewController.emailId = _emailId;
        confirmDetailsViewController.confirmDetailDictionary = dictionaryWithConfirmDetailsObjects;
    }
}


@end
