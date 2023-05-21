//
//  EditProfileViewController.h
//  fasBackTechnician
//
//  Created by User on 06/10/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservice.h"
#import "UserInfo.h"
#import "Skillset.h"
#import "City.h"
#import "State.h"
#import "Country.h"

@interface EditProfileViewController : UIViewController<webProtocol,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate>
{
    Webservice * webservice;
    float width, height,xAxis, yAxis, widthForLabel, heightForLabel, offsetOfTableView;
    NSMutableArray * arrayWithList;
    UITextField * previousTExtField;
    State * stateSelected;
    Country * countrySelected;
    UIImagePickerController * imagePicker;

}

@property City * selectedCity;
@property UserInfo * userInfo;
@property UIImage * userProfileImage;

@property NSMutableArray * arrayWithSkills ,* arrayWithListOfSkills;
@property NSString * requestedFor;



@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTExtField;
@property (weak, nonatomic) IBOutlet UIButton *genderButton;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthTExtField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *alternatePhoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressLineTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;
@property (weak, nonatomic) IBOutlet UIView *viewForSkills;
@property (weak, nonatomic) IBOutlet UITextField *countryTextfield;


@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;




@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintForSkillView;

@end
