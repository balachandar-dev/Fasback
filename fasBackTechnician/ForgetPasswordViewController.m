//
//  ForgetPasswordViewController.m
//  FasBackTechnician
//
//  Created by User on 11/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "StoryboardsAndSegues.h"
#import "ConstantColors.h"
#import "StringHandling.h"
#import "EnterAuthenticationCodeViewController.h"
#import "AppDelegate.h"

@interface ForgetPasswordViewController ()
{
    AppDelegate * appDelegate;
}
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;

    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
    
    [self changesInUI];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [_emailIdTextField becomeFirstResponder];
//    _emailIdTextField.text = @"";

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - General

-(void) changesInUI
{
//    self.navigationController.navigationBarHidden = NO;

    _saveButton.layer.cornerRadius = 4;
    _cancelButton.layer.cornerRadius = 4;
    _cancelButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _cancelButton.layer.borderWidth = 1.0;
    
    if (height == 480) {
//        _topConstraintOfEmailLabel.constant = 20;
//        _topConstraintOFImageView.constant = 30;
//        _BottomConstarinOfImageView.constant = 20;

//        _emailLabel.font = [UIFont systemFontOfSize:11];
//        _emailIdTextField.font = [UIFont systemFontOfSize:12];
//        _messageLineOneLabel.font = [UIFont systemFontOfSize:12];

    }
    else if (height == 568)
    {
//        _topConstraintOfEmailLabel.constant = 25;

        _fogetPasswordLabel.font = [UIFont poppinsSemiBoldFontWithSize:16];
        _messageLineOneLabel.font = [UIFont poppinsNormalFontWithSize:11];

        _emailLabel.font = [UIFont poppinsMediumFontWithSize:11];
        _emailIdTextField.font = [UIFont poppinsNormalFontWithSize:12];
        _cancelButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:12];
        _saveButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:12];

//        _widthOfImageView.constant = 60;
//        _heightOfImageView.constant = 47;
//        _topConstraintOFImageView.constant = 45;
//        _BottomConstarinOfImageView.constant = 20;
      
    }
    else if (height == 667)
    {
//        _topConstraintOFImageView.constant = 50;
//        _BottomConstarinOfImageView.constant = 30;
////        _widthOfImageView.constant = 105;
////        _heightOfImageView.constant = 80;
//        _topConstraintOfEmailLabel.constant = 35;
        
//        _emailLabel.font = [UIFont systemFontOfSize:12];
//        _messageLineOneLabel.font = [UIFont systemFontOfSize:12];


    }
    else if (height == 736)
    {
        _fogetPasswordLabel.font = [UIFont poppinsSemiBoldFontWithSize:19];
        _messageLineOneLabel.font = [UIFont poppinsNormalFontWithSize:13];
        _emailLabel.font = [UIFont poppinsNormalFontWithSize:13];
        _emailIdTextField.font = [UIFont poppinsNormalFontWithSize:15];
        _cancelButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:15];
        _saveButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:15];
//        _topConstraintOFImageView.constant = 70;
//        _bottomConstraintOfForgotPasswordLabel.constant = 25;

    }
    
}

-(void) showAlertWithMessage : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Call Web service

-(void) webserviceToForgetPassword
{
    //    {
    //        "Username": "sample string 1",
    //        "Password": "sample string 2"
    //    }
    [appDelegate initActivityIndicatorForviewController:self];

    NSDictionary * postDataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:_emailIdTextField.text,@"Email",@"technician",@"UserRole", nil];
    
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/Account/ForgotPasswordAPP",[Webservice webserviceLink]];
    
    NSLog(@"%@",stringWithUrl);
    
    [webservice requestMethodForPost:stringWithUrl withData:postDataDictionary withTag:12];
}


#pragma mark - UIButton Actions

- (IBAction)cancelButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)sendButtonClicked:(id)sender {
    if (_emailIdTextField.text.length == 0) {
        [self showAlertWithMessage:@"Please enter your Email id"];
    }
    else if (![StringHandling isValidEmail:_emailIdTextField.text])
    {
        [self showAlertWithMessage:@"Please enter a valid Email id"];
    }
    else
    {
        [self webserviceToForgetPassword];
        // Validation success
    }
//    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_EnterActivationCode] sender:nil];
}


#pragma mark - UITextFieldDelegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


#pragma mark - Webservice delagate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];

    NSLog(@"%@",parsedData);
    if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
        
        [self performSegueWithIdentifier:[StoryboardsAndSegues segue_EnterActivationCode] sender:nil];
    }
    else
    {
        [self showAlertWithMessage:parsedData[@"ErrorDescription"]];
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
    EnterAuthenticationCodeViewController * enterAuthenticationViewController = segue.destinationViewController;
    enterAuthenticationViewController.emailId = _emailIdTextField.text;
}


@end
