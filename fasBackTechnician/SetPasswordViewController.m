//
//  SetPasswordViewController.m
//  FasBackTechnician
//
//  Created by User on 19/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "UIFont+PoppinsFont.h"
#import "StoryboardsAndSegues.h"
#import "ConstantColors.h"
#import "EnterAuthenticationCodeViewController.h"
#import "StringHandling.h"
#import "AppDelegate.h"
#import "Constants.h"
@interface SetPasswordViewController ()
{
    AppDelegate * appDelegate;
}
@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    [self restoreToDefaults];
    [self changesInUI];
    // Do any additional setup after loading the view.
}

#pragma mark - General

-(void) restoreToDefaults
{
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    isEnterTeextFieldReturned = NO;
    isReenterTextFieldReturned = NO;
    validationList = [NSArray arrayWithObjects:@"Have to be at least 8 characters long",@"Have at least one uppercase character",@"Have at least one lowercase character",@"Have at least one number",@"Have at least one special character", nil];
    newPasswordString = [[NSMutableString alloc]init];
    confirmPasswordString = [[NSMutableString alloc]init];
    validationResponseList = [[NSMutableArray alloc]initWithObjects:@"0",@"0",@"0",@"0",@"0", nil];
    
    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
    
    
}
-(void) changesInUI
{
    if (height == 480) {
        _setPasswordLabel.font = [UIFont poppinsMediumFontWithSize:14];
        _pleaseEnterMessageLabel.font = [UIFont poppinsNormalFontWithSize:11];
        _enterNewPasswordLabel.font = [UIFont poppinsMediumFontWithSize:11];
        _enterYourPasswordTExtField.font = [UIFont poppinsNormalFontWithSize:13];
        _confirmPasswordLabel.font = [UIFont poppinsMediumFontWithSize:11];
        _reEnterPasswordTextField.font = [UIFont poppinsNormalFontWithSize:13];
        _setPasswordButton.titleLabel.font = [UIFont poppinsMediumFontWithSize:13];
        
    }
    else if (height == 568)
    {
        //        _heightConstraintOfValidationTable.constant = 120;
        //        _widthConstraintOfValidationTable.constant = width - 60;
        //        _bottomConstraintOfNewPasswordLabel.constant = 0;
        //        _bottomConstraintOfConfirmPAsswordLabel.constant = 0;
        //        _bottomConstraintForSetNewPasswordLabel.constant = 10;
        //        _widthOfImageView.constant = _widthOfImageView.constant * 0.85;
        //        _heightConstraintsOfImageView.constant = _heightConstraintsOfImageView.constant * 0.85;
        
        
        _setPasswordLabel.font = [UIFont poppinsMediumFontWithSize:14];
        _pleaseEnterMessageLabel.font = [UIFont poppinsNormalFontWithSize:11];
        _enterNewPasswordLabel.font = [UIFont poppinsMediumFontWithSize:11];
        _enterYourPasswordTExtField.font = [UIFont poppinsNormalFontWithSize:13];
        _confirmPasswordLabel.font = [UIFont poppinsMediumFontWithSize:11];
        _reEnterPasswordTextField.font = [UIFont poppinsNormalFontWithSize:13];
        _setPasswordButton.titleLabel.font = [UIFont poppinsMediumFontWithSize:12];
        
        _enterYourPasswordTExtField.font = [UIFont poppinsNormalFontWithSize:12];
        _reEnterPasswordTextField.font = [UIFont poppinsNormalFontWithSize:12];
        
        _previousButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:12];
        _setPasswordButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:12];
        
        
        _mainScrollView.contentSize = CGSizeMake(width, height +150);
        
    }
    else if(height == 667)
    {
        //        _centerYOfValidationTableView.constant = 30;
        //        _heightConstraintOfValidationTable.constant = 160;
    }
    else if(height == 736)
    {
        
    }
    
    _setPasswordButton.layer.cornerRadius = 4;
    _previousButton.layer.cornerRadius = 4;
    _previousButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _previousButton.layer.borderWidth = 1.0;
    
    UIViewController *previousViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    
    
    if ([previousViewController isKindOfClass:[EnterAuthenticationCodeViewController class]]) {
        _setPasswordLabel.text = @"Set New Password";
        _previousButton.hidden = YES;
        _widthConstraintOfCompleteButton.constant = (width/6)*5;
        [_setPasswordButton setTitle:@"Set Password" forState:UIControlStateNormal];
    }
    else
    {
        _setPasswordLabel.text = @"Set Password";
        _previousButton.hidden = YES;
        [_setPasswordButton setTitle:@"Complete" forState:UIControlStateNormal];
    }
    [self EnablingAndDisablingCompleteButton:NO];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) showAlertWithMessage : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void) EnablingAndDisablingCompleteButton : (BOOL) isEnabled
{
    if (isEnabled) {
        [_setPasswordButton setBackgroundColor:[ConstantColors enabledButtonBackGroundColor]];
        [_setPasswordButton setTitleColor:[ConstantColors enabledButtonTextColor] forState:UIControlStateNormal];
        _setPasswordButton.enabled = YES;
        
    }
    else
    {
        [_setPasswordButton setBackgroundColor:[ConstantColors disabledButtonBackgroundColor]];
        [_setPasswordButton setTitleColor:[ConstantColors disabledButtonTextColor] forState:UIControlStateNormal];
        _setPasswordButton.enabled = NO;
    }
}

