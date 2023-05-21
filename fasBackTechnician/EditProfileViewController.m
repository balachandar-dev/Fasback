//
//  EditProfileViewController.m
//  fasBackTechnician
//
//  Created by User on 06/10/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "EditProfileViewController.h"
#import "Webservice.h"
#import "UserInfo.h"
#import "Skillset.h"
#import <EDStarRating.h>
#import "PaddingLabel.h"
#import "ConstantColors.h"
#import "UIFont+PoppinsFont.h"
#import "StoryboardsAndSegues.h"
#import "AppDelegate.h"
#import "DisplayListViewController.h"
#import "Constants.h"
#import <MFSideMenu.h>
#import "StringHandling.h"
@interface EditProfileViewController ()
{
    AppDelegate * appDelegate;
}
@end

@implementation EditProfileViewController

static NSInteger const FIRST_NAME_TEXTFIELD_TAG = 401;
static NSInteger const LAST_NAME_TEXTFIELD_TAG = 402;
static NSInteger const PHONE_TEXTFIELD_TAG = 403;
static NSInteger const ALTERNATE_PHONE_TEXTFIELD_TAG = 404;
static NSInteger const ADDRESS_LINE_TEXTFIELD_TAG = 405;
static NSInteger const CITY_TEXTFIELD_TAG = 406;
static NSInteger const STATE_TEXTFIELD_TAG = 407;
static NSInteger const COUNTRY_TEXTFIELD_TAG = 408;
static NSInteger const ZIPCODE_TEXTFIELD_TAG = 409;

static NSInteger const WEBSERVICE_FOR_STATES_TAG = 1001;
static NSInteger const WEBSERVICE_FOR_SKILLSETS_TAG = 1002;
static NSInteger const WEBSERVICE_FOR_UPDATE_PROFILE_TAG = 1003;
static NSInteger const WEBSERVICE_FOR_COUNTRY_TAG = 1004;



