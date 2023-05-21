//
//  JobsListViewController.m
//  FasBackTechnician
//
//  Created by User on 20/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "JobsListViewController.h"
#import "UIColor+Customcolor.h"
#import "ConstantColors.h"
#import "UIFont+PoppinsFont.h"
#import "Constants.h"
#import <MFSideMenu.h>
#import "AppDelegate.h"
#import "StoryboardsAndSegues.h"
#import "ConfirmWorkOrderViewController.h"
#import "CheckoutViewController.h"
#import <UIImageView+AFNetworking.h>
#import "NewJobNotificationViewController.h"
#import "OpenWorkOrderTableViewCell.h"

@interface JobsListViewController ()
{
    AppDelegate * appDelegate;

}

@end

@implementation JobsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self restoretoDefaults];
    
    [self changesInUI];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    self.menuContainerViewController.panMode = MFSideMenuPanModeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - General

-(void) restoretoDefaults
{
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    
    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
    
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
//    self.jobListTableView.rowHeight = UITableViewAutomaticDimension;

    
    sampleArrayForJobList = [NSMutableArray arrayWithObjects:@"WEB-6416879",@"WEB-6416892",@"WEB-6416560",@"WEB-6416713",@"WEB-6416725",@"WEB-6416826", nil];
    sampleArrayForJobListDates = [NSMutableArray arrayWithObjects:@"03 Jun, 12:45 PM",@"27 May, 03:16 PM",@"02 May, 06:19 PM",@"02 Apr, 11:12 AM",@"12 Mar, 11:19 AM",@"01 Feb, 04:43 PM", nil];
    jobListArray = [[NSMutableArray alloc]init];
    
    workOrderNumerForOpen = 5;
    workOrderNumberForRejected = 8;
    workOrderNumerForRating = 13;
    workOrderNumberForAssigned = 2;
    workOrderNumberForAccepted = 3 ;
    workOrderNumerForcompleted = 6;
    
    _jobListTableView.hidden = YES;
    [self webserviceForJobList];
}

-(void) changesInUI
{
    if ([_workStatus isEqualToString: CompletedWork]) {
    _headerLabel.text = @"Completed";
    }
    else if ([_workStatus isEqualToString: OpenWork])
    {
        _headerLabel.text = @"Open";
    }
    else if ([_workStatus isEqualToString: AcceptedWork])
    {
        _headerLabel.text = @"Accepted";
    }
    else if ([_workStatus isEqualToString: CompletedWork])
    {
        _headerLabel.text = @"Completed";
    }
    else if ([_workStatus isEqualToString: AssignedWork])
    {
        _headerLabel.text = @"Assigned";
    }
    else if ([_workStatus isEqualToString: RatingsForWork])
    {
        _headerLabel.text = @"Ratings";
    }
    else
    {
        _headerLabel.text = @"Rejected";
    }
}


-(void) showAlertWithMessage : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark- Web service

-(void) webserviceForJobList
{
    [appDelegate initActivityIndicatorForviewController:self];
    
    NSString * stringWithUrl;
    if ([_workStatus isEqualToString: RatingsForWork]) {

    stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/GetWorkOrderListByStatus/%d",[Webservice webserviceLink],workOrderNumerForRating];
    }
    else if ([_workStatus isEqualToString: AcceptedWork])
    {
        stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/GetWorkOrderListByStatus/%d",[Webservice webserviceLink],workOrderNumberForAccepted];
    }
    else if ([_workStatus isEqualToString: RejectedWork])
    {
        stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/GetWorkOrderListByStatus/%d",[Webservice webserviceLink],workOrderNumberForRejected];
    }
    if ([_workStatus isEqualToString: AssignedWork]) {
        
        stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/GetWorkOrderListByStatus/%d",[Webservice webserviceLink],workOrderNumberForAssigned];
    }
    else if ([_workStatus isEqualToString: OpenWork])
    {
        stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/GetWorkOrderListByStatus/%d",[Webservice webserviceLink],workOrderNumerForOpen];
    }
    else if ([_workStatus isEqualToString: CompletedWork])
    {
        stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/GetWorkOrderListByStatus/%d",[Webservice webserviceLink],workOrderNumerForcompleted];
    }
    [webservice requestMethod:stringWithUrl withMsgType:12];
    
}

