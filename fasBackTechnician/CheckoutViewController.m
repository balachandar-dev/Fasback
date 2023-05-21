//
//  CheckoutViewController.m
//  fasBackTechnician
//
//  Created by User on 22/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "CheckoutViewController.h"
#import "ConstantColors.h"
#import "UIFont+PoppinsFont.h"
#import "StoryboardsAndSegues.h"
#import <MFSideMenu.h>
#import "AppDelegate.h"
#import "CompletedViewController.h"
@interface CheckoutViewController ()
{
    AppDelegate * appDelegate;

}
@end

@implementation CheckoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    
    isResolved = YES;
    
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
    
    _descriptionTExtView.text = @"";
    
    NSLog(@"%@",_workOrderInfo.workOrderNumber);
    [self UIChanges];

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
//    _mainScrollView.contentOffset = CGPointMake(0, 0);

}
-(void)viewDidAppear:(BOOL)animated
{
    
    self.menuContainerViewController.panMode = MFSideMenuPanModeNone;
}

#pragma mark - General

-(void) UIChanges
{
    NSLog(@"%f",height);
    _confirmButton.layer.cornerRadius = 4;
    _cancelButton.layer.cornerRadius = 4;
    _cancelButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _cancelButton.layer.borderWidth = 1.0;

    _descriptionTExtView.layer.cornerRadius = 4;
    _descriptionTExtView.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _descriptionTExtView.layer.borderWidth = 1.0;
    
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        NSString *requestedETAString = _workOrderInfo.requestedEtaId;
        requestedETAString = [requestedETAString stringByReplacingOccurrencesOfString:@"T" withString:@" " ];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *yourDate = [dateFormatter dateFromString:requestedETAString];
    if (yourDate == nil) {
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SS";
    }
    yourDate = [dateFormatter dateFromString:requestedETAString];

        dateFormatter.dateFormat = @"dd MMM, yyyy hh:mm a";
        NSLog(@"date %@",[dateFormatter stringFromDate:yourDate]);
    NSString * dateToBeDisplayed = [dateFormatter stringFromDate:yourDate] ;
    
    NSString * messageAttributedText = [NSString stringWithFormat:@"You are now checking out of location for %@ (%@ EST)",_workOrderInfo.workOrderNumber,dateToBeDisplayed ];
    if (yourDate == nil) {
        dateToBeDisplayed = @"";
         messageAttributedText = [NSString stringWithFormat:@"You are now checking out of location %@",_workOrderInfo.workOrderNumber ];
    }
    
    NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:messageAttributedText];
    
    NSRange range = [messageAttributedText rangeOfString:_workOrderInfo.workOrderNumber];
    [attString addAttribute:NSFontAttributeName value:[UIFont poppinsSemiBoldFontWithSize:12] range:range];
    _messageLineOneLabel.attributedText = attString;
    self.navigationController.navigationBarHidden = YES;
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(hideKeyboard)],
                           nil];
    [numberToolbar sizeToFit];
    _descriptionTExtView.inputAccessoryView = numberToolbar;
    
    [self addCustomDatePicker];
    
    [_resolvedSwitchButton setImage:[UIImage imageNamed:@"Toggle_On"] forState:UIControlStateNormal];
    _nextEtaLabel.hidden = YES;
    _datPickerButton.hidden = YES;
    
    isResolved = YES;
    
    [self setDefaultDateForDatButton];
    if (height == 480) {
        
    }
    else if (height == 568)
    {
        _checkOutLabel.font = [UIFont poppinsSemiBoldFontWithSize:18];
        _messageLineOneLabel.font = [UIFont poppinsNormalFontWithSize:10];
        _hasIssueResolvedMessageLabel.font = [UIFont poppinsNormalFontWithSize:10];
        _detailsLabel.font = [UIFont poppinsNormalFontWithSize:10];
        _descriptionTExtView.font = [UIFont poppinsNormalFontWithSize:10];
        _nextEtaLabel.font = [UIFont poppinsNormalFontWithSize:10];
        _cancelButton.titleLabel.font= [UIFont poppinsSemiBoldFontWithSize:12];
        _confirmButton.titleLabel.font= [UIFont poppinsSemiBoldFontWithSize:12];
        _datPickerButton.titleLabel.font= [UIFont poppinsNormalFontWithSize:12];


    }
    else if (height == 667)
    {
        
    }
    else
    {
        
    }
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [objectForCustomDatePickerView.cancelButton addTarget:self action:@selector(cancelButtonInCustomDatePickerClicked:) forControlEvents:UIControlEventTouchUpInside];
    [objectForCustomDatePickerView.continueButton addTarget:self action:@selector(okButtonInCustomDatePickerClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //    objectForCustomDatePickerView.hidden = YES;
    objectForCustomDatePickerView.cancelButton.enabled = YES;
    [self.view bringSubviewToFront:objectForCustomDatePickerView.cancelButton];
    [self.view addSubview:objectForCustomDatePickerView];
    
    objectForCustomDatePickerView.frame = CGRectMake(20, height + 100, width-40, 300);
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
    
    dateSelected= [NSString stringWithFormat:@"    %@",timeSelectedInTimePicker];
    [_datPickerButton setTitle:[NSString stringWithFormat:@"    %@",timeSelectedInTimePicker] forState:UIControlStateNormal];
    
}


-(void) showAlertWithMessage : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Web service

-(void) webserviceForCheckOut
{
    [appDelegate initActivityIndicatorForviewController:self];

//    {
//        "WOId": 109,
//        "WorkOrderNo": "CUST-20170813-0026",
//        "IsIssueBeenResolved": true,
//        "CheckoutDetail": "problem fixed by approx time.",
//        "CheckoutTime": "08-14-2017 16:42:00"
//        
//    }
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMMM yyyy hh:mm a"];

    NSDate *nextEtaDate = [dateFormatter dateFromString:timeSelectedInTimePicker];

    
    NSDate *yourDate = [NSDate date];
    dateFormatter.dateFormat = @"MM-dd-yyyy HH:mm:ss";
    NSLog(@"date %@",[dateFormatter stringFromDate:yourDate]);

    NSString * dateString = [dateFormatter stringFromDate:yourDate];
    
    NSMutableDictionary * postDataDictionary = [[NSMutableDictionary alloc]init];
    [postDataDictionary setValue:_workOrderInfo.workOrderId forKey:@"WOId"];
    [postDataDictionary setValue:_workOrderInfo.workOrderNumber forKey:@"WorkOrderNo"];
    if (isResolved) {
        [postDataDictionary setObject:@"true" forKey:@"isIssueBeenResolved"];
    }
    else
    {
    [postDataDictionary setObject:@"false" forKey:@"isIssueBeenResolved"];
    
    [postDataDictionary setValue:[dateFormatter stringFromDate:nextEtaDate] forKey:@"NextETA"];

    }
    [postDataDictionary setValue:_descriptionTExtView.text forKey:@"CheckoutDetail"];
    [postDataDictionary setValue:dateString forKey:@"CheckoutTime"];
    
    NSLog(@"postDataDictionary%@",postDataDictionary);
    
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/Checkout",[Webservice webserviceLink]];
    [webservice requestMethodForPost:stringWithUrl withData:postDataDictionary withTag:12];
}

#pragma mark - UIButton Actions

- (IBAction)datePickerButtonClicked:(id)sender {

    transparentBAckgroundView.hidden = NO;
    [UIView animateWithDuration:0.7f animations:^{
        objectForCustomDatePickerView.frame = CGRectMake(3,   150, width-6, 300);
    }];

}

- (IBAction)checkoutButtonClicked:(id)sender {
    if (_descriptionTExtView.text.length == 0) {
        [self showAlertWithMessage:@"Please enter the details"];
    }
    else
    {
        [self webserviceForCheckOut];
//    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_Completed] sender:nil];
    }
}

- (IBAction)cancelButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)resolvedSwitchValueChanges:(id)sender {
    if (!isResolved) {
        [_resolvedSwitchButton setImage:[UIImage imageNamed:@"Toggle_On"] forState:UIControlStateNormal];
        _nextEtaLabel.hidden = YES;
        _datPickerButton.hidden = YES;
        
        isResolved = YES;


    }
    else
    {
        [_resolvedSwitchButton setImage:[UIImage imageNamed:@"toggle_off"] forState:UIControlStateNormal];
        
        
        _nextEtaLabel.hidden = NO;
        _datPickerButton.hidden = NO;
        
        isResolved = NO;

    }
}