#pragma mark - Web service

-(void) webserviceToSetPassword
{
    //    "Email": "sample string 1",
    //    "NewPassword": "sample string 2"
    //    "Username": "sample string 1",
    //    "NewPassword": "sample string 2",
    //    "ConfirmPassword": "sample string 3",
    //    "IsFromResetPassword": true
    
    //    _emailId = @"tch3@gmail.com";
    
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    [appDelegate initActivityIndicatorForviewController:self];
    NSDictionary * postDataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:_emailId,@"Email",_enterYourPasswordTExtField.text,@"NewPassword",_reEnterPasswordTextField.text,@"ConfirmPassword",uniqueIdentifier,@"DeviceID", nil];
    
    NSLog(@"%@",postDataDictionary);
    
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/Account/SetPasswordAPP",[Webservice webserviceLink]];
    [webservice requestMethodForPost:stringWithUrl withData:postDataDictionary withTag:12];
}


#pragma mark - Validations

-(void) validateThePasswordString : (NSMutableString * ) stringReceived
{
    if ([StringHandling checkIfStringHasEightCharacters:stringReceived]) {
        [validationResponseList replaceObjectAtIndex:0 withObject:@"1"];
    }
    else
    {
        [validationResponseList replaceObjectAtIndex:0 withObject:@"0"];
    }
    if ([StringHandling checkIfItHasAtleastOneUpperCase:stringReceived]) {
        [validationResponseList replaceObjectAtIndex:1 withObject:@"1"];
    }
    else
    {
        [validationResponseList replaceObjectAtIndex:1 withObject:@"0"];
    }
    if ([StringHandling checkIfItHasAtleastOneLowerCase:stringReceived]) {
        [validationResponseList replaceObjectAtIndex:2 withObject:@"1"];
    }
    else
    {
        [validationResponseList replaceObjectAtIndex:2 withObject:@"0"];
    }
    
    if ([StringHandling checkIfItHasAtleastOneNumber:stringReceived]) {
        [validationResponseList replaceObjectAtIndex:3 withObject:@"1"];
    }
    else
    {
        [validationResponseList replaceObjectAtIndex:3 withObject:@"0"];
    }
    
    if ([StringHandling checkIfItHasAtleastOneSpecialCharacter:stringReceived]) {
        [validationResponseList replaceObjectAtIndex:4 withObject:@"1"];
    }
    else
    {
        [validationResponseList replaceObjectAtIndex:4 withObject:@"0"];
    }
    
    NSLog(@"%@",validationResponseList);
    if ([self checkIfWholeStringIsValidWithArray:validationResponseList]) {
        [_validationImageViewInNewPasswordTextField setImage:[UIImage imageNamed:@"checkbox_selected"] forState:UIControlStateNormal];
    }
    else
    {
        [_validationImageViewInNewPasswordTextField setImage:[UIImage imageNamed:@"cross_red"] forState:UIControlStateNormal];
        
    }
    [_validationTableView reloadData];
}

