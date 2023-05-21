//
//  customDatePickerView.m
//  fasBackTechnician
//
//  Created by User on 26/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "customDatePickerView.h"
#import "ConstantColors.h"
@implementation customDatePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (id)initWithCoder:(NSCoder *)aDecoder {
//    if ((self = [super initWithCoder:aDecoder])) {
//        [self addSubview:[[[NSBundle mainBundle] loadNibNamed:@"customDatePickerViewforfasBack" owner:self options:nil] objectAtIndex:0]];
//    }
//    return self; }

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"customDatePickerViewforfasBack" owner:self options:nil];
        UIView *view = [views objectAtIndex:0];
        [self customizeDesign];
        self = (customDatePickerView *)view;
    }
    return self;
}

-(void) customizeDesign
{
    _continueButton.layer.cornerRadius = 4;
    _cancelButton.layer.cornerRadius = 4;
    _cancelButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _cancelButton.layer.borderWidth = 1.0;
}


@end
