//
//  InviteCodeViewController.h
//  FasBackTechnician
//
//  Created by User on 19/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextField+ModifyngTextField.h"
#import "ConstantColors.h"
#import "Webservice.h"

@interface InviteCodeViewController : UIViewController<UITextFieldDelegate,webProtocol>
{
    BOOL isKeyboardVisible;
    float width, height;
    Webservice * webservice;
    NSString * emailIdString;
}



// UI Elements
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *enterInvitationCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *PleaseEnterInviteCodeLabel;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet UITextField *firstDigitTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondDigitTextField;
@property (weak, nonatomic) IBOutlet UITextField *thirdDigitTextField;
@property (weak, nonatomic) IBOutlet UITextField *fourthDigitTextField;
@property (weak, nonatomic) IBOutlet UITextField *fifthDigitTextField;
@property (weak, nonatomic) IBOutlet UITextField *sixthDigitTextfield;

@property (weak, nonatomic) IBOutlet UIView *stackViewWithTextFields;
@property (weak, nonatomic) IBOutlet UIView * viewOverTextFields;


// Constraints

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraintOfImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthOfImageView;

@end
