//
//  ConfirmDetailsViewController.h
//  FasBackTechnician
//
//  Created by User on 14/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaddingLabel.h"
#import "Webservice.h"

@interface ConfirmDetailsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,webProtocol>
{
    NSMutableArray * arrayWithtitleTexts, * arrayWithTextFieldValues, * arrayWithSkills;
    float width, height,xAxis, yAxis, widthForLabel, heightForLabel, offsetOfTableView;
    Webservice * webservice;
}

@property (nonatomic,strong) NSString * emailId;
@property (nonatomic,strong) NSDictionary * confirmDetailDictionary;
@property (weak, nonatomic) IBOutlet UITableView *profileTableView;
@property (weak, nonatomic) IBOutlet UIView *backgroundOfTableView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundTableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabelforLogoImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameHeaderLabel;

@end