#pragma mark - UIButton Actions

- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableView Datasoure

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return jobListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    workOrder = [[WorkOrder alloc]init];
    workOrder= jobListArray[indexPath.row];
    
    NSString * dateStringToBeDisplayed = @"";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *requestedETAString = workOrder.updatedTime;
    if (requestedETAString != [NSNull null]) {
    requestedETAString = [requestedETAString stringByReplacingOccurrencesOfString:@"T" withString:@" " ];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *yourDate = [dateFormatter dateFromString:requestedETAString];
    if (yourDate == nil) {
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    yourDate = [dateFormatter dateFromString:requestedETAString];

    dateFormatter.dateFormat = @"dd MMM, hh:mm a";
    NSLog(@"date %@",[dateFormatter stringFromDate:yourDate]);
        dateStringToBeDisplayed = [dateFormatter stringFromDate:yourDate];
    }
    else
    {
       dateStringToBeDisplayed = @"";
    }
    if ([_workStatus isEqualToString:RatingsForWork]) {
        RatingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[RatingTableViewCell reuseIdentifier] forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[RatingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[RatingTableViewCell reuseIdentifier]];
        }
        cell.workOrderNumberLabel.text = workOrder.workOrderNumner;
        cell.dateOfCompletionLabel.text = dateStringToBeDisplayed;
        cell.starRatingView.rating = [workOrder.ratingOfWorkOrder floatValue];
        cell.feedbackOfWorkOrderLabel.text = workOrder.feedbackDecription;
        return cell;
    }
    else if ([_workStatus isEqualToString:OpenWork]) {
        OpenWorkOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[OpenWorkOrderTableViewCell reuseIdentifier] forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[OpenWorkOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[OpenWorkOrderTableViewCell reuseIdentifier]];
        }
        cell.workOderNumberLabel.text = workOrder.workOrderNumner;
        cell.dateLabel.text = dateStringToBeDisplayed;
        [cell.workOrderImageView setImageWithURL:[NSURL URLWithString:workOrder.imageProfileString]];
        cell.statusLabel.text = workOrder.statusOfWorkOrder;
        cell.workOderDescriptionLabel.text = workOrder.requestType;
        return cell;
        
    }
    else
    {
    JobListableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[JobListableViewCell reuseIdentifier] forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[JobListableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[JobListableViewCell reuseIdentifier]];
    }
   

    cell.jobDescriptionLabel.text = workOrder.requestType;
    cell.jobName.text = workOrder.workOrderNumner;

     if ([_workStatus isEqualToString: RejectedWork] )
    {
        // Pending
        cell.dateLabel.text = dateStringToBeDisplayed;
        cell.jobStatusLabel.text = workOrder.statusOfWorkOrder;
        cell.jobStatusLabel.textColor = [UIColor ColorWithHexaString:@"f9954b"];
        cell.logoImgeView.image = [UIImage imageNamed:@"PendingWorkIcon"];
        if ([workOrder.statusOfWorkOrder isEqualToString:@"Reached"]) {
            cell.jobStatusLabel.text = @"Reached";
        }
        
    }
    else if ([_workStatus isEqualToString: AcceptedWork] || [_workStatus isEqualToString: CompletedWork] ||  [_workStatus isEqualToString: AssignedWork])
    {
        // Rejected
        cell.dateLabel.text = dateStringToBeDisplayed;
        cell.jobName.text = workOrder.workOrderNumner;
        cell.jobStatusLabel.hidden = YES;
    }

    [cell.logoImgeView setImageWithURL:[NSURL URLWithString:workOrder.imageProfileString]];

    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_workStatus isEqualToString:RatingsForWork]) {
        return 100;
    }
    else if ([_workStatus isEqualToString:OpenWork]) {
        return 110;
    }

    return 74.0f;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 29)];
