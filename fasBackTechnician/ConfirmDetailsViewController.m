//
//  ConfirmDetailsViewController.m
//  FasBackTechnician
//
//  Created by User on 14/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "ConfirmDetailsViewController.h"
#import "ConfirmDetailsTableViewCell.h"
#import "UIFont+PoppinsFont.h"
#import "UIColor+Customcolor.h"
#import "StoryboardsAndSegues.h"
#import "SetPasswordViewController.h"
#import <AFNetworking.h>
#import "AppDelegate.h"
#import "Skillset.h"
#import "ConstantColors.h"
#import <UIImageView+AFNetworking.h>

@interface ConfirmDetailsViewController ()
{
    AppDelegate * appDelegate;
}

@end

@implementation ConfirmDetailsViewController


static NSInteger const WEBSERVICE_FROM_GET_DETAILS_TAG = 1101;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self restoreToDefaults];

    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    _mainScrollView.contentSize = CGSizeMake(width, 200 + [self tableViewHeight]);
    _tableViewHeightConstraint.constant = [self tableViewHeight];
    _backgroundTableViewHeightConstraint.constant = [self tableViewHeight] + 20;
//    [self webserviceToConfirmDetails];
}

#pragma mark - General 

-(void) restoreToDefaults
{
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
    
    arrayWithtitleTexts = [[NSMutableArray alloc]initWithObjects:@"EMAIL ADDRESS", @"PHONE #",@"ADDRESS LINE 1",@"CITY",@"COUNTRY",@"STATE",@"ZIP CODE",@"ORGANISATION",@"SKILLS", nil];
//    arrayWithTextFieldValues = [[NSMutableArray alloc]initWithObjects:@"justinjenderson@gmail.com", @"(251) 546-9442",@"8153",@"Vlley View Ave",@"Fort Lauderdale",@"Florida",@"33334",@"Bluewell Electricals, Fort Lauderdale FL, Fort Lauderdale FL,Bluewell Electricals, Fort Lauderdale FL, Fort Lauderdale FL,Bluewell Electricals, Fort Lauderdale FL, Fort Lauderdale FL ",@"", nil];
    arrayWithTextFieldValues = [[NSMutableArray alloc]initWithObjects:@"", @"",@"",@"",@"",@"",@"",@"",@"", nil];

    arrayWithSkills = [[NSMutableArray alloc]initWithObjects:@"Plumbing", @"Electrical Works",@"Bike Mechanic",@"Car Mechanic", nil];
    arrayWithSkills = [[NSMutableArray alloc]init];

    [self changesInUI];
    
//    self.profileTableView.estimatedRowHeight = 100;
//    self.profileTableView.rowHeight = UITableViewAutomaticDimension;
//    [_profileTableView reloadData];
}


-(void) changesInUI
{
    _placeholderLabelforLogoImage.text = @"";
    _userNameLabel.text = @"";
    
    _placeholderLabelforLogoImage.hidden = YES;
//    _profileImageView.image = nil;
    
    _profileImageView.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _profileImageView.layer.borderWidth = 0.4;
    _profileImageView.layer.cornerRadius = _profileImageView.frame.size.width/2;
    _profileImageView.layer.masksToBounds = YES;
    
    _backgroundOfTableView.layer.cornerRadius = 6;
    _nextButton.layer.cornerRadius = 6;
    _profileImageView.layer.cornerRadius = _profileImageView.frame.size.width/2;
    _profileImageView.layer.masksToBounds = YES;
    _profileImageView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _profileImageView.layer.borderWidth = 1;
    
    _profileImageView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _profileImageView.layer.shadowOpacity = 0.4;
    _profileImageView.layer.shadowRadius = 3;
    _profileImageView.layer.shadowOffset = CGSizeMake(2.0f, 5.0f);
    if (height == 480) {
        //
    }
    else if (height == 568)
    {
        _userNameHeaderLabel.font = [UIFont poppinsSemiBoldFontWithSize:16];
        _nextButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:12];
    }
    else if (height == 667)
    {
        
    }
    else
    {
        
    }
    
    [self setValuesToUIElementsFromWebservice];
}

