//
//  SetNewPasswordTableViewCell.m
//  FasBackTechnician
//
//  Created by User on 13/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "SetNewPasswordTableViewCell.h"

@implementation SetNewPasswordTableViewCell


- (instancetype)init
{
    self = [super init];
    if (self) {
        //
    }
    [self UIChanges];
    return self;
}

-(id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        //Changes here after init'ing self
    }
    [self UIChanges];
    return self;
}
-(void) UIChanges
{
//    if (height == 480) {
//        
//    }
//    else if (height == 568)
//    {
        _heightConstrintOfImageView.constant = 120;
        _widthOfImageView.constant =  40;
        
//    }
//    else if(height == 667)
//    {
////        _heightConstraintOfValidationTable.constant = 160;
//    }
//    else if(height == 736)
//    {
//        
//    }

}
+(NSString *)reuseIdentifier
{
    return @"validateCell";
}
@end
