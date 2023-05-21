//
//  ForgetPasswordViewController.h
//  FasBackTechnician
//
//  Created by User on 11/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+PoppinsFont.h"
#import "Webservice.h"

@interface ForgetPasswordViewController : UIViewController<UITextFieldDelegate,webProtocol>
{
    float width, height;
    Webservice * webservice;
}
@property (weak, nonatomic) IBOutlet UITextField *emailIdTextField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraintOfEmailLabel;

@property (weak, nonatomic) IBOutlet UILabel *fogetPasswordLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLineOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraintOFImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BottomConstarinOfImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthOfImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintOfForgotPasswordLabel;

@end
