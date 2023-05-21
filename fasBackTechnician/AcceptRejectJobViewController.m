//
//  AcceptRejectJobViewController.m
//  FasBackTechnician
//
//  Created by User on 20/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "AcceptRejectJobViewController.h"
#import "ConstantColors.h"
#import "UIFont+PoppinsFont.h"
#import "StoryboardsAndSegues.h"
#import <MFSideMenu.h>
#import "AppDelegate.h"
#import "ConfirmWorkOrderViewController.h"
#import "DisplayListViewController.h"
#import "EstimatedTimeArrivalViewController.h"

@interface AcceptRejectJobViewController ()
{
    AppDelegate * appDelegate;

}
@end

@implementation AcceptRejectJobViewController


static NSInteger const WEBSERVICE_ACCEPT_TAG = 1101;
static NSInteger const WEBSERVICE_ACCEPT_TRAVEL_TIME_TAG = 1102;

static NSInteger const WEBSERVICE_REJECT_TAG = 1103;
static NSInteger const WEBSERVICE_REJECT_REASONS_TAG = 1104;

- (void)viewDidLoad {
    [super viewDidLoad];
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;

    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
    
    arrayWithRejectReasons = [[NSMutableArray alloc]init];
    
    rejectReason = [[RejectReasons alloc]init];
    [self changesInUI];
    if (_isRejected) {
        [self webserviceForRejectReasons];
    }
    else
    {
        [self webserviceForTravelTime];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [appDelegate stopActivityIndicatorForViewController:self];

}

-(void)viewDidAppear:(BOOL)animated
{
    
    [self addCustomDatePicker];
    self.menuContainerViewController.panMode = MFSideMenuPanModeNone;
  }

#pragma mark - General

-(void) changesInUI
{
    
    _confirmButton.layer.cornerRadius = 4;
    _cancelButton.layer.cornerRadius = 4;
    _cancelButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _cancelButton.layer.borderWidth = 1.0;
    
    _dateButton.layer.cornerRadius = 4;
    _dateButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _dateButton.layer.borderWidth = 1.0;
    
    _dateButtonInAcceptSubView.layer.cornerRadius = 4;
    _dateButtonInAcceptSubView.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _dateButtonInAcceptSubView.layer.borderWidth = 1.0;
    
    _doneButton.layer.cornerRadius = 4;
    if (_isRejected) {
        _acceptWorkOrderLabel.text = @"Reject Work Order";
        _logoImageView.image =[UIImage imageNamed:@"Failed"];
        
        
        NSString * messageAttributedText = [NSString stringWithFormat: @"Are you sure you want to reject the work order with %@?.",_workOrderNo ];
        NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:messageAttributedText];
        
        NSRange range = [messageAttributedText rangeOfString:[NSString stringWithFormat:@"%@",_workOrderNo]];
        [attString addAttribute:NSFontAttributeName value:[UIFont poppinsSemiBoldFontWithSize:12] range:range];
        _messageLineOneLabel.attributedText = attString;

        _messageLineTwoLabel.text = @"Please choose a reason for rejection from the list.";
        [_confirmButton setTitle:@"Yes, Reject" forState:UIControlStateNormal];
        [_dateButton setTitle:[NSString stringWithFormat:@"  Please select reason" ] forState:UIControlStateNormal];

        self.backgroundViewForAcceptSubView.hidden = YES;

    }
    else{
    NSString * messageAttributedText = [NSString stringWithFormat: @"You are about to accept work order %@.",_workOrderNo ];
    NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:messageAttributedText];
    
    NSRange range = [messageAttributedText rangeOfString:[NSString stringWithFormat:@"%@",_workOrderNo]];
    [attString addAttribute:NSFontAttributeName value:[UIFont poppinsSemiBoldFontWithSize:12] range:range];
    _messageLineOneLabel.attributedText = attString;
        [self setDefaultDateForDatButton];

        _messageLineTwoLabel.text = @"I will start to the customer location";
        self.backgroundViewForAcceptSubView.hidden = NO;
        [self immediateRadioButtonClicked:nil];
    }
   
