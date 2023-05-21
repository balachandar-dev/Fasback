//
//  DashboardTableViewCell.h
//  FasBackTechnician
//
//  Created by User on 20/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *numberOfWorksCompleted;
@property (weak, nonatomic) IBOutlet UILabel *statusOfWork;
@property (weak, nonatomic) IBOutlet UIImageView *graphImageView;
+(NSString *) reuseIdentifier;

@end