//    /* Create custom view to display section header... */
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, tableView.frame.size.width, 17)];
//    [label setFont:[UIFont poppinsNormalFontWithSize:14]];
//    label.textColor = [UIColor ColorWithHexaString:@"83878A"];
//    NSString *string =@"Last week";
//
//    [label setText:string];
//    [view addSubview:label];
//    [view setBackgroundColor:[UIColor ColorWithHexaString:@"f9fafa"]];
//
//    UIView * bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 28, tableView.frame.size.width, 1)];
//    bottomLine.backgroundColor = [UIColor ColorWithHexaString:@"D2D5D6"];
//    
//    [view addSubview:bottomLine];
//    return view;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 29;
//}
#pragma mark - UITabl eView Delegates

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    workOrder = [jobListArray objectAtIndex:indexPath.row];
    if ([_workStatus isEqualToString:RatingsForWork]) {
        [self performSegueWithIdentifier:[StoryboardsAndSegues segue_ConfirmWorkOrder] sender:nil];
    }
    else if ([_workStatus isEqualToString:RejectedWork]) {
        [self performSegueWithIdentifier:[StoryboardsAndSegues segue_ConfirmWorkOrder] sender:nil];
    }
    else if ([_workStatus isEqualToString:AcceptedWork]) {
        [self performSegueWithIdentifier:[StoryboardsAndSegues segue_ConfirmWorkOrder] sender:nil];
    }
    else if ([_workStatus isEqualToString:CompletedWork]) {
        [self performSegueWithIdentifier:[StoryboardsAndSegues segue_ConfirmWorkOrder] sender:nil];
    }
    else if ([_workStatus isEqualToString:AssignedWork]) {
        [self performSegueWithIdentifier:[StoryboardsAndSegues segue_NewWorkOrder] sender:nil];
    }
    else if ([_workStatus isEqualToString: OpenWork]) {
        if ([workOrder.statusOfWorkOrder isEqualToString:@"Accepted"]) {
            [self performSegueWithIdentifier:[StoryboardsAndSegues segue_ConfirmWorkOrder] sender:nil];
        }
        else if ([workOrder.statusOfWorkOrder isEqualToString:@"Reached"])
        {
            [self performSegueWithIdentifier:[StoryboardsAndSegues segue_ConfirmWorkOrder] sender:nil];
        }
        else if ([workOrder.statusOfWorkOrder isEqualToString:@"Checked In"])
        {
            [self performSegueWithIdentifier:[StoryboardsAndSegues segue_Checkout] sender:nil];
        }
        else if ([workOrder.statusOfWorkOrder isEqualToString:@"On Hold"])
        {
            [self performSegueWithIdentifier:[StoryboardsAndSegues segue_ConfirmWorkOrder] sender:nil];
        }

        
    }
}


