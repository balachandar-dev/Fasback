//
//  ConfirmWorkOrderViewController.m
//  fasBackTechnician
//
//  Created by User on 22/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "ConfirmWorkOrderViewController.h"
#import "StoryboardsAndSegues.h"
#import "ConstantColors.h"
#import <MFSideMenu.h>
#import "DashboardViewController.h"
#import "CheckoutViewController.h"
#import "AppDelegate.h"
#import "AcceptRejectJobViewController.h"
#import "GetLocationViewController.h"
#import "HoldAndDiscardWorkOrderViewController.h"
#import "UIFont+PoppinsFont.h"
#import "ViewSensorFactViewController.h"
#import <UIImageView+AFNetworking.h>

@interface ConfirmWorkOrderViewController ()
{
    AppDelegate * appDelegate;
}
@end

@implementation ConfirmWorkOrderViewController

static NSInteger const WEBSERVICE_CHECKIN_TAG = 1101;
static NSInteger const WEBSERVICE_REACHED_TAG = 1102;
static NSInteger const WEBSERVICE_GET_WORK_ORDER_DETAILS_TAG = 1103;

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
    self.menuContainerViewController.panMode = MFSideMenuPanModeNone;
}

-(void)viewDidLayoutSubviews
{
    _logoImageView.layer.cornerRadius = _logoImageView.frame.size.width/2;
    _logoImageView.layer.masksToBounds = YES;
}


#pragma mark - General

-(void) restoreToDefaults
{
    customerLocation = [[StepsInGoogleMap alloc]init];

    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    workPrderInfo = [[WorkOrderInfo alloc]init];
    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
    
    isREachedWorkOrderCalled = NO;
    
    _headerLabel.text = @"";
    _workOrderNumberLabel.text = @"";
    _workOrderTypeLabel.text = @"";
    _requestedOnLabel.text = @"";
    _requestedEtaLabel.text = @"";
    _locationAddressLabel.text = @"";
    _issueLabel.text = @"";
    _workOrderName.text = @"";
    _remainingTimeLabel.text = @"";

    UIViewController *previousViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    
    if (![previousViewController isKindOfClass:[AcceptRejectJobViewController class]]) {
        if ([_workStatus isEqualToString:@"9"]) {
            //
        }
       
            [self webserviceToWorkOrderInfo];
        
    }
    else
    {
    [self setValuesToUIElementsFromWebservice];
    }

}

-(void) changesInUI
{
//    _placeholederLabelForLogoImage.text =@"";
    _logoImageView.image = nil;
//    _placeholederLabelForLogoImage.hidden = YES;
    _logoImageView.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _logoImageView.layer.borderWidth = 0.4;
    
    _mainScrollView.contentSize = CGSizeMake(width,  2000);
    _checkInButton.layer.cornerRadius = 4;
    _discardButton.layer.cornerRadius = 4;
    _discardButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _discardButton.layer.borderWidth = 1.0;
    
       
    if ([_workStatus isEqualToString:@"13"] || [_workStatus isEqualToString:@"Completed"] || [_workStatus isEqualToString:@"8"] || [_workStatus isEqualToString:@"Rejected"] || [_workStatus isEqualToString:@"Cancelled"] || [_workStatus isEqualToString:@"9"] || [_workStatus isEqualToString:@"Discard"] || [_workStatus isEqualToString:@"16"] || [_workStatus isEqualToString:@"Done"] || [_workStatus isEqualToString:@"6"] ||  [_workStatus isEqualToString:@"17"] ) {
        _bottomConstraintOfScrollView.constant = 0;
        _checkInButton.hidden = YES;
        _discardButton.hidden = YES;
        _topConstraintContactPersonViewAndEndingTime.constant = 15;
        _backgroundViewForHeaderButtons.hidden = YES;
    }
    else if([_workStatus isEqualToString:@"2"] || [_workStatus isEqualToString:@"Accepted"] || [_workStatus isEqualToString:@"27"] || [_workStatus isEqualToString:@"OnHold"])
    {
        [_checkInButton setTitle:@"Reached" forState:UIControlStateNormal] ;
    }
    
    if (height == 480) {
        //
    }
    else if (height == 568)
    {
        _workOrderName.font = [UIFont poppinsSemiBoldFontWithSize:16];
        _remainingTimeLabel.font = [UIFont poppinsNormalFontWithSize:14];
//        _callCustomerButton.titleLabel.font = [UIFont poppinsNormalFontWithSize:11];
//        _viewLocationButton.titleLabel.font = [UIFont poppinsNormalFontWithSize:11];
        _workOrderNumberLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _workOrderTypeLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _requestedEtaLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _requestedOnLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _locationAddressLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _issueLabel.font = [UIFont poppinsNormalFontWithSize:12];
    }
    else if (height == 667)
    {
        
    }
    else
    {
        
    }
}

