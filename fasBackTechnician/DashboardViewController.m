//
//  DashboardViewController.m
//  FasBackTechnician
//
//  Created by User on 20/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "DashboardViewController.h"
#import "UIColor+Customcolor.h"
#import "StoryboardsAndSegues.h"
#import "ConstantColors.h"
#import "Constants.h"
#import "JobsListViewController.h"
#import <MFSideMenu.h>
#import "AppDelegate.h"
#import "CheckoutViewController.h"
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
#import "ConfirmWorkOrderViewController.h"
#import "NewJobNotificationViewController.h"
#import "UIFont+PoppinsFont.h"
#import "WorkOrderInfo.h"
#import "DashboardCollectionViewCell.h"

#define RADIANS(degrees) ((degrees * M_PI) / 180.0)

@interface DashboardViewController ()
{
    AppDelegate * appDelegate;
    
}
@end

@implementation DashboardViewController

static NSInteger const WEBSERVICE_DASHBOARD_DETAILS_TAG = 1101;
static NSInteger const WEBSERVICE_NOTIFICATION_COUNT_TAG = 1102;
static NSInteger const WEBSERVICE_USER_PROFILE_TAG = 1103;


- (void)viewDidLoad {
    [super viewDidLoad];
       
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotificationCount:)
                                                 name:@"NotificationCount"
                                               object:nil];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self restoreToDefaults];
    [self webserviceForDashboardDetails];
    [self webserviceForUserProfile];
}

-(void)viewDidAppear:(BOOL)animated
{
    self.menuContainerViewController.panMode = MFSideMenuPanModeCenterViewController | MFSideMenuPanModeSideMenu;
    
    //    [self ani];
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(notificationLabelTapped:)];
    
    tapGesture1.numberOfTapsRequired = 1;
    
    [tapGesture1 setDelegate:self];
    
    [_notificationLabel addGestureRecognizer:tapGesture1];
    
    
    UITapGestureRecognizer *tapGestureForWorkOder = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(logoImageViewTapped:)];
    
    tapGestureForWorkOder.numberOfTapsRequired = 1;
    
    [tapGestureForWorkOder setDelegate:self];
    
    [_backgroundOfTopCard addGestureRecognizer:tapGestureForWorkOder];
    
    }

-(void)viewWillLayoutSubviews
{
    _logoImageView.layer.cornerRadius = _logoImageView.frame.size.width/2;
    _logoImageView.layer.masksToBounds = YES;
}

#pragma mark - General