//    _centerYOfMessageLineOneLabel.constant = -40;
    
//    
//    if (height == 480) {
//        _topConstraintOfImageView.constant = 20;
//        _widthOfImageView.constant = 70;
//        _heightOfImageView.constant = 50;
//    }
    if (height == 480) {
        //
    }
    else if (height == 568)
    {
        _acceptWorkOrderLabel.font = [UIFont poppinsSemiBoldFontWithSize:18];
        _dateButton.titleLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _dateButtonInAcceptSubView.titleLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _cancelButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:12];
        _confirmButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:12];

    }
    else if (height == 667)
    {
        
    }
    else
    {
        
    }
        _bottomConstrainForBackgroundPickerView.constant = -300;
}

-(void) addCustomDatePicker
{
    transparentBAckgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    transparentBAckgroundView.backgroundColor = [UIColor blackColor];
    transparentBAckgroundView.alpha = 0.4;
    
    transparentBAckgroundView.hidden = YES;
    
    [self.view addSubview:transparentBAckgroundView];
    
    
    objectForCustomDatePickerView = [[customDatePickerView alloc]initWithFrame:CGRectMake(0, 50, width, 202)];
    [objectForCustomDatePickerView layoutIfNeeded];
    [objectForCustomDatePickerView.timePicker addTarget:self action:@selector(timePickeValueChanged:) forControlEvents:UIControlEventValueChanged];
//    [objectForCustomDatePickerView.datePicker addTarget:self action:@selector(datePickeValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [objectForCustomDatePickerView.cancelButton addTarget:self action:@selector(cancelButtonInCustomDatePickerClicked:) forControlEvents:UIControlEventTouchUpInside];
    [objectForCustomDatePickerView.continueButton addTarget:self action:@selector(okButtonInCustomDatePickerClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    NSDate *minusOneHr = [_requestedETA dateByAddingTimeInterval:-15*60];

//    if ( ([[NSDate date] compare:minusOneHr]) != NSOrderedDescending ) {
//        objectForCustomDatePickerView.timePicker.maximumDate = minusOneHr;
//    }
    
    objectForCustomDatePickerView.timePicker.date = [NSDate date];
//    objectForCustomDatePickerView.timePicker.maximumDate = minusOneHr;
    objectForCustomDatePickerView.timePicker.minimumDate = [NSDate date];
    //    objectForCustomDatePickerView.hidden = YES;
    objectForCustomDatePickerView.cancelButton.enabled = YES;
    [self.view bringSubviewToFront:objectForCustomDatePickerView.cancelButton];
    [self.view addSubview:objectForCustomDatePickerView];
    
    objectForCustomDatePickerView.frame = CGRectMake(3, height + 100, width-6, 300);
    objectForCustomDatePickerView.layer.borderWidth = 1;
    objectForCustomDatePickerView.layer.borderColor = [[ConstantColors coolGray]CGColor];
    
    objectForCustomDatePickerView.continueButton.layer.cornerRadius = 4;
    objectForCustomDatePickerView.cancelButton.layer.cornerRadius = 4;
    objectForCustomDatePickerView.cancelButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    objectForCustomDatePickerView.cancelButton.layer.borderWidth = 1.0;
}

-(void) setDefaultDateForDatButton
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd MMMM yyyy hh:mm a"];
    timeSelectedInTimePicker =[dateFormat stringFromDate:[NSDate date]];
    
    [dateFormat setDateFormat:@"dd MMMM yyyy"];
//    dateSelectedInDatePicker =[dateFormat stringFromDate:[NSDate date]];
    dateSelected= [NSString stringWithFormat:@"    %@",timeSelectedInTimePicker];
    [_dateButtonInAcceptSubView setTitle:[NSString stringWithFormat:@"    %@",timeSelectedInTimePicker] forState:UIControlStateNormal];

}

-(void) showAlertWithMessage : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Web service

-(void) webserviceToAcceptAndRejectJob
{
    [appDelegate initActivityIndicatorForviewController:self];

   if (_isRejected) {
       NSMutableDictionary * postDataDictionary = [[NSMutableDictionary alloc]init];
       [postDataDictionary setValue:_workOderId forKey:@"WOId"];
       [postDataDictionary setValue:_rejectReasonSelected.reasonId forKey:@"RejectionReasonId"];
       NSLog(@"postDataDictionary %@",postDataDictionary);
        NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/RejectWO",[Webservice webserviceLink]];
        [webservice requestMethodForPost:stringWithUrl withData:postDataDictionary withTag:WEBSERVICE_REJECT_TAG];
   }
    else
    {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        
//            NSString *requestedETAString = dateToBeDisplayed;
//            requestedETAString = [requestedETAString stringByReplacingOccurrencesOfString:@"T" withString:@" " ];
//            dateFormatter.dateFormat = @"    dd MMMM yyyy hh:mm a";
//            NSDate *yourDate = [dateFormatter dateFromString:requestedETAString];
            dateFormatter.dateFormat = @"MM-dd-yyyy HH:mm:ss";
            NSLog(@"date %@",[dateFormatter stringFromDate:dateToBeDisplayed]);
        NSDictionary * postDataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:_workOderId,@"WOId",[dateFormatter stringFromDate:dateToBeDisplayed],@"ApproxETA", nil];
        
        NSLog(@"postDataDictionary %@",postDataDictionary);

        [self performSegueWithIdentifier:[StoryboardsAndSegues segue_EstimatedETA] sender:postDataDictionary];
//        NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/AcceptWO",[Webservice webserviceLink]];
//        [webservice requestMethodForPost:stringWithUrl withData:postDataDictionary withTag:WEBSERVICE_ACCEPT_TAG];

    }
}

