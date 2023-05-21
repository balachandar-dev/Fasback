//
//  CheckoutViewController.h
//  fasBackTechnician
//
//  Created by User on 22/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservice.h"
#import "customDatePickerView.h"
#import "WorkOrderInfo.h"

@interface CheckoutViewController : UIViewController<UITextViewDelegate,webProtocol>
{
    float width,height;
    BOOL isResolved;
    Webservice * webservice;
    customDatePickerView * objectForCustomDatePickerView;
    UIView * transparentBAckgroundView;
    NSString  * timeSelectedInTimePicker, * dateSelected, * jobIdReceived;

}

//@property (strong,nonatomic) NSString * workOrderId, * workOrderNumber, * approximateEtaTime;
@property WorkOrderInfo * workOrderInfo;

// UI Elements

@property (weak, nonatomic) IBOutlet UILabel *checkOutLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLineOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *hasIssueResolvedMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextEtaLabel;

@property (weak, nonatomic) IBOutlet UITextView *descriptionTExtView;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIButton *datPickerButton;
@property (weak, nonatomic) IBOutlet UIButton *resolvedSwitchButton;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;




@end
