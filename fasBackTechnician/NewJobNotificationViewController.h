//
//  NewJobNotificationViewController.h
//  FasBackTechnician
//
//  Created by User on 20/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservice.h"
#import "WorkOrderInfo.h"
#import "StepsInGoogleMap.h"

@interface NewJobNotificationViewController : UIViewController<webProtocol>
{
    float width, height;
    BOOL isRejected;
    Webservice * webservice;
    WorkOrderInfo * workPrderInfo;
    NSString * contactAddressReceived;
    StepsInGoogleMap * customerLocation;
}

@property NSString * workStatus, * workOrderId;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIButton *rejectButton;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;

@property (weak, nonatomic) IBOutlet UILabel *placeholederLabelForLogoImage;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *workOrderName;
@property (weak, nonatomic) IBOutlet UILabel *remainingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *workOrderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *workOrderTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *requestedOnLabel;
@property (weak, nonatomic) IBOutlet UILabel *requestedEtaLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintOfScrollView;

@property (weak, nonatomic) IBOutlet UIButton *callCustomerButton;
@property (weak, nonatomic) IBOutlet UIButton *viewLocationButton;


@end
