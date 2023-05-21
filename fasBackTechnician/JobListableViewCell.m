//
//  JobListableViewCell.m
//  FasBackTechnician
//
//  Created by User on 20/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "JobListableViewCell.h"
#import "UIFont+PoppinsFont.h"
@implementation JobListableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self changesInUI];
    // Initialization code
}

-(void) changesInUI
{
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    
    if (height == 480) {
        //
    }
    else if (height == 568)
    {
        _jobName.font = [UIFont poppinsNormalFontWithSize:13];
        _jobStatusLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _jobDescriptionLabel.font = [UIFont poppinsNormalFontWithSize:12];
        _dateLabel.font = [UIFont poppinsNormalFontWithSize:12];

    }
    else if (height == 667)
    {
        
    }
    else
    {
        
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(NSString *)reuseIdentifier
{
    return @"JobListTableViewCell";
}
@end
