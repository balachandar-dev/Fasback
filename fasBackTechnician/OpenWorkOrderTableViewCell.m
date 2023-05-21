//
//  OpenWorkOrderTableViewCell.m
//  fasBackTechnician
//
//  Created by User on 26/10/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "OpenWorkOrderTableViewCell.h"
#import "UIColor+Customcolor.h"
@implementation OpenWorkOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self changesInUI];

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) changesInUI
{
    _statusLabel.layer.borderColor = [[UIColor ColorWithHexaString:@"f9954b"] CGColor];
    _statusLabel.layer.borderWidth = 1;
}

+(NSString *)reuseIdentifier
{
    return @"OpenWorkOrderTableViewCell";
}

@end
