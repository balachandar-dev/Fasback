//
//  AcceptRejectJobViewController.h
//  FasBackTechnician
//
//  Created by User on 20/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customDatePickerView.h"
#import "Webservice.h"
#import "RejectReasons.h"
#import "MessageLineLabel.h"

@interface AcceptRejectJobViewController : UIViewController<webProtocol>
{
    float width,height, travelTimeReceived;
    customDatePickerView * objectForCustomDatePickerView;
    NSString  * timeSelectedInTimePicker, * dateSelected, * rejectReasonSelected;
    UIView * transparentBAckgroundView;
    Webservice * webservice;
    NSMutableArray * arrayWithRejectReasons;
    RejectReasons * rejectReason;
    NSDictionary * dictionWithReturnObjectAfterAccept;
    NSDate * dateToBeDisplayed;
    BOOL isImmediate;
}

@property BOOL isRejected;
@property(nonatomic,strong) NSString*  workOderId, * workOrderNo;
@property NSDate * requestedETA;
@property RejectReasons * rejectReasonSelected;


// UI Elements

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *acceptWorkOrderLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLineOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLineTwoLabel;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerYOfMessageLineOneLabel;
@property (weak, nonatomic) IBOutlet UIView *backgriundViewOfPickeriew;
@property (weak, nonatomic) IBOutlet UIPickerView *resonsPickerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet MessageLineLabel *willYouBeTakingABreakLabel;
@property (weak, nonatomic) IBOutlet UIButton *timePickerButton;

@property (weak, nonatomic) IBOutlet UIView *backgroundViewForAcceptSubView;

@property (weak, nonatomic) IBOutlet UIButton *immediateRadioButton;
@property (weak, nonatomic) IBOutlet UIButton *atRadioButton;

@property (weak, nonatomic) IBOutlet UIButton *dateButtonInAcceptSubView;

// Constraints

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstrainForBackgroundPickerView;

@end
