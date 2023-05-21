//
//  LandingScreenViewController.m
//  FasBackTechnician
//
//  Created by User on 10/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "LandingScreenViewController.h"
#import "UIColor+Customcolor.h"
#import "ConstantColors.h"

@interface LandingScreenViewController ()

@end

@implementation LandingScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    
    [self UIChanges];
    // Do any additional setup after loading the view.
}


-(void) UIChanges
{
    NSLog(@"%f",height);
    
    self.navigationController.navigationBarHidden = YES;
    
    
//    CALayer *bottomBorderForRequestInvitationButton = [CALayer layer];
//    bottomBorderForRequestInvitationButton.frame = CGRectMake(0.0f, _requestInvitationButton.frame.size.height - 3, _requestInvitationButton.frame.size.width, 0.5f);
//    bottomBorderForRequestInvitationButton.backgroundColor = _requestInvitationButton.currentTitleColor.CGColor;
//    [_requestInvitationButton.layer addSublayer:bottomBorderForRequestInvitationButton];
//    
//    CALayer *bottomBorderForForgetButton = [CALayer layer];
//    bottomBorderForForgetButton.frame = CGRectMake(0.0f, _forgetPasswordButton.frame.size.height - 3, _forgetPasswordButton.frame.size.width, 0.5f);
//    bottomBorderForForgetButton.backgroundColor = _forgetPasswordButton.currentTitleColor.CGColor;
//    [_forgetPasswordButton.layer addSublayer:bottomBorderForForgetButton];
    
    CALayer *bottomBorderForTermsAndConditionButton = [CALayer layer];
    bottomBorderForTermsAndConditionButton.frame = CGRectMake(0.0f, _termsAndcontionButton.frame.size.height - 3, _termsAndcontionButton.frame.size.width, 0.5f);
    bottomBorderForTermsAndConditionButton.backgroundColor = _termsAndcontionButton.currentTitleColor.CGColor;
    [_termsAndcontionButton.layer addSublayer:bottomBorderForTermsAndConditionButton];
    
    
    NSString * messageAttributedText = @"Already Registered? SIGN IN";
    NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:messageAttributedText];
    
    NSRange range = [messageAttributedText rangeOfString:@"SIGN IN"];
   
    
    [_signInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if (height == 480) {
        
        
        _requestInvitationButton.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightSemibold];
        _forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightSemibold];
        _messageLabel.font = [UIFont systemFontOfSize:13];
        _signInButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightSemibold];
        _haveAnInviteCodeButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightSemibold];
        _bySigningMessageLabel.font = [UIFont systemFontOfSize:10];
        _termsAndcontionButton.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightSemibold];

        
        _logoImageView.frame = CGRectMake((width-(_logoImageView.frame.size.width -17 ))/2, 40, _logoImageView.frame.size.width-17, _logoImageView.frame.size.height-25);
        _fasBackLogoImageView.frame =CGRectMake((width-(_fasBackLogoImageView.frame.size.width *0.8))/2, _logoImageView.frame.origin.y + _logoImageView.frame.size.height + 25,( _fasBackLogoImageView.frame.size.width * 0.8), (_fasBackLogoImageView.frame.size.height * 0.8));
        _technicianImageView.frame =CGRectMake(((_fasBackLogoImageView.frame.size.width + _fasBackLogoImageView.frame.origin.x) -5 ) - _technicianImageView.frame.size.width, _fasBackLogoImageView.frame.origin.y + _fasBackLogoImageView.frame.size.height + 2, _technicianImageView.frame.size.width, _technicianImageView.frame.size.height);

        _messageLabel.frame = CGRectMake((width-(_messageLabel.frame.size.width - 10))/2, _technicianImageView.frame.origin.y + _technicianImageView.frame.size.height + 5, _messageLabel.frame.size.width - 10, _messageLabel.frame.size.height);
        
        
        
        _termsAndcontionButton.frame = CGRectMake((width-(_termsAndcontionButton.frame.size.width - 22))/2, height-35, _termsAndcontionButton.frame.size.width - 22, _termsAndcontionButton.frame.size.height);
        _bySigningMessageLabel.frame = CGRectMake((width-_bySigningMessageLabel.frame.size.width)/2, _termsAndcontionButton.frame.origin.y - 17, _bySigningMessageLabel.frame.size.width, _bySigningMessageLabel.frame.size.height);
        _requestInvitationButton.frame = CGRectMake(20, _bySigningMessageLabel.frame.origin.y - 50, _requestInvitationButton.frame.size.width - 28, _requestInvitationButton.frame.size.height);
        _forgetPasswordButton.frame = CGRectMake(((20 + (width - 40))- (_forgetPasswordButton.frame.size.width -31) ), _bySigningMessageLabel.frame.origin.y - 54, _forgetPasswordButton.frame.size.width - 31, _forgetPasswordButton.frame.size.height);
        _haveAnInviteCodeButton.frame = CGRectMake( 20, _forgetPasswordButton.frame.origin.y - 50, width - 40, _haveAnInviteCodeButton.frame.size.height - 10);
        _signInButton.frame = CGRectMake(20, _haveAnInviteCodeButton.frame.origin.y - 55, width-40, _signInButton.frame.size.height-10);

        
        
