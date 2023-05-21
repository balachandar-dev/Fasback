//
//  NotificationListViewController.m
//  fasBackTechnician
//
//  Created by User on 21/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "NotificationListViewController.h"
#import "UIFont+PoppinsFont.h"
#import "StoryboardsAndSegues.h"
#import <MFSideMenu.h>
#import "AppDelegate.h"
#import "NewJobNotificationViewController.h"
#import <UIImageView+AFNetworking.h>
#import "ConfirmWorkOrderViewController.h"
#import "UIFont+PoppinsFont.h"
@interface NotificationListViewController ()
{
    AppDelegate * appDelegate;

}
@end

@implementation NotificationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self restoreToDefaults];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    self.menuContainerViewController.panMode = MFSideMenuPanModeNone;

}

-(void)viewWillAppear:(BOOL)animated
{
    arraywithNotificationList = [[NSMutableArray alloc]init];
    [self webserviceForJobList];

}

#pragma mark - General 

-(void) restoreToDefaults
{
    sampleArrayForNotificationList = [NSMutableArray arrayWithObjects:@"New Work Order WEB-298756 (AC Failure)",@"Hansesn Limited has assigned you WEB-456898 (AC Failure).",@"365 Warehousing has revoked your assignment WEB-456898 (AC Failure).",@"Spare Parts for WEB-456898 (AC Failure) has been delayed by 10 days.",@"Your profile update request has been approved.",@"Track Management has sent you a message:“It’s way past the ETA requested, hope you reach soon & resolve the issue”", nil];
    sampleArrayForNotificationDates = [NSMutableArray arrayWithObjects:@"20 mins ago",@"4hrs ago",@"1 day ago",@"5 days ago",@"25 days ago",@"1 month ago",@"1 month ago", nil];
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
    
    
    if (height == 568) {
        fontOfNotificationName = 12;
        fontOfDateOfNotification = 11;
        _headerLabel.font = [UIFont poppinsSemiBoldFontWithSize:14];
    }
    else if (height == 667)
    {
        fontOfNotificationName = 14;
        fontOfDateOfNotification = 12;
    }
    else if (height == 736)
    {
        fontOfNotificationName = 14;
        fontOfDateOfNotification = 12;
    }
    else
    {
        fontOfNotificationName = 10;
        fontOfDateOfNotification = 8;
    }

}
-(NSString *) generateTimeWithMinutes : (NSString *) minutesReceived
{
//    minutesReceived = [minutesReceived stringByReplacingOccurrencesOfString:@" minutes ago" withString:@""];
    
    int minutes = [minutesReceived intValue];
    NSLog(@"minutes %d",minutes);
    if (minutes >= 43200) {
        int noOfMonths = minutes / 43200;
        if (noOfMonths == 1) {
            return [NSString stringWithFormat:@"%d month ago",noOfMonths];
        }
        else
        {
        return [NSString stringWithFormat:@"%d months ago",noOfMonths];
        }
    }
   else if (minutes >= 1440) {
        int noOfDays = minutes / 1440;
        if (noOfDays == 1) {
            return [NSString stringWithFormat:@"%d day ago",noOfDays];
        }
        else
        {
            return [NSString stringWithFormat:@"%d days ago",noOfDays];
        }
    }
    else if (minutes >= 60)
    {
    int noOfHours = minutes / 60;
        if (noOfHours == 1) {
            return [NSString stringWithFormat:@"%d hour ago",noOfHours];
        }
        else
        {
            return [NSString stringWithFormat:@"%d hours ago",noOfHours];
        }
    }
    else
    {
        if (minutes == 1) {
        return [NSString stringWithFormat:@"%d minute ago",minutes];
        }
        else
        {
            return [NSString stringWithFormat:@"%d minutes ago",minutes];
        }
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
    
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/Admin/Notification/GetNotifications",[Webservice webserviceLink]];
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
//    return [sampleArrayForNotificationList count];

    return [arraywithNotificationList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    WorkOrder * eachWorkOrder = [[WorkOrder alloc]init];
    eachWorkOrder = [arraywithNotificationList objectAtIndex:indexPath.row];
    
    UILabel * titleLabel = (UILabel *)[tableView viewWithTag:51];
//    titleLabel.text = [sampleArrayForNotificationList objectAtIndex:indexPath.row];
    
//    titleLabel.text = eachWorkOrder.workOrderName;
    
//    if (indexPath.row == 0) {
//        eachWorkOrder.workOrderName = @"Open sensor fact";
//    }
    
    titleLabel.font = [UIFont poppinsNormalFontWithSize:fontOfNotificationName];
    NSString * messageAttributedText = eachWorkOrder.workOrderName;
    NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:messageAttributedText];
    
    NSRange range = [messageAttributedText rangeOfString:eachWorkOrder.highlightedText];
    [attString addAttribute:NSFontAttributeName value:[UIFont poppinsSemiBoldFontWithSize:fontOfNotificationName] range:range];
    titleLabel.attributedText = attString;

    
    UILabel * timeLabel = (UILabel *)[tableView viewWithTag:52];
    timeLabel.font = [UIFont poppinsNormalFontWithSize:fontOfDateOfNotification];
    timeLabel.text = [self generateTimeWithMinutes:eachWorkOrder.updatedTime];
    
//    timeLabel.text =eachWorkOrder.updatedTime;

    UIImageView * imageVieInTable = (UIImageView *)[tableView viewWithTag:50];
//    imageVieInTable.image =[UIImage imageNamed:arrayWithImages[indexPath.row]];
    [imageVieInTable setImageWithURL:[NSURL URLWithString:eachWorkOrder.imageProfileString]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkOrder * eachWorkOrder = [[WorkOrder alloc]init];
    eachWorkOrder = [arraywithNotificationList objectAtIndex:indexPath.row];
    
//    NSString *str = [sampleArrayForNotificationList objectAtIndex:indexPath.row];
    
    NSString *notificationNameString = eachWorkOrder.workOrderName;

    CGSize sizeOfNotificationName = [notificationNameString sizeWithFont:[UIFont poppinsNormalFontWithSize:fontOfNotificationName] constrainedToSize:CGSizeMake(280, 999) lineBreakMode:NSLineBreakByWordWrapping];
    
//    NSString *str2 = @"20 minutes ago";
    NSString *dateString = eachWorkOrder.updatedTime;

        CGSize sizeOfDateLabel = [dateString sizeWithFont:[UIFont poppinsNormalFontWithSize:fontOfDateOfNotification] constrainedToSize:CGSizeMake(280, 999) lineBreakMode:NSLineBreakByWordWrapping];
        NSLog(@"%f",sizeOfDateLabel.height);
    
        return sizeOfNotificationName.height + sizeOfDateLabel.height + 40;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    workOrderSelected = [[WorkOrder alloc]init];
    workOrderSelected = [arraywithNotificationList objectAtIndex:indexPath.row];

    if ([workOrderSelected.workOrderStatusId isEqualToString:@"1"] || [workOrderSelected.workOrderStatusId isEqualToString:@"2"] || [workOrderSelected.workOrderStatusId isEqualToString:@"4"]) {
        [self performSegueWithIdentifier:[StoryboardsAndSegues segue_NewWorkOrder] sender:nil];
    }
    else if ([workOrderSelected.workOrderStatusId isEqualToString:@"18"]) {
        
    }
    else
    {
        [self performSegueWithIdentifier:[StoryboardsAndSegues segue_ConfirmWorkOrder] sender:nil];
    }
}


#pragma mark - Webservice delagate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];
    NSLog(@"%@",parsedData);
    if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
    if ([parsedData objectForKey:@"ReturnObject"] != [NSNull null]) {
        NSDictionary * resultData = [parsedData objectForKey:@"ReturnObject"];
        if ([resultData objectForKey:@"Notifications"] != [NSNull null]) {
            NSArray * arrayWithJobList = [resultData objectForKey:@"Notifications"];
            if (arrayWithJobList.count != 0) {
            for (int i = 0; i< [arrayWithJobList count]; i++) {
                NSDictionary * dictionaryAtEachIndex = [arrayWithJobList objectAtIndex:i];
                WorkOrder * workOrder = [[WorkOrder alloc]init];
                if ([dictionaryAtEachIndex objectForKey:@"Action"] != [NSNull null]) {
                    workOrder.workOrderStatusId = [NSString stringWithFormat:@"%@", [dictionaryAtEachIndex objectForKey:@"Action"] ];
                }
                if ([dictionaryAtEachIndex objectForKey:@"UserImageUrl"] != [NSNull null]) {
                    workOrder.imageProfileString = [dictionaryAtEachIndex objectForKey:@"UserImageUrl"];
                }
                if ([dictionaryAtEachIndex objectForKey:@"WorkOrderNo"] != [NSNull null]) {
                    workOrder.workOrderNumner = [dictionaryAtEachIndex objectForKey:@"WorkOrderNo"];
                }
                if ([dictionaryAtEachIndex objectForKey:@"WorkOrderID"] != [NSNull null]) {
                    workOrder.workOrderId = [dictionaryAtEachIndex objectForKey:@"WorkOrderID"];
                }
                if ([dictionaryAtEachIndex objectForKey:@"TimeAgo"] != [NSNull null]) {
                    
                    workOrder.updatedTime = [[dictionaryAtEachIndex objectForKey:@"TimeAgo"] stringByReplacingOccurrencesOfString:@" minutes ago" withString:@""];
                }
                if ([dictionaryAtEachIndex objectForKey:@"CreatedOn"] != [NSNull null]) {
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    NSString *requestedETAString = [dictionaryAtEachIndex objectForKey:@"CreatedOn"];
                        requestedETAString = [requestedETAString stringByReplacingOccurrencesOfString:@"T" withString:@" " ];
                        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SS";
                        workOrder.createdOnDate = [dateFormatter dateFromString:requestedETAString];
                    if (workOrder.createdOnDate == nil) {
                        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                    }
                    workOrder.createdOnDate = [dateFormatter dateFromString:requestedETAString];
                    NSTimeInterval distanceBetweenDates = [[NSDate date] timeIntervalSinceDate:workOrder.createdOnDate];
                    double minutesInAnHour = 60;
                    NSInteger minutesBetweenDates = distanceBetweenDates / minutesInAnHour;
                    
                    workOrder.updatedTime = [NSString stringWithFormat:@"%ld", (long)minutesBetweenDates ];
                    
                }

                if ([dictionaryAtEachIndex objectForKey:@"BlackHighlightText"] != [NSNull null]) {
                    workOrder.highlightedText = [dictionaryAtEachIndex objectForKey:@"BlackHighlightText"];
                }
                //        workOrder.equipmentId = [dictionaryAtEachIndex objectForKey:@"EquipmentId"];
                //        workOrder.equipmentName = [dictionaryAtEachIndex objectForKey:@"EquipmentName"];
                if ([dictionaryAtEachIndex objectForKey:@"Notification"] != [NSNull null]) {
                    workOrder.workOrderName = [dictionaryAtEachIndex objectForKey:@"Notification"];
                }
                
                [arraywithNotificationList addObject:workOrder];
            }
            
//            NSSortDescriptor *sortDescriptor;
//            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"updatedTime"
//                                                          ascending:YES] ;
//            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
//            NSArray *sortedArray;
////            sortedArray = [arraywithNotificationList sortedArrayUsingDescriptors:sortDescriptors];
//            
//            [arraywithNotificationList sortUsingDescriptors:sortDescriptors];
            
            NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"createdOnDate" ascending:NO];
            [arraywithNotificationList sortUsingDescriptors:[NSArray arrayWithObject:sorter]];
            
            NSArray* reversedArray = [[arraywithNotificationList reverseObjectEnumerator] allObjects];
            arraywithNotificationList = [NSMutableArray arrayWithArray:reversedArray];
            
            [notificationTableView reloadData];
            }
            else
            {
                [self showAlertWithMessage:@"No notifications available"];
            }
        }
        else
        {
            [self showAlertWithMessage:@"No notifications available"];
        }
    }
    else
    {
        [self showAlertWithMessage:@"No notifications available"];
    }
    }
    else
    {
        if (parsedData[@"Error"] != [NSNull null]) {
        [self showAlertWithMessage:parsedData[@"Error"]];
        }

    }
//       NSArray * sortedArray = [arraywithNotificationList sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
//            NSString *first = [(WorkOrder*)a updatedTime];
//            NSString *second = [(WorkOrder*)b updatedTime];
//            return [first compare:second];
//        }];
//        
//    
//        
//        
//        arraywithNotificationList = [NSMutableArray arrayWithArray:sortedArray];
    
}




-(void)errorRecieved:(NSString *)errorString withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];
//    [self showAlertWithMessage:errorString];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_sensorfact]]) {
        //
    }
    else if ([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_ConfirmWorkOrder]]) {
        ConfirmWorkOrderViewController * confirmWorkOrderDetailsViewController = segue.destinationViewController;
        confirmWorkOrderDetailsViewController.worOrderId = workOrderSelected.workOrderId;
        confirmWorkOrderDetailsViewController.workStatus = workOrderSelected.workOrderStatusId;

    }

    else
    {
    NewJobNotificationViewController * newJobNotificationViewController = segue.destinationViewController;
    newJobNotificationViewController.workOrderId = workOrderSelected.workOrderId;
    newJobNotificationViewController.workStatus = workOrderSelected.workOrderStatusId;

    }
}


@end
