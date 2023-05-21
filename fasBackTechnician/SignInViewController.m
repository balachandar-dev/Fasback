//
//  SignInViewController.m
//  FasBackTechnician
//
//  Created by User on 12/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "SignInViewController.h"
#import "StringHandling.h"
#import <MFSideMenuContainerViewController.h>
#import "AppDelegate.h"
#import "Constants.h"

@interface SignInViewController ()

@end

@implementation SignInViewController
AppDelegate * appDelegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self restoreToDefaults];
    
//    _emailTextField.text = @"tch8@gmail.com";
//    _passwordTextField.text = @"Pass@word1";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - General

-(void)restoreToDefaults
{
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 50);
    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
    
    [self changesInUI];
}

-(void) changesInUI
{
    
    
    if (height == 480) {
        _technicianLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
        _forgotPasswordButton.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightSemibold];
        _signInButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightSemibold];
        _bySigningMessageLabel.font = [UIFont systemFontOfSize:10];
        _termsAndConditionButton.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightSemibold];
        _emailTextField.font =[UIFont systemFontOfSize:12];
        _passwordTextField.font =[UIFont systemFontOfSize:12];
        _signInLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];

        [_technicianLabel sizeToFit];

        _backButton.frame = CGRectMake(_backButton.frame.origin.x, _backButton.frame.origin.y, _backButton.frame.size.width * 0.5, _backButton.frame.size.height * 0.5);
        _logoImageView.frame = CGRectMake((width-(_logoImageView.frame.size.width * 0.75))/2, 40, (_logoImageView.frame.size.width * 0.75), (_logoImageView.frame.size.height * 0.75));
        _fasBackLogoImageView.frame =CGRectMake((width-(_fasBackLogoImageView.frame.size.width * 0.7 ))/2, _logoImageView.frame.origin.y + _logoImageView.frame.size.height + 22,( _fasBackLogoImageView.frame.size.width *0.7), (_fasBackLogoImageView.frame.size.height * 0.7));
        _technicianLabel.frame =CGRectMake(((_fasBackLogoImageView.frame.size.width + _fasBackLogoImageView.frame.origin.x)-5 ) - _technicianLabel.frame.size.width, _fasBackLogoImageView.frame.origin.y + _fasBackLogoImageView.frame.size.height + 2, _technicianLabel.frame.size.width, _technicianLabel.frame.size.height);
        _signInLabel.frame = CGRectMake((width - 120)/2, _technicianLabel.frame.origin.y + _technicianLabel.frame.size.height + 10, 120, 30);
        
        _termsAndConditionButton.frame = CGRectMake((width - (_termsAndConditionButton.frame.size.width -31) )/2, height - 50, _termsAndConditionButton.frame.size.width -51, 15);
        _bySigningMessageLabel.frame = CGRectMake(20, _termsAndConditionButton.frame.origin.y - 15, width-40, 15);
        _forgotPasswordButton.frame = CGRectMake((width - (_forgotPasswordButton.frame.size.width - 24) )/2, _bySigningMessageLabel.frame.origin.y - 55, _forgotPasswordButton.frame.size.width - 24, 15);
        _signInButton.frame = CGRectMake(25, _forgotPasswordButton.frame.origin.y - 45, width - 50, _signInButton.frame.size.height - 5);

        
        
        _heightConstraintsOfBackgroundViewOfTextFields.constant = 90;
        _widthConstraintOfBackGroundViewOfTextFields.constant = 270;
        _centerYConstraintForBackGroundViewOfTextFields.constant = 15;
        
      
        _signInButton.layer.cornerRadius = 4;
        _wholeViewContainsTextfields.layer.cornerRadius = 4;
        
      

    }
    else if (height == 568)
    {
        
        _forgotPasswordButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:10];
        _signInButton.titleLabel.font = [UIFont poppinsMediumFontWithSize:12];
        _bySigningMessageLabel.font = [UIFont poppinsNormalFontWithSize:10];
        _termsAndConditionButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:10];
        _emailTextField.font =[UIFont poppinsNormalFontWithSize:11];
        _passwordTextField.font =[UIFont poppinsNormalFontWithSize:11];
        _signInLabel.font = [UIFont poppinsSemiBoldFontWithSize:12];
        