-(void)restoreToDefaults
{
    self.navigationController.navigationBarHidden = YES;
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;

    _workOrderNameLabel.text = @"";
    _remainingTimeLabel.text = @"";
    _workOrderNumberLabel.text = @"";
    _requestedEtaLabel.text = @"";
    
    arrayWithIcons = [[NSMutableArray alloc]initWithObjects:@"dashboardTick",@"dashboardX",@"dashboardSundial", nil];
    arrayWithNumberOfWorkCompleted = [[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil];
    arrayWithStatus = [[NSMutableArray alloc]initWithObjects:@"Assigned",@"Open",@"Accepted",@"Completed",@"Rejected",@"Rating", nil];
    arrayWithJobStatusImages = [[NSMutableArray alloc]initWithObjects:@"assigned",@"open",@"accepted",@"Completed",@"rejected",@"Ratings", nil];
    
    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
    
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [self changesInUI];
}

-(void) changesInUI
{
    //    CALayer *sublayer = [CALayer layer];
    //    sublayer.backgroundColor = [UIColor blueColor].CGColor; // If you dont give this, shadow will not come, dont know why
    //    sublayer.shadowOffset = CGSizeMake(0, 3);
    //    sublayer.shadowRadius = 5.0;
    //    sublayer.shadowColor = [UIColor blackColor].CGColor;
    //    sublayer.shadowOpacity = 1.0;
    //    sublayer.cornerRadius = 5.0;
    //    sublayer.frame = CGRectMake(_dashboardTableView.frame.origin.x, _dashboardTableView.frame.origin.y, _dashboardTableView.frame.size.width, _dashboardTableView.frame.size.height);
    //    [self.view.layer addSublayer:sublayer];
    //
    //    [self.view.layer addSublayer:_dashboardTableView.layer];
    
    _logoImageView.image = nil;
    
    _logoImageView.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _logoImageView.layer.borderWidth = 0.4;
    _logoImageView.layer.cornerRadius = _logoImageView.frame.size.width/2;
    _logoImageView.layer.masksToBounds = YES;
    
    _placeholederLabelForLogoImage.text = @"";
    //    _placeholederLabelForLogoImage.hidden = YES;
    _notificationLabel.hidden = YES;
    
    [_dashboardTableView.layer setShadowColor:[[UIColor ColorWithHexaString:@"e8eced"] CGColor]];
    [_dashboardTableView.layer setShadowOffset:CGSizeMake(2, 5)];
    [_dashboardTableView.layer setShadowRadius:5.0];
    [_dashboardTableView.layer setShadowOpacity:0.5];
    
    _dashboardTableView.clipsToBounds = NO;
    _dashboardTableView.layer.masksToBounds = NO;
    
    _dashboardTableView.layer.cornerRadius = 4;
    
    _bottomiewOfHeaderView.layer.shadowColor = [UIColor ColorWithHexaString:@"d2d5d6"].CGColor;
    _bottomiewOfHeaderView.layer.shadowOpacity = 0.4;
    _bottomiewOfHeaderView.layer.shadowRadius = 5;
    _bottomiewOfHeaderView.layer.shadowOffset = CGSizeMake(0, 2.0f);
    
//    _bottomiewOfHeaderView.layer.shadowColor = [UIColor grayColor].CGColor;
//    _bottomiewOfHeaderView.layer.shadowOpacity = 0.1;
//    _bottomiewOfHeaderView.layer.shadowRadius = 2;
//    _bottomiewOfHeaderView.layer.shadowOffset = CGSizeMake(5, 2.0f);

    
    if (height == 480) {
        //
    }
    else if (height == 568)
    {
        _placeholederLabelForLogoImage.font = [UIFont poppinsNormalFontWithSize:40];
        _workOrderNameLabel.font = [UIFont poppinsSemiBoldFontWithSize:16];
        _remainingTimeLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _workOrderNumberLabel.font = [UIFont poppinsNormalFontWithSize:11];
        _requestedEtaLabel.font = [UIFont poppinsNormalFontWithSize:11];
        _workOrderNameTitleLabel.font = [UIFont poppinsSemiBoldFontWithSize:8];
        _requestedEtaTitleLabel.font = [UIFont poppinsSemiBoldFontWithSize:8];

    }
    
    
}
-(void) showAlertWithMessage : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void) animateTheNotificationIcon
{
    
    _notificationLabel.hidden = NO;
    _notificationLabel.layer.cornerRadius = _notificationLabel.frame.size.width/2;
    _notificationLabel.layer.masksToBounds = YES;
    CGAffineTransform leftWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-30.0));
    CGAffineTransform rightWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(30.0));
    CGAffineTransform nomalWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(0.0));
    _notificationLabel.transform = CGAffineTransformMakeScale(0, 0);
    
    //    _notificationLabel.text = [NSString stringWithFormat:@"20"];
    _notificationButton.transform = leftWobble;  // starting point
    //    _bellImageView.deleteButton.hidden = NO;
    
    
    [UIView animateWithDuration:0.3 delay:0 options:( UIViewAnimationOptionAutoreverse) animations:^{
        _notificationButton.transform = rightWobble;
        [UIView setAnimationRepeatCount:2];
        
    }completion:^(BOOL finished){
        if (finished) {
            _notificationButton.transform = nomalWobble;
            //            [_notificationButton stopAnimating];
            [UIView animateWithDuration:0.2
                             animations:^{
                                 _notificationLabel.transform = CGAffineTransformIdentity;
                             }
                             completion:^(BOOL finished) {
                                 //                                 [UIView animateWithDuration:1
                                 //                                                  animations:^{
                                 //                                                      _noOfCountsLabel.transform = CGAffineTransformIdentity;
                                 //
                                 //                                                  }];
                             }];
        }
        
    }];
    
}

