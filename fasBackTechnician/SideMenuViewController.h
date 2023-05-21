//
//  SideMenuViewController.h
//  FasBackTechnician
//
//  Created by User on 18/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EDStarRating.h>
#import "Webservice.h"

@interface SideMenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,webProtocol>
{
    NSMutableArray * arrayWithImages, * arrayWithTexts;
    float width, height;
    Webservice * webservice;

}

@property (weak, nonatomic) IBOutlet UIImageView *fasBackHeaderImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *availableButton;
@property (weak, nonatomic) IBOutlet UITableView *sideMenuTableView;
@property (weak, nonatomic) IBOutlet UILabel *versionNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starRatingImageView;

@property (weak, nonatomic) IBOutlet EDStarRating *starRatingView;


-(void) getDatafromCoreData;

@end
