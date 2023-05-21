//
//  EstimatedTimeArrivalViewController.m
//  fasBackTechnician
//
//  Created by User on 11/12/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "EstimatedTimeArrivalViewController.h"
#import "ConstantColors.h"
#import "AppDelegate.h"
#import "StoryboardsAndSegues.h"
#import "ConfirmWorkOrderViewController.h"
#import "DashboardViewController.h"
@interface EstimatedTimeArrivalViewController ()
{
    NSDictionary * dictionWithReturnObjectAfterAccept;
}
@end

@implementation EstimatedTimeArrivalViewController
{
    AppDelegate * appDelegate;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
    [self changesInUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - General

-(void) changesInUI
{
    
    _confirmButton.layer.cornerRadius = 4;
    _previousButton.layer.cornerRadius = 4;
    _previousButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _previousButton.layer.borderWidth = 1.0;
    
    [_estimatedTimeButton setTitle:_estimatedDateString forState:UIControlStateNormal];
}

-(void) showAlertWithMessage : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UIButton Actions

- (IBAction)previousButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)cpnfirmButtonClicked:(id)sender {
    [self webserviceToAcceptAndRejectJob];
}

#pragma mark - Web service

-(void) webserviceToAcceptAndRejectJob
{
    [appDelegate initActivityIndicatorForviewController:self];
    
        NSLog(@"postDataDictionary %@",_dictionaryToBePassedForAcceptAPI);
        
        NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/AcceptWO",[Webservice webserviceLink]];
        [webservice requestMethodForPost:stringWithUrl withData:_dictionaryToBePassedForAcceptAPI withTag:11];
        
}

#pragma mark - Webservice delegate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];
    NSLog(@"%@",parsedData);
    if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
            if (parsedData[@"ReturnObject"] != [NSNull null]) {
                        dictionWithReturnObjectAfterAccept = parsedData[@"ReturnObject"];
                for (UIViewController* viewController in self.navigationController.viewControllers) {
                    
                    //This if condition checks whether the viewController's class is MyGroupViewController
                    // if true that means its the MyGroupViewController (which has been pushed at some point)
                    if ([viewController isKindOfClass:[DashboardViewController class]] ) {
                        
                        // Here viewController is a reference of UIViewController base class of MyGroupViewController
                        // but viewController holds MyGroupViewController  object so we can type cast it here
                        DashboardViewController *groupViewController = (DashboardViewController*)viewController;
                        [self.navigationController popToViewController:groupViewController animated:YES];
                    }
                }
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
    ConfirmWorkOrderViewController * confirmWorkOrderViewController = segue.destinationViewController;
    confirmWorkOrderViewController.dictionaryWithWorkOrderDetails = dictionWithReturnObjectAfterAccept;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