- (void)viewDidLoad {
    [super viewDidLoad];
    [self restoreToDefaults];
     [self chngsInUI];
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews
{
    [self addingSkillsSetToView];
    _userImageView.layer.cornerRadius = _userImageView.frame.size.width/2;
    _userImageView.layer.masksToBounds = YES;

}


#pragma mark - General

-(void) restoreToDefaults
{
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;

    _firstNameTextField.tag = FIRST_NAME_TEXTFIELD_TAG;
    _lastNameTExtField.tag = LAST_NAME_TEXTFIELD_TAG;
    _phoneNumberTextField.tag = PHONE_TEXTFIELD_TAG;
    _alternatePhoneNumberTextField.tag = ALTERNATE_PHONE_TEXTFIELD_TAG;
    _addressLineTextField.tag = ADDRESS_LINE_TEXTFIELD_TAG;
    _cityTextField.tag = CITY_TEXTFIELD_TAG;
    _stateTextField.tag = STATE_TEXTFIELD_TAG;
    _zipCodeTextField.tag = ZIPCODE_TEXTFIELD_TAG;
    _countryTextfield.tag = COUNTRY_TEXTFIELD_TAG;
    
    _firstNameTextField.text = _userInfo.firstName;
    _lastNameTExtField.text = _userInfo.lastName;
    
    [_genderButton setTitle:_userInfo.gender forState:UIControlStateNormal];

    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    NSString *requestedETAString = _userInfo.dateOfBirth;
    requestedETAString = [requestedETAString stringByReplacingOccurrencesOfString:@"T" withString:@" " ];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SS";
    NSDate *yourDate = [dateFormatter dateFromString:requestedETAString];
    if (yourDate == nil) {
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    yourDate = [dateFormatter dateFromString:requestedETAString];

    dateFormatter.dateFormat = @"MM/dd/yyyy";
    NSLog(@"date %@",[dateFormatter stringFromDate:yourDate]);
    
    _dateOfBirthTExtField.text = [dateFormatter stringFromDate:yourDate];

    stateSelected = [[State alloc]init];
    _selectedCity = [[City alloc]init];
    countrySelected = [[Country alloc]init];
    
    _userNameLabel.text = [NSString stringWithFormat:@"%@ %@",_userInfo.firstName,_userInfo.lastName];
    
    _emailTextField.text  = _userInfo.primaryEmailAddress;
    _phoneNumberTextField.text = _userInfo.primaryMobileNumber;
    _alternatePhoneNumberTextField.text = _userInfo.secondaryMobileNumber;
    _addressLineTextField.text = _userInfo.addressLineOne;
    _cityTextField.text = _userInfo.cityName;
    _stateTextField.text = _userInfo.stateName;
    _zipCodeTextField.text =_userInfo.zipCode;
    _countryTextfield.text = _userInfo.countryName;
    
    _selectedCity.cityName = _userInfo.cityName;
    _selectedCity.cityId = _userInfo.cityId;
    stateSelected.stateId = _userInfo.stateId;
    stateSelected.stateName = _userInfo.stateName;
    
    countrySelected.countryName = _userInfo.countryName;
    countrySelected.countryId = _userInfo.countryId;
    
    
    arrayWithList= [[NSMutableArray alloc]init];
    _arrayWithListOfSkills = [[NSMutableArray alloc]init];
    
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:userImage] != [NSNull null]) {
        NSString *imagePath = [[NSUserDefaults standardUserDefaults] objectForKey:userImage];
        if (imagePath) {
            _userImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
        }
    }
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(skillViewTapped:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [_viewForSkills addGestureRecognizer:tapRecognizer];
    
    
    UITapGestureRecognizer *tapRecognizerForImagePicker = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
    tapRecognizerForImagePicker.numberOfTapsRequired = 1;
    [_userImageView addGestureRecognizer:tapRecognizerForImagePicker];
    
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;

    
    [self webserviceToGetListOfSkills];
}

-(void) chngsInUI
{
    _updateButton.layer.cornerRadius = 4;
    _cancelButton.layer.cornerRadius = 4;
    _cancelButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _cancelButton.layer.borderWidth = 1.0;
    
   
    _userImageView.layer.borderColor = [[ConstantColors coolGray]CGColor];
    _userImageView.layer.borderWidth = 1;
    _userImageView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _userImageView.layer.shadowOpacity = 0.7;
    _userImageView.layer.shadowRadius = 5;
    _userImageView.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    
    if (height == 480) {
        //
    }
    else if (height == 568)
    {
        _userNameLabel.font = [UIFont poppinsSemiBoldFontWithSize:16];
//        _messageLineOne.font = [UIFont poppinsNormalFontWithSize:10];
//        
//        _openWorkOrderTitleLabel.font = [UIFont poppinsNormalFontWithSize:10];
//        _completedWorkOrderTitleLabel.font = [UIFont poppinsNormalFontWithSize:10];
//        _averageTimeTitleLabel.font = [UIFont poppinsNormalFontWithSize:10];
        
//        _openorkOrderCountLabel.font = [UIFont poppinsNormalFontWithSize:18];
//        _completedWorkOrderLabel.font = [UIFont poppinsNormalFontWithSize:18];
//        _averageTimeLabel.font = [UIFont poppinsNormalFontWithSize:18];
        
        
        _firstNameTextField.font = [UIFont poppinsNormalFontWithSize:12];
        _lastNameTExtField.font = [UIFont poppinsNormalFontWithSize:12];
        _genderButton.titleLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _dateOfBirthTExtField.font = [UIFont poppinsNormalFontWithSize:12];
        _emailTextField.font = [UIFont poppinsNormalFontWithSize:12];
        _phoneNumberTextField.font = [UIFont poppinsNormalFontWithSize:12];
        _alternatePhoneNumberTextField.font = [UIFont poppinsNormalFontWithSize:12];
        _addressLineTextField.font = [UIFont poppinsNormalFontWithSize:12];
        _cityTextField.font = [UIFont poppinsNormalFontWithSize:12];
        _stateTextField.font = [UIFont poppinsNormalFontWithSize:12];
        _zipCodeTextField.font = [UIFont poppinsNormalFontWithSize:12];
        
        
        
    }
    else if (height == 667)
    {
        
    }
    else
    {
        
    }

}

-(void) addingSkillsSetToView
{
    
    for (UIView * eachSubvies in _viewForSkills.subviews) {
        [eachSubvies removeFromSuperview];
    }
    xAxis = 0;
    yAxis =10;
    widthForLabel = 100;
    heightForLabel = 17;
    offsetOfTableView = 40;
    for (int i = 0; i< [_arrayWithSkills count]; i++) {
        PaddingLabel* labelForEachItem = [[PaddingLabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, widthForLabel, heightForLabel)];
        Skillset * eachSkillset = [_arrayWithSkills objectAtIndex:i];
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
        [_viewForSkills addSubview:labelForEachItem];
        
        xAxis = xAxis + labelForEachItem.frame.size.width + 10;
        if (xAxis + widthForLabel > (width - 30)) {
            yAxis = yAxis + labelForEachItem.frame.size.height + 10;
            xAxis = 0;
            if (i != [_arrayWithSkills count]-1) {
                offsetOfTableView = offsetOfTableView + 40;
            }
        }
    }
    _heightConstraintForSkillView.constant = offsetOfTableView;
    
//    if (offsetOfTableView > 80) {
//        widthConstraintforJobInformation = (offsetOfTableView - 80) - 100;
//        calculateBottomContraintForJobInformationViewWithOffset = offsetOfTableView - ([arrayWithSkills count]*4);
//    }
}

-(void) showAlertWithMessage : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Webservice

-(void) webserviceToGetStatesWithCityIdString : (NSString *) cityIdString
{
    [appDelegate initActivityIndicatorForviewController:self];
    
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/Common/GetStatesByCityID/%@",[Webservice webserviceLink],cityIdString];
    [webservice requestMethod:stringWithUrl withMsgType:WEBSERVICE_FOR_STATES_TAG];
    
}

-(void) webserviceToGetCountryWithCityIdString : (NSString *) cityIdString
{
    [appDelegate initActivityIndicatorForviewController:self];
    
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/Common/GetCountriesByCityID/%@",[Webservice webserviceLink],cityIdString];
    [webservice requestMethod:stringWithUrl withMsgType:WEBSERVICE_FOR_COUNTRY_TAG];
    
}

-(void) webserviceToGetListOfSkills
{
    [appDelegate initActivityIndicatorForviewController:self];
    
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/Common/GetSkillSets",[Webservice webserviceLink]];
    [webservice requestMethod:stringWithUrl withMsgType:WEBSERVICE_FOR_SKILLSETS_TAG];
    
}
-(void) webserviceToUpdateProfile
{
    [appDelegate initActivityIndicatorForviewController:self];
    

    
//       {
//        "FName": "sample string 1",
//        "LName": "sample string 2",
//        "Gender": 1,
//        "DOB": "2017-10-10T03:06:48.9818818-04:00",
//        "EmailP": "sample string 3",
//        "EmailS": "sample string 4",
//        "MobileP": "sample string 5",
//        "MobileS": "sample string 6",
//        "AddressLine1": "sample string 7",
//        "AddressLine2": "sample string 8",
//        "CountryID": 1,
//        "CountryName": "sample string 9",
//        "StateID": 1,
//        "StateName": "sample string 10",
//        "CountyID": 1,
//        "CountyName": "sample string 11",
//        "CityID": 1,
//        "CityName": "sample string 12",
//        "ZipCode": "sample string 13",
//        "ImgProfile": "sample string 14",
//        "ProfileImage": {
//            "ImgName": "sample string 1",
//            "ImgBase64Data": "sample string 2"
//        },
//        "JobName": "sample string 15",
//        "JobExperience": 1.1,
//        "SkillSets": [
//                      {
//                          "SkillID": 1,
//                          "SkillName": "sample string 2"
//                      },
//                      {
//                          "SkillID": 1,
//                          "SkillName": "sample string 2"
//                      }
//                      ]
//    }
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
//    NSDate *yourDate = ;
    dateFormatter.dateFormat = @"MM-dd-yyyy HH:mm:ss";
//    NSLog(@"date %@",[dateFormatter stringFromDate:yourDate]);
//    
//    NSString * dateString = [dateFormatter stringFromDate:yourDate];
    
    
    NSMutableDictionary * postDataDictionary = [[NSMutableDictionary alloc]init];
    [postDataDictionary setValue:_firstNameTextField.text forKey:@"FName"];
    [postDataDictionary setValue:_lastNameTExtField.text forKey:@"LName"];
    if ([_genderButton.titleLabel.text isEqualToString:@"Male"]) {
        [postDataDictionary setObject:@"1" forKey:@"Gender"];
    }
    else
    {
        [postDataDictionary setObject:@"2" forKey:@"Gender"];
    }
    [postDataDictionary setValue:_userInfo.dateOfBirth forKey:@"DOB"];
    [postDataDictionary setValue:_phoneNumberTextField.text forKey:@"MobileP"];
    [postDataDictionary setValue:_alternatePhoneNumberTextField.text forKey:@"MobileS"];
    [postDataDictionary setValue:_addressLineTextField.text forKey:@"AddressLine1"];
    [postDataDictionary setValue:@"" forKey:@"CountryID"];
    [postDataDictionary setValue:stateSelected.stateId forKey:@"StateID"];
    [postDataDictionary setValue:stateSelected.stateName forKey:@"StateName"];
    [postDataDictionary setValue:countrySelected.countryId forKey:@"CountryID"];
    [postDataDictionary setValue:countrySelected.countryName forKey:@"CountryName"];
    [postDataDictionary setValue:_selectedCity.cityId forKey:@"CityID"];
    [postDataDictionary setValue:_selectedCity.cityName forKey:@"CityName"];
    [postDataDictionary setValue:_zipCodeTextField.text forKey:@"ZipCode"];
    [postDataDictionary setValue:_emailTextField.text forKey:@"EmailP"];
    [postDataDictionary setValue:_userInfo.profileImage forKey:@"ImgProfile"];
    
    NSString * imageProfileString = [UIImagePNGRepresentation(_userImageView.image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSMutableDictionary * imageDictionary = [[NSMutableDictionary alloc]init];
    [imageDictionary setValue:imageProfileString forKey:@"ImgBase64Data"];
    [imageDictionary setValue:[NSString stringWithFormat:@"Image%@",[NSDate date]] forKey:@"ImgName"];

    [postDataDictionary setValue:imageDictionary forKey:@"ProfileImage"];

    NSMutableArray * arrayOfSkillsToBePosted = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<_arrayWithSkills.count; i++) {
        Skillset * skilSet = [_arrayWithSkills objectAtIndex:i];
        NSMutableDictionary * dictionaryToSkills = [[NSMutableDictionary alloc]init];
        [dictionaryToSkills setObject:skilSet.skillId forKey:@"SkillID"];
        [dictionaryToSkills setObject:skilSet.skillName forKey:@"SkillName"];
        
        [arrayOfSkillsToBePosted addObject:dictionaryToSkills];
        
    }
    [postDataDictionary setValue:arrayOfSkillsToBePosted forKey:@"SkillSets"];
    NSLog(@"postDataDictionary%@",postDataDictionary);
    
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/UpdateTechnicianInfo",[Webservice webserviceLink]];
    [webservice requestMethodForPost:stringWithUrl withData:postDataDictionary withTag:WEBSERVICE_FOR_UPDATE_PROFILE_TAG];
}


#pragma mark - Button Actions

#pragma mark - UIElement Actions

-(void)imageViewTapped:(UITapGestureRecognizer*)sender {
    
    UIAlertController *alertActionSheetForImage = [UIAlertController alertControllerWithTitle:@"Select option:" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertActionSheetForImage addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (! [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self showAlertWithMessage:@"Camera feature not available"];
        }
        else
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:NULL];
        }
        // Code for Cam
    }]];
    [alertActionSheetForImage addAction:[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:NULL];
        //Code for Gallery
    }]];
    [alertActionSheetForImage addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alertActionSheetForImage setModalPresentationStyle:UIModalPresentationPopover];
    
    UIPopoverPresentationController *popPresenter = [alertActionSheetForImage popoverPresentationController];
    popPresenter.sourceView = _userImageView;
    popPresenter.sourceRect = _userImageView.bounds; // You can set position of popover
    [self presentViewController:alertActionSheetForImage animated:TRUE completion:nil];
}