//        bottomBorderForRequestInvitationButton.frame = CGRectMake(0.0f, _requestInvitationButton.frame.size.height - 3, _requestInvitationButton.frame.size.width, 0.5f);
//        bottomBorderForForgetButton.frame = CGRectMake(0.0f, _forgetPasswordButton.frame.size.height - 6, _forgetPasswordButton.frame.size.width, 0.5f);
        bottomBorderForTermsAndConditionButton.frame = CGRectMake(0.0f, _termsAndcontionButton.frame.size.height - 6, _termsAndcontionButton.frame.size.width, 0.5f);


    }
    else if (height == 568)
    {
        
//        _technicianImageView.font = [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
//        _requestInvitationButton.titleLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];
//        _forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];
//        _messageLabel.font = [UIFont systemFontOfSize:16];
//        _signInButton.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightSemibold];
//        _haveAnInviteCodeButton.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightSemibold];
//        _bySigningMessageLabel.font = [UIFont systemFontOfSize:11];
//        _termsAndcontionButton.titleLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];
        
//        _technicianImageView.font = [UIFont poppinsSemiBoldFontWithSize:10];
        _requestInvitationButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:10];
        _forgetPasswordButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:10];
        _signInButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightSemibold];
        _messageLabel.font = [UIFont poppinsNormalFontWithSize:14];
        _haveAnInviteCodeButton.titleLabel.font = [UIFont poppinsMediumFontWithSize:12];
        _bySigningMessageLabel.font = [UIFont poppinsNormalFontWithSize:10];
        _termsAndcontionButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:10];

//        [_technicianImageView sizeToFit];

        
        _logoImageView.frame = CGRectMake((width-(_logoImageView.frame.size.width * 0.9))/2, 60, (_logoImageView.frame.size.width * 0.9), (_logoImageView.frame.size.height * 0.9));
        _fasBackLogoImageView.frame =CGRectMake((width-(_fasBackLogoImageView.frame.size.width * 0.9 ))/2, _logoImageView.frame.origin.y + _logoImageView.frame.size.height + 30,( _fasBackLogoImageView.frame.size.width *0.9), (_fasBackLogoImageView.frame.size.height * 0.9));
        _technicianImageView.frame =CGRectMake(((_fasBackLogoImageView.frame.size.width + _fasBackLogoImageView.frame.origin.x)-5 ) - _technicianImageView.frame.size.width, _fasBackLogoImageView.frame.origin.y + _fasBackLogoImageView.frame.size.height + 5, _technicianImageView.frame.size.width *0.9, _technicianImageView.frame.size.height *0.9);
        
        _messageLabel.frame = CGRectMake((width-_messageLabel.frame.size.width)/2, _technicianImageView.frame.origin.y + _technicianImageView.frame.size.height + 10, _messageLabel.frame.size.width - 10, _messageLabel.frame.size.height + 15);

   
   
    _termsAndcontionButton.frame = CGRectMake((width-(_termsAndcontionButton.frame.size.width - 23))/2, height-40, _termsAndcontionButton.frame.size.width-23, _termsAndcontionButton.frame.size.height);
    _bySigningMessageLabel.frame = CGRectMake((width-_bySigningMessageLabel.frame.size.width)/2, _termsAndcontionButton.frame.origin.y - 17, _bySigningMessageLabel.frame.size.width, _bySigningMessageLabel.frame.size.height);
    _requestInvitationButton.frame = CGRectMake(20, _bySigningMessageLabel.frame.origin.y - 50, _requestInvitationButton.frame.size.width-25, _requestInvitationButton.frame.size.height);
    _forgetPasswordButton.frame = CGRectMake(((20 + (width - 40))- (_forgetPasswordButton.frame.size.width -29) ), _bySigningMessageLabel.frame.origin.y - 50, _forgetPasswordButton.frame.size.width-29, _forgetPasswordButton.frame.size.height);
    _haveAnInviteCodeButton.frame = CGRectMake( 20, _bySigningMessageLabel.frame.origin.y - 120, width - 40, _haveAnInviteCodeButton.frame.size.height- 5);
    _signInButton.frame = CGRectMake(20, _haveAnInviteCodeButton.frame.origin.y - 60, width-40, _signInButton.frame.size.height - 5);
        
        
