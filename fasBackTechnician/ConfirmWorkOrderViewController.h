//
//  ConfirmWorkOrderViewController.h
//  fasBackTechnician
//
//  Created by User on 22/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservice.h"
#import "WorkOrderInfo.h"
#import "StepsInGoogleMap.h"

@interface ConfirmWorkOrderViewController : UIViewController<webProtocol>
{
    float width, height;
    Webservice * webservice;
    WorkOrderInfo * workPrderInfo;
    NSString * contactAddressReceived;
    StepsInGoogleMap * customerLocation;
    BOOL isREachedWorkOrderCalled;
}

@property NSString * workStatus, * worOrderId;
@property NSDictionary * dictionaryWithWorkOrderDetails;

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIButton *discardButton;
@property (weak, nonatomic) IBOutlet UIButton *checkInButton;

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *workOrderName;
@property (weak, nonatomic) IBOutlet UILabel *remainingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *workOrderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *workOrderTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *requestedOnLabel;
@property (weak, nonatomic) IBOutlet UILabel *requestedEtaLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *issueLabel;
@property (weak, nonatomic) IBOutlet UIView *backgroundViewForHeaderButtons;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintOfScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraintContactPersonViewAndEndingTime;

@end