-(BOOL) checkIfWholeStringIsValidWithArray : (NSMutableArray *) arrayReceived
{
    for (int i =0 ; i<arrayReceived.count; i++) {
        if ([arrayReceived[i] isEqualToString:@"1"]) {
            //
        }
        else
        {
            return NO;
        }
    }
    return YES;
}

#pragma mark - UIButton Action

- (IBAction)continueButtonClicked:(id)sender {
    if (_enterYourPasswordTExtField.text.length == 0) {
        [self showAlertWithMessage:@"All fields are mandatory"];
    }
    else if(_reEnterPasswordTextField.text.length == 0 )
    {
        [self showAlertWithMessage:@"All fields are mandatory"];
    }
    else if (![_enterYourPasswordTExtField.text isEqualToString:_reEnterPasswordTextField.text])
    {
        [self showAlertWithMessage:@"Passwords in both the fields doesn't matches"];
        
    }
    else
    {
        [self webserviceToSetPassword];
        // Validation success
    }
    //    [self successAfterContinueButton];
}

- (IBAction)previousButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) successAfterContinueButton
{
    UIViewController *previousViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    
    if (![previousViewController isKindOfClass:[EnterAuthenticationCodeViewController class]]) {
        [self performSegueWithIdentifier:[StoryboardsAndSegues segue_SuccessAndFailureSettingPassword] sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:[StoryboardsAndSegues segue_SuccessChangingPassword] sender:nil];
    }
    
}

