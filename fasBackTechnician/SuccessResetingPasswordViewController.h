//
//  SuccessResetingPasswordViewController.h
//  FasBackTechnician
//
//  Created by User on 13/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuccessResetingPasswordViewController : UIViewController
{
    float width, height;
}

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;

@end