-(void) webserviceForRejectReasons
{
    [appDelegate initActivityIndicatorForviewController:self];

    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/GetReasons/1",[Webservice webserviceLink]];
    [webservice requestMethod:stringWithUrl withMsgType:WEBSERVICE_REJECT_REASONS_TAG];
    
}

-(void) webserviceForTravelTime
{
    [appDelegate initActivityIndicatorForviewController:self];
    
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/GetAcceptWODetail/%@",[Webservice webserviceLink],_workOderId];
    [webservice requestMethod:stringWithUrl withMsgType:WEBSERVICE_ACCEPT_TRAVEL_TIME_TAG];
    
}

#pragma mark - UIButton Actions

- (IBAction)doneBarButtoncCicked:(id)sender {
    [UIView animateWithDuration:0.7f animations:^{
        _backgriundViewOfPickeriew.frame = CGRectMake(0,   height, width, 180);
    }];
    
        [_dateButton setTitle:[NSString stringWithFormat:@"  %@", rejectReason.reason ] forState:UIControlStateNormal];
}

- (IBAction)cancelButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)confirmButtonClicked:(id)sender {
//    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_EstimatedETA] sender:nil];
    if (_isRejected) {
        if ([_dateButton.titleLabel.text isEqualToString:@"  Please select reason"]) {
            [self showAlertWithMessage:@"Please select reason"];
        }else
        {
        [self webserviceToAcceptAndRejectJob];
        }
//        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        if (isImmediate) {
            dateToBeDisplayed = [[NSDate date] dateByAddingTimeInterval:travelTimeReceived];
        }
        else
        {
            dateToBeDisplayed = [objectForCustomDatePickerView.timePicker.date dateByAddingTimeInterval:travelTimeReceived];
        }
        [self webserviceToAcceptAndRejectJob];
//
////    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_ConfirmWorkOrder] sender:nil];
    }
}

