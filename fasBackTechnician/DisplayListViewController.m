//
//  DisplayListViewController.m
//  fasBackTechnician
//
//  Created by User on 28/08/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "DisplayListViewController.h"
#import "AcceptRejectJobViewController.h"
#import "StoryboardsAndSegues.h"
#import "HoldAndDiscardWorkOrderViewController.h"
#import "EditProfileViewController.h"
#import "DisplayListTableViewCell.h"
#import "Constants.h"
#import "UIColor+Customcolor.h"
#import "ConstantColors.h"

@interface DisplayListViewController ()
{
}
@end

@implementation DisplayListViewController
static NSInteger const WEBSERVICE_CITIES_TAG = 1101;
static NSInteger const WEBSERVICE_STATES_TAG = 1102;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayToBeDisplayed = [[NSMutableArray alloc]init];
    
    arrayWithCities = [[NSMutableArray alloc]init];
    skillset = [[Skillset alloc]init];

    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
   
    searchFieldString = [[NSMutableString alloc]init];
    temporaryArrayForSkillsSets = [[NSMutableArray alloc]init];

    arrayToBeDisplayed = _arrayWithReasons;
    
    [self restoreTemporaaryArray];
    if (_isEditProfile) {
        if ([_requestedFor isEqualToString:CITY]) {
            _headerLabel.text = @"Select City";
        }
        else if ([_requestedFor isEqualToString:SKILLS])
        {
            _headerLabel.text = @"Select Skills";
        }
    }
    if (![_requestedFor isEqualToString:SKILLS]) {
        _bottomConstraintOfTableView.constant = 0;
        _cancelButton.hidden = YES;
        _okButton.hidden = YES;
    }
    _okButton.layer.cornerRadius = 4;
    _cancelButton.layer.cornerRadius = 4;
    _cancelButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _cancelButton.layer.borderWidth = 1.0;

    _searchTextField.layer.borderColor = [[UIColor ColorWithHexaString:@"e8eced"] CGColor];
    _searchTextField.layer.borderWidth = 1;
    // Do any additional setup after loading the view.
}

-(void) restoreTemporaaryArray
{
    temporaryArrayForSkillsSets = nil;
    temporaryArrayForSkillsSets = [[NSMutableArray alloc]init];

    if (_isEditProfile) {
        if ([_requestedFor isEqualToString:SKILLS]) {
            for (int i = 0; i<arrayToBeDisplayed.count; i++) {
                Skillset * eachSkillset = [[Skillset alloc]init];
                eachSkillset = [arrayToBeDisplayed objectAtIndex:i];
//                [temporaryArrayForSkillsSets addObject:eachSkillset.skillName];
            }
        }
    }
    
    for (int i = 0; i<arrayToBeDisplayed.count; i++) {
    Skillset * eachSkillset = [[Skillset alloc]init];
    eachSkillset = [arrayToBeDisplayed objectAtIndex:i];
    NSLog(@"eachskill%@",eachSkillset);
    NSLog(@"_arrayWithSkillsSelected%@",_arrayWithSkillsSelected);
    
    for (Skillset * eachTechnicianSkillset in _arrayWithSkillsSelected) {
        if ([eachTechnicianSkillset.skillName isEqualToString:eachSkillset.skillName]) {
            [temporaryArrayForSkillsSets addObject:eachTechnicianSkillset.skillName];
//            cell.checkboxButton.image = [UIImage imageNamed:@"checkbox_selected"];
            break;
        }
//        else
//        {
//            [temporaryArrayForSkillsSets replaceObjectAtIndex:i withObject:@"0"];
////            cell.checkboxButton.image = [UIImage imageNamed:@"checkbox_default"];
//        }
    }
        
    }
    NSLog(@"temporary %@",temporaryArrayForSkillsSets);


}

#pragma mark - Webservice

-(void) webserviceToGetCityListWithSubstring : (NSString *) citySubstring
{
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/Common/GetAllCitiesByText/%@",[Webservice webserviceLink],citySubstring];
    [webservice requestMethod:stringWithUrl withMsgType:WEBSERVICE_CITIES_TAG];
}

