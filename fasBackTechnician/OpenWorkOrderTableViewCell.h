//
//  OpenWorkOrderTableViewCell.h
//  fasBackTechnician
//
//  Created by User on 26/10/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaddingLabel.h"

@interface OpenWorkOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *workOrderImageView;
@property (weak, nonatomic) IBOutlet PaddingLabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *workOderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *workOderDescriptionLabel;

+(NSString *)reuseIdentifier;

@end