- (IBAction)dateButtonClicked:(id)sender {
    if (_isRejected) {
        if (arrayWithRejectReasons.count != 0) {
            [self performSegueWithIdentifier:[StoryboardsAndSegues SegueToDisplayList] sender:nil];
//        [UIView animateWithDuration:0.7f animations:^{
//            _backgriundViewOfPickeriew.frame = CGRectMake(0,   height-180, width, 180);
//            rejectReason = arrayWithRejectReasons[0];
//        }];
        }
        else
        {
            [self showAlertWithMessage:@"There are no reasons available"];
        }

    }
    else
    {
    transparentBAckgroundView.hidden = NO;
    [UIView animateWithDuration:0.7f animations:^{
        objectForCustomDatePickerView.frame = CGRectMake(3,   150, width-6, 300);
    }];
        
    }
}

- (IBAction)cancelButtonInCustomDatePickerClicked:(id)sender {
    
    [UIView animateWithDuration:0.7f animations:^{
        objectForCustomDatePickerView.frame = CGRectMake(3,   height, width-6, 300);
        transparentBAckgroundView.hidden = YES;
    }];
}

- (IBAction)okButtonInCustomDatePickerClicked:(id)sender {
    [UIView animateWithDuration:0.7f animations:^{
        objectForCustomDatePickerView.frame = CGRectMake(3,   height, width-6, 300);
        transparentBAckgroundView.hidden = YES;
    }];
    [_dateButtonInAcceptSubView setTitle:[NSString stringWithFormat:@"    %@",timeSelectedInTimePicker] forState:UIControlStateNormal];
}

-(void) timePickeValueChanged : (UIDatePicker*) picker
{
    NSLog(@"%@",picker.date);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"d MMMM yyyy hh:mm a"];
    timeSelectedInTimePicker =[dateFormat stringFromDate:picker.date];
    dateSelected= [NSString stringWithFormat:@"     %@",timeSelectedInTimePicker];
    dateToBeDisplayed = [picker.date dateByAddingTimeInterval:travelTimeReceived];
}

- (IBAction)immediateRadioButtonClicked:(id)sender {
    _dateButtonInAcceptSubView.hidden = YES;
    [self.immediateRadioButton setImage:[UIImage imageNamed:@"radio_selected"] forState:UIControlStateNormal] ;
    [self.atRadioButton setImage:[UIImage imageNamed:@"radio_unselected"] forState:UIControlStateNormal] ;
//    dateToBeDisplayed = [[NSDate date] dateByAddingTimeInterval:travelTimeReceived];
    isImmediate = YES;
}

- (IBAction)atRadioButtonClicked:(id)sender {
    _dateButtonInAcceptSubView.hidden = NO;
    [self.immediateRadioButton setImage:[UIImage imageNamed:@"radio_unselected"] forState:UIControlStateNormal] ;
    [self.atRadioButton setImage:[UIImage imageNamed:@"radio_selected"] forState:UIControlStateNormal] ;
//    dateToBeDisplayed = [objectForCustomDatePickerView.timePicker.date dateByAddingTimeInterval:travelTimeReceived];
    isImmediate = NO;
}

//-(void) datePickeValueChanged : (UIDatePicker*) picker
//{
//    NSLog(@"%@",picker.date);
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"dd MMMM yyyy"];
//    dateSelectedInDatePicker =[dateFormat stringFromDate:picker.date];
//    dateSelected= [NSString stringWithFormat:@"    %@ %@",dateSelectedInDatePicker,timeSelectedInTimePicker];
//
//}

#pragma mark - UIPicker View Delegates

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;//Or return whatever as you intend
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [arrayWithRejectReasons count];//Or, return as suitable for you...normally we use array for dynamic
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    RejectReasons * eachRejectReason = [[RejectReasons alloc]init];
    rejectReason = arrayWithRejectReasons[row];
    NSLog(@"%@",rejectReason);

    NSLog(@"%@",rejectReason.reason);
    return rejectReason.reason;//Or, your suitable title; like Choice-a, etc.
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    rejectReason = arrayWithRejectReasons[row];
    
//    [_dateButton setTitle:[NSString stringWithFormat:@"  %@", rejectReason.reason ] forState:UIControlStateNormal];
    _backgriundViewOfPickeriew.hidden =NO;
    _backgriundViewOfPickeriew.frame = CGRectMake(0,   height-180, width, 180);

}