#pragma mark - UITableView Datasoure

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [validationList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SetNewPasswordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[SetNewPasswordTableViewCell reuseIdentifier] forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[SetNewPasswordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[SetNewPasswordTableViewCell reuseIdentifier]];
    }
    cell.validateMessageTextLabel.text = [validationList objectAtIndex:indexPath.row];
    if (height == 568) {
        //        cell.heightConstrintOfImageView.constant = 15;
        cell.widthOfImageView.constant = 15;
        cell.validateMessageTextLabel.font = [UIFont poppinsNormalFontWithSize:11];
    }
    if ([[validationResponseList objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
        cell.validateImageView.image = [UIImage imageNamed:@"cross_red"];
    }
    else
    {
        cell.validateImageView.image = [UIImage imageNamed:@"checkbox_selected"];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (height == 480) {
        return 35;
        
    }
    else if (height == 568)
    {
        return 30;
        
    }
    else if (height == 667)
    {
        return 35;
        
    }
    else
    {
        return 35;
    }
}



#pragma mark - UITableView Delegates

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - UITextField Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _enterYourPasswordTExtField) {
        return [_reEnterPasswordTextField becomeFirstResponder];
    }
    return [textField resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual: _enterYourPasswordTExtField]) {
        for (int i = 0; i<[validationResponseList count]; i++) {
            [validationResponseList replaceObjectAtIndex:i withObject:@"0"];
        }
        isEnterTeextFieldReturned = YES;
        [_validationTableView reloadData];
        //        isEnterTeextFieldReturned = NO;
    }
    if (textField == _reEnterPasswordTextField) {
        _mainScrollView.contentOffset = CGPointMake(0, 130);
        isReenterTextFieldReturned = YES;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _mainScrollView.contentOffset = CGPointMake(0, 0);
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField isEqual:_enterYourPasswordTExtField]) {
        if (isEnterTeextFieldReturned == YES) {
            newPasswordString = nil;
            newPasswordString = [[NSMutableString alloc]init];
            isEnterTeextFieldReturned = NO;
            
            if ([string isEqualToString:@""]) {
                NSLog(@"Back space");
            }
            else
            {
                NSLog(@"%@",string);
                [newPasswordString appendString:string];
            }
            
        }
        else
        {
            if ([string isEqualToString:@""]) {
                NSLog(@"Back space");
                [newPasswordString replaceCharactersInRange:range withString:@""];
            }
            else
            {
                NSLog(@"%@",string);
                [newPasswordString appendString:string];
            }
        }
        //        _enterYourPasswordTExtField.text = newPasswordString;
        NSLog(@"%@",newPasswordString);
        
        [self validateThePasswordString:newPasswordString];
        // for confirmation text  field
        if ([newPasswordString isEqualToString:_reEnterPasswordTextField.text]) {
            [_validationImageViewInConfirmPasswordTextField setImage:[UIImage imageNamed:@"checkbox_selected"] forState:UIControlStateNormal];
        }
        else
        {
            [_validationImageViewInConfirmPasswordTextField setImage:[UIImage imageNamed:@"cross_red"] forState:UIControlStateNormal];
            
        }
        
    }
    else
    {
        if (isReenterTextFieldReturned == YES) {
            confirmPasswordString = nil;
            confirmPasswordString = [[NSMutableString alloc]init];
            isReenterTextFieldReturned = NO;
            
            if ([string isEqualToString:@""]) {
                NSLog(@"Back space");
            }
            else
            {
                NSLog(@"%@",string);
                [confirmPasswordString appendString:string];
            }
            
        }
        else
        {
            
            if ([string isEqualToString:@""]) {
                NSLog(@"Back space");
                [confirmPasswordString replaceCharactersInRange:range withString:@""];
            }
            else
            {
                NSLog(@"%@",string);
                [confirmPasswordString appendString:string];
            }
        }
        if ([confirmPasswordString isEqualToString:_enterYourPasswordTExtField.text]) {
            [_validationImageViewInConfirmPasswordTextField setImage:[UIImage imageNamed:@"checkbox_selected"] forState:UIControlStateNormal];
        }
        else
        {
            [_validationImageViewInConfirmPasswordTextField setImage:[UIImage imageNamed:@"cross_red"] forState:UIControlStateNormal];
            
        }
    }
    
    if ([_validationImageViewInConfirmPasswordTextField.imageView.image isEqual:[UIImage imageNamed:@"checkbox_selected"]]) {
        if ([_validationImageViewInNewPasswordTextField.imageView.image isEqual:[UIImage imageNamed:@"checkbox_selected"]]) {
            [self EnablingAndDisablingCompleteButton:YES];
            
            
        }
        else
        {
            [self EnablingAndDisablingCompleteButton:NO];
        }
    }
    else
    {
        [self EnablingAndDisablingCompleteButton:NO];
        
    }
    return YES;
}


#pragma mark - Webservice delagate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];
    if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
        UIViewController *previousViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
        
        if (![previousViewController isKindOfClass:[EnterAuthenticationCodeViewController class]]) {
            [[NSUserDefaults standardUserDefaults]setObject:[parsedData objectForKey:@"access_token"] forKey:accessToken];
        }
        [self successAfterContinueButton];
    }
    else
    {
        [self showAlertWithMessage:parsedData[@"Error"]];
    }
}


-(void)errorRecieved:(NSString *)errorString withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:errorString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"Ok"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [self.navigationController popToRootViewControllerAnimated:YES];
                                   //Handle your yes please button action here
                               }];
    [alertController addAction:okButton];
    
    [self presentViewController:alertController animated:YES completion:nil];}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
