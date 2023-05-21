//
//  NotificationListViewController.h
//  fasBackTechnician
//
//  Created by User on 21/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservice.h"
#import "WorkOrder.h"
@interface NotificationListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,webProtocol>
{
    NSMutableArray * sampleArrayForNotificationList, *sampleArrayForNotificationDates , * arraywithNotificationList;
    Webservice * webservice;

    __weak IBOutlet UITableView *notificationTableView;
    WorkOrder * workOrderSelected;
    int fontOfNotificationName , fontOfDateOfNotification;
    
    float width, height;
    
    BOOL isImmediate;
}
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@end
