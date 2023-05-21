//
//  HeaderViewForProfile.m
//  fasBackTechnician
//
//  Created by User on 25/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "HeaderViewForProfile.h"

@implementation HeaderViewForProfile

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 
*/

//-(id)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super initWithCoder:aDecoder]) {
//        UIView *xibView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderViewInProfile"
//                                                         owner:self
//                                                       options:nil] objectAtIndex:0];
//        xibView.frame = self.bounds;
//        xibView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        [self addSubview: xibView];
//    }
//    return self;
//}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"HeaderViewInProfile" owner:self options:nil];
        UIView *view = [views objectAtIndex:0];
        [self customiingUIView];
        self = (HeaderViewForProfile *)view;
    }
    return self;
}

-(void) customiingUIView
{
//    [self.categoryButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
//    self.categoryButton.layer.cornerRadius = 2;
    
}

@end
