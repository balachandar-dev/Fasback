//
//  SetNewPasswordTableViewCell.h
//  FasBackTechnician
//
//  Created by User on 13/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetNewPasswordTableViewCell : UITableViewCell
{
    float width, height;
}
@property (weak, nonatomic) IBOutlet UIImageView *validateImageView;
@property (weak, nonatomic) IBOutlet UILabel *validateMessageTextLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthOfImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstrintOfImageView;
+(NSString *) reuseIdentifier;
@end
