//
//  DashboardTableViewCell.m
//  FasBackTechnician
//
//  Created by User on 20/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "DashboardTableViewCell.h"
#import "UIFont+PoppinsFont.h"
@implementation DashboardTableViewCell



+(NSString *)reuseIdentifier
{
    return @"DashboardTableViewCell";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)drawRect:(CGRect)rect
{
    if ([UIScreen mainScreen].bounds.size.height == 480 ) {
        _numberOfWorksCompleted.font = [UIFont poppinsLightFontWithSize:25];
        _statusOfWork.font = [UIFont poppinsNormalFontWithSize:13];
    }
   else if ([UIScreen mainScreen].bounds.size.height == 568 ) {
        _numberOfWorksCompleted.font = [UIFont poppinsLightFontWithSize:25];
        _statusOfWork.font = [UIFont poppinsNormalFontWithSize:11];
    }
    else if ([UIScreen mainScreen].bounds.size.height == 667 ) {
        _numberOfWorksCompleted.font = [UIFont poppinsLightFontWithSize:29];
        _statusOfWork.font = [UIFont poppinsNormalFontWithSize:13];
    }
    else{
        
    }
    
}
@end
