//
//  JobsListViewController.h
//  FasBackTechnician
//
//  Created by User on 20/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobListableViewCell.h"
#import "Webservice.h"
#import "WorkOrder.h"
#import "WorkOrderInfo.h"
#import "RatingTableViewCell.h"
@interface JobsListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,webProtocol>
{
    float width, height;
    Webservice * webservice;
    NSMutableArray * sampleArrayForJobList , * sampleArrayForJobListDates , * jobListArray;
    int workOrderNumerForcompleted,workOrderNumerForRating, workOrderNumerForOpen , workOrderNumberForRejected, workOrderNumberForAccepted, workOrderNumberForAssigned;
    WorkOrder * workOrder;
}

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UITableView *jobListTableView;


@property NSString * workStatus;
@end
