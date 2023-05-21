//
//  NewJobNotificationViewController.m
//  FasBackTechnician
//
//  Created by User on 20/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "NewJobNotificationViewController.h"
#import "StoryboardsAndSegues.h"
#import "AcceptRejectJobViewController.h"
#import "ConstantColors.h"
#import <MFSideMenu.h>
#import "AppDelegate.h"
#import <UIImageView+AFNetworking.h>
#import "GetLocationViewController.h"
#import "UIFont+PoppinsFont.h"
#import "ViewSensorFactViewController.h"

@interface NewJobNotificationViewController ()
{
    AppDelegate * appDelegate;
}
@end

@implementation NewJobNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self restoreToDefaults];
    [self changesInUI];
    [self webserviceToWorkOrderInfo];
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
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    workPrderInfo = [[WorkOrderInfo alloc]init];
    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
    
    _remainingTimeLabel.text = @"";
    _workOrderNumberLabel.text = @"";
    _workOrderName.text = @"";
    _workOrderTypeLabel.text = @"";
    _requestedOnLabel.text = @"";
    _requestedEtaLabel.text = @"";
    _locationAddressLabel.text = @"";
    _descriptionLabel.text = @"";
    
    customerLocation = [[StepsInGoogleMap alloc]init];
}
-(void) changesInUI
{
    _placeholederLabelForLogoImage.text =@"";
    _logoImageView.image = nil;
    _placeholederLabelForLogoImage.hidden = YES;
    _logoImageView.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _logoImageView.layer.borderWidth = 0.4;
   
    
    _mainScrollView.contentSize = CGSizeMake(width,  1200);
    _acceptButton.layer.cornerRadius = 4;
    _rejectButton.layer.cornerRadius = 4;
    _rejectButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _rejectButton.layer.borderWidth = 1.0;
    
    if (height == 480) {
        //
    }
    else if (height == 568)
    {
        _workOrderName.font = [UIFont poppinsSemiBoldFontWithSize:16];
        _remainingTimeLabel.font = [UIFont poppinsNormalFontWithSize:14];
        _callCustomerButton.titleLabel.font = [UIFont poppinsNormalFontWithSize:11];
        _viewLocationButton.titleLabel.font = [UIFont poppinsNormalFontWithSize:11];
        _workOrderNumberLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _workOrderTypeLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _requestedEtaLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _requestedOnLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _locationAddressLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _descriptionLabel.font = [UIFont poppinsNormalFontWithSize:12];

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

-(void) showAlertToPopTheScreen : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)setValuesToUIElementsFromWebservice
{
    workPrderInfo.contactAddress= contactAddressReceived;
    _workOrderNumberLabel.text = workPrderInfo.workOrderNumber;
    _workOrderTypeLabel.text = workPrderInfo.workOrderType;
    _requestedOnLabel.text = workPrderInfo.requestedOn;
    _requestedEtaLabel.text = workPrderInfo.requestedEtaId;
    _locationAddressLabel.text = workPrderInfo.contactAddress;
    _descriptionLabel.text = workPrderInfo.descriptionOfWorkOrder;
    _workOrderName.text = workPrderInfo.customerLegalName;
    _remainingTimeLabel.text = workPrderInfo.remainingTime;
}


#pragma mark- Web service

-(void) webserviceToWorkOrderInfo
{
    [appDelegate initActivityIndicatorForviewController:self];
    
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/GetWorkOrderDetail/%@",[Webservice webserviceLink],_workOrderId];
    NSLog(@"%@",stringWithUrl);
    [webservice requestMethod:stringWithUrl withMsgType:12];
    
}
#pragma mark - UIButton Actions

- (IBAction)rejectButtonClicked:(id)sender {
    isRejected = YES;
    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_AcceptAndRejectWork] sender:nil];
}

- (IBAction)acceptButtonClicked:(id)sender {
    isRejected = NO;
    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_AcceptAndRejectWork] sender:nil];
}

- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)callCustomerButtonClicked:(id)sender {
    if (workPrderInfo.contactPhoneNumber != nil) {
        
        NSCharacterSet *illegalCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
        workPrderInfo.contactPhoneNumber = [[workPrderInfo.contactPhoneNumber componentsSeparatedByCharactersInSet:illegalCharSet] componentsJoinedByString:@""];
    NSURL *phoneNumber = [[NSURL alloc] initWithString: workPrderInfo.contactPhoneNumber];
    if (phoneNumber != nil) {
        NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phoneNumber]];
        
        if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
            [[UIApplication sharedApplication] openURL:phoneUrl];
        } else
        {
            [self showAlertWithMessage:@"Call facility is not available!!!"];
        }
    }
    }
    else
    {
        [self showAlertWithMessage:@"Phone number not available"];
    }
}

