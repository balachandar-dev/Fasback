//
//  HoldAndDiscardWorkOrderViewController.h
//  fasBackTechnician
//
//  Created by User on 16/09/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservice.h"
#import "RejectReasons.h"

@interface HoldAndDiscardWorkOrderViewController : UIViewController<webProtocol>
{
    float width,height;
    Webservice * webservice;
    NSMutableArray * arrayWithHoldOrDiscardReasons;
    RejectReasons * holdOrDiscardReason;

}

@property BOOL isHold;

@property(nonatomic,strong) NSString * workOderId, * workOrderNo;
@property RejectReasons * holdOrDiscardReasonSelected;


@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLineOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLineTwoLabel;
@property (weak, nonatomic) IBOutlet UIButton *reasonButton;
@property (weak, nonatomic) IBOutlet UIButton *OkButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end
