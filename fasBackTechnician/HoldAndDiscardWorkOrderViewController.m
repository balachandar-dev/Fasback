//
//  HoldAndDiscardWorkOrderViewController.m
//  fasBackTechnician
//
//  Created by User on 16/09/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "HoldAndDiscardWorkOrderViewController.h"
#import "ConstantColors.h"
#import "UIFont+PoppinsFont.h"
#import "StoryboardsAndSegues.h"
#import <MFSideMenu.h>
#import "AppDelegate.h"
#import "ConfirmWorkOrderViewController.h"
#import "DisplayListViewController.h"

@interface HoldAndDiscardWorkOrderViewController ()
{
    AppDelegate * appDelegate;
}
@end

@implementation HoldAndDiscardWorkOrderViewController

static NSInteger const WEBSERVICE_HOLD_TAG = 1101;
static NSInteger const WEBSERVICE_DISCARD_TAG = 1102;
static NSInteger const WEBSERVICE_REASONS_TAG = 1103;

- (void)viewDidLoad {
    [super viewDidLoad];
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
    
    arrayWithHoldOrDiscardReasons = [[NSMutableArray alloc]init];
    
    holdOrDiscardReason = [[RejectReasons alloc]init];
    
    _holdOrDiscardReasonSelected = [[RejectReasons alloc]init];
    [self changesInUI];
    
//    if (_isRejected) {
        [self webserviceForReasons];
//    }

    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    self.menuContainerViewController.panMode = MFSideMenuPanModeNone;
    
    
}

#pragma mark - General

-(void) changesInUI
{
    
    _OkButton.layer.cornerRadius = 4;
    _cancelButton.layer.cornerRadius = 4;
    _cancelButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _cancelButton.layer.borderWidth = 1.0;
    
    _reasonButton.layer.cornerRadius = 4;
    _reasonButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _reasonButton.layer.borderWidth = 1.0;
    
    _reasonButton.layer.cornerRadius = 4;
    if (_isHold) {
        _titleLabel.text = @"Hold Work Order";
        _logoImageView.image =[UIImage imageNamed:@"Failed"];
        
        
        NSString * messageAttributedText = [NSString stringWithFormat: @"Are you sure you want to put the work order with ID %@ on hold?",_workOrderNo ];
        NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:messageAttributedText];
        
        NSRange range = [messageAttributedText rangeOfString:[NSString stringWithFormat:@"%@",_workOrderNo]];
        [attString addAttribute:NSFontAttributeName value:[UIFont poppinsSemiBoldFontWithSize:12] range:range];
        _messageLineOneLabel.attributedText = attString;
        
        _messageLineTwoLabel.text = @"Please choose a reason for the hold from the list.";
        [_OkButton setTitle:@"Confirm" forState:UIControlStateNormal];
        [_reasonButton setTitle:[NSString stringWithFormat:@"  Please select reason" ] forState:UIControlStateNormal];
        
        
    }
    else{
        _titleLabel.text = @"Discard Work Order";

        _logoImageView.image =[UIImage imageNamed:@"Failed"];
        
        
        
        NSString * messageAttributedText = [NSString stringWithFormat: @"Are you sure you want to reject the work order with ID %@?",_workOrderNo ];
        NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:messageAttributedText];
        
        NSRange range = [messageAttributedText rangeOfString:[NSString stringWithFormat:@"%@",_workOrderNo]];
        [attString addAttribute:NSFontAttributeName value:[UIFont poppinsSemiBoldFontWithSize:12] range:range];
        _messageLineOneLabel.attributedText = attString;
        
        _messageLineTwoLabel.text = @"Please choose a reason for rejection from the list.";
        [_OkButton setTitle:@"Yes, Discard" forState:UIControlStateNormal];
        [_reasonButton setTitle:[NSString stringWithFormat:@"  Please select reason" ] forState:UIControlStateNormal];
        
    }
    
    //    _centerYOfMessageLineOneLabel.constant = -40;
    
    //
    //    if (height == 480) {
    //        _topConstraintOfImageView.constant = 20;
    //        _widthOfImageView.constant = 70;
    //        _heightOfImageView.constant = 50;
    //    }
    
//    _bottomConstrainForBackgroundPickerView.constant = -300;
}

-(void) showAlertWithMessage : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Web service

