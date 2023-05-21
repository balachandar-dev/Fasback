//
//  RatingTableViewCell.h
//  fasBackTechnician
//
//  Created by User on 10/10/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EDStarRating.h>
@interface RatingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *workOrderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateOfCompletionLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedbackOfWorkOrderLabel;
@property (weak, nonatomic) IBOutlet EDStarRating *starRatingView;


+(NSString *) reuseIdentifier;
@end
