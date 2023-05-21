//
//  SignInViewController.h
//  FasBackTechnician
//
//  Created by User on 12/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+PoppinsFont.h"
#import "Webservice.h"
@interface SignInViewController : UIViewController<UITextFieldDelegate,webProtocol>
{
    float width, height;
    Webservice * webservice;
    UIActivityIndicatorView * activityIndicator;
    UIImage * animateImageView;
}

// UI elements

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fasBackLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *technicianLabel;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *termsAndConditionButton;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UILabel *signInLabel;
@property (weak, nonatomic) IBOutlet UIView *whiteBackgroundViewOfTextFields;
@property (weak, nonatomic) IBOutlet UIView *wholeViewContainsTextfields;
@property (weak, nonatomic) IBOutlet UILabel *bySigningMessageLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraintOfBackGroundViewOfTextFields;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintsOfBackgroundViewOfTextFields;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerYConstraintForBackGroundViewOfTextFields;

@end