-(void) setValuesToUIElementsFromWebservice
{
    NSMutableString * nameString = [[NSMutableString alloc]init];
    
    if(_confirmDetailDictionary[@"FName"] != [NSNull null])
    {
        [nameString appendString:_confirmDetailDictionary[@"FName"]];
    }
    if(_confirmDetailDictionary[@"LName"] != [NSNull null])
    {
        [nameString appendString:_confirmDetailDictionary[@"LName"]];
    }
    _userNameHeaderLabel.text = nameString;
    if(_confirmDetailDictionary[@"EmailP"] != [NSNull null])
    {
    [arrayWithTextFieldValues replaceObjectAtIndex:0 withObject:_confirmDetailDictionary[@"EmailP"]];
    }
    if(_confirmDetailDictionary[@"MobileP"] != [NSNull null])
    {
    [arrayWithTextFieldValues replaceObjectAtIndex:1 withObject:_confirmDetailDictionary[@"MobileP"]];
    }
    if(_confirmDetailDictionary[@"AddressLine1"] != [NSNull null])
    {
    [arrayWithTextFieldValues replaceObjectAtIndex:2 withObject:_confirmDetailDictionary[@"AddressLine1"]];
    }
//    if(_confirmDetailDictionary[@"AddressLine2"] != [NSNull null])
//    {
//    [arrayWithTextFieldValues replaceObjectAtIndex:3 withObject:_confirmDetailDictionary[@"AddressLine2"]];
//    }
    if(_confirmDetailDictionary[@"CityName"] != [NSNull null])
    {
    [arrayWithTextFieldValues replaceObjectAtIndex:4 withObject:_confirmDetailDictionary[@"CityName"]];
    }
    if(_confirmDetailDictionary[@"StateName"] != [NSNull null])
    {
    [arrayWithTextFieldValues replaceObjectAtIndex:6 withObject:_confirmDetailDictionary[@"StateName"]];
    }
    if(_confirmDetailDictionary[@"ZipCode"] != [NSNull null])
    {
    [arrayWithTextFieldValues replaceObjectAtIndex:7 withObject:_confirmDetailDictionary[@"ZipCode"]];
    }
    if(_confirmDetailDictionary[@"Organization"] != [NSNull null])
    {
    [arrayWithTextFieldValues replaceObjectAtIndex:8 withObject:_confirmDetailDictionary[@"Organization"]];
    }
    if(_confirmDetailDictionary[@"ImgProfile"] != [NSNull null])
    {
        [_profileImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_confirmDetailDictionary[@"ImgProfile"]]]
                              placeholderImage:nil
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           
                                           // do image resize here
                                           
                                           // then set image view
                                           if (image != nil) {
                                               _profileImageView.image = image;
                                           }
                                           else
                                           {
                                               if (_confirmDetailDictionary[@"FName"] != [NSNull null]) {
                                                   NSString * firstCharacterOfCustomerName = [_confirmDetailDictionary[@"FName"] substringToIndex:1];
                                                   _placeholderLabelforLogoImage.text =firstCharacterOfCustomerName;
                                               }
                                           }
                                       }
                                       failure:nil];
    }
    else
    {
        if (_confirmDetailDictionary[@"FName"] != [NSNull null]) {
            NSString * firstCharacterOfCustomerName = [_confirmDetailDictionary[@"FName"] substringToIndex:1];
            _placeholderLabelforLogoImage.text =firstCharacterOfCustomerName;
        }
    }

    
    NSArray * skillsetArray = _confirmDetailDictionary[@"SkillSets"];
    for (int i = 0; i< skillsetArray.count; i++) {
        NSDictionary * skillsetDictionary = skillsetArray[i];
        
        Skillset * eachSkillset = [[Skillset alloc]init];
        eachSkillset.skillId = skillsetDictionary[@"SkillID"];
        eachSkillset.skillName = skillsetDictionary[@"SkillName"];
        [arrayWithSkills addObject:eachSkillset];
    }
    
    
    [_profileTableView reloadData];
}

- (CGFloat)tableViewHeight
{
    [self.profileTableView reloadData];
    self.profileTableView.delegate=self;
    self.profileTableView.dataSource=self;
    [self.profileTableView layoutIfNeeded];
    return [self.profileTableView  contentSize].height;
    
}

-(void) showAlertWithMessage : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Call Web service

-(void) webserviceToConfirmDetails
{
    [appDelegate initActivityIndicatorForviewController:self];
//     _emailId = @"tch3@gmail.com";
    
    NSDictionary * postDataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:_emailId,@"Email", nil];
        
        NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/Account/ConfirmTechnicianDetail",[Webservice webserviceLink]];
        [webservice requestMethodForPost:stringWithUrl withData:postDataDictionary withTag:WEBSERVICE_FROM_GET_DETAILS_TAG];

}

//- (void)requestFinished:(ASIHTTPRequest *)request {
//    NSLog(@"Response %d ==> %@", request.responseStatusCode, [request responseString]);
//    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
//    NSLog(@"JSON %@", json);
//}

#pragma mark - UIButton Actions