//        bottomBorderForRequestInvitationButton.frame = CGRectMake(0.0f, _requestInvitationButton.frame.size.height - 5, _requestInvitationButton.frame.size.width, 0.5f);
//        bottomBorderForForgetButton.frame = CGRectMake(0.0f, _forgetPasswordButton.frame.size.height - 5, _forgetPasswordButton.frame.size.width, 0.5f);
        bottomBorderForTermsAndConditionButton.frame = CGRectMake(0.0f, _termsAndcontionButton.frame.size.height - 5, _termsAndcontionButton.frame.size.width, 0.5f);
        
        [attString addAttribute:NSFontAttributeName value:[UIFont poppinsSemiBoldFontWithSize:12] range:range];
        [_signInButton setAttributedTitle:attString forState:UIControlStateNormal];

    }
    else if (height == 667)
    {
        
//        _requestInvitationButton.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightSemibold];
//        _forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightSemibold];
//        _messageLabel.font = [UIFont systemFontOfSize:16];
//        _signInButton.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
//        _haveAnInviteCodeButton.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
//        _bySigningMessageLabel.font = [UIFont systemFontOfSize:12];
//        _termsAndcontionButton.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightSemibold];
//        
//        [_technicianImageView sizeToFit];
//
//        _logoImageView.frame = CGRectMake((width-_logoImageView.frame.size.width)/2, 50, _logoImageView.frame.size.width, _logoImageView.frame.size.height);
//        _technicianImageView.frame =CGRectMake(((_fasBackLogoImageView.frame.size.width + _fasBackLogoImageView.frame.origin.x)-5 ) - _technicianImageView.frame.size.width, _fasBackLogoImageView.frame.origin.y + _fasBackLogoImageView.frame.size.height + 2, _technicianImageView.frame.size.width, _technicianImageView.frame.size.height);
//
//        _messageLabel.frame = CGRectMake(25, _logoImageView.frame.origin.y + _logoImageView.frame.size.height + 30, width - 50, _messageLabel.frame.size.height + 10);
//        
//        
//        
//        _termsAndcontionButton.frame = CGRectMake((width-(_termsAndcontionButton.frame.size.width))/2, height-40, _termsAndcontionButton.frame.size.width, _termsAndcontionButton.frame.size.height);
//        _bySigningMessageLabel.frame = CGRectMake((width-_bySigningMessageLabel.frame.size.width)/2, _termsAndcontionButton.frame.origin.y - 20, _bySigningMessageLabel.frame.size.width, _bySigningMessageLabel.frame.size.height);
//        _requestInvitationButton.frame = CGRectMake((width-_signInButton.frame.size.width)/2, _bySigningMessageLabel.frame.origin.y - 70, _requestInvitationButton.frame.size.width -5 , _requestInvitationButton.frame.size.height);
//        _forgetPasswordButton.frame = CGRectMake(_requestInvitationButton.frame.origin.x + _requestInvitationButton.frame.size.width + 76, _bySigningMessageLabel.frame.origin.y - 75, _forgetPasswordButton.frame.size.width - 8 , _forgetPasswordButton.frame.size.height);
//        _haveAnInviteCodeButton.frame = CGRectMake((width-_haveAnInviteCodeButton.frame.size.width)/2, _forgetPasswordButton.frame.origin.y - 70, _haveAnInviteCodeButton.frame.size.width, _haveAnInviteCodeButton.frame.size.height + 5);
//        _signInButton.frame = CGRectMake((width-_signInButton.frame.size.width)/2, _haveAnInviteCodeButton.frame.origin.y - 70, _signInButton.frame.size.width, _signInButton.frame.size.height+5);
        
        
        
//        bottomBorderForRequestInvitationButton.frame = CGRectMake(0.0f, _requestInvitationButton.frame.size.height - 3, _requestInvitationButton.frame.size.width, 0.5f);
//        bottomBorderForForgetButton.frame = CGRectMake(0.0f, _forgetPasswordButton.frame.size.height - 6, _forgetPasswordButton.frame.size.width, 0.5f);
        bottomBorderForTermsAndConditionButton.frame = CGRectMake(0.0f, _termsAndcontionButton.frame.size.height - 3, _termsAndcontionButton.frame.size.width, 0.5f);
        
        [attString addAttribute:NSFontAttributeName value:[UIFont poppinsSemiBoldFontWithSize:12] range:range];
        [_signInButton setAttributedTitle:attString forState:UIControlStateNormal];

    }
    else if (height == 736)
    {
        
        _requestInvitationButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightSemibold];
        _forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightSemibold];
        _messageLabel.font = [UIFont systemFontOfSize:18];
        _signInButton.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
        _haveAnInviteCodeButton.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
        _bySigningMessageLabel.font = [UIFont systemFontOfSize:13];
        _termsAndcontionButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightSemibold];

        _logoImageView.frame = CGRectMake((width-_logoImageView.frame.size.width * 1.1)/2,80, (_logoImageView.frame.size.width *1.1), (_logoImageView.frame.size.height *1.1));
        _fasBackLogoImageView.frame =CGRectMake((width-(_fasBackLogoImageView.frame.size.width * 1.2 ))/2, _logoImageView.frame.origin.y + _logoImageView.frame.size.height + 30,( _fasBackLogoImageView.frame.size.width *1.2), (_fasBackLogoImageView.frame.size.height * 1.2));
                _technicianImageView.frame =CGRectMake(((_fasBackLogoImageView.frame.size.width + _fasBackLogoImageView.frame.origin.x)-5 ) - _technicianImageView.frame.size.width, _fasBackLogoImageView.frame.origin.y + _fasBackLogoImageView.frame.size.height + 2, _technicianImageView.frame.size.width, _technicianImageView.frame.size.height);
        _messageLabel.frame = CGRectMake(25, _technicianImageView.frame.origin.y + _technicianImageView.frame.size.height + 30, width - 50, _messageLabel.frame.size.height + 10);

        
        
        _termsAndcontionButton.frame = CGRectMake((width-(_termsAndcontionButton.frame.size.width - 3))/2, height-50, _termsAndcontionButton.frame.size.width -3 , _termsAndcontionButton.frame.size.height);
        _bySigningMessageLabel.frame = CGRectMake((width-_bySigningMessageLabel.frame.size.width)/2, _termsAndcontionButton.frame.origin.y - 20, _bySigningMessageLabel.frame.size.width, _bySigningMessageLabel.frame.size.height);
        _requestInvitationButton.frame = CGRectMake(30, _bySigningMessageLabel.frame.origin.y - 82, _requestInvitationButton.frame.size.width -13, _requestInvitationButton.frame.size.height);
        _forgetPasswordButton.frame = CGRectMake(((30 + (width - 60))- (_forgetPasswordButton.frame.size.width -15) ) , _bySigningMessageLabel.frame.origin.y - 87, _forgetPasswordButton.frame.size.width - 15, _forgetPasswordButton.frame.size.height);
        _haveAnInviteCodeButton.frame = CGRectMake(30, _forgetPasswordButton.frame.origin.y - 77, width - 60, _haveAnInviteCodeButton.frame.size.height + 10);
        _signInButton.frame = CGRectMake(30, _haveAnInviteCodeButton.frame.origin.y - 80, width-60, _signInButton.frame.size.height + 10);
        
        
        
        
      

