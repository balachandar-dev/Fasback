//
//  ViewSensorfactTableViewCell.m
//  fasBackTechnician
//
//  Created by User on 02/09/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "ViewSensorfactTableViewCell.h"

@implementation ViewSensorfactTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(NSString *)reuseIdentifier
{
    return @"ViewSensorfactTableViewCell";
}

@end
