//
//  CompletedViewController.h
//  fasBackTechnician
//
//  Created by User on 25/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompletedViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UILabel *messageLabelOne;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property(strong,nonatomic) NSString * jobId;
@property BOOL isResolved;
@end