- (IBAction)viewLocationButtonclicked:(id)sender {
    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_GetLocation] sender:nil];
}

- (IBAction)viewSensorfactButtonclicked:(id)sender {
    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_sensorfact] sender:nil];
}


#pragma mark - Webservice delagate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];

    contactAddressReceived = @"";

    NSLog(@"%@",parsedData);
    if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
        NSDictionary * workOrderDictionary = [parsedData objectForKey:@"ReturnObject"];
        
//        NSDictionary * workOrderDictionary = resultData[@"TechnicianSummary"];
        if (workOrderDictionary[@"CustomerLegalName"] != [NSNull null]) {
            workPrderInfo.customerLegalName =workOrderDictionary[@"CustomerLegalName"];
        }
        
        if (workOrderDictionary[@"ImgUrl"] != [NSNull null]) {
        workPrderInfo.profileImageString =workOrderDictionary[@"ImgUrl"];
//            _logoImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:workOrderDictionary[@"ImgUrl"]]]];

            [_logoImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:workOrderDictionary[@"ImgUrl"]]]
                                  placeholderImage:nil
                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                               
                                               // do image resize here
                                               
                                               // then set image view
                                               if (image != nil) {
                                                   _logoImageView.image = image;
                                               }
                                               else
                                               {
                                                   if (workOrderDictionary[@"CustomerLegalName"] != [NSNull null]) {
                                                       NSString * firstCharacterOfCustomerName = [workOrderDictionary[@"CustomerLegalName"] substringToIndex:1];
                                                       _placeholederLabelForLogoImage.text =firstCharacterOfCustomerName;
                                                   }
                                               }
                                           }
                                           failure:nil];
        }
        else
        {
            if (workOrderDictionary[@"CustomerLegalName"] != [NSNull null]) {
                NSString * firstCharacterOfCustomerName = [workPrderInfo.customerLegalName substringToIndex:1];
                _placeholederLabelForLogoImage.text =firstCharacterOfCustomerName;
            }
        }
        if (workOrderDictionary[@"CustomerId"] != [NSNull null]) {
        workPrderInfo.customerId =workOrderDictionary[@"CustomerId"];
        }
       
        if (workOrderDictionary[@"EndingIn"] != [NSNull null]) {
        workPrderInfo.remainingTime =workOrderDictionary[@"EndingIn"];
        }
        if (workOrderDictionary[@"WorkOrderNo"] != [NSNull null]) {
        workPrderInfo.workOrderNumber =workOrderDictionary[@"WorkOrderNo"];
        }
        if (workOrderDictionary[@"WOId"] != [NSNull null]) {
        workPrderInfo.workOrderId =workOrderDictionary[@"WOId"];
        }
        if (workOrderDictionary[@"RequestedETA"] != [NSNull null]) {
            
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
            NSString *requestedETAString = workOrderDictionary[@"RequestedETA"];
            requestedETAString = [requestedETAString stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSDate *yourDate = [dateFormatter dateFromString:requestedETAString];
            if (yourDate == nil) {
                dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            }
            yourDate = [dateFormatter dateFromString:requestedETAString];
            workPrderInfo.requestedETADate = yourDate;
            dateFormatter.dateFormat = @"dd MMM hh:mm a";
            NSLog(@"date %@",[dateFormatter stringFromDate:yourDate]);
        workPrderInfo.requestedEtaId =[dateFormatter stringFromDate:yourDate];
        }
        if (workOrderDictionary[@"ContactPersonName"] != [NSNull null]) {
        workPrderInfo.contactPersonName =workOrderDictionary[@"ContactPersonName"];
        }
        if (workOrderDictionary[@"ContactEmailP"] != [NSNull null]) {
        workPrderInfo.contactEmail =workOrderDictionary[@"ContactEmailP"];
        }
        if (workOrderDictionary[@"ContactMobileP"] != [NSNull null]) {
        workPrderInfo.contactPhoneNumber =workOrderDictionary[@"ContactMobileP"];
        }
        if (workOrderDictionary[@"LocationLatitudeCustomer"] != [NSNull null]) {
        workPrderInfo.locationLatitudeCustomer =workOrderDictionary[@"LocationLatitudeCustomer"];
            customerLocation.latitudeString = workPrderInfo.locationLatitudeCustomer;
        }
        if (workOrderDictionary[@"LocationLongitudeCustomer"] != [NSNull null]) {
        workPrderInfo.locationLongitudeCustomer =workOrderDictionary[@"LocationLongitudeCustomer"];
            customerLocation.longitudeString = workPrderInfo.locationLongitudeCustomer;

        }
        if (workOrderDictionary[@"WorkOrderType"] != [NSNull null]) {
        workPrderInfo.workOrderType =workOrderDictionary[@"WorkOrderType"];
        }
        if (workOrderDictionary[@"RequestedOn"] != [NSNull null]) {
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                NSString *requestedETAString = workOrderDictionary[@"RequestedOn"];
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
//        if (workOrderDictionary[@"ImgProfile"] != [NSNull null]) {
//        workPrderInfo.locationAddress =workOrderDictionary[@"LocationAddress"];
//        }
        if (workOrderDictionary[@"Description"] != [NSNull null]) {
        workPrderInfo.descriptionOfWorkOrder =workOrderDictionary[@"Description"];
        }
//        if (workOrderDictionary[@"ImgProfile"] != [NSNull null]) {
//        workPrderInfo.profileImageString =workOrderDictionary[@"ImgProfile"];
//        }
        if (workOrderDictionary[@"Action"] != [NSNull null]) {
        workPrderInfo.action =workOrderDictionary[@"Action"];
        }
        if (workOrderDictionary[@"SiteAddress"] != [NSNull null]) {
            NSDictionary * siteAddressDictionary = workOrderDictionary[@"SiteAddress"];
            if (siteAddressDictionary[@"Address"] != [NSNull null]) {
                contactAddressReceived =[NSString stringWithFormat:@"%@", siteAddressDictionary[@"Address"] ];
            }
//            if (workOrderDictionary[@"ContactCountryId"] != [NSNull null]) {
//                workPrderInfo.contactCountryId =workOrderDictionary[@"ContactCountryId"];
//            }
            if (siteAddressDictionary[@"CityName"] != [NSNull null]) {
                contactAddressReceived =[NSString stringWithFormat:@"%@\n%@",contactAddressReceived, siteAddressDictionary[@"CityName"] ];
                workPrderInfo.contactCountyId =siteAddressDictionary[@"CityName"];
            }

           //            if (workOrderDictionary[@"ContactStateId"] != [NSNull null]) {
//                workPrderInfo.contactStateId =workOrderDictionary[@"ContactStateId"];
//            }
            if (siteAddressDictionary[@"CountyName"] != [NSNull null]) {
                workPrderInfo.contactCountyName =siteAddressDictionary[@"CountyName"];
            }

            if (siteAddressDictionary[@"StateName"] != [NSNull null]) {
                contactAddressReceived =[NSString stringWithFormat:@"%@\n%@",contactAddressReceived, siteAddressDictionary[@"StateName"] ];
                workPrderInfo.contactStateName =siteAddressDictionary[@"StateName"];
            }
                       if (siteAddressDictionary[@"CountryName"] != [NSNull null]) {
                workPrderInfo.contactCountryName =siteAddressDictionary[@"CountryName"];
            }

          //            if (workOrderDictionary[@"ContactCityId"] != [NSNull null]) {
//                workPrderInfo.contactCityId =workOrderDictionary[@"ContactCityId"];
//            }
            
            if (siteAddressDictionary[@"ZipCode"] != [NSNull null]) {
                contactAddressReceived =[NSString stringWithFormat:@"%@\n%@",contactAddressReceived, siteAddressDictionary[@"ZipCode"] ];

                workPrderInfo.contactZipCode =siteAddressDictionary[@"ZipCode"];
            }

        }
        [self setValuesToUIElementsFromWebservice];
    }
    else
    {
        [self showAlertToPopTheScreen:parsedData[@"Error"]];
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
    if ([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_AcceptAndRejectWork]]) {
    AcceptRejectJobViewController * acceptViewController = [segue destinationViewController];
    acceptViewController.isRejected = isRejected;
    acceptViewController.workOderId = workPrderInfo.workOrderId;
    acceptViewController.workOrderNo = workPrderInfo.workOrderNumber;
        acceptViewController.requestedETA = workPrderInfo.requestedETADate;
    }
   else if ([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_GetLocation]]) {
       GetLocationViewController * getLocationViewController = segue.destinationViewController;
       getLocationViewController.endLocation = customerLocation;
       getLocationViewController.addressOfCustomer = workPrderInfo.contactAddress;
       getLocationViewController.contactNumber = workPrderInfo.contactPhoneNumber;
   }
   else if ([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_sensorfact]]) {
       if (workPrderInfo.workOrderId != nil) {
       ViewSensorFactViewController * viewSensorFactViewController = segue.destinationViewController;
       viewSensorFactViewController.workOrderInfo = workPrderInfo;
       }
   }

}

@end