- (IBAction)bakButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)cancelButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)updateButtonClicke:(id)sender {
    
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];

    
    if(_firstNameTextField.text.length == 0)
    {
        [self showAlertWithMessage:@"Please enter a valid first name"];
    }
    else if (![StringHandling haveOnlyAlphabets:_firstNameTextField.text WithSpecialCharacter:@"."])
    {
        [self showAlertWithMessage:@"Please enter a valid first name"];
    }
    else if(_lastNameTExtField.text.length == 0)
    {
        [self showAlertWithMessage:@"Please enter a valid last name"];
    }
    else if (![StringHandling haveOnlyAlphabets:_lastNameTExtField.text WithSpecialCharacter:@"-"])
    {
        [self showAlertWithMessage:@"Please enter a valid last name"];
    }
    else if (_phoneNumberTextField.text.length == 0 )
    {
        [self showAlertWithMessage:@"Please enter a valid phone number, it shouldn't exceed ten digits"];
    }
    else if (![StringHandling isValidPhoneNumber:_phoneNumberTextField.text])
    {
        [self showAlertWithMessage:@"Please enter a valid phone number, it shouldn't exceed 10 digits"];
    }
    else if ([StringHandling removePunctuationFromPhoneNumberString:_phoneNumberTextField.text].length != 10)
    {
        NSLog(@"%@",[StringHandling removePunctuationFromPhoneNumberString:_phoneNumberTextField.text]);
        [self showAlertWithMessage:@"Please enter a valid phone number, it shouldn't exceed ten digits"];
    }
    else if ([_phoneNumberTextField.text rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    {
        [self showAlertWithMessage:@"Please enter a valid phone number, it shouldn't exceed ten digits"];
    }
//    else if (_alternatePhoneNumberTextField.text.length == 0)
//    {
//        [self showAlertWithMessage:@"Please enter a valid alternate phone number"];
//    }
    else if ([StringHandling removePunctuationFromPhoneNumberString:_alternatePhoneNumberTextField.text].length > 10)
    {
        [self showAlertWithMessage:@"Please enter a valid alternate phone number"];
    }
    else if (![StringHandling isValidPhoneNumber:_alternatePhoneNumberTextField.text])
    {
        [self showAlertWithMessage:@"Please enter a valid alternate phone number, it shouldn't exceed 10 digits"];
    }
    else if (_addressLineTextField.text.length == 0)
    {
        [self showAlertWithMessage:@"Please enter a valid address"];
    }
    else if (![StringHandling validAddress:_addressLineTextField.text])
    {
        [self showAlertWithMessage:@"Please enter a valid address"];
    }
    else if (_cityTextField.text.length == 0)
    {
        [self showAlertWithMessage:@"Please select city"];
    }
    else if (_stateTextField.text.length == 0)
    {
        [self showAlertWithMessage:@"Please select State"];
    }
    else if (_zipCodeTextField.text.length == 0 || _zipCodeTextField.text.length != 5)
    {
        [self showAlertWithMessage:@"Please enter a valid Zip code, it shouldnt exceed five digits"];
    }
    else
    {
    [self webserviceToUpdateProfile];
    }
}

//-(NSString *) removePunctuationFromPhoneNumberString : (NSString *) stringWithPunctuations
//{
//    NSCharacterSet *illegalCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
//    NSString *phoneNumberRemovingPunctuations = [[stringWithPunctuations componentsSeparatedByCharactersInSet:illegalCharSet] componentsJoinedByString:@""];
//    return phoneNumberRemovingPunctuations;
//}
//
//-(BOOL) haveOnlyAlphabets : (NSString *) stringWithPunctuations
//{
//    NSCharacterSet *characterSetWithStrings = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"] invertedSet];
//
//    NSRange r = [stringWithPunctuations rangeOfCharacterFromSet:characterSetWithStrings];
//    if (r.location != NSNotFound) {
//        NSLog(@"the string contains illegal characters");
//        return NO;
//    }
//    return YES;
//}
//
//-(BOOL) validAddress : (NSString *) stringWithPunctuations
//{
//    NSCharacterSet *characterSetWithStrings = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-/@, "] invertedSet];
//    
//    NSRange r = [stringWithPunctuations rangeOfCharacterFromSet:characterSetWithStrings];
//    if (r.location != NSNotFound) {
//        NSLog(@"the string contains illegal characters");
//        return NO;
//    }
//    return YES;
//}

-(void)skillViewTapped:(UITapGestureRecognizer*)sender {
    arrayWithList = _arrayWithListOfSkills;
    _requestedFor = SKILLS;
    [self performSegueWithIdentifier:[StoryboardsAndSegues SegueToDisplayList] sender:nil];
}

#pragma mark - UITextField Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [previousTExtField resignFirstResponder];
    return YES;
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _stateTextField) {
        [textField resignFirstResponder];
        _requestedFor = STATE;
        [self performSegueWithIdentifier:[StoryboardsAndSegues SegueToDisplayList] sender:nil];
    }
    else if (textField == _cityTextField) {
        [textField resignFirstResponder];
        _requestedFor = CITY;
        [self performSegueWithIdentifier:[StoryboardsAndSegues SegueToDisplayList] sender:nil];
    }
    else
    {
        
    }
    previousTExtField = textField;

}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [previousTExtField resignFirstResponder];
}


