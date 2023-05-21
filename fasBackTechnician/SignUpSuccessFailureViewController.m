//
//  SignUpSuccessFailureViewController.m
//  FasBackTechnician
//
//  Created by User on 17/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "SignUpSuccessFailureViewController.h"
#import "UIFont+PoppinsFont.h"
#import "ConstantColors.h"
#import "AppDelegate.h"
#import "Constants.h"
#import <MFSideMenu.h>
@interface SignUpSuccessFailureViewController ()

@end

@implementation SignUpSuccessFailureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    isSuccess = YES;
    [self UIChanges];
    // Do any additional setup after loading the view.
}


-(void) UIChanges
{
    _okButton.layer.cornerRadius = 4;
    _cancelButton.layer.cornerRadius = 4;
    _cancelButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _cancelButton.layer.borderWidth = 1.0;
    
    
    if (isSuccess) {
        NSString * messageAttributedText = @"You can now continue to use the app or tap Edit Profile button to start updating your profile.";
        NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:messageAttributedText];
    
        NSRange range = [messageAttributedText rangeOfString:@"Edit Profile"];
        [attString addAttribute:NSFontAttributeName value:[UIFont poppinsSemiBoldFontWithSize:12] range:range];
        _messageLineTwoLabel.attributedText = attString;


    }
    else
    {
        _logoImageView.image = [UIImage imageNamed:@"Failed"];
        _responseMessageLabel.text = @"Failed";
        _messageLineOneLabel.text = @"Praesent eu lectus vel ipsum mollisgravida. Praesent malesuada a leo at tincidunt";
        _messageLineTwoLabel.hidden = YES;
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal] ;
        [_okButton setTitle:@"Try Again" forState:UIControlStateNormal] ;

    }
    
    if (height == 480) {
        //
    }
    else if (height == 568)
    {
        _cancelButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:12];
        _okButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:12];
        
    }
    else if (height == 667)
    {
        
    }
    else
    {
        
    }

}

#pragma mark - UIButton Actions

- (IBAction)continueButtonClicked:(id)sender {
    if (isSuccess) {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:IsSignedIn];
        AppDelegate * appDelegate;
        
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UIStoryboard * mainStroyBoard = [UIStoryboard storyboardWithName:@"Profile" bundle:[NSBundle mainBundle]];
        MFSideMenuContainerViewController * controller = (MFSideMenuContainerViewController *)[mainStroyBoard instantiateInitialViewController];
        
        UINavigationController * mainViewController = [mainStroyBoard instantiateViewControllerWithIdentifier:@"DashboardNavigationController"];
        //        UIViewController * sideViewController = [mainStroyBoard instantiateInitialViewController];
        
        UIViewController * sideViewController = [mainStroyBoard instantiateViewControllerWithIdentifier:@"SideViewController"];
        [controller setCenterViewController:mainViewController];
        [controller setLeftMenuViewController:sideViewController];
        
        appDelegate.window.rootViewController = controller;

    }
    else
    {
    [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
- (IBAction)editProfileButtonClicked:(id)sender {
    if (!isSuccess) {
    [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
