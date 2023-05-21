//
//  ViewSensorfactTableViewCell.h
//  fasBackTechnician
//
//  Created by User on 02/09/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewSensorfactTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *valueFromSensorLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *graphImage;


+(NSString *) reuseIdentifier;

@end