-(void) showAlertWithMessage : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)setValuesToUIElementsFromWebservice
{
    NSLog(@"_dictionaryWithWorkOrderDetails %@",_dictionaryWithWorkOrderDetails);
    contactAddressReceived = @"";
    if (_dictionaryWithWorkOrderDetails[@"ImgUrl"] != [NSNull null]) {
        workPrderInfo.profileImageString =_dictionaryWithWorkOrderDetails[@"ImgUrl"];
        [_logoImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_dictionaryWithWorkOrderDetails[@"ImgUrl"]]]
                              placeholderImage:nil
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           
                                           // do image resize here
                                           
                                           // then set image view
                                           if (image != nil) {
                                               _logoImageView.image = image;
                                           }
                                           else
                                           {
                                               if (_dictionaryWithWorkOrderDetails[@"CustomerLegalName"] != [NSNull null]) {
                                                   NSString * firstCharacterOfCustomerName = [_dictionaryWithWorkOrderDetails[@"CustomerLegalName"] substringToIndex:1];
//                                                   _placeholederLabelForLogoImage.text =firstCharacterOfCustomerName;
                                               }
                                           }
                                       }
                                       failure:nil];
    }
    else
    {
//        if (workOrderDictionary[@"CustomerLegalName"] != [NSNull null]) {
//            NSString * firstCharacterOfCustomerName = [workPrderInfo.customerLegalName substringToIndex:1];
//            _placeholederLabelForLogoImage.text =firstCharacterOfCustomerName;
//        }
    }
    if (_dictionaryWithWorkOrderDetails[@"CustomerId"] != [NSNull null]) {
        workPrderInfo.customerId =_dictionaryWithWorkOrderDetails[@"CustomerId"];
    }
    if (_dictionaryWithWorkOrderDetails[@"CustomerLegalName"] != [NSNull null]) {
        workPrderInfo.customerLegalName =_dictionaryWithWorkOrderDetails[@"CustomerLegalName"];
    }
    if (_dictionaryWithWorkOrderDetails[@"EndingIn"] != [NSNull null]) {
        workPrderInfo.remainingTime =_dictionaryWithWorkOrderDetails[@"EndingIn"];
    }
    if (_dictionaryWithWorkOrderDetails[@"WorkOrderNo"] != [NSNull null]) {
        workPrderInfo.workOrderNumber =_dictionaryWithWorkOrderDetails[@"WorkOrderNo"];
        _headerLabel.text = workPrderInfo.workOrderNumber;
    }
    if (_dictionaryWithWorkOrderDetails[@"WOId"] != [NSNull null]) {
        workPrderInfo.workOrderId =_dictionaryWithWorkOrderDetails[@"WOId"];
    }
    if (_dictionaryWithWorkOrderDetails[@"RequestedETA"] != [NSNull null]) {
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        NSString *requestedETAString = _dictionaryWithWorkOrderDetails[@"RequestedETA"];
        requestedETAString = [requestedETAString stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *yourDate = [dateFormatter dateFromString:requestedETAString];
        if (yourDate == nil) {
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        }
        yourDate = [dateFormatter dateFromString:requestedETAString];

        dateFormatter.dateFormat = @"dd MMM hh:mm a";
        NSLog(@"date %@",[dateFormatter stringFromDate:yourDate]);
        workPrderInfo.requestedEtaId =[dateFormatter stringFromDate:yourDate];
    }
    if (_dictionaryWithWorkOrderDetails[@"ContactPersonName"] != [NSNull null]) {
        workPrderInfo.contactPersonName =_dictionaryWithWorkOrderDetails[@"ContactPersonName"];
    }
    if (_dictionaryWithWorkOrderDetails[@"ContactEmailP"] != [NSNull null]) {
        workPrderInfo.contactEmail =_dictionaryWithWorkOrderDetails[@"ContactEmailP"];
    }
    if (_dictionaryWithWorkOrderDetails[@"ContactMobileP"] != [NSNull null]) {
        workPrderInfo.contactPhoneNumber =_dictionaryWithWorkOrderDetails[@"ContactMobileP"];
    }
    if (_dictionaryWithWorkOrderDetails[@"LocationLatitudeCustomer"] != [NSNull null]) {
        workPrderInfo.locationLatitudeCustomer =_dictionaryWithWorkOrderDetails[@"LocationLatitudeCustomer"];
        customerLocation.latitudeString = workPrderInfo.locationLatitudeCustomer;
        customerLocation.longitudeString = workPrderInfo.locationLongitudeCustomer;

    }
    if (_dictionaryWithWorkOrderDetails[@"LocationLongitudeCustomer"] != [NSNull null]) {
        workPrderInfo.locationLongitudeCustomer =_dictionaryWithWorkOrderDetails[@"LocationLongitudeCustomer"];
    }
    if (_dictionaryWithWorkOrderDetails[@"WorkOrderType"] != [NSNull null]) {
        workPrderInfo.workOrderType =_dictionaryWithWorkOrderDetails[@"WorkOrderType"];
    }
    if (_dictionaryWithWorkOrderDetails[@"RequestedOn"] != [NSNull null]) {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        NSString *requestedETAString = _dictionaryWithWorkOrderDetails[@"RequestedOn"];
        requestedETAString = [requestedETAString stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SS";
        NSDate *yourDate = [dateFormatter dateFromString:requestedETAString];
        if (yourDate == nil) {
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        }
        yourDate = [dateFormatter dateFromString:requestedETAString];

        dateFormatter.dateFormat = @"dd MMM hh:mm a";
        NSLog(@"date %@",[dateFormatter stringFromDate:yourDate]);
        
        
        workPrderInfo.requestedOn =[dateFormatter stringFromDate:yourDate];
    }
    //        if (_dictionaryWithWorkOrderDetails[@"ImgProfile"] != [NSNull null]) {
    //        workPrderInfo.locationAddress =_dictionaryWithWorkOrderDetails[@"LocationAddress"];
    //        }
    if (_dictionaryWithWorkOrderDetails[@"Description"] != [NSNull null]) {
        workPrderInfo.descriptionOfWorkOrder =_dictionaryWithWorkOrderDetails[@"Description"];
    }
    if (_dictionaryWithWorkOrderDetails[@"SiteAddress"] != [NSNull null]) {
        NSDictionary * siteAddressDictionary = _dictionaryWithWorkOrderDetails[@"SiteAddress"];
        if (siteAddressDictionary[@"Address"] != [NSNull null]) {
            contactAddressReceived =[NSString stringWithFormat:@"%@", siteAddressDictionary[@"Address"] ];
//            contactAddressReceived = @"No.22, AL ";
            
        }
        //            if (_dictionaryWithWorkOrderDetails[@"ContactCountryId"] != [NSNull null]) {
        //                workPrderInfo.contactCountryId =_dictionaryWithWorkOrderDetails[@"ContactCountryId"];
        //            }
       
        //            if (_dictionaryWithWorkOrderDetails[@"ContactStateId"] != [NSNull null]) {
        //                workPrderInfo.contactStateId =_dictionaryWithWorkOrderDetails[@"ContactStateId"];
        //            }
       
        if (siteAddressDictionary[@"CityName"] != [NSNull null]) {
            contactAddressReceived =[NSString stringWithFormat:@"%@\n%@",contactAddressReceived, siteAddressDictionary[@"CityName"] ];
            workPrderInfo.contactCountyId =siteAddressDictionary[@"CityName"];
        }
        if (siteAddressDictionary[@"StateName"] != [NSNull null]) {
            contactAddressReceived =[NSString stringWithFormat:@"%@\n%@",contactAddressReceived, siteAddressDictionary[@"StateName"] ];
            workPrderInfo.contactStateName =siteAddressDictionary[@"StateName"];
        }
        if (siteAddressDictionary[@"CountyName"] != [NSNull null]) {
            workPrderInfo.contactCountyName =siteAddressDictionary[@"CountyName"];
        }
        if (siteAddressDictionary[@"CountryName"] != [NSNull null]) {
            workPrderInfo.contactCountryName =siteAddressDictionary[@"CountryName"];
        }
        if (siteAddressDictionary[@"ZipCode"] != [NSNull null]) {
            contactAddressReceived =[NSString stringWithFormat:@"%@\n%@",contactAddressReceived, siteAddressDictionary[@"ZipCode"] ];

            workPrderInfo.contactZipCode =siteAddressDictionary[@"ZipCode"];
        }
        
    }
    workPrderInfo.contactAddress= contactAddressReceived;
    _workOrderNumberLabel.text = workPrderInfo.contactPersonName;
    _workOrderTypeLabel.text = workPrderInfo.workOrderType;
    _requestedOnLabel.text = workPrderInfo.requestedOn;
    _requestedEtaLabel.text = workPrderInfo.requestedEtaId;
    _locationAddressLabel.text = workPrderInfo.contactAddress;
    _issueLabel.text = workPrderInfo.descriptionOfWorkOrder;
    
    _workOrderName.text = workPrderInfo.customerLegalName;
    _remainingTimeLabel.text = workPrderInfo.remainingTime;
    
    if (_dictionaryWithWorkOrderDetails[@"Action"] != [NSNull null]) {
    if ([_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"Completed"] || [_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"2"] ) {
        _remainingTimeLabel.text = @"Completed";
        
    }
    else  if ([_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"Rejected"] || [_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"8"] ) {
        _remainingTimeLabel.text = @"Rejected";
        
    }
    else  if ([_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"Done"] || [_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"6"] ) {
        _remainingTimeLabel.text = @"Done";
        
    }
    else  if ([_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"Cancelled"] || [_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"9"] ) {
        _remainingTimeLabel.text = @"Cancelled";
        
    }
    else  if ([_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"Discard"] || [_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"16"] ) {
        _remainingTimeLabel.text = @"Discard";
        
    }
    else  if ([_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"Accepted"] || [_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"2"] || [_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"OnHold"] || [_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"7"] ) {
//        _remainingTimeLabel.text = @"Discard";
        [_checkInButton setTitle:@"Reached" forState:UIControlStateNormal];
    
    }

    }
    
//    if ([_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"13"] || [_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"Completed"] || [_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"8"] || [_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"Rejected"] || [_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"Cancelled"] || [_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"9"] || [_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"Discard"] || [_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"16"] || [_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"CheckedOut"] || [_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"6"] ) {
//        _bottomConstraintOfScrollView.constant = 0;
//        _checkInButton.hidden = YES;
//        _discardButton.hidden = YES;
//        _topConstraintContactPersonViewAndEndingTime.constant = 15;
//        _backgroundViewForHeaderButtons.hidden = YES;
//    }
//    else if([_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"2"] || [_dictionaryWithWorkOrderDetails[@"Action"] isEqualToString:@"Accepted"])
//    {
//        [_checkInButton setTitle:@"Reached" forState:UIControlStateNormal] ;
//    }

}

#pragma mark- Web service

-(void) webserviceForCheckIn
{
    [appDelegate initActivityIndicatorForviewController:self];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *yourDate = [NSDate date];
    dateFormatter.dateFormat = @"MM-dd-yyyy HH:mm:ss";
    NSLog(@"date %@",[dateFormatter stringFromDate:yourDate]);
    
        NSMutableDictionary * postDataDictionary = [[NSMutableDictionary alloc]init];
    [postDataDictionary setValue:workPrderInfo.workOrderId forKey:@"WOId"];
    [postDataDictionary setValue:[dateFormatter stringFromDate:yourDate] forKey:@"CheckinTime"];
    
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/CheckIn",[Webservice webserviceLink]];
    [webservice requestMethodForPost:stringWithUrl withData:postDataDictionary withTag:WEBSERVICE_CHECKIN_TAG];
    
}

-(void) webserviceForReached
{
    [appDelegate initActivityIndicatorForviewController:self];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *yourDate = [NSDate date];
    dateFormatter.dateFormat = @"MM-dd-yyyy HH:mm:ss";
    NSLog(@"date %@",[dateFormatter stringFromDate:yourDate]);
    
            NSMutableDictionary * postDataDictionary = [[NSMutableDictionary alloc]init];
            [postDataDictionary setValue:workPrderInfo.workOrderId forKey:@"WOId"];
            
            NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/TechnicianReached",[Webservice webserviceLink]];
            [webservice requestMethodForPost:stringWithUrl withData:postDataDictionary withTag:WEBSERVICE_REACHED_TAG];

}
-(void) webserviceToWorkOrderInfo
{
    [appDelegate initActivityIndicatorForviewController:self];
    
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/GetWorkOrderDetail/%@",[Webservice webserviceLink],_worOrderId];
    NSLog(@"%@",stringWithUrl);
    [webservice requestMethod:stringWithUrl withMsgType:WEBSERVICE_GET_WORK_ORDER_DETAILS_TAG];
    
}

#pragma mark - UIButton Actions

- (IBAction)callCustomerButtonClicked:(id)sender {
    NSURL *phoneNumber = [[NSURL alloc] initWithString: workPrderInfo.contactPhoneNumber];
    NSCharacterSet *illegalCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
    workPrderInfo.contactPhoneNumber = [[workPrderInfo.contactPhoneNumber componentsSeparatedByCharactersInSet:illegalCharSet] componentsJoinedByString:@""];
    if (phoneNumber != nil) {
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phoneNumber]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    }
    else
    {
        [self showAlertWithMessage:@"Call facility is not available!!!"];
    }
    }
}

