//
//  UserProfileViewController.m
//  FasBackTechnician
//
//  Created by User on 18/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "UserProfileViewController.h"
#import "PaddingLabel.h"
#import "UIColor+Customcolor.h"
#import "UIFont+PoppinsFont.h"
#import "ConstantColors.h"
#import "Constants.h"
#import <MFSideMenu.h>
#import "AppDelegate.h"
#import <UIImageView+AFNetworking.h>
#import "StoryboardsAndSegues.h"
#import "EditProfileViewController.h"

@interface UserProfileViewController ()
{
    AppDelegate * appDelegate;
}
@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;

    

  
  

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self restoreToDefaults];
    [self changesInUI];
    
    [self webserviceForUserProfile];

    self.navigationController.navigationBarHidden = YES;
    _jobInformationView.hidden = YES;
    _widthConstraintOfView.constant = 300 ;
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:IsSignedIn] isEqualToString:@"YES"]) {
        [_menuButton setImage:[UIImage imageNamed:@"sideMenuImage"] forState:UIControlStateNormal];
        _cancelButton.hidden = YES;
        _widthConstraintForEditProfileButton.constant = (width - 60);
//        _continueButton.hidden = YES;
//        _editProfileButton.wi
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [self addheaderViewForProfile];
//    _mainScrollView.contentSize = CGSizeMake(375, 1200);
//
    _logoImageView.layer.cornerRadius = _logoImageView.frame.size.width/2;
    _logoImageView.layer.masksToBounds = YES;

//    _widthConstraintOfView.constant = 315 ;
}

#pragma mark - General

-(void) restoreToDefaults
{
    
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    userInfo = [[UserInfo alloc]init];
    //    arrayWithSkills = [[NSMutableArray alloc]initWithObjects:@"Plumbing", @"Electrical Works",@"Bike Mechanic",@"Car Mechanic", nil];
    arrayWithSkills = [[NSMutableArray alloc]init];

    widthConstraintforJobInformation = -100;
    calculateBottomContraintForJobInformationViewWithOffset = 0;
    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
    
    _userNameLabel.text = @"";
    _messageLineOne.text = @"";
    _openorkOrderCountLabel.text = @"";
    _completedWorkOrderLabel.text = @"";
    _averageTimeLabel.text = @"";
    
    _firstNameLabel.text = @"";
    _lastNameLabel.text = @"";
    _genderLabel.text = @"";
    _dateOfBirthLabel.text = @"";
    _emailIdLabel.text = @"";
    _phoneNumberLabel.text = @"";
    _alternatePhoneNumberLabel.text = @"";
    _addressLineOneLabel.text = @"";
    _addressLineTwoLabel.text = @"";
    _cityLabel.text = @"";
    _stateLabel.text = @"";
    _zipCodeLabel.text = @"";
    
    
    _jobNameLabel.text = @"";
//    _experienceLabel.text= @"";

}

-(void) changesInUI
{
    _starRatingView.starImage = [UIImage imageNamed:@"Empty_Star"];
    _starRatingView.starHighlightedImage = [UIImage imageNamed:@"Full_Star"];
    _starRatingView.maxRating = 5.0;
//    _starRatingView.delegate = self;
    _starRatingView.horizontalMargin = 0;
    _starRatingView.editable=YES;
    _starRatingView.rating= 0;
    _starRatingView.displayMode=EDStarRatingDisplayAccurate;


    _editProfileButton.layer.cornerRadius = 4;
    _cancelButton.layer.cornerRadius = 4;
    _cancelButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _cancelButton.layer.borderWidth = 1.0;
    
    
    _logoImageView.layer.borderColor = [[ConstantColors coolGray]CGColor];
    _logoImageView.layer.borderWidth = 1;
    
    _logoImageView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _logoImageView.layer.shadowOpacity = 0.7;
    _logoImageView.layer.shadowRadius = 25;
    _logoImageView.layer.shadowOffset = CGSizeMake(10.0f, 10.0f);
    
    if (height == 480) {
        //
    }
    else if (height == 568)
    {
        _userNameLabel.font = [UIFont poppinsSemiBoldFontWithSize:16];
        _messageLineOne.font = [UIFont poppinsNormalFontWithSize:10];
        
        _openWorkOrderTitleLabel.font = [UIFont poppinsNormalFontWithSize:10];
        _completedWorkOrderTitleLabel.font = [UIFont poppinsNormalFontWithSize:10];
        _averageTimeTitleLabel.font = [UIFont poppinsNormalFontWithSize:10];

        _openorkOrderCountLabel.font = [UIFont poppinsNormalFontWithSize:18];
        _completedWorkOrderLabel.font = [UIFont poppinsNormalFontWithSize:18];
        _averageTimeLabel.font = [UIFont poppinsNormalFontWithSize:18];

        
        _firstNameLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _lastNameLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _genderLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _dateOfBirthLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _emailIdLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _phoneNumberLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _alternatePhoneNumberLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _addressLineOneLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _cityLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _stateLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _zipCodeLabel.font = [UIFont poppinsNormalFontWithSize:12];

        

    }
    else if (height == 667)
    {
        
    }
    else
    {
        
    }
//    [self addingSkillsSetToView];
//    [self basicInformationButtonClicked:nil];
}

