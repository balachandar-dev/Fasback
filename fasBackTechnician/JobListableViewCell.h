//
//  JobListableViewCell.h
//  FasBackTechnician
//
//  Created by User on 20/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobListableViewCell : UITableViewCell
{
    float width, height;
}
@property (weak, nonatomic) IBOutlet UIImageView *logoImgeView;
@property (weak, nonatomic) IBOutlet UILabel *jobName;
@property (weak, nonatomic) IBOutlet UILabel *jobStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

+(NSString *)reuseIdentifier;

@end