- (NSString *)documentsPathForFileName:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}
#pragma mark - Web service

-(void) webserviceForDashboardDetails
{
    [appDelegate initActivityIndicatorForviewController:self];
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/GetDashboardDetail",[Webservice webserviceLink]];
    [webservice requestMethod:stringWithUrl withMsgType:WEBSERVICE_DASHBOARD_DETAILS_TAG];
    
}


-(void) webserviceForNotificationCount
{
    [appDelegate initActivityIndicatorForviewController:self];
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/Admin/Notification/GetNotificationCount",[Webservice webserviceLink]];
    [webservice requestMethod:stringWithUrl withMsgType:WEBSERVICE_NOTIFICATION_COUNT_TAG];
    
}

-(void) webserviceForUserProfile
{
    //    [appDelegate initActivityIndicatorForviewController:self];
    
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/GetTechnicianProfileDetails",[Webservice webserviceLink]];
    [webservice requestMethod:stringWithUrl withMsgType:WEBSERVICE_USER_PROFILE_TAG];
    
}

- (void) receiveNotificationCount:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    NSLog(@"Notification count%@",[notification object]);
    
        if ([[NSString stringWithFormat:@"%@",[[notification object]objectForKey:@"NotificationCount"]] isEqualToString:@"0"]) {
            //
        }
        else
        {
            NSLog(@"Notification count%@",[NSString stringWithFormat:@"%@",[[notification object] objectForKey:@"NotificationCount"]]);

            _notificationLabel.text = [NSString stringWithFormat:@"%@",[[notification object] objectForKey:@"NotificationCount"]];
            [self animateTheNotificationIcon];
        }
    

}
#pragma mark - UIButton Actions

- (void)notificationLabelTapped:(UITapGestureRecognizer *)recognizer
{
    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_NotificationList] sender:nil];
    
    //Do stuff here...
}

- (void)logoImageViewTapped:(UITapGestureRecognizer *)recognizer
{
    if (recentWorkOrderId != nil) {
        if (recentWorkOrderStatusId == 5) {
            [self performSegueWithIdentifier:[StoryboardsAndSegues segue_Checkout] sender:nil];
        }
        else if(recentWorkOrderStatusId == 6 || recentWorkOrderStatusId == 13)
        {
            [self showAlertWithMessage:@"The Work Order is completed"];
        }
        else if (recentWorkOrderStatusId == 8)
        {
            [self showAlertWithMessage:@"You have rejected this Work Order"];
        }
        else if (recentWorkOrderStatusId == 9)
        {
            [self showAlertWithMessage:@"This Work Order has been cancelled"];
        }
        //        else if (recentWorkOrderStatusId == 1)
        //        {
        //            [self showAlertWithMessage:@"This Work Order has been cancelled"];
        //        }
        else if (recentWorkOrderStatusId == 3)
        {
            //check in
            [self performSegueWithIdentifier:[StoryboardsAndSegues segue_ConfirmWorkOrder] sender:nil];
        }
        else if (recentWorkOrderStatusId == 2)
        {
            //accept or reject
            [self performSegueWithIdentifier:[StoryboardsAndSegues segue_NewWorkOrder] sender:nil];
        }
    }
    else
    {
        [self showAlertWithMessage:@"There is no recent work order"];
    }
    //Do stuff here...
}

- (IBAction)notificationIconClicked:(id)sender {
    //    workStatusSelected = NewWork;
    //    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_JobList] sender:nil];
    
}