- (IBAction)nextButtonClicked:(id)sender {
    [self webserviceToConfirmDetails];
//    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_SetPassword] sender:nil];
}


#pragma mark - UITableView Datasoure

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayWithtitleTexts count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConfirmDetailsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"confirmOrganizationCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ConfirmDetailsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"confirmOrganizationCell"];
    }
    
    cell.titleLabel.text = [arrayWithtitleTexts objectAtIndex:indexPath.row];
    if (indexPath.row != arrayWithtitleTexts.count - 1) {
    cell.detailsLabel.text = [arrayWithTextFieldValues objectAtIndex:indexPath.row];
    }
    else
    {
        cell.detailsLabel.hidden = YES;
        xAxis = 15;
        yAxis =30;
        widthForLabel = 50;
        heightForLabel = 17;
        offsetOfTableView = 0;
        for (int i = 0; i< [arrayWithSkills count]; i++) {
           PaddingLabel* labelForEachItem = [[PaddingLabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, widthForLabel, heightForLabel)];
            Skillset * eachSkilSet = [arrayWithSkills objectAtIndex:i];
            labelForEachItem.text = eachSkilSet.skillName;
            labelForEachItem.tag = 2000+i;
            labelForEachItem.textColor = [UIColor ColorWithHexaString:@"31393C"];
            labelForEachItem.font = [UIFont poppinsNormalFontWithSize:12];
            labelForEachItem.backgroundColor = [UIColor ColorWithHexaString:@"F4F5F7"];
            labelForEachItem.layer.borderWidth = 0.7;
            labelForEachItem.layer.borderColor = [[UIColor lightGrayColor]CGColor];
            [labelForEachItem sizeToFit];
            labelForEachItem.frame = CGRectMake(xAxis, yAxis, labelForEachItem.frame.size.width+10, labelForEachItem.frame.size.height+5);
            xAxis = xAxis + labelForEachItem.frame.size.width + 10;
            if (xAxis > tableView.frame.size.width - labelForEachItem.frame.size.width-10) {
                yAxis = yAxis + 40;
                xAxis = 15;
                offsetOfTableView = offsetOfTableView + 40;
            }
            [cell addSubview:labelForEachItem];
        }
    }

    return cell;
}

//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    //minimum size of your cell, it should be single line of label if you are not clear min. then return UITableViewAutomaticDimension;
//    return UITableViewAutomaticDimension;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str = [arrayWithtitleTexts objectAtIndex:indexPath.row];
    
//    CGSize size = [str sizeWithAttributes:
//                   @{NSFontAttributeName: [UIFont poppinsSemiBoldFontWithSize:12]}];
    CGSize size = [str sizeWithFont:[UIFont poppinsSemiBoldFontWithSize:12] constrainedToSize:CGSizeMake(280, 999) lineBreakMode:NSLineBreakByWordWrapping];

    NSString *str2 = [arrayWithTextFieldValues objectAtIndex:indexPath.row];

//    CGSize size2 = [str2 sizeWithAttributes:
//                   @{NSFontAttributeName: [UIFont poppinsNormalFontWithSize:12]}];
    if (indexPath.row != arrayWithtitleTexts.count - 1) {
    CGSize size2 = [str2 sizeWithFont:[UIFont poppinsSemiBoldFontWithSize:12] constrainedToSize:CGSizeMake(280, 999) lineBreakMode:NSLineBreakByWordWrapping];
        NSLog(@"%f",size2.height);
        return size.height + size2.height + 30;
    }
    else
    {
        return size.height + offsetOfTableView + 40;
    }
   
    
    
//    NSString *str = [dataSourceArray objectAtIndex:indexPath.row];
//    CGSize size = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17] constrainedToSize:CGSizeMake(280, 999) lineBreakMode:NSLineBreakByWordWrapping];
//    NSLog(@"%f",size.height);
//    return size.height + 10;
//    return UITableViewAutomaticDimension;
}



#pragma mark - UITableView Delegates

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - UITextView Delegates

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    [self restoreToDefaults];
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

#pragma mark - Webservice delagate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];

    NSLog(@"Json %@",parsedData);
    if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
        [self performSegueWithIdentifier:[StoryboardsAndSegues segue_SetPassword] sender:nil];
    }
    else
    {
        [self showAlertWithMessage:parsedData[@"Error"]];
    }
}


-(void)errorRecieved:(NSString *)errorString withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];

    [self showAlertWithMessage:errorString];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    SetPasswordViewController * setPasswordViewController = segue.destinationViewController;
    setPasswordViewController.emailId = _emailId;
}


@end
