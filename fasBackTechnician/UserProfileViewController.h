//
//  UserProfileViewController.h
//  FasBackTechnician
//
//  Created by User on 18/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderViewForProfile.h"
#import "customDatePickerView.h"
#import "Webservice.h"
#import "UserInfo.h"
#import "Skillset.h"
#import <EDStarRating.h>


@interface UserProfileViewController : UIViewController<UIScrollViewDelegate,webProtocol>
{
    HeaderViewForProfile * headerViewForProfile;
    float width, height,xAxis, yAxis, widthForLabel, heightForLabel, offsetOfTableView;
    NSMutableArray * arrayWithSkills;
    int widthConstraintforJobInformation, calculateBottomContraintForJobInformationViewWithOffset;
    Webservice * webservice;
    UserInfo * userInfo;
}



//UI elements
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starRatingImageView;
@property (weak, nonatomic) IBOutlet UILabel *messageLineOne;
@property (weak, nonatomic) IBOutlet UILabel *openorkOrderCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *completedWorkOrderLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageTimeLabel;


@property (weak, nonatomic) IBOutlet UIView *bottomHightlightViewForBasicInformationView;
@property (weak, nonatomic) IBOutlet UIView *bottomHightlightViewForJobDescriptionView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraintOfView;
@property (weak, nonatomic) IBOutlet UIView *jobInformationView;
@property (weak, nonatomic) IBOutlet UIView *viewForSkillsInJobInformationView;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UIButton *basicInformationButton;
@property (weak, nonatomic) IBOutlet UIButton *jobInformationButton;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;


@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirthLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *alternatePhoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLineOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLineTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *zipCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;

@property (weak, nonatomic) IBOutlet UILabel *jobNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *experienceLabel;
@property (weak, nonatomic) IBOutlet EDStarRating *starRatingView;

@property (weak, nonatomic) IBOutlet UILabel *openWorkOrderTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *completedWorkOrderTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *averageTimeTitleLabel;


//Constraints

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintForSkillView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraintForEditProfileButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintOfJobInformationView;

@end