#pragma mark - Webservice delagate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];
    NSLog(@"%@",parsedData);
    if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
        if ( [parsedData objectForKey:@"ReturnObject"] != [NSNull null]) {
            NSDictionary * resultData = [parsedData objectForKey:@"ReturnObject"];
            if ( [resultData objectForKey:@"WorkOrders"] != [NSNull null]) {
                NSArray * arrayWithJobList = [resultData objectForKey:@"WorkOrders"];
                if (arrayWithJobList.count != 0) {
                for (int i = 0; i< [arrayWithJobList count]; i++) {
                    NSDictionary * dictionaryAtEachIndex = [arrayWithJobList objectAtIndex:i];
                    WorkOrder * eachworkOrder = [[WorkOrder alloc]init];
                    eachworkOrder.imageProfileString = [dictionaryAtEachIndex objectForKey:@"ImgUrl"];
                    eachworkOrder.workOrderNumner = [dictionaryAtEachIndex objectForKey:@"WorkOrderNo"];
                    eachworkOrder.workOrderId = [dictionaryAtEachIndex objectForKey:@"WorkOrderId"];
                    eachworkOrder.updatedTime = [dictionaryAtEachIndex objectForKey:@"RequestedETA"];
                    eachworkOrder.equipmentId = [dictionaryAtEachIndex objectForKey:@"EquipmentId"];
                    eachworkOrder.equipmentName = [dictionaryAtEachIndex objectForKey:@"EquipmentName"];
                    eachworkOrder.requestType = [dictionaryAtEachIndex objectForKey:@"RequestType"];
                    eachworkOrder.statusOfWorkOrder = [dictionaryAtEachIndex objectForKey:@"WOStatus"];
                    eachworkOrder.ratingOfWorkOrder = [dictionaryAtEachIndex objectForKey:@"Rating"];
                    eachworkOrder.feedbackDecription = [dictionaryAtEachIndex objectForKey:@"FeedbackDesc"];

                    
                    
//                    if ([_workStatus isEqualToString:AcceptedWork]) {
//                        if ([eachworkOrder.statusOfWorkOrder isEqualToString: @"Accepted"]) {
//                            [jobListArray addObject:eachworkOrder];
//                        }
//                    }
//                    else if ([_workStatus isEqualToString:CompletedWork]) {
//                        if ([eachworkOrder.statusOfWorkOrder isEqualToString: @"Checked Out"]) {
//                            [jobListArray addObject:eachworkOrder];
//                        }
//                    }
//                    else if ([_workStatus isEqualToString:OpenWork]) {
//                        if ([eachworkOrder.statusOfWorkOrder isEqualToString: @"Checked In"] || [eachworkOrder.statusOfWorkOrder isEqualToString: @"On Hold"] || [eachworkOrder.statusOfWorkOrder isEqualToString: @"Reached"]   ) {
//                            [jobListArray addObject:eachworkOrder];
//                        }
//                    }
//                    else
//                    {
                        [jobListArray addObject:eachworkOrder];
//                    }
                    
                    
                }
                
                [_jobListTableView reloadData];
                _jobListTableView.hidden = NO;
                }
                else
                {
                    [self showAlertWithMessage:@"No work order available"];
                }
            }
            else
            {
                [self showAlertWithMessage:@"No work order available"];
                
            }
        }
        else
        {
            [self showAlertWithMessage:@"No work order available"];
            
        }
    }
    else
    {
        [self showAlertWithMessage:[parsedData objectForKey:@"ErrorDescription"]];
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
    if ([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_ConfirmWorkOrder]]) {
        ConfirmWorkOrderViewController * confirmWorkOrderDetailsViewController = segue.destinationViewController;
        confirmWorkOrderDetailsViewController.worOrderId = workOrder.workOrderId;
        confirmWorkOrderDetailsViewController.workStatus = workOrder.statusOfWorkOrder;

    }
    else if ([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_Checkout]]) {
        CheckoutViewController * checkOutViewController = segue.destinationViewController;
//        checkOutViewController.workOrderId = workOrder.workOrderId;
//        checkOutViewController.workOrderNumber = workOrder.workOrderNumner;
        
        WorkOrderInfo * workOrderInfo = [[WorkOrderInfo alloc]init];
        workOrderInfo.workOrderNumber = workOrder.workOrderNumner;
        workOrderInfo.workOrderId = workOrder.workOrderId;
        workOrderInfo.requestedEtaId = workOrder.updatedTime;;
        
        checkOutViewController.workOrderInfo = workOrderInfo;

        NSString * dateStringToBeDisplayed = @"";

        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        NSString *requestedETAString = workOrder.updatedTime;
        if (requestedETAString != [NSNull null]) {
        requestedETAString = [requestedETAString stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *yourDate = [dateFormatter dateFromString:requestedETAString];
        if (yourDate == nil) {
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        }
        yourDate = [dateFormatter dateFromString:requestedETAString];

        yourDate = [dateFormatter dateFromString:requestedETAString];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        requestedETAString = [requestedETAString stringByReplacingOccurrencesOfString:@" " withString:@"T" ];
        
        NSLog(@"date %@",[dateFormatter stringFromDate:yourDate]);
        
        workOrderInfo.requestedEtaId = [dateFormatter stringFromDate:yourDate];
    
        checkOutViewController.workOrderInfo = workOrderInfo;
    }
        else
        {
            workOrderInfo.requestedEtaId = @"";
            
            checkOutViewController.workOrderInfo = workOrderInfo;
        }
//        checkOutViewController.approximateEtaTime = [dateFormatter stringFromDate:yourDate];

    }
    else
    {
        NewJobNotificationViewController * newJobNotificationViewController = segue.destinationViewController;
        newJobNotificationViewController.workOrderId = workOrder.workOrderId;
        newJobNotificationViewController.workStatus = workOrder.workOrderStatusId;

    }
}


@end