//        _technicianLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
//        _forgotPasswordButton.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightSemibold];
//        _signInButton.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightSemibold];
//        _bySigningMessageLabel.font = [UIFont systemFontOfSize:10];
//        _termsAndConditionButton.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightSemibold];
//        _emailTextField.font =[UIFont systemFontOfSize:12];
//        _passwordTextField.font =[UIFont systemFontOfSize:12];
//        _signInLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];

        
//        [_technicianLabel sizeToFit];
//        
//        _backButton.frame = CGRectMake(_backButton.frame.origin.x, _backButton.frame.origin.y, _backButton.frame.size.width * 0.5, _backButton.frame.size.height * 0.5);
//        _logoImageView.frame = CGRectMake((width-(_logoImageView.frame.size.width * 0.85))/2, 45, (_logoImageView.frame.size.width * 0.85), (_logoImageView.frame.size.height * 0.85));
//        _fasBackLogoImageView.frame =CGRectMake((width-(_fasBackLogoImageView.frame.size.width * 0.85 ))/2, _logoImageView.frame.origin.y + _logoImageView.frame.size.height + 24,( _fasBackLogoImageView.frame.size.width *0.85), (_fasBackLogoImageView.frame.size.height * 0.85));
//        _technicianLabel.frame =CGRectMake(((_fasBackLogoImageView.frame.size.width + _fasBackLogoImageView.frame.origin.x)-5 ) - _technicianLabel.frame.size.width, _fasBackLogoImageView.frame.origin.y + _fasBackLogoImageView.frame.size.height + 2, _technicianLabel.frame.size.width, _technicianLabel.frame.size.height);        _signInLabel.frame = CGRectMake((width - 120)/2, _technicianLabel.frame.origin.y + _technicianLabel.frame.size.height + 13, 120, 30);
//        _signInLabel.frame = CGRectMake((width - 120)/2, _technicianLabel.frame.origin.y + _technicianLabel.frame.size.height + 20, 120, 30);
//
//        
//        _termsAndConditionButton.frame = CGRectMake((width-(_termsAndConditionButton.frame.size.width - 23))/2, height-70, _termsAndConditionButton.frame.size.width-23, _termsAndConditionButton.frame.size.height);
//        _bySigningMessageLabel.frame = CGRectMake((width-_bySigningMessageLabel.frame.size.width)/2, _termsAndConditionButton.frame.origin.y - 12, _bySigningMessageLabel.frame.size.width, _bySigningMessageLabel.frame.size.height);
//        _forgotPasswordButton.frame = CGRectMake((width - (_forgotPasswordButton.frame.size.width - 24) )/2, _bySigningMessageLabel.frame.origin.y - 71, _forgotPasswordButton.frame.size.width - 24, 15);
//        _signInButton.frame = CGRectMake(25, _forgotPasswordButton.frame.origin.y - 45, width - 50, _signInButton.frame.size.height - 5);
        
        
        
//        _heightConstraintsOfBackgroundViewOfTextFields.constant = 100;
//        _widthConstraintOfBackGroundViewOfTextFields.constant = 270;
//        _centerYConstraintForBackGroundViewOfTextFields.constant = 15;
        
      
        
        _signInButton.layer.cornerRadius = 5;
        _wholeViewContainsTextfields.layer.cornerRadius = 5;
        
        _mainScrollView.contentOffset = CGPointMake(0, 20);

//        _forgotPasswordButton.titleLabel.numberOfLines = 1;
//        _forgotPasswordButton.titleLabel.adjustsFontSizeToFitWidth = YES;
//        _forgotPasswordButton.titleLabel.lineBreakMode = NSLineBreakByClipping;

        
       

    }
    else if (height == 667)
    {
//        _centerYConstraintForBackGroundViewOfTextFields.constant = 12;
//        _signInLabel.frame = CGRectMake((width - 120)/2, _logoImageView.frame.origin.y + _logoImageView.frame.size.height + 30, 120, 30);

        _signInButton.layer.cornerRadius = 7;
        _wholeViewContainsTextfields.layer.cornerRadius = 5;

     
    }
    else
    {
        _forgotPasswordButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:13];
        _signInButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:15];
        _bySigningMessageLabel.font = [UIFont poppinsNormalFontWithSize:13];
        _termsAndConditionButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:13];
        _emailTextField.font =[UIFont poppinsNormalFontWithSize:14];
        _passwordTextField.font =[UIFont poppinsNormalFontWithSize:14];
        _signInLabel.font = [UIFont poppinsSemiBoldFontWithSize:15];
        
