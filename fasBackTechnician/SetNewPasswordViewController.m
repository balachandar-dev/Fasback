//
//  SetNewPasswordViewController.m
//  FasBackTechnician
//
//  Created by User on 13/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "SetNewPasswordViewController.h"
#import "UIFont+PoppinsFont.h"
#import "StoryboardsAndSegues.h"
#import "AppDelegate.h"

@interface SetNewPasswordViewController ()
{
    AppDelegate * appDelegate;
}
@end

@implementation SetNewPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    [self restoreToDefaults];
    [self changesInUI];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    _mainScrollView.contentOffset = CGPointMake(0, 0);

}

-(void) restoreToDefaults
{
    validationList = [NSArray arrayWithObjects:@"Have to be atleaset 8 characters long",@"Have atleast one uppercase character",@"Have atleast one lowercase character",@"Have atleast one number",@"Have atleast one special character", nil];
    _mainScrollView.contentOffset = CGPointMake(0, 0);
    
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;

}
-(void) changesInUI
{
    if (height == 480) {
//        _setNewPasswordLabel.font = [UIFont poppinsMediumFontWithSize:14];
//        _pleaseEnterMessageLabel.font = [UIFont poppinsNormalFontWithSize:11];
        _enterNewPasswordLabel.font = [UIFont poppinsMediumFontWithSize:11];
        _enterYourPasswordTExtField.font = [UIFont poppinsNormalFontWithSize:13];
        _confirmPasswordLabel.font = [UIFont poppinsMediumFontWithSize:11];
        _reEnterPasswordTextField.font = [UIFont poppinsNormalFontWithSize:13];
        _setPasswordButton.titleLabel.font = [UIFont poppinsMediumFontWithSize:13];
        
    }
    else if (height == 568)
    {
        _heightConstraintOfValidationTable.constant = 120;
        _widthConstraintOfValidationTable.constant = width - 60;
        _bottomConstraintOfNewPasswordLabel.constant = 0;
        _bottomConstraintOfConfirmPAsswordLabel.constant = 0;
        _bottomConstraintForSetNewPasswordLabel.constant = 10;
        _widthOfImageView.constant = _widthOfImageView.constant * 0.85;
//        _heightConstraintsOfImageView.constant = _heightConstraintsOfImageView.constant * 0.85;
//        
//        
//        _setNewPasswordLabel.font = [UIFont poppinsMediumFontWithSize:14];
//        _pleaseEnterMessageLabel.font = [UIFont poppinsNormalFontWithSize:11];
        _enterNewPasswordLabel.font = [UIFont poppinsMediumFontWithSize:11];
        _enterYourPasswordTExtField.font = [UIFont poppinsNormalFontWithSize:13];
        _confirmPasswordLabel.font = [UIFont poppinsMediumFontWithSize:11];
        _reEnterPasswordTextField.font = [UIFont poppinsNormalFontWithSize:13];
        _setPasswordButton.titleLabel.font = [UIFont poppinsMediumFontWithSize:12];
        
        _mainScrollView.contentSize = CGSizeMake(width, height +150);

    }
    else if(height == 667)
    {
        _centerYOfValidationTableView.constant = 30;
        _heightConstraintOfValidationTable.constant = 160;
    }
    else if(height == 736)
    {
        
    }
    
    _setPasswordButton.layer.cornerRadius = 4;

    
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


#pragma mark - UIButton Actions

- (IBAction)setPasswordButtonClicked:(id)sender {
    if (_enterYourPasswordTExtField.text.length != 0) {
        [self showAlertWithMessage:@"All fields are mandatory"];
    }
    else if(_reEnterPasswordTextField.text.length != 0 )
    {
        [self showAlertWithMessage:@"All fields are mandatory"];
    }
    if (_enterYourPasswordTExtField.text.length != 0) {
        [self showAlertWithMessage:@"All fields are mandatory"];
    }
    else if(_reEnterPasswordTextField.text.length != 0 )
    {
        [self showAlertWithMessage:@"All fields are mandatory"];
    }
    else if (![_enterYourPasswordTExtField.text isEqualToString:_reEnterPasswordTextField.text])
    {
        [self showAlertWithMessage:@"Passwords in both the fields doesn't matches"];
        
    }
    else
    {
        // Validation success
    }

    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_SuccessChangingPassword] sender:nil];
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
    cell.heightConstrintOfImageView.constant = 15;
    cell.widthOfImageView.constant = 15;
        cell.validateMessageTextLabel.font = [UIFont poppinsNormalFontWithSize:11];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _heightConstraintOfValidationTable.constant/5;
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
    if (textField == _reEnterPasswordTextField) {
        _mainScrollView.contentOffset = CGPointMake(0, 130);
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _mainScrollView.contentOffset = CGPointMake(0, 0);

}



#pragma mark - Webservice delagate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];

}


-(void)errorRecieved:(NSString *)errorString withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];
    [self showAlertWithMessage:errorString];
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