-(void) addingSkillsSetToView
{
    xAxis = 0;
    yAxis =10;
    widthForLabel = 100;
    heightForLabel = 17;
    offsetOfTableView = 40;
    
    NSArray *viewsToRemove = [_viewForSkillsInJobInformationView subviews];
    for (UIView *labelToBeRemoved in viewsToRemove) {
        [labelToBeRemoved removeFromSuperview];
    }
    
    for (int i = 0; i< [arrayWithSkills count]; i++) {
        PaddingLabel* labelForEachItem = [[PaddingLabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, widthForLabel, heightForLabel)];
        Skillset * eachSkillset = [arrayWithSkills objectAtIndex:i];
        labelForEachItem.text =eachSkillset.skillName;
        labelForEachItem.tag = 2000+i;
        labelForEachItem.textColor = [ConstantColors charcoalGray];
        labelForEachItem.font = [UIFont poppinsNormalFontWithSize:12];
        labelForEachItem.backgroundColor = [UIColor ColorWithHexaString:@"F4F5F7"];
        labelForEachItem.layer.borderWidth = 0.7;
        labelForEachItem.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        [labelForEachItem sizeToFit];
        labelForEachItem.frame = CGRectMake(xAxis, yAxis, labelForEachItem.frame.size.width+10, labelForEachItem.frame.size.height+5);
        
//        if (xAxis > (width - 30) - (labelForEachItem.frame.size.width-10)) {
//            yAxis = yAxis + labelForEachItem.frame.size.height + 10;
//            xAxis = 0;
//            if (i != [arrayWithSkills count]-1) {
//            offsetOfTableView = offsetOfTableView + 40;
//            }
//        }
        [_viewForSkillsInJobInformationView addSubview:labelForEachItem];
        
        xAxis = xAxis + labelForEachItem.frame.size.width + 10;
        if (xAxis + widthForLabel > (width - 30)) {
            yAxis = yAxis + labelForEachItem.frame.size.height + 10;
            xAxis = 0;
            if (i != [arrayWithSkills count]-1) {
                offsetOfTableView = offsetOfTableView + 40;
            }

        }
    }
    _heightConstraintForSkillView.constant = offsetOfTableView;

    if (offsetOfTableView > 80) {
        widthConstraintforJobInformation = (offsetOfTableView - 80) - 100;
        calculateBottomContraintForJobInformationViewWithOffset = offsetOfTableView - ([arrayWithSkills count]*4);
    }
}

-(void) addheaderViewForProfile
{
//    headerViewForProfile = [[HeaderViewForProfile alloc]initWithFrame:CGRectMake(0, 50, width, 52)];
//    [headerViewForProfile layoutIfNeeded];
//    
//    headerViewForProfile.hidden = YES;
//    
//    [headerViewForProfile.basicInformationButton addTarget:self action:@selector(basicInformationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [headerViewForProfile.jobInformationButton addTarget:self action:@selector(jobInformationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//
//    [self.view addSubview:headerViewForProfile];
//
//    headerViewForProfile.frame =  CGRectMake(0, _mainScrollView.frame.origin.y, width, 52);
//    [self basicInformationButtonClicked:nil];

}