- (IBAction)menuButtonClicked:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

#pragma mark - UICollectionView Datasource & Delegates

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrayWithStatus count];
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"DashboardCollectionViewCell";
    
    DashboardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.workOrderStatusName.text = [arrayWithStatus objectAtIndex:indexPath.item];
    cell.WorkOrderStatusImageView.image = [UIImage imageNamed:[arrayWithJobStatusImages objectAtIndex:indexPath.item]];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            workStatusSelected = AssignedWork;
            
            break;
            
        case 1 :
            workStatusSelected = OpenWork;
            
            break;
            
        case 2:
            workStatusSelected = AcceptedWork;
            break;
            
        case 3:
            workStatusSelected = CompletedWork;
            break;
            
        case 4 :
            workStatusSelected = RejectedWork;
            
            break;
            
        case 5:
            workStatusSelected = RatingsForWork;
            
            break;
        default:
            break;
            
    }
    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_JobList] sender:nil];

}

#pragma mark - UIColectionView FlowLayout Delegates

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((width/2)-0.5,((height-80)-1)/3);
}

//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 100, 0, 30);
//}
//
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0;
//}
//
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0;
//}

#pragma mark - UITableView Datasoure

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayWithNumberOfWorkCompleted count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DashboardTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[DashboardTableViewCell reuseIdentifier] forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[DashboardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[DashboardTableViewCell reuseIdentifier]];
    }
    cell.numberOfWorksCompleted.text = arrayWithNumberOfWorkCompleted[indexPath.row];
    cell.statusOfWork.text = arrayWithStatus[indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:arrayWithIcons[indexPath.row]];
    cell.graphImageView.image = [UIImage imageNamed:arrayWithJobStatusImages[indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (height == 480) {
        return 90.0f;
    }
    else if (height == 568)
    {
        return 90.0f;
    }
    else if (height == 667) {
    return 108.0f;
    }
    else
    {
        return 140;
    }
}



#pragma mark - UITableView Delegates

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            workStatusSelected = CompletedWork;
            break;
            
        case 1 :
            workStatusSelected = RejectedWork;
            
            break;
            
        case 2:
            workStatusSelected = OpenWork;
            
            break;
        default:
            break;
            
    }
    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_JobList] sender:nil];
}