#pragma mark - Webservice delegate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];
    NSLog(@"%@",parsedData);
    if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
        if ( [parsedData objectForKey:@"ReturnObject"] != [NSNull null]) {
            NSDictionary * resultData = [parsedData objectForKey:@"ReturnObject"];
            if (msgType == WEBSERVICE_REJECT_REASONS_TAG) {
                NSArray * arrayFromResons = [resultData objectForKey:@"Reasons"];
                for (int i = 0; i<arrayFromResons.count; i++) {
                    NSDictionary * dictionaryWithEachReason = [arrayFromResons objectAtIndex:i];
                    
                    RejectReasons * rejectReasons = [[RejectReasons alloc]init];
                    rejectReasons.reason = dictionaryWithEachReason[@"Reason"];
                    rejectReasons.reasonId = dictionaryWithEachReason[@"ReasonId"];
                    
                    [arrayWithRejectReasons addObject:rejectReasons];
                }
                [_resonsPickerView reloadAllComponents];
            }
            else if (msgType == WEBSERVICE_ACCEPT_TAG)
            {
                if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
                    if (parsedData[@"ReturnObject"] != [NSNull null]) {
                        dictionWithReturnObjectAfterAccept = parsedData[@"ReturnObject"];
                        [self performSegueWithIdentifier:[StoryboardsAndSegues segue_ConfirmWorkOrder] sender:nil];
                    }
                }
            }
            else if (msgType == WEBSERVICE_ACCEPT_TRAVEL_TIME_TAG)
            {
                if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
                    if (parsedData[@"ReturnObject"] != [NSNull null]) {
                        dictionWithReturnObjectAfterAccept = parsedData[@"ReturnObject"];
//                        [self performSegueWithIdentifier:[StoryboardsAndSegues segue_ConfirmWorkOrder] sender:nil];
                        NSLog(@"ApproxTravelTime %@",[dictionWithReturnObjectAfterAccept objectForKey:@"ApproxTravelTime"]);
                        travelTimeReceived = [[dictionWithReturnObjectAfterAccept objectForKey:@"ApproxTravelTime"] floatValue];
                    }
                }
            }

            else // web service to reject
            {
                if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                
            }
        }
        else
        {
            [self showAlertWithMessage:@"Could not accept this Work Order"];
        }
    }
    else
    {
        [self showAlertWithMessage:parsedData[@"Error"]];
        
    }
    
}


-(void)errorRecieved:(NSString *)errorString withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];
    [self showAlertWithMessage:errorString];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_ConfirmWorkOrder]]) {
    ConfirmWorkOrderViewController * confirmWorkOrderViewController = segue.destinationViewController;
    confirmWorkOrderViewController.dictionaryWithWorkOrderDetails = dictionWithReturnObjectAfterAccept;
    }
    else if ([[segue identifier] isEqualToString:[StoryboardsAndSegues SegueToDisplayList]])
    {
        DisplayListViewController * displayListViewController = segue.destinationViewController;
        displayListViewController.arrayWithReasons = arrayWithRejectReasons;
    }
    else if ([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_EstimatedETA]])
    {
        EstimatedTimeArrivalViewController * estimatedETAViewController = segue.destinationViewController;
        
        NSDateFormatter * dateformater = [[NSDateFormatter alloc]init];
        dateformater.dateFormat = @"dd MMMM yyyy hh:mm a";
        NSString * dateToBeSent = [dateformater stringFromDate:dateToBeDisplayed];
        estimatedETAViewController.estimatedDateString = dateToBeSent;
        
        estimatedETAViewController.dictionaryToBePassedForAcceptAPI = sender;
    }
}

- (IBAction)unwindToAcceptOrRejectViewController:(UIStoryboardSegue *)segue {
    NSLog(@"reject reason %@",_rejectReasonSelected);
    [_dateButton setTitle:[NSString stringWithFormat:@"  %@", _rejectReasonSelected.reason ] forState:UIControlStateNormal];

}

@end