-(void) setValuesfromWebServiceToUIElements
{
//    _userNameLabel.text = userInfo.fullName;
//    _messageLineOne.text = userInfo.technicianDescription;
//    _openorkOrderCountLabel.text = userInfo.openWorkOrder;
//    _completedWorkOrderLabel.text = userInfo.completedWorkOrder;
//    _averageTimeLabel.text = userInfo.averageTime;
//    
//    _firstNameLabel.text = userInfo.firstName;
//    _lastNameLabel.text = userInfo.lastName;
//    _genderLabel.text = userInfo.gender;
//    _dateOfBirthLabel.text = userInfo.dateOfBirth;
//    _emailIdLabel.text = userInfo.primaryEmailAddress;
//    _phoneNumberLabel.text = userInfo.primaryMobileNumber;
//    _alternatePhoneNumberLabel.text = userInfo.secondaryMobileNumber;
//    _addressLineOneLabel.text = userInfo.addressLineOne;
//    _addressLineTwoLabel.text = userInfo.addressLineTwo;
//    _cityLabel.text = userInfo.cityName;
//    _stateLabel.text = userInfo.stateName;
//    _zipCodeLabel.text = userInfo.zipCode;
//    
//    
//    _jobNameLabel.text = userInfo.jobName;
//    _experienceLabel.text= userInfo.jobExperience;
    
    
    [self addingSkillsSetToView];
    
}

-(void) showAlertWithMessage : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark- Web service

-(void) webserviceForUserProfile

{    [appDelegate initActivityIndicatorForviewController:self];
    
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/GetTechnicianProfileDetails",[Webservice webserviceLink]];
    [webservice requestMethod:stringWithUrl withMsgType:12];
    
}

#pragma mark - UIButtonActions


- (IBAction)basicInformationButtonClicked:(id)sender {
    
    _jobInformationView.hidden = YES;
    _widthConstraintOfView.constant = 315 ;
    
    _bottomHightlightViewForJobDescriptionView.backgroundColor = [UIColor clearColor];
    _bottomHightlightViewForBasicInformationView.backgroundColor = [ConstantColors modifiedBlueColorOfFasback];

    [_basicInformationButton setTitleColor:[ConstantColors modifiedBlueColorOfFasback] forState:UIControlStateNormal];
    [_jobInformationButton setTitleColor:[ConstantColors charcoalGray] forState:UIControlStateNormal];
    
    headerViewForProfile.bottomHighlightViewForJobInformationButton.backgroundColor = [UIColor clearColor];
    headerViewForProfile.bottomHightlightViewForBasicInformationButton.backgroundColor = [ConstantColors modifiedBlueColorOfFasback];
    
    [headerViewForProfile.basicInformationButton setTitleColor:[ConstantColors modifiedBlueColorOfFasback] forState:UIControlStateNormal];
    [headerViewForProfile.jobInformationButton setTitleColor:[ConstantColors charcoalGray] forState:UIControlStateNormal];
    
    _bottomConstraintOfJobInformationView.constant = 0;
}

- (IBAction)jobInformationButtonClicked:(id)sender {
    
    _jobInformationView.hidden = NO;
    _widthConstraintOfView.constant = widthConstraintforJobInformation ;
    _bottomHightlightViewForJobDescriptionView.backgroundColor = [ConstantColors modifiedBlueColorOfFasback];
    _bottomHightlightViewForBasicInformationView.backgroundColor = [UIColor clearColor];
    
    [_basicInformationButton setTitleColor:[ConstantColors charcoalGray] forState:UIControlStateNormal];
    [_jobInformationButton setTitleColor:[ConstantColors modifiedBlueColorOfFasback] forState:UIControlStateNormal];
    
    headerViewForProfile.bottomHighlightViewForJobInformationButton.backgroundColor = [ConstantColors modifiedBlueColorOfFasback];
    headerViewForProfile.bottomHightlightViewForBasicInformationButton.backgroundColor = [UIColor clearColor];
    
    [headerViewForProfile.basicInformationButton setTitleColor:[ConstantColors charcoalGray] forState:UIControlStateNormal];
    [headerViewForProfile.jobInformationButton setTitleColor:[ConstantColors modifiedBlueColorOfFasback] forState:UIControlStateNormal];

    _bottomConstraintOfJobInformationView.constant = -315 + calculateBottomContraintForJobInformationViewWithOffset;
}

