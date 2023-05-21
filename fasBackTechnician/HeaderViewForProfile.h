//
//  HeaderViewForProfile.h
//  fasBackTechnician
//
//  Created by User on 25/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderViewForProfile : UIView
@property (weak, nonatomic) IBOutlet UIButton *basicInformationButton;
@property (weak, nonatomic) IBOutlet UIButton *jobInformationButton;
@property (weak, nonatomic) IBOutlet UIView *bottomHightlightViewForBasicInformationButton;
@property (weak, nonatomic) IBOutlet UIView *bottomHighlightViewForJobInformationButton;

@end