-(void) webserviceToGetStateListWithSubstring : (NSString * ) cityId
{
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/Common/GetStatesByCityID/%@",[Webservice webserviceLink],cityId];
    [webservice requestMethod:stringWithUrl withMsgType:WEBSERVICE_STATES_TAG];
}

#pragma mark - UIButton Actions

- (IBAction)closeButtonclicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)tickButtonClicked:(id)sender {
    _arrayWithSkillsSelected = nil;
    _arrayWithSkillsSelected = [[NSMutableArray alloc]init];
    
    for (int i = 0; i< _arrayWithReasons.count; i++) {
        Skillset * eachSkillset = [[Skillset alloc]init];
        eachSkillset = [_arrayWithReasons objectAtIndex:i];
        if ([temporaryArrayForSkillsSets containsObject:eachSkillset.skillName]) {
            [_arrayWithSkillsSelected addObject:[_arrayWithReasons objectAtIndex:i]];
        }
    }
    [self performSegueWithIdentifier:[StoryboardsAndSegues unwindToEditProfileViewController] sender:nil];
}

#pragma mark - UITableView Datasoure

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (!_isEditProfile) {
        return [arrayToBeDisplayed count];
//    }
//    else
//    {
//        if (<#condition#>) {
//            statements
//        }
//    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DisplayListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"reasonCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[DisplayListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reasonCell"];
    }
    
    cell.checkboxButton.hidden = YES;
    cell.reasonLabel.hidden = YES;
    
    if (_isEditProfile) {
        if ([_requestedFor isEqualToString:CITY]) {
            City * eachCity = [[City alloc]init];
            cell.reasonLabel.hidden = NO;

            eachCity = [arrayToBeDisplayed objectAtIndex:indexPath.row];
            cell.reasonLabel.text = eachCity.cityName;
        }
        else if([_requestedFor isEqualToString:SKILLS])
        {
            cell.checkboxButton.hidden = NO;
            cell.reasonLabel.hidden = NO;

           Skillset * eachSkillset = [[Skillset alloc]init];
            eachSkillset = [arrayToBeDisplayed objectAtIndex:indexPath.row];
            cell.reasonLabel.text = eachSkillset.skillName;
            NSLog(@"eachskill%@",eachSkillset);
            NSLog(@"_arrayWithSkillsSelected%@",_arrayWithSkillsSelected);

            if ([temporaryArrayForSkillsSets containsObject:eachSkillset.skillName]) {
                cell.checkboxButton.image = [UIImage imageNamed:@"checkbox_selected"];
            }
            else
            {
                cell.checkboxButton.image = [UIImage imageNamed:@"checkbox_default"];
            }
        
        }
        else
        {
            
        }
    }
    else
    {
    rejectReason = [[RejectReasons alloc]init];
    rejectReason = [arrayToBeDisplayed objectAtIndex:indexPath.row];
    cell.textLabel.text = rejectReason.reason;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

#pragma mark - UITableView Delegates

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isEditProfile) {
        if ([_requestedFor isEqualToString:CITY]) {
            citySelected = [[City alloc]init];
            citySelected = [arrayToBeDisplayed objectAtIndex:indexPath.row];
            [self performSegueWithIdentifier:[StoryboardsAndSegues unwindToEditProfileViewController] sender:nil];

        }
        else if([_requestedFor isEqualToString:SKILLS])
        {
            skillset = [arrayToBeDisplayed objectAtIndex:indexPath.row];
            
            if ([temporaryArrayForSkillsSets containsObject:skillset.skillName]) {
                [temporaryArrayForSkillsSets removeObject:skillset.skillName];
            }
            else
            {
                [temporaryArrayForSkillsSets addObject:skillset.skillName];
            }
//            for (Skillset * eachTechnicianSkillset in _arrayWithSkillsSelected) {
//                if ([eachTechnicianSkillset.skillName isEqualToString:skillset.skillName]) {
//                [_arrayWithSkillsSelected removeObject:skillset];
//                    return;
//            }
//            else
//            {
//                [_arrayWithSkillsSelected addObject:skillset];
//            }
            
//            }
            [tableView reloadData];
        }
        else
        {
            
        }

    }
    else
    {
    rejectReason = arrayToBeDisplayed[indexPath.row];
    if (_isHoldOrDiscard) {
        [self performSegueWithIdentifier:[StoryboardsAndSegues unwindToHoldOrRejectViewController] sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:[StoryboardsAndSegues unwindToAcceptOrRejectViewController] sender:nil];
    }
    }
}