- (IBAction)viewLocationButtonClicked:(id)sender {
    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_GetLocation] sender:nil];
}

- (IBAction)discardButtonClicked:(id)sender {
    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_HoldAndDiscard] sender:nil];
}

- (IBAction)checkInButtonClicked:(id)sender
{
    if ([_checkInButton.titleLabel.text isEqualToString:@"Reached"]) {
        [self webserviceForReached];
    }
    else
    {
    [self webserviceForCheckIn];
    }
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        
//        if ([controller isKindOfClass:[DashboardViewController class]]) {
//            
//            [self.navigationController popToViewController:controller
//                                                  animated:YES];
//            break;
//        }
//    }
//    
//    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_Dashboard] sender:nil];
}

- (IBAction)backButtonClicked:(id)sender {
    for (UIViewController *controller in self.navigationController.viewControllers) {
        
        if ([controller isKindOfClass:[DashboardViewController class]]) {
            
            [self.navigationController popToViewController:controller
                                                  animated:YES];
            break;
        }
    }
    
//    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_Dashboard] sender:nil];
}
- (IBAction)viewSensorfactDataButtoncliecked:(id)sender {
    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_sensorfact] sender:nil];

}


#pragma mark - Webservice delagate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];

    NSLog(@"%@",parsedData);
    if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
        if (msgType == WEBSERVICE_CHECKIN_TAG) {
            isREachedWorkOrderCalled = YES;
//            [self webserviceForCheckIn];
        for (UIViewController *controller in self.navigationController.viewControllers) {
            
            if ([controller isKindOfClass:[DashboardViewController class]]) {
                
                [self.navigationController popToViewController:controller
                                                      animated:YES];
                break;
            }
        }
        }
        else if(msgType == WEBSERVICE_REACHED_TAG)
        {
            if (parsedData[@"ReturnObject"] != [NSNull null]) {
                _dictionaryWithWorkOrderDetails = parsedData[@"ReturnObject"];
                [_checkInButton setTitle:@"Check in" forState:UIControlStateNormal];
            }
        }
        else // work order details
        {
            if (parsedData[@"ReturnObject"] != [NSNull null]) {
                _dictionaryWithWorkOrderDetails = parsedData[@"ReturnObject"];
                [self setValuesToUIElementsFromWebservice];
            }
        }

    }
    else
    {
        [self showAlertWithMessage:parsedData[@"Error"]];

    }



}


