//
//  MessageLineLabel.m
//  fasBackTechnician
//
//  Created by User on 26/09/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "MessageLineLabel.h"
#import "UIFont+PoppinsFont.h"
@implementation MessageLineLabel

-(void)awakeFromNib{
    [super awakeFromNib];
    [self customize];
}


- (void)customize {
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        self.font = [UIFont poppinsNormalFontWithSize:10];
    }
    else if ([UIScreen mainScreen].bounds.size.height == 568)
    {
        self.font = [UIFont poppinsNormalFontWithSize:10];
    }
    else if ([UIScreen mainScreen].bounds.size.height == 667)
    {
        self.font = [UIFont poppinsNormalFontWithSize:12];
    }
    else
    {
        self.font = [UIFont poppinsNormalFontWithSize:12];
    }
}


@end
