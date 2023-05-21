//
//  LandingScreenViewController.h
//  FasBackTechnician
//
//  Created by User on 10/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+PoppinsFont.h"
#import "StoryboardsAndSegues.h"

@interface LandingScreenViewController : UIViewController
{
    float width, height;
}
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fasBackLogoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *technicianImageView;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *haveAnInviteCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *requestInvitationButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordButton;
@property (weak, nonatomic) IBOutlet UILabel *bySigningMessageLabel;
@property (weak, nonatomic) IBOutlet UIButton *termsAndcontionButton;

@end