#pragma mark - UIImagepicker View Delegates

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    _userImageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


#pragma mark - Webservice delagate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];
        NSLog(@"%@",parsedData);
    if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {

    if (msgType == WEBSERVICE_FOR_STATES_TAG) {
            if ([parsedData objectForKey:@"ReturnObject"] != [NSNull null]) {
                NSArray * arrayWithStateList =  [parsedData objectForKey:@"ReturnObject"];
                NSDictionary * dictionaryforEachState = [arrayWithStateList objectAtIndex:0];
                stateSelected = [[State alloc]init];
                stateSelected.stateId = dictionaryforEachState[@"StateID"];
                stateSelected.stateName = dictionaryforEachState[@"StateName"];

                _stateTextField.text = stateSelected.stateName;
            }
        }
    else if (msgType == WEBSERVICE_FOR_COUNTRY_TAG) {
        if ([parsedData objectForKey:@"ReturnObject"] != [NSNull null]) {
            NSArray * arrayWithStateList =  [parsedData objectForKey:@"ReturnObject"];
            NSDictionary * dictionaryforEachState = [arrayWithStateList objectAtIndex:0];
            countrySelected = [[Country alloc]init];
            countrySelected.countryId = dictionaryforEachState[@"CountryID"];
            countrySelected.countryName = dictionaryforEachState[@"CountryName"];
            
            _countryTextfield.text = countrySelected.countryName;
        }
        [self webserviceToGetStatesWithCityIdString:_selectedCity.cityId];
    }

    else if (msgType == WEBSERVICE_FOR_SKILLSETS_TAG)
    {
        if ([parsedData objectForKey:@"ReturnObject"] != [NSNull null]) {
            NSArray * arrayWithSkillList =  [parsedData objectForKey:@"ReturnObject"];
            for (int i = 0; i<arrayWithSkillList.count; i++) {
            NSDictionary * dictionaryforEachSkill = [arrayWithSkillList objectAtIndex:i];
            Skillset * eachSkillSet = [[Skillset alloc]init];
            eachSkillSet.skillId = dictionaryforEachSkill[@"SkillID"];
            eachSkillSet.skillName = dictionaryforEachSkill[@"SkillName"];
            
            [_arrayWithListOfSkills addObject:eachSkillSet];
            }
        }
    }
    else
    {
        if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:IsSignedIn] isEqualToString:@"YES"]) {
            [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:IsSignedIn];
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
        }
    }
    }
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:[StoryboardsAndSegues SegueToDisplayList]]) {
        DisplayListViewController * displayListViewController = segue.destinationViewController;
        if ([_requestedFor isEqualToString:SKILLS]) {
        displayListViewController.arrayWithReasons = arrayWithList;
        displayListViewController.arrayWithSkillsSelected = _arrayWithSkills;
        }
        displayListViewController.requestedFor = _requestedFor;
        displayListViewController.isEditProfile = YES;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)unwindToEditProfileViewController:(UIStoryboardSegue *)segue {
    if ([_requestedFor isEqualToString:CITY]) {
        NSLog(@"%@",_selectedCity);
        _cityTextField.text = _selectedCity.cityName;
        [self webserviceToGetCountryWithCityIdString:_selectedCity.cityId];
    }
    else if ([_requestedFor isEqualToString:STATE])
    {
        
    }
    else if ([_requestedFor isEqualToString:SKILLS])
    {
        NSLog(@"selected skills %@",_arrayWithSkills);
        [self addingSkillsSetToView];
    }
    
    
//    [_dateButton setTitle:[NSString stringWithFormat:@"  %@", _rejectReasonSelected.reason ] forState:UIControlStateNormal];
    
}

@end
