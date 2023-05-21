//
//  DashboardCollectionViewCell.h
//  fasBackTechnician
//
//  Created by User on 10/10/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *WorkOrderStatusImageView;
@property (weak, nonatomic) IBOutlet UILabel *workOrderStatusName;

@end
