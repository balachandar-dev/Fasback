//
//  SignUpSuccessFailureViewController.h
//  FasBackTechnician
//
//  Created by User on 17/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpSuccessFailureViewController : UIViewController
{
    float width,height;
    BOOL isSuccess;
}
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *responseMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLineOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLineTwoLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@end
