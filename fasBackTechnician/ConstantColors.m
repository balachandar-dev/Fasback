//
//  ConstantColors.m
//  FasBackTechnician
//
//  Created by User on 12/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "ConstantColors.h"

@implementation ConstantColors

+(UIColor *)disabledButtonBackgroundColor
{
    return [UIColor ColorWithHexaString:@"F5F5F5"];
}

+(UIColor *)enabledButtonBackGroundColor
{
    return [UIColor ColorWithHexaString:@"00A2FE"];
}


+(UIColor *)enabledButtonTextColor
{
    return [UIColor whiteColor];
}

+(UIColor *)disabledButtonTextColor
{
    return [UIColor ColorWithHexaString:@"a9a9a9"];
}

+(UIColor *) charcoalGray
{
    return [UIColor ColorWithHexaString:@"3B4042"];
}
+(UIColor *) coolGray
{
    return [UIColor ColorWithHexaString:@"ABAEB0"];
}



+(UIColor *) availableStatusColor
{
    return [UIColor ColorWithHexaString:@"62da64"];
}

+(UIColor *) modifiedBlueColorOfFasback
{
    return [UIColor ColorWithHexaString:@"00a8ff"];
}
@end
