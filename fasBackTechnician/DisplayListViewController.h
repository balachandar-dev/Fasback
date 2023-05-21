//
//  DisplayListViewController.h
//  fasBackTechnician
//
//  Created by User on 28/08/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RejectReasons.h"
#import "Skillset.h"
#import "Webservice.h"
#import "City.h"
#import "State.h"


@interface DisplayListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,webProtocol>
{
    RejectReasons * rejectReason;
    Skillset * skillset;
    NSMutableArray  * arrayWithCities, * temporaryArrayForSkillsSets;
    NSMutableString * searchFieldString;
    Webservice * webservice;
    City * citySelected;
    NSMutableArray * arrayToBeDisplayed;
}

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;


@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property BOOL  isHoldOrDiscard , isEditProfile;

@property NSString * requestedFor;

@property NSMutableArray * arrayWithReasons,* arrayWithSkillsSelected;
@property (weak, nonatomic) IBOutlet UITableView *displayListTbleView;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintOfTableView;

@end