//        _logoImageView.frame = CGRectMake((width-_logoImageView.frame.size.width * 1.1)/2,80, (_logoImageView.frame.size.width *1.1), (_logoImageView.frame.size.height *1.1));
//        _fasBackLogoImageView.frame =CGRectMake((width-(_fasBackLogoImageView.frame.size.width * 1.2 ))/2, _logoImageView.frame.origin.y + _logoImageView.frame.size.height + 30,( _fasBackLogoImageView.frame.size.width *1.2), (_fasBackLogoImageView.frame.size.height * 1.2));
//        _signInLabel.frame = CGRectMake((width - 120)/2, _fasBackLogoImageView.frame.origin.y + _fasBackLogoImageView.frame.size.height + 40, 120, 30);
//        //
//        //
//        _termsAndConditionButton.frame = CGRectMake((width - (_termsAndConditionButton.frame.size.width ) )/2, height - 68, _termsAndConditionButton.frame.size.width , _termsAndConditionButton.frame.size.height);
//        _bySigningMessageLabel.frame = CGRectMake(20, _termsAndConditionButton.frame.origin.y - 25, width-40, 20);
//        _forgotPasswordButton.frame = CGRectMake((width - (_forgotPasswordButton.frame.size.width ) )/2, _bySigningMessageLabel.frame.origin.y - 91, _forgotPasswordButton.frame.size.width , 20);
//        _signInButton.frame = CGRectMake(30, _forgotPasswordButton.frame.origin.y - 65, width - 60, _signInButton.frame.size.height + 8);
//        
        
        
//        _heightConstraintsOfBackgroundViewOfTextFields.constant = _heightConstraintsOfBackgroundViewOfTextFields.constant + 10;
//        _widthConstraintOfBackGroundViewOfTextFields.constant = _widthConstraintOfBackGroundViewOfTextFields.constant + 40;
//        _centerYConstraintForBackGroundViewOfTextFields.constant = 31;
        
//        _forgotPasswordButton.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightSemibold];
//        _signInButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightSemibold];
//        _bySigningMessageLabel.font = [UIFont systemFontOfSize:10];
//        _termsAndConditionButton.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightSemibold];
//        _emailTextField.font =[UIFont systemFontOfSize:12];
//        _passwordTextField.font =[UIFont systemFontOfSize:12];
//        _signInLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];
        
        _signInButton.layer.cornerRadius = 8;
        _wholeViewContainsTextfields.layer.cornerRadius = 6;

        _mainScrollView.contentOffset = CGPointMake(0, 35);

      
    }
    
//    [_forgotPasswordButton sizeToFit];
//    [_termsAndConditionButton sizeToFit];
    
    


    
    NSMutableAttributedString* forgetPasswordString = [[NSMutableAttributedString alloc] initWithString:@"Forgot Password?"];
    [forgetPasswordString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){0,[forgetPasswordString length]}];
    
    [_forgotPasswordButton setAttributedTitle:forgetPasswordString forState:UIControlStateNormal];
    
    NSMutableAttributedString* termsAndConditionString = [[NSMutableAttributedString alloc] initWithString:@"Terms and Conditions"];
    [termsAndConditionString addAttribute:NSUnderlineStyleAttributeName
                                 value:@(NSUnderlineStyleSingle)
                                 range:(NSRange){0,[termsAndConditionString length]}];
    
    [_termsAndConditionButton setAttributedTitle:termsAndConditionString forState:UIControlStateNormal];
    _whiteBackgroundViewOfTextFields.layer.cornerRadius = 5;
    


}

-(void) showAlertWithMessage : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Call Web service 

-(void) webserviceToLogin
{

    
    [appDelegate initActivityIndicatorForviewController:self];
    
//    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//
////    NSDictionary * postDataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:_emailTextField.text,@"Username",_passwordTextField.text,@"Password",@"true",@"IsAutoLogin",@"ere",@"DeviceID", nil];
//    NSDictionary * postDataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:_emailTextField.text,@"Username",_passwordTextField.text,@"Password", nil];
//    
//    NSLog(@"postDataDictionary %@",postDataDictionary);
//
//    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/Account/Login",[Webservice webserviceLink]];
//
//    [webservice requestMethodForPost:stringWithUrl withData:postDataDictionary withTag:12];
    
    NSError *error;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url =  [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/Account/Login",[Webservice webserviceLink]] ];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    NSDictionary * postDataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:_emailTextField.text,@"Username",_passwordTextField.text,@"Password", nil];

    NSLog(@"postDataDictionary %@",postDataDictionary);

    NSData *postData = [NSJSONSerialization dataWithJSONObject:postDataDictionary options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [appDelegate stopActivityIndicatorForViewController:self];

        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:nil];
                NSLog(@"json %@",jsonData);
                //Process the data

            NSLog(@"%@",jsonData);
            if ([[jsonData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
                if ([jsonData objectForKey:@"Role"] == [NSNumber numberWithLong:4]) {
                    [[NSUserDefaults standardUserDefaults]setObject:[jsonData objectForKey:@"access_token"] forKey:accessToken];
                    [self onSuccessSigningIn];
                    
                }
                else
                {
                    [self showAlertWithMessage:@"Please login with valid login id"];
                }
            }
            else
            {
                
                if ([jsonData objectForKey:@"ErrorDescription"]) {
                    [self showAlertWithMessage:[jsonData objectForKey:@"ErrorDescription"]];
                }
                else if ([jsonData objectForKey:@"Message"])
                {
                    [self showAlertWithMessage:@"The user name or password is incorrect"];
                }
                else if ([jsonData objectForKey:@"errorDescription"])
                {
                    [self showAlertWithMessage:[jsonData objectForKey:@"errorDescription"]];
                }
                else if ([jsonData objectForKey:@"error_description"])
                {
                    [self showAlertWithMessage:[jsonData objectForKey:@"error_description"]];
                }
                

            }

        }
        else
        {
            [self showAlertWithMessage:error.localizedDescription];
        }
        });
    }];
    [postDataTask resume];

}