#pragma mark - UITextField Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //            isEnterTeextFieldReturned = NO;
    
    if ([string isEqualToString:@""]) {
        NSLog(@"Back space");
        [searchFieldString replaceCharactersInRange:range withString:@""];
    }
    else
    {
        NSLog(@"%@",string);
        [searchFieldString appendString:string];
    }
    if (_isEditProfile) {
        if ([_requestedFor isEqualToString:CITY]) {
            if (searchFieldString.length %2 == 0) {
                [self webserviceToGetCityListWithSubstring:searchFieldString];
            }
        }
        else if ([_requestedFor isEqualToString:SKILLS])
        {
            if (searchFieldString.length == 0) {
                arrayToBeDisplayed = _arrayWithReasons;
            }
            else
            {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"skillName contains[c] %@", searchFieldString];
            arrayToBeDisplayed = [self.arrayWithReasons filteredArrayUsingPredicate:predicate];
            }
            NSLog(@"%@",arrayToBeDisplayed);
            
//            [self restoreTemporaaryArray];
            //        if (arrayToBeDisplayed.count != 0 ) {
            //            arrayToBeDisplayed = _arrayWithReasons;
            //        }
            [_displayListTbleView reloadData];
        }
    }
    else
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"reason contains[c] %@", searchFieldString];
        arrayToBeDisplayed = [self.arrayWithReasons filteredArrayUsingPredicate:predicate];
        
        NSLog(@"%@",arrayToBeDisplayed);
        
//        if (arrayToBeDisplayed.count != 0 ) {
//            arrayToBeDisplayed = _arrayWithReasons;
//        }
        [_displayListTbleView reloadData];
    }
    return YES;
}

#pragma mark - Webservice delagate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    
//    NSLog(@"%@",parsedData);
    
    _arrayWithReasons = [[NSMutableArray alloc]init];

        if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
            if ([parsedData objectForKey:@"ReturnObject"] != [NSNull null]) {
                
                NSArray * resultData = [parsedData objectForKey:@"ReturnObject"];
                NSLog(@"%@",resultData);
                if (msgType == WEBSERVICE_CITIES_TAG) {
                    for (int i =0 ; i<[resultData count]; i++) {
                        NSDictionary * cityDictionary = resultData[i];
                        City * eachCity = [[City alloc]init];
                        eachCity.cityId = cityDictionary[@"CityID"];
                        eachCity.cityName = cityDictionary[@"CityName"];
                        
                        [_arrayWithReasons addObject:eachCity];
                    }
                }
                else
                {
                    
                }
            }
        }
    arrayToBeDisplayed = _arrayWithReasons;
    [_displayListTbleView reloadData];

}

-(void)errorRecieved:(NSString *)errorString withMsgType:(int)msgType
{
    
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:[StoryboardsAndSegues unwindToEditProfileViewController]]) {
        EditProfileViewController * editProfileViewController = segue.destinationViewController;

        if ([_requestedFor isEqualToString:CITY]) {
            editProfileViewController.selectedCity = citySelected;
        }
        else if([_requestedFor isEqualToString:SKILLS])
        {
               editProfileViewController.arrayWithSkills = _arrayWithSkillsSelected;
        }
        else
        {
            
        }
    }
    else if (_isHoldOrDiscard) {
        HoldAndDiscardWorkOrderViewController * holdAndDiscardWorkOrderVieController = segue.destinationViewController;
        holdAndDiscardWorkOrderVieController.holdOrDiscardReasonSelected = rejectReason;
    }
    else
    {
    AcceptRejectJobViewController * acceptRejectViewController = segue.destinationViewController;
    acceptRejectViewController.rejectReasonSelected = rejectReason;
    }
}


@end