- (IBAction)menuButtonClicked:(id)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:IsSignedIn] isEqualToString:@"YES"]) {
        [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];

    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)editProfileButtonClicked:(id)sender {
    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_editProfile] sender:nil];
}

- (IBAction)cancelButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIScrollView Delegates

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 271) {
        headerViewForProfile.hidden = NO;
    }
    else
    {
        headerViewForProfile.hidden = YES;

    }
}

#pragma mark - Webservice delagate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];

    NSLog(@"%@",parsedData);
    if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
        NSDictionary * resultData = [parsedData objectForKey:@"ReturnObject"];
    
        if (resultData[@"TechnicianSummary"] != [NSNull null]) {
            NSDictionary * technicalSummaryDictionary = resultData[@"TechnicianSummary"];
            if (technicalSummaryDictionary[@"FName"] != [NSNull null]) {
                userInfo.fullName = [NSString stringWithFormat:@"%@", technicalSummaryDictionary[@"FName"] ];
                _userNameLabel.text = userInfo.fullName;
            }
            if (technicalSummaryDictionary[@"Rating"] != [NSNull null]) {
                userInfo.ratingOfTechnician = [NSString stringWithFormat:@"%@", technicalSummaryDictionary[@"Rating"] ];
                _starRatingView.rating= [userInfo.ratingOfTechnician doubleValue];

            }
            if (technicalSummaryDictionary[@"TechnicianDesc"] != [NSNull null]) {
                userInfo.technicianDescription = [NSString stringWithFormat:@"%@", technicalSummaryDictionary[@"TechnicianDesc"] ];
                _messageLineOne.text = userInfo.technicianDescription;
            }
            if (technicalSummaryDictionary[@"StatusId"] != [NSNull null]) {
                userInfo.statusId = [NSString stringWithFormat:@"%@", technicalSummaryDictionary[@"StatusId"] ];
            }
            if (technicalSummaryDictionary[@"StatusName"] != [NSNull null]) {
                userInfo.statusName = [NSString stringWithFormat:@"%@", technicalSummaryDictionary[@"StatusName"] ];
            }
            if (technicalSummaryDictionary[@"OpenWO"] != [NSNull null]) {
                userInfo.openWorkOrder = [NSString stringWithFormat:@"%@", technicalSummaryDictionary[@"OpenWO"] ];
                _openorkOrderCountLabel.text = userInfo.openWorkOrder;
            }
            if (technicalSummaryDictionary[@"CompletedWO"] != [NSNull null]) {
                userInfo.completedWorkOrder = [NSString stringWithFormat:@"%@", technicalSummaryDictionary[@"CompletedWO"] ];
                _completedWorkOrderLabel.text = userInfo.completedWorkOrder;
            }
            if (technicalSummaryDictionary[@"AverageTime"] != [NSNull null]) {
                userInfo.averageTime = [NSString stringWithFormat:@"%@", technicalSummaryDictionary[@"AverageTime"] ];
                _averageTimeLabel.text = userInfo.averageTime;
            }
        }
    
        if (resultData[@"BasicInfo"] != [NSNull null]) {
            NSDictionary * basicInfoDictionary = resultData[@"BasicInfo"];
    
            if (basicInfoDictionary[@"FName"] != [NSNull null]) {
                userInfo.firstName =  [NSString stringWithFormat:@"%@", basicInfoDictionary[@"FName"] ];
                _firstNameLabel.text = userInfo.firstName;
                
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@", basicInfoDictionary[@"FName"] ] forKey:userName];

            }
            if (basicInfoDictionary[@"LName"] != [NSNull null]) {
                userInfo.lastName = [NSString stringWithFormat:@"%@", basicInfoDictionary[@"LName"] ];
                _lastNameLabel.text = userInfo.lastName;
            }
            if (basicInfoDictionary[@"Gender"] != [NSNull null]) {
                if ([basicInfoDictionary[@"Gender"] intValue] == 1) {
                    userInfo.gender = [NSString stringWithFormat:@"Male" ];
                }
                else
                {
                    userInfo.gender = [NSString stringWithFormat:@"Female" ];
                }
                    _genderLabel.text = userInfo.gender;
                
                
            }
            if (basicInfoDictionary[@"DOB"] != [NSNull null]) {
                userInfo.dateOfBirth = [NSString stringWithFormat:@"%@", basicInfoDictionary[@"DOB"] ];
                
                NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    NSString *requestedETAString = userInfo.dateOfBirth;
                    requestedETAString = [requestedETAString stringByReplacingOccurrencesOfString:@"T" withString:@" " ];
                    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                    NSDate *yourDate = [dateFormatter dateFromString:requestedETAString];
                if (yourDate == nil) {
                    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                }
                yourDate = [dateFormatter dateFromString:requestedETAString];
                    dateFormatter.dateFormat = @"MM/dd/yyyy";
                    NSLog(@"date %@",[dateFormatter stringFromDate:yourDate]);
                    
                _dateOfBirthLabel.text = [dateFormatter stringFromDate:yourDate];
            }
            
            if (basicInfoDictionary[@"EmailP"] != [NSNull null]) {
                userInfo.primaryEmailAddress = [NSString stringWithFormat:@"%@", basicInfoDictionary[@"EmailP"] ];
                _emailIdLabel.text = userInfo.primaryEmailAddress;
            }
            if (basicInfoDictionary[@"EmailS"] != [NSNull null]) {
                userInfo.secondaryemailAddress = [NSString stringWithFormat:@"%@", basicInfoDictionary[@"EmailS"] ];
            }
            if (basicInfoDictionary[@"MobileP"] != [NSNull null]) {
                userInfo.primaryMobileNumber = [NSString stringWithFormat:@"%@", basicInfoDictionary[@"MobileP"] ];
                _phoneNumberLabel.text = userInfo.primaryMobileNumber;
            }
            if (basicInfoDictionary[@"MobileS"] != [NSNull null]) {
                userInfo.secondaryMobileNumber =[NSString stringWithFormat:@"%@", basicInfoDictionary[@"MobileS"] ];
                _alternatePhoneNumberLabel.text = userInfo.secondaryMobileNumber;
            }
            if (basicInfoDictionary[@"AddressLine1"] != [NSNull null]) {
                userInfo.addressLineOne = [NSString stringWithFormat:@"%@", basicInfoDictionary[@"AddressLine1"] ];
                _addressLineOneLabel.text = userInfo.addressLineOne;
            }
            if (basicInfoDictionary[@"AddressLine2"] != [NSNull null]) {
                userInfo.addressLineTwo = [NSString stringWithFormat:@"%@", basicInfoDictionary[@"AddressLine2"] ];
                _addressLineTwoLabel.text = userInfo.addressLineTwo;
            }
            if (basicInfoDictionary[@"CountryID"] != [NSNull null]) {
                userInfo.countryId = [NSString stringWithFormat:@"%@", basicInfoDictionary[@"CountryID"] ];
            }
            if (basicInfoDictionary[@"CountryName"] != [NSNull null]) {
                userInfo.countryName = [NSString stringWithFormat:@"%@", basicInfoDictionary[@"CountryName"] ];
                _countryLabel.text = userInfo.countryName;
            }
            if (basicInfoDictionary[@"StateID"] != [NSNull null]) {
                userInfo.stateId = [NSString stringWithFormat:@"%@", basicInfoDictionary[@"StateID"] ];
            }
            if (basicInfoDictionary[@"StateName"] != [NSNull null]) {
                userInfo.stateName = [NSString stringWithFormat:@"%@", basicInfoDictionary[@"StateName"] ];
                _stateLabel.text = userInfo.stateName;
            }
            if (basicInfoDictionary[@"CityID"] != [NSNull null]) {
                userInfo.cityId = [NSString stringWithFormat:@"%@", basicInfoDictionary[@"CityID"] ];
            }
            if (basicInfoDictionary[@"CityName"] != [NSNull null]) {
                userInfo.cityName = [NSString stringWithFormat:@"%@", basicInfoDictionary[@"CityName"] ];
                _cityLabel.text = userInfo.cityName;
            }
            if (basicInfoDictionary[@"CountyID"] != [NSNull null]) {
                userInfo.countyid = [NSString stringWithFormat:@"%@", basicInfoDictionary[@"CountyID"] ];
            }
            if (basicInfoDictionary[@"CountyName"] != [NSNull null]) {
                userInfo.countyName = [NSString stringWithFormat:@"%@", basicInfoDictionary[@"CountyName"] ];
            }
            if (basicInfoDictionary[@"ZipCode"] != [NSNull null]) {
                userInfo.zipCode = [NSString stringWithFormat:@"%@", basicInfoDictionary[@"ZipCode"] ];
                _zipCodeLabel.text = userInfo.zipCode;
            }
            if (basicInfoDictionary[@"ImgProfile"] != [NSNull null]) {
                
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

                userInfo.profileImage = [NSString stringWithFormat:@"%@", basicInfoDictionary[@"ImgProfile"] ];
                NSURLRequest * requestForImageView = [NSURLRequest requestWithURL:[NSURL URLWithString:basicInfoDictionary[@"ImgProfile"]]];
                [_logoImageView setImageWithURLRequest:requestForImageView placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                        [UIView transitionWithView:_logoImageView
                                      duration:0.3
                                       options:UIViewAnimationOptionTransitionCrossDissolve
                                    animations:^{
                                        _logoImageView.image = image;
                                        NSData *imageData = UIImageJPEGRepresentation(image, 1);
                                        
                                        // Get image path in user's folder and store file with name image_CurrentTimestamp.jpg (see documentsPathForFileName below)
                                        NSString *imagePath = [self documentsPathForFileName:[NSString stringWithFormat:@"image_%f.jpg", [NSDate timeIntervalSinceReferenceDate]]];
                                        
                                        // Write image data to user's folder
                                        [imageData writeToFile:imagePath atomically:YES];
                                        
                                        // Store path in NSUserDefaults
                                        [[NSUserDefaults standardUserDefaults] setObject:imagePath forKey:userImage];
                                        
                                        // Sync user defaults
                                        [[NSUserDefaults standardUserDefaults] synchronize];
                                        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

                                    }
                                    completion:NULL];
                }
                                               failure:NULL];
            }
        }
    
        if (resultData[@"JobInfo"] != [NSNull null]) {
            NSDictionary * jobInfoDictionary = resultData[@"JobInfo"];
            if (jobInfoDictionary[@"JobName"] != [NSNull null]) {
//                userInfo.jobName = jobInfoDictionary[@"JobName"];
//                _jobNameLabel.text = userInfo.jobName;
            }
            if (jobInfoDictionary[@"JobExperience"] != [NSNull null]) {
//                userInfo.jobExperience = jobInfoDictionary[@"JobExperience"];
//                _experienceLabel.text= userInfo.jobExperience;
            }
            if (jobInfoDictionary[@"SkillSets"] != [NSNull null]) {
                NSArray * skillsetArray = jobInfoDictionary[@"SkillSets"];
                
                NSDictionary * skillsetDictionary = skillsetArray[0];
                _jobNameLabel.text= skillsetDictionary[@"SkillName"];
                for (int i = 0; i< skillsetArray.count; i++) {
                    NSDictionary * skillsetDictionary = skillsetArray[i];
                
                    Skillset * eachSkillset = [[Skillset alloc]init];
                    eachSkillset.skillId = skillsetDictionary[@"SkillID"];
                    eachSkillset.skillName = skillsetDictionary[@"SkillName"];
                    [arrayWithSkills addObject:eachSkillset];
                }
            }
        }
        [self setValuesfromWebServiceToUIElements];
    }
    
}


-(void)errorRecieved:(NSString *)errorString withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];

    [self showAlertWithMessage:errorString];
}

- (NSString *)documentsPathForFileName:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_editProfile]]) {
        EditProfileViewController * editProfileViewController = [segue destinationViewController];
        editProfileViewController.userInfo = userInfo;
        editProfileViewController.arrayWithSkills = arrayWithSkills;
    }
}


@end