-(void)errorRecieved:(NSString *)errorString withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];
    [self showAlertWithMessage:errorString];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_Checkout]])  {
    CheckoutViewController * checkoutViewController = segue.destinationViewController;
    checkoutViewController.workOrderInfo = workPrderInfo;
//    checkoutViewController.workOrderNumber = workPrderInfo.workOrderNumber;
    }
    else if ([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_GetLocation]]) {
        GetLocationViewController * getLocationViewController = segue.destinationViewController;
        getLocationViewController.endLocation = customerLocation;
        getLocationViewController.addressOfCustomer = workPrderInfo.contactAddress;
        getLocationViewController.contactNumber = workPrderInfo.contactPhoneNumber;
    }
    else if ([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_HoldAndDiscard]]) {
        HoldAndDiscardWorkOrderViewController * holdAndDiscardWorkOrderViewController = segue.destinationViewController;
        holdAndDiscardWorkOrderViewController.workOderId = workPrderInfo.workOrderId;
        holdAndDiscardWorkOrderViewController.workOrderNo = workPrderInfo.workOrderNumber;
        holdAndDiscardWorkOrderViewController.isHold= NO;

    }
    else if ([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_sensorfact]]) {
        ViewSensorFactViewController * viewSensorFactViewController = segue.destinationViewController;
        viewSensorFactViewController.workOrderInfo = workPrderInfo;
//        viewSensorFactViewController.workOrderStatus = workPrderInfo;

    }

}


@end
