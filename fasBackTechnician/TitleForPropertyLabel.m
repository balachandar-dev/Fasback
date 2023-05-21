//
//  TitleForPropertyLabel.m
//  fasBackTechnician
//
//  Created by User on 22/09/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "TitleForPropertyLabel.h"
#import "UIFont+PoppinsFont.h"
@implementation TitleForPropertyLabel

-(void)awakeFromNib{
    [super awakeFromNib];
    [self customize];
}


- (void)customize {
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        self.font = [UIFont poppinsSemiBoldFontWithSize:10];
    }
    else if ([UIScreen mainScreen].bounds.size.height == 568)
    {
        self.font = [UIFont poppinsSemiBoldFontWithSize:9];
    }
    else if ([UIScreen mainScreen].bounds.size.height == 667)
    {
        self.font = [UIFont poppinsSemiBoldFontWithSize:10];
    }
    else
    {
        self.font = [UIFont poppinsSemiBoldFontWithSize:10];
    }
}


@end
