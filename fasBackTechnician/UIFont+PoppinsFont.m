//
//  UIFont+PoppinsFont.m
//  FasBackTechnician
//
//  Created by User on 13/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "UIFont+PoppinsFont.h"

@implementation UIFont (PoppinsFont)

+(UIFont *) poppinsNormalFontWithSize : (int) size
{
    return [UIFont fontWithName:@"Poppins-Regular" size:size];
}
+(UIFont *) poppinsBoldFontWithSize : (int) size
{
    return [UIFont fontWithName:@"Poppins-Bold" size:size];
}
+(UIFont *) poppinsSemiBoldFontWithSize : (int) size
{
    return [UIFont fontWithName:@"Poppins-SemiBold" size:size];
}
+(UIFont *) poppinsMediumFontWithSize : (int) size
{
    return [UIFont fontWithName:@"Poppins-Medium" size:size];
}
+(UIFont *) poppinsLightFontWithSize : (int) size
{
    return [UIFont fontWithName:@"Poppins-Light" size:size];
}
@end