#pragma mark - Validations and others

-(void)onSuccessSigningIn
{
    [[NSUserDefaults standardUserDefaults] setObject:_emailTextField.text forKey:EMAILID];
    [appDelegate startSignalRWithEmailId];
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:IsSignedIn];
       UIStoryboard * mainStroyBoard = [UIStoryboard storyboardWithName:@"Profile" bundle:[NSBundle mainBundle]];
    MFSideMenuContainerViewController * controller = (MFSideMenuContainerViewController *)[mainStroyBoard instantiateInitialViewController];
    
    UINavigationController * mainViewController = [mainStroyBoard instantiateViewControllerWithIdentifier:@"DashboardNavigationController"];
    //        UIViewController * sideViewController = [mainStroyBoard instantiateInitialViewController];
    
    UIViewController * sideViewController = [mainStroyBoard instantiateViewControllerWithIdentifier:@"SideViewController"];
    [controller setCenterViewController:mainViewController];
    [controller setLeftMenuViewController:sideViewController];
    
    appDelegate.window.rootViewController = controller;
    

}

#pragma mark - UIButtonActions

- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)signInButtonClicked:(id)sender {
    if (_emailTextField.text.length == 0) {
        [self showAlertWithMessage:@"Please enter your Email id"];
    }
    else if (![StringHandling isValidEmail:_emailTextField.text])
    {
        [self showAlertWithMessage:@"Please enter a valid Email id"];
    }
    else if (_passwordTextField.text.length == 0)
    {
        [self showAlertWithMessage:@"Please enter your password"];
    }
    else
    {
    
//       [NSThread detachNewThreadSelector:@selector(webserviceToLogin) toTarget:self withObject:nil];

        [self webserviceToLogin];
//        //call service
    }
//    [self onSuccessSigningIn];
}

- (IBAction)fogotPasswordButtonClicked:(id)sender {
    
}
- (IBAction)termsAndConditionButtonClicked:(id)sender {
    
}


#pragma mark - UITextFieldDelegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _emailTextField) {
        [_passwordTextField becomeFirstResponder];
    }
    return [textField resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (height < 500) {
    
        _mainScrollView.contentOffset = CGPointMake(0, 50);
    }
   else  if (height < 600 ) {
       if (textField == _passwordTextField) {
       _mainScrollView.contentOffset = CGPointMake(0, 50);
       }
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (height < 600) {

    _mainScrollView.contentOffset = CGPointMake(0, 0);
    }
}


#pragma mark - Webservice delagate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];
    NSLog(@"%@",parsedData);
        if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
            if ([parsedData objectForKey:@"Role"] == [NSNumber numberWithLong:4]) {
                [[NSUserDefaults standardUserDefaults]setObject:[parsedData objectForKey:@"access_token"] forKey:accessToken];
                [self onSuccessSigningIn];
                
            }
            else
            {
                [self showAlertWithMessage:[parsedData objectForKey:@"ErrorDescription"]];
            }
        }
        else
        {
            [self showAlertWithMessage:[parsedData objectForKey:@"ErrorDescription"]];
            
        }
}


-(void)errorRecieved:(NSString *)errorString withMsgType:(int)msgType
{
    NSLog(@"%@",errorString);
    
    [appDelegate stopActivityIndicatorForViewController:self];
    if ([errorString isEqualToString:@"Request failed: bad request (400)"]) {
        [self showAlertWithMessage:@"Some error has occured, please try again"];
    }
    else
    {
        [self showAlertWithMessage:errorString];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
