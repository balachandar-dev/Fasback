//
//  RatingTableViewCell.m
//  fasBackTechnician
//
//  Created by User on 10/10/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "RatingTableViewCell.h"

@implementation RatingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self changesInUI];
    // Initialization code
}
-(void) changesInUI
{
    _starRatingView.starImage = [UIImage imageNamed:@"Empty_Star"];
    _starRatingView.starHighlightedImage = [UIImage imageNamed:@"Full_Star"];
    _starRatingView.maxRating = 5.0;
    //    _starRatingView.delegate = self;
    _starRatingView.horizontalMargin = 0;
    _starRatingView.editable=YES;
    _starRatingView.rating= 0;
    _starRatingView.displayMode=EDStarRatingDisplayAccurate;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(NSString *)reuseIdentifier
{
    return @"RatingTableViewCell";
}
@end
