//
//  EstimatedTimeArrivalViewController.h
//  fasBackTechnician
//
//  Created by User on 11/12/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageLineLabel.h"
#import "Webservice.h"

@interface EstimatedTimeArrivalViewController : UIViewController<webProtocol>
{
    Webservice * webservice;

}

@property NSString * estimatedDateString;
@property (weak, nonatomic) IBOutlet MessageLineLabel *messageLineOneLabel;
@property (weak, nonatomic) IBOutlet UIButton *estimatedTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;


@property NSDictionary * dictionaryToBePassedForAcceptAPI;
@end
