//
//  SetPasswordViewController.h
//  FasBackTechnician
//
//  Created by User on 19/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetNewPasswordTableViewCell.h"
#import "Webservice.h"
@interface SetPasswordViewController : UIViewController<UITextFieldDelegate,webProtocol>
{
    float width, height;
    NSArray * validationList;
    NSMutableString * newPasswordString, * confirmPasswordString;
    NSMutableArray * validationResponseList;
    Webservice * webservice;
    BOOL isEnterTeextFieldReturned, isReenterTextFieldReturned;
}


@property (nonatomic,strong) NSString * emailId;

//UIElements

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *setPasswordLabel;
@property (weak, nonatomic) IBOutlet UILabel *pleaseEnterMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel * enterNewPasswordLabel;
@property (weak, nonatomic) IBOutlet UITableView *validationTableView;
@property (weak, nonatomic) IBOutlet UILabel *confirmPasswordLabel;
@property (weak, nonatomic) IBOutlet UITextField *enterYourPasswordTExtField;
@property (weak, nonatomic) IBOutlet UITextField *reEnterPasswordTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIButton *setPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;

@property (weak, nonatomic) IBOutlet UIButton *validationImageViewInNewPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *validationImageViewInConfirmPasswordTextField;



// Constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthOfImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintsOfImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraintsOfImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraintForSetNewPasswordLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintForSetNewPasswordLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintOfValidationTable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraintOfValidationTable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerYOfValidationTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintOfNewPasswordLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintOfConfirmPAsswordLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraintOfCompleteButton;

@end
