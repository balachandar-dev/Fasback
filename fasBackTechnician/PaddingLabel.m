//
//  PaddingLabel.m
//  SampleApp
//
//  Created by Developer on 16/04/16.
//  Copyright © 2016 Developer. All rights reserved.
//

#import "PaddingLabel.h"

@implementation PaddingLabel


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.edgeInsets = UIEdgeInsetsMake(2, 5, 2, 5);
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

- (CGSize)intrinsicContentSize
{
    CGSize size = [super intrinsicContentSize];
    size.width  += self.edgeInsets.left + self.edgeInsets.right;
    size.height += self.edgeInsets.top + self.edgeInsets.bottom;
    return size;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