-(void) webserviceToHoldOrDiscardWorkOrder
{
    [appDelegate initActivityIndicatorForviewController:self];
    
    if (_isHold) {
        NSMutableDictionary * postDataDictionary = [[NSMutableDictionary alloc]init];
        [postDataDictionary setValue:_workOderId forKey:@"WOId"];
        [postDataDictionary setValue:_holdOrDiscardReasonSelected.reasonId forKey:@"HoldReasonId"];
        [postDataDictionary setValue:@"" forKey:@"Comment"];

        NSLog(@"postDataDictionary %@",postDataDictionary);
        NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/HoldWO",[Webservice webserviceLink]];
        [webservice requestMethodForPost:stringWithUrl withData:postDataDictionary withTag:WEBSERVICE_HOLD_TAG];
    }
else
{
    NSMutableDictionary * postDataDictionary = [[NSMutableDictionary alloc]init];
    [postDataDictionary setValue:_workOderId forKey:@"WOId"];
    [postDataDictionary setValue:_holdOrDiscardReasonSelected.reasonId forKey:@"DiscardReasonId"];
    
    NSLog(@"postDataDictionary %@",postDataDictionary);
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/DiscardWO",[Webservice webserviceLink]];
    [webservice requestMethodForPost:stringWithUrl withData:postDataDictionary withTag:WEBSERVICE_DISCARD_TAG];
}
}

-(void) webserviceForReasons
{
    [appDelegate initActivityIndicatorForviewController:self];
    NSString * stringWithUrl;
    if (_isHold) {
    stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/GetReasons/1",[Webservice webserviceLink]];
    }
    else
    {
        stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/GetReasons/1",[Webservice webserviceLink]];

    }
    [webservice requestMethod:stringWithUrl withMsgType:WEBSERVICE_REASONS_TAG];
    
}

#pragma mark - UIButton Actions


- (IBAction)cancelButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)confirmButtonClicked:(id)sender {
    if (_isHold) {
         [self webserviceToHoldOrDiscardWorkOrder];
        //        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self webserviceToHoldOrDiscardWorkOrder];

        //    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_ConfirmWorkOrder] sender:nil];
    }
}

- (IBAction)reasonButtonClicked:(id)sender {
        if (arrayWithHoldOrDiscardReasons.count != 0) {
            [self performSegueWithIdentifier:[StoryboardsAndSegues SegueToDisplayList] sender:nil];
             }
        else
        {
            [self showAlertWithMessage:@"There are no reasons available"];
        }
    
}

#pragma mark - Webservice delegate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];
    NSLog(@"%@",parsedData);
    if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
        if ( [parsedData objectForKey:@"ReturnObject"] != [NSNull null]) {
            NSDictionary * resultData = [parsedData objectForKey:@"ReturnObject"];
            if (msgType == WEBSERVICE_REASONS_TAG) {
                NSArray * arrayFromResons = [resultData objectForKey:@"Reasons"];
                for (int i = 0; i<arrayFromResons.count; i++) {
                    NSDictionary * dictionaryWithEachReason = [arrayFromResons objectAtIndex:i];
                    
                    RejectReasons * eachHoldOrDiscardReasons = [[RejectReasons alloc]init];
                    eachHoldOrDiscardReasons.reason = dictionaryWithEachReason[@"Reason"];
                    eachHoldOrDiscardReasons.reasonId = dictionaryWithEachReason[@"ReasonId"];
                    
                    [arrayWithHoldOrDiscardReasons addObject:eachHoldOrDiscardReasons];
                }
            }
//            else if (msgType == WEBSERVICE_HOLD_TAG)
//            {
//                if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
//                    if (parsedData[@"ReturnObject"] != [NSNull null]) {
////                        dictionWithReturnObjectAfterAccept = parsedData[@"ReturnObject"];
//                        [self performSegueWithIdentifier:[StoryboardsAndSegues segue_ConfirmWorkOrder] sender:nil];
//                    }
//                }
//            }
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
    if ([[segue identifier] isEqualToString:[StoryboardsAndSegues SegueToDisplayList]])
    {
        DisplayListViewController * displayListViewController = segue.destinationViewController;
        displayListViewController.arrayWithReasons = arrayWithHoldOrDiscardReasons;
        displayListViewController.isHoldOrDiscard = YES;
    }
    
}

- (IBAction)unwindToHoldOrRejectViewController:(UIStoryboardSegue *)segue {
    NSLog(@"reject reason %@",_holdOrDiscardReasonSelected);
    [_reasonButton setTitle:[NSString stringWithFormat:@"  %@", _holdOrDiscardReasonSelected.reason ] forState:UIControlStateNormal];
}




@end
