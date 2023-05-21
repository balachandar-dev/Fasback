//
//  DashboardViewController.h
//  FasBackTechnician
//
//  Created by User on 20/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashboardTableViewCell.h"
#import "Webservice.h"
#import <AFNetworkReachabilityManager.h>

@interface DashboardViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,webProtocol,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray * arrayWithNumberOfWorkCompleted, * arrayWithStatus, * arrayWithIcons , * arrayWithJobStatusImages;
    NSString * workStatusSelected, *recentWorkOrderId , * appoximateEtaTimeForRecentWorkOrder;
    Webservice * webservice;
    int numberOfCompletedWorkOrder,  numberOfRejectedWorkOrder, numberOfPendingWorkOrder, recentWorkOrderStatusId;
    float height, width;
    AFNetworkReachabilityManager * reachabilityManager;
}

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *workOrderNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *workOrderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *requestedEtaLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomViewOfTopCard;
@property (weak, nonatomic) IBOutlet UILabel *placeholederLabelForLogoImage;
@property (weak, nonatomic) IBOutlet UIView *backgroundOfTopCard;
@property (weak, nonatomic) IBOutlet UILabel *workOrderNameTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *requestedEtaTitleLabel;


@property (weak, nonatomic) IBOutlet UITableView *dashboardTableView;
@property (weak, nonatomic) IBOutlet UILabel *notificationLabel;
@property (weak, nonatomic) IBOutlet UIButton *notificationButton;
@property (weak, nonatomic) IBOutlet UICollectionView *dshboardCollectionView;
@property (weak, nonatomic) IBOutlet UIView *bottomiewOfHeaderView;

@end