-(void) hideKeyboard
{
    [_descriptionTExtView resignFirstResponder];
}

- (IBAction)dateButtonClicked:(id)sender {
    transparentBAckgroundView.hidden = NO;
    [UIView animateWithDuration:0.7f animations:^{
        objectForCustomDatePickerView.frame = CGRectMake(3,   150, width-6, 300);
    }];
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
    [_datPickerButton setTitle:[NSString stringWithFormat:@"    %@",timeSelectedInTimePicker] forState:UIControlStateNormal];
}

-(void) timePickeValueChanged : (UIDatePicker*) picker
{
    NSLog(@"%@",picker.date);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd MMMM yyyy hh:mm a"];
    timeSelectedInTimePicker =[dateFormat stringFromDate:picker.date];
    dateSelected= [NSString stringWithFormat:@"   %@",timeSelectedInTimePicker];
}
//-(void) datePickeValueChanged : (UIDatePicker*) picker
//{
//    NSLog(@"%@",picker.date);
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"dd MMMM yyyy"];
//    dateSelectedInDatePicker =[dateFormat stringFromDate:picker.date];
//    dateSelected= [NSString stringWithFormat:@"   %@ %@",dateSelectedInDatePicker,timeSelectedInTimePicker];
//    
//}

#pragma mark - UITextView Delegates

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _mainScrollView.contentOffset = CGPointMake(0, 50);
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    _mainScrollView.contentOffset = CGPointMake(0, -20);

}

#pragma mark - Webservice delagate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];
    
    jobIdReceived = @"";
    if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
        if ([parsedData objectForKey:@"ReturnObject"] != [NSNull null] ) {
            NSDictionary * returnObjectDictionary = [parsedData objectForKey:@"ReturnObject"];
//            if (returnObjectDictionary[@"JobId"] != [NSNull null]) {
                jobIdReceived = _workOrderInfo.workOrderNumber;
//            }
        }
            [self performSegueWithIdentifier:[StoryboardsAndSegues segue_Completed] sender:nil];
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
    if([[segue identifier] isEqualToString:[StoryboardsAndSegues segue_Completed]])
    {
        CompletedViewController * completedViewController = segue.destinationViewController;
        completedViewController.jobId= jobIdReceived;
        completedViewController.isResolved = isResolved;
    }
}


@end
