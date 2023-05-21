//
//  UITextField+ModifyngTextField.m
//  FasBack Consumer
//
//  Created by User on 10/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "UITextField+ModifyngTextField.h"

@implementation UITextField (ModifyngTextField)

- (void)setBorderForColor:(UIColor *)color width:(float)width radius:(float)radius
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [color CGColor];
    self.layer.borderWidth = width;
}

@end
