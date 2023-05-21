//
//  ViewSensorFactViewController.h
//  fasBackTechnician
//
//  Created by User on 02/09/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewSensorfactTableViewCell.h"
#import "Webservice.h"
#import "SensorFactData.h"
#import "WorkOrderInfo.h"

@interface ViewSensorFactViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,webProtocol>
{
    NSMutableArray * arrayWithSnsorfactData;
    Webservice * webservice;
    UIRefreshControl * refreshControl;
    float height, width;
}
@property (weak, nonatomic) IBOutlet UITableView *sensorFactTableView;
@property (weak, nonatomic) IBOutlet UIButton *holdButton;
@property (weak, nonatomic) IBOutlet UIButton *checkoutButton;

@property (weak, nonatomic) IBOutlet UICollectionView *sensorFsctCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstrainOfCollectionView;
@property WorkOrderInfo * workOrderInfo;
@end