//        bottomBorderForRequestInvitationButton.frame = CGRectMake(0.0f, _requestInvitationButton.frame.size.height - 3, _requestInvitationButton.frame.size.width, 0.5f);
//        bottomBorderForForgetButton.frame = CGRectMake(0.0f, _forgetPasswordButton.frame.size.height - 3, _forgetPasswordButton.frame.size.width, 0.5f);
        bottomBorderForTermsAndConditionButton.frame = CGRectMake(0.0f, _termsAndcontionButton.frame.size.height - 3, _termsAndcontionButton.frame.size.width, 0.5f);
        
        [attString addAttribute:NSFontAttributeName value:[UIFont poppinsSemiBoldFontWithSize:15] range:range];
        [_signInButton setAttributedTitle:attString forState:UIControlStateNormal];
    }
    
    _signInButton.layer.cornerRadius = 4;
    _haveAnInviteCodeButton.layer.cornerRadius = 4;
    _haveAnInviteCodeButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _haveAnInviteCodeButton.layer.borderWidth = 1.0;
    
    
   

    _signInButton.layer.shadowColor = [UIColor ColorWithHexaString:@"00A3FF"].CGColor;
    _signInButton.layer.shadowOpacity = 0.4;
    _signInButton.layer.shadowRadius = 3;
    _signInButton.layer.shadowOffset = CGSizeMake(0, 3.0f);
    
   

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIButton Actions 

- (IBAction)signInButton:(id)sender {
    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_SignIn] sender:nil];
}

- (IBAction)haveAnInviteCodeButton:(id)sender {
    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_EnterInviteCode] sender:nil];
}
- (IBAction)requestInvitationButtonClicked:(id)sender {
}
- (IBAction)forgetPasswordButtonClicked:(id)sender {
}
- (IBAction)termsAndConditionButtonClicked:(id)sender {
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
