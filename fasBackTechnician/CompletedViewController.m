//
//  CompletedViewController.m
//  fasBackTechnician
//
//  Created by User on 25/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "CompletedViewController.h"
#import <MFSideMenu.h>
#import "UIFont+PoppinsFont.h"
#import "DashboardViewController.h"
@interface CompletedViewController ()
{
    int fontOfMessageLine;
    float height;
}
@end

@implementation CompletedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    height = [UIScreen mainScreen].bounds.size.height;

    if (height == 480) {
        //
    }
    else if (height == 568)
    {
        fontOfMessageLine = 10;
        _statusLabel.font = [UIFont poppinsSemiBoldFontWithSize:16];
    }
    else if (height == 667)
    {
        fontOfMessageLine = 12;
    }
    else
    {
        
    }
    _closeButton.layer.cornerRadius = 4;
    if (_jobId != nil) {
        if (_isResolved) {
        NSString * messageAttributedText = [NSString stringWithFormat:@"You have successfully completed the Work Order ID %@.",_jobId];
        NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:messageAttributedText];
        
        NSRange range = [messageAttributedText rangeOfString:[NSString stringWithFormat:@"%@", _jobId ]];
        [attString addAttribute:NSFontAttributeName value:[UIFont poppinsSemiBoldFontWithSize:fontOfMessageLine] range:range];
        _messageLabelOne.attributedText = attString;
        
        [NSTimer scheduledTimerWithTimeInterval:5.0
                                         target:self
                                       selector:@selector(closeButtonClicked:)
                                       userInfo:nil
                                        repeats:NO];
        }
        else
        {
            _statusImageView.image = [UIImage imageNamed:@"Alert_Icon"];
            _statusLabel.text = @"On Hold";
            NSString * messageAttributedText = [NSString stringWithFormat:@"The work order %@ has been marked as On Hold.",_jobId];
            
            NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:messageAttributedText];
            
            NSRange range = [messageAttributedText rangeOfString:[NSString stringWithFormat:@"%@", _jobId ]];
            [attString addAttribute:NSFontAttributeName value:[UIFont poppinsSemiBoldFontWithSize:fontOfMessageLine] range:range];
            _messageLabelOne.attributedText = attString;
            
            [NSTimer scheduledTimerWithTimeInterval:5.0
                                             target:self
                                           selector:@selector(closeButtonClicked:)
                                           userInfo:nil
                                            repeats:NO];
        }
    }
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    self.menuContainerViewController.panMode = MFSideMenuPanModeNone;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - General

-(void) UIChanges
{
    _statusLabel.font = [UIFont poppinsSemiBoldFontWithSize:18];
    _messageLabelOne.font = [UIFont poppinsNormalFontWithSize:10];
    
}


#pragma mark - Button Actions

//- (IBAction)closeButtonClicked:(id)sender {
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

- (IBAction)closeButtonClicked:(id)sender {
    for (UIViewController *controller in self.navigationController.viewControllers) {
        
        if ([controller isKindOfClass:[DashboardViewController class]]) {
            
            [self.navigationController popToViewController:controller
                                                  animated:YES];
            break;
        }
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