#pragma mark - Webservice delagate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];
    
    NSLog(@"%@",parsedData);
    if (msgType == WEBSERVICE_DASHBOARD_DETAILS_TAG) {
        if (parsedData != [NSNull null]) {
        if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
            if ([parsedData objectForKey:@"ReturnObject"] != [NSNull null]) {
                
                NSDictionary * resultData = [parsedData objectForKey:@"ReturnObject"];
                
                if (resultData[@"Completed"] != [NSNull null]) {
                    numberOfCompletedWorkOrder = [resultData[@"Completed"] intValue];
                }
                if (resultData[@"Pending"] != [NSNull null]) {
                    numberOfPendingWorkOrder = [resultData[@"Pending"] intValue];
                }
                if (resultData[@"Rejected"] != [NSNull null]) {
                    numberOfRejectedWorkOrder = [resultData[@"Rejected"] intValue];
                }
                if (resultData[@"CustomerLegalName"] != [NSNull null]) {
                    _workOrderNameLabel.text = resultData[@"CustomerLegalName"];
                }
                if (resultData[@"WorkOrderNo"] != [NSNull null]) {
                    _workOrderNumberLabel.text = resultData[@"WorkOrderNo"];
                }
                if (resultData[@"WorkOrderId"] != [NSNull null]) {
                    recentWorkOrderId = resultData[@"WorkOrderId"];
                }
                if (resultData[@"WorkOrderStatusID"] != [NSNull null]) {
                    recentWorkOrderStatusId = [resultData[@"WorkOrderStatusID"] intValue];
                }
                if (resultData[@"ApproximateETADateTime"] != [NSNull null]) {
                    appoximateEtaTimeForRecentWorkOrder = resultData[@"ApproximateETADateTime"];
                }
                if (resultData[@"ImgProfile"] != [NSNull null]) {
                    
                    [_logoImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:resultData[@"ImgProfile"]]]
                                          placeholderImage:nil
                                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                       
                                                       // do image resize here
                                                       
                                                       // then set image view
                                                       if (image != nil) {
                                                           _logoImageView.image = image;
                                                       }
                                                       else
                                                       {
                                                           if (resultData[@"CustomerLegalName"] != [NSNull null]) {
                                                               NSString * firstCharacterOfCustomerName = [resultData[@"CustomerLegalName"] substringToIndex:1];
                                                               _placeholederLabelForLogoImage.text =firstCharacterOfCustomerName;
                                                           }
                                                       }
                                                   }
                                                   failure:nil];
                }
                else
                {
                    if (resultData[@"CustomerLegalName"] != [NSNull null]) {
                        NSString * firstCharacterOfCustomerName = [resultData[@"CustomerLegalName"] substringToIndex:1];
                        _placeholederLabelForLogoImage.text =firstCharacterOfCustomerName;
                    }
                }
                [arrayWithNumberOfWorkCompleted replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%02d", numberOfCompletedWorkOrder ]];
                [arrayWithNumberOfWorkCompleted replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%02d", numberOfRejectedWorkOrder ]];
                [arrayWithNumberOfWorkCompleted replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%02d", numberOfPendingWorkOrder ]];
                
                NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                
                if (resultData[@"RequestedETA"] != [NSNull null]) {
                    NSString *requestedETAString = resultData[@"RequestedETA"];
                    requestedETAString = [requestedETAString stringByReplacingOccurrencesOfString:@"T" withString:@" " ];
                    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                    NSDate *yourDate = [dateFormatter dateFromString:requestedETAString];
                    if (yourDate == nil) {
                        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                    }
                    yourDate = [dateFormatter dateFromString:requestedETAString];

                    dateFormatter.dateFormat = @"dd MMM hh:mm a";
                    NSLog(@"date %@",[dateFormatter stringFromDate:yourDate]);
                    
                    _requestedEtaLabel.text = [dateFormatter stringFromDate:yourDate];
                }
                
                if (resultData[@"RemainingTime"] != [NSNull null]) {
                    dateFormatter.dateFormat = @"hh:mm:ss";
                    NSString *remainingTimeString = resultData[@"RemainingTime"];
                    NSDate *remainingDate = [dateFormatter dateFromString:remainingTimeString];
                    
                    dateFormatter.dateFormat = @"hh' hr 'mm' min remaining";
                    
                    _remainingTimeLabel.text = [dateFormatter stringFromDate:remainingDate];
                }
                [_dashboardTableView reloadData];
            }
        }
        else
        {
            [self showAlertWithMessage:parsedData[@"Error"]];
        }
        [self webserviceForNotificationCount];
        }
        else
        {
            [self showAlertWithMessage:@"Couldn't connect to server"];
        }
    }
    else if (msgType == WEBSERVICE_USER_PROFILE_TAG) {
        NSLog(@"User profile %@",parsedData);
        
        //        NSManagedObjectContext *context = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).persistentContainer.viewContext;
        
        //        NSFetchRequest<User *> *fetchRequest = [User fetchRequest];
        //        NSError *error ;
        //        NSArray *resultArray= [context executeFetchRequest:fetchRequest error:&error];
        //
        //        for (int i = 0; i<[resultArray count]; i++) {
        //            User * user = resultArray[i];
        //            [context deleteObject:user];
        //        }
        
        //        [appDelegate saveContext];
        
        if (parsedData != [NSNull null]) {

        if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
            if ([parsedData objectForKey:@"ReturnObject"] != [NSNull null]) {
                //        NSManagedObjectContext *context = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).persistentContainer.viewContext;
                //        NSManagedObject *entityNameObj = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
                
                
                NSDictionary * resultData = [parsedData objectForKey:@"ReturnObject"];
                
                
                if (resultData[@"TechnicianSummary"] != [NSNull null]) {
                    NSDictionary * technicalSummaryDictionary = resultData[@"TechnicianSummary"];
                    if (technicalSummaryDictionary[@"FName"] != [NSNull null]) {
                        //                        [entityNameObj setValue:[NSString stringWithFormat:@"%@", technicalSummaryDictionary[@"FName"] ] forKey:@"userName"];
                        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@", technicalSummaryDictionary[@"FName"] ] forKey:userName];
                    }
                    if (technicalSummaryDictionary[@"Rating"] != [NSNull null]) {
                        //                        [entityNameObj setValue:[NSString stringWithFormat:@"%@", technicalSummaryDictionary[@"Rating"] ]  forKey:@"Rating"];
                        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@", technicalSummaryDictionary[@"Rating"] ] forKey:userRating];
                        
                    }
                    if (technicalSummaryDictionary[@"Status"] != [NSNull null]) {
                        //                        [entityNameObj setValue:[NSString stringWithFormat:@"%@", technicalSummaryDictionary[@"Rating"] ]  forKey:@"Rating"];
                        NSLog(@"Status %@",[NSString stringWithFormat:@"%@", technicalSummaryDictionary[@"Status"] ]);
                        int status = [technicalSummaryDictionary[@"Status"]intValue];
                        [[NSUserDefaults standardUserDefaults]removeObjectForKey:isUserAvailable];
                        [[NSUserDefaults standardUserDefaults]setInteger:status forKey:isUserAvailable];
                        
                    }
                }
                
                if (resultData[@"BasicInfo"] != [NSNull null]) {
                    NSDictionary * basicInfoDictionary = resultData[@"BasicInfo"];
                    if (basicInfoDictionary[@"EmailP"] != [NSNull null]) {
                        [[NSUserDefaults standardUserDefaults] setObject:basicInfoDictionary[@"EmailP"] forKey:EMAILID];

                    }
                }
                
                if (resultData[@"BasicInfo"] != [NSNull null]) {
                    NSDictionary * basicInfoDictionary = resultData[@"BasicInfo"];
                    if (basicInfoDictionary[@"ImgProfile"] != [NSNull null]) {
                        
                        NSString* stringVideo = [NSString stringWithFormat:@"%@", basicInfoDictionary[@"ImgProfile"] ];
                        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: stringVideo]];

                        
                        AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                        requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
                        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                            NSLog(@"Response: %@", responseObject);
                            NSData *imageData = UIImageJPEGRepresentation(responseObject, 1);
                            
                            // Get image path in user's folder and store file with name image_CurrentTimestamp.jpg (see documentsPathForFileName below)
                            NSString *imagePath = [self documentsPathForFileName:[NSString stringWithFormat:@"image_%f.jpg", [NSDate timeIntervalSinceReferenceDate]]];
                            
                            // Write image data to user's folder
                            [imageData writeToFile:imagePath atomically:YES];
                            
                            // Store path in NSUserDefaults
                            [[NSUserDefaults standardUserDefaults] setObject:imagePath forKey:userImage];
                            
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            NSLog(@"Image error: %@", error);
                        }];
                        [requestOperation start];
                        
//                        NSString* stringVideo = [NSString stringWithFormat:@"%@", basicInfoDictionary[@"ImgProfile"] ];
//                        AFImageDownloader* dow = [[AFImageDownloader alloc] init];
//                        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: stringVideo]];
//                        [dow downloadImageForURLRequest:request success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull responseObject) {
//                            NSLog(@"Succes downloud image");
//                            //                                [[NSUserDefaults standardUserDefaults]setObject:responseObject forKey:userImage];
//                            
//                            NSData *imageData = UIImageJPEGRepresentation(responseObject, 1);
//                            
//                            // Get image path in user's folder and store file with name image_CurrentTimestamp.jpg (see documentsPathForFileName below)
//                            NSString *imagePath = [self documentsPathForFileName:[NSString stringWithFormat:@"image_%f.jpg", [NSDate timeIntervalSinceReferenceDate]]];
//                            
//                            // Write image data to user's folder
//                            [imageData writeToFile:imagePath atomically:YES];
//                            
//                            // Store path in NSUserDefaults
//                            [[NSUserDefaults standardUserDefaults] setObject:imagePath forKey:userImage];
//
//                            
//                        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
//                            NSLog(@"Error downloud image");
//                        }];
                        
                        
                    }
                }
                //                    [entityNameObj setValue:@""  forKey:@"isAvailable"];
            }
        }
        }
        else
        {
            [self showAlertWithMessage:@"Couldn't connect to server"];
        }
        //                [appDelegate saveContext];
        
    }
    else
    {
        if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
            if ([[NSString stringWithFormat:@"%@",[parsedData[@"ReturnObject"] objectForKey:@"NotificationCount"]] isEqualToString:@"0"]) {
                //
            }
            else
            {
            _notificationLabel.text = [NSString stringWithFormat:@"%@",[parsedData[@"ReturnObject"] objectForKey:@"NotificationCount"]];
            [self animateTheNotificationIcon];
            }
        }
        else
        {
            [self showAlertWithMessage:parsedData[@"Error"]];
        }
        
    }
    //    "ImgProfile": "sample string 1",
    //    "CustomerId": 2,
    //    "CustomerLegalName": "sample string 3",
    //    "RemainingTime": "00:00:00.1234567",
    //    "WorkOrderNo": "sample string 5",
    //    "RequestedETA": "2017-08-03T16:44:38.4058373+05:30",
    //    "Completed": 7,
    //    "Rejected": 8,
    //    "Pending": 9
    
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
    if ([[segue identifier]isEqualToString:[StoryboardsAndSegues segue_JobList]]) {
        JobsListViewController * destinationViewController = [segue destinationViewController];
        destinationViewController.workStatus = workStatusSelected;
    }
    else if ([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_Checkout]])
    {
        CheckoutViewController * checkOutViewController = segue.destinationViewController;
        WorkOrderInfo * workOrderInfo = [[WorkOrderInfo alloc]init];
        workOrderInfo.workOrderNumber=_workOrderNumberLabel.text;
        workOrderInfo.workOrderId = recentWorkOrderId;
        workOrderInfo.requestedEtaId =appoximateEtaTimeForRecentWorkOrder;
        checkOutViewController.workOrderInfo =workOrderInfo;

//        checkOutViewController.workOrderNumber =_workOrderNumberLabel.text;
//        checkOutiewController.workOrderId = recentWorkOrderId;
//        checkOutViewController.approximateEtaTime = appoximateEtaTimeForRecentWorkOrder;
    }
    else if ([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_ConfirmWorkOrder]])
    {
        ConfirmWorkOrderViewController * confirmWorkOrderViewController = segue.destinationViewController;
        //        checkOutViewController.workOrderNumber =_workOrderNumberLabel.text;
        confirmWorkOrderViewController.worOrderId = recentWorkOrderId;
        confirmWorkOrderViewController.workStatus = [NSString stringWithFormat:@"%d", recentWorkOrderStatusId ];
        
        //        checkOutViewController.approximateEtaTime = appoximateEtaTimeForRecentWorkOrder;
    }
    else if ([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_NewWorkOrder]])
    {
        NewJobNotificationViewController * newJobNotificationViewController = segue.destinationViewController;
        newJobNotificationViewController.workOrderId = recentWorkOrderId;
    }

    
}


@end
