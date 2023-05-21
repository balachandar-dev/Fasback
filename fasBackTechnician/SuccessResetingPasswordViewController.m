//
//  SuccessResetingPasswordViewController.m
//  FasBackTechnician
//
//  Created by User on 13/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "SuccessResetingPasswordViewController.h"
#import "UIFont+PoppinsFont.h"
@interface SuccessResetingPasswordViewController ()

@end

@implementation SuccessResetingPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    [self changesInUI];
    // Do any additional setup after loading the view.
}

#pragma mark - General

-(void) changesInUI
{
    _closeButton.layer.cornerRadius = 4;
    if (height == 480) {
        //
    }
    else if (height == 568)
    {
        _messageLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _successLabel.font = [UIFont poppinsMediumFontWithSize:14];
        _closeButton.titleLabel.font = [UIFont poppinsMediumFontWithSize:13];
    }
    else if(height == 667)
    {
        
    }
    else if (height == 763)
    {
        
    }
    
}

- (IBAction)closeButtonClicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
