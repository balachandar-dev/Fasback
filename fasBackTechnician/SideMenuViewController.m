//
//  SideMenuViewController.m
//  FasBackTechnician
//
//  Created by User on 18/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "SideMenuViewController.h"
#import "DashboardViewController.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "ConstantColors.h"
#import <MFSideMenu.h>
#import "StoryboardsAndSegues.h"
#import "UIFont+PoppinsFont.h"

@interface SideMenuViewController ()

@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self restoreToDefaults];
    // Do any additional setup after loading the view.
}

#pragma mark - General

-(void) restoreToDefaults
{
    arrayWithTexts = [[NSMutableArray alloc]initWithObjects:@"My Profile",@"My Jobs",@"Reports",@"Settings",@"About Us",@"Logout", nil];
    arrayWithImages = [[NSMutableArray alloc]initWithObjects:@"Slide_menu_profile",@"suitcase",@"Reports",@"Settings",@"About_Us",@"Log_Off", nil];
    [self changesInUI];
    [self availabilityStatusButtonclicked:nil];
    //    self.profileTableView.estimatedRowHeight = 100;
    //    self.profileTableView.rowHeight = UITableViewAutomaticDimension;
    //    [_profileTableView reloadData];
    [self getDatafromCoreData];

}

-(void) viewWillAppear:(BOOL)animated
{
    [self getDatafromCoreData];
   _versionNumberLabel.text = [ NSString stringWithFormat:@"Version %@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ];
}

-(void)viewDidLayoutSubviews
{
    
}
-(void) getDatafromCoreData
{
//    NSManagedObjectContext *context = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).persistentContainer.viewContext;
//
//    NSFetchRequest<User *> *fetchRequest = [User fetchRequest];
//       NSError *error ;
//    NSArray *resultArray= [context executeFetchRequest:fetchRequest error:&error];
//    int count = [resultArray count];
    
//    User * user =resultArray[count - 1];
//    _userNameLabel.text = user.userName;
//    
//    int rating = [user.rating intValue];
//    _starRatingView.rating= rating;
//
//    NSLog(@"result %@",resultArray);
//    NSLog(@"result %@",resultArray[0]);
    
    _userNameLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:userName];
    int rating = [[[NSUserDefaults standardUserDefaults]objectForKey:userRating] intValue];
    _starRatingView.rating= rating;
    if ([[NSUserDefaults standardUserDefaults]objectForKey:userImage] != [NSNull null]) {
        NSString *imagePath = [[NSUserDefaults standardUserDefaults] objectForKey:userImage];
        if (imagePath) {
            _logoImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath]];
        }
    }
    
    
    int status = [[NSUserDefaults standardUserDefaults]integerForKey:isUserAvailable];
    
    
    NSLog(@"status %d",status);
    if (status == 1) {

    [_availableButton setBackgroundColor:[ConstantColors availableStatusColor]];
    [_availableButton setTitle:@"AVAILABLE" forState:UIControlStateNormal];
    [_availableButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _availableButton.userInteractionEnabled = YES;

    }
    else if (status == 2)
    {
        [_availableButton setBackgroundColor:[ConstantColors disabledButtonBackgroundColor]];
        [_availableButton setTitle:@"NOT AVAILABLE" forState:UIControlStateNormal];
        [_availableButton setTitleColor:[ConstantColors disabledButtonTextColor] forState:UIControlStateNormal];
        _availableButton.userInteractionEnabled = YES;

    }
    else
    {
        [_availableButton setBackgroundColor:[ConstantColors disabledButtonBackgroundColor]];
        [_availableButton setTitle:@"BUSY" forState:UIControlStateNormal];
        [_availableButton setTitleColor:[ConstantColors disabledButtonTextColor] forState:UIControlStateNormal];
        _availableButton.userInteractionEnabled = NO;
    }
    _availableButton.layer.shadowColor = _availableButton.backgroundColor.CGColor;

    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
}

-(void) viewDidAppear:(BOOL)animated
{
    
}
-(void) changesInUI
{
//    _backgroundOfTableView.layer.cornerRadius = 6;
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    if (height == 568) {
        _fasBackHeaderImageView.frame = CGRectMake(_fasBackHeaderImageView.frame.origin.x * 0.9, _fasBackHeaderImageView.frame.origin.y * 0.8, _fasBackHeaderImageView.frame.size.width * 0.9, _fasBackHeaderImageView.frame.size.height * 0.9);
        _logoImageView.frame = CGRectMake(_logoImageView.frame.origin.x * 0.9, _fasBackHeaderImageView.frame.origin.y + _fasBackHeaderImageView.frame.size.height + 22, _logoImageView.frame.size.width * 0.9 , _logoImageView.frame.size.height * 0.9);
        _userNameLabel.frame = CGRectMake(_userNameLabel.frame.origin.x * 0.9, _logoImageView.frame.origin.y + _logoImageView.frame.size.height + 17, _userNameLabel.frame.size.width * 0.9, _userNameLabel.frame.size.height * 0.9);
        _starRatingView.frame = CGRectMake(_starRatingView.frame.origin.x * 0.9,_userNameLabel.frame.origin.y + _userNameLabel.frame.size.height + 10 , _starRatingView.frame.size.width * 0.9, _starRatingView.frame.size.height * 0.9);
        _availableButton.frame = CGRectMake(_availableButton.frame.origin.x * 0.9, _starRatingView.frame.origin.y + _starRatingView.frame.size.height + 15, _availableButton.frame.size.width , _availableButton.frame.size.height * 0.9);

        _sideMenuTableView.frame = CGRectMake(_sideMenuTableView.frame.origin.x, _availableButton.frame.origin.y + _availableButton.frame.size.height + 20, _sideMenuTableView.frame.size.width * 0.9, _sideMenuTableView.frame.size.height * 0.9);

        _versionNumberLabel.frame = CGRectMake(_versionNumberLabel.frame.origin.x * 0.9, height - 40, _versionNumberLabel.frame.size.width *0.9, _versionNumberLabel.frame.size.height * 0.9);

        _userNameLabel.font = [UIFont poppinsSemiBoldFontWithSize:16];
        [_availableButton.titleLabel setFont:[UIFont poppinsSemiBoldFontWithSize:9]];
        _versionNumberLabel.font = [UIFont poppinsMediumFontWithSize:12];
    }
    else if (height == 667)
    {
       
    }
    _availableButton.layer.cornerRadius = 3;
    _availableButton.layer.shadowColor = _availableButton.backgroundColor.CGColor;
    _availableButton.layer.shadowOpacity = 0.6;
    _availableButton.layer.shadowRadius = 5;
    _availableButton.layer.shadowOffset = CGSizeMake(2.0f, 5.0f);
    
    _logoImageView.layer.cornerRadius = _logoImageView.frame.size.width/2;
    _logoImageView.layer.masksToBounds = YES;
//    _logoImageView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
//    _logoImageView.layer.borderWidth = 1;
    
    _logoImageView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _logoImageView.layer.shadowOpacity = 0.4;
    _logoImageView.layer.shadowRadius = 3;
    _logoImageView.layer.shadowOffset = CGSizeMake(2.0f, 5.0f);
    
    _starRatingView.starImage = [UIImage imageNamed:@"Empty_Star"];
    _starRatingView.starHighlightedImage = [UIImage imageNamed:@"Full_Star"];
    _starRatingView.maxRating = 5.0;
    //    _starRatingView.delegate = self;
    _starRatingView.horizontalMargin = 0;
    _starRatingView.editable=YES;
    _starRatingView.rating= 3.5;
    _starRatingView.displayMode=EDStarRatingDisplayAccurate;
    


}

#pragma mark - UIButton Actions

- (IBAction)availabilityStatusButtonclicked:(id)sender {
    
    NSMutableDictionary * postDataDictionary = [[NSMutableDictionary alloc]init];

    int status = [[NSUserDefaults standardUserDefaults]integerForKey:isUserAvailable];

    if (status == 2) {
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:IsUserAvailble];
        [_availableButton setBackgroundColor:[ConstantColors availableStatusColor]];
        [_availableButton setTitle:@"AVAILABLE" forState:UIControlStateNormal];
        [_availableButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [postDataDictionary setValue:@"1" forKey:@"Status"];

    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:IsUserAvailble];
        [_availableButton setBackgroundColor:[ConstantColors disabledButtonBackgroundColor]];
        [_availableButton setTitle:@"NOT AVAILABLE" forState:UIControlStateNormal];
        [_availableButton setTitleColor:[ConstantColors disabledButtonTextColor] forState:UIControlStateNormal];
        [postDataDictionary setValue:@"2" forKey:@"Status"];


    }
    
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/UpdateStatus",[Webservice webserviceLink]];

}

#pragma mark - UITableView Datasoure

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayWithTexts count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    UILabel * titleLabel = (UILabel *)[tableView viewWithTag:51];
    titleLabel.text = arrayWithTexts[indexPath.row];
    
    UIImageView * imageVieInTable = (UIImageView *)[tableView viewWithTag:52];
    imageVieInTable.image =[UIImage imageNamed:arrayWithImages[indexPath.row]];
    
    if (height == 568) {
        titleLabel.font = [UIFont poppinsMediumFontWithSize:12];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (height == 568) {
        return 40;
    }
    return 45.0f;
}



#pragma mark - UITableView Delegates

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard * profileStroyboard = [UIStoryboard storyboardWithName:@"Profile" bundle:[NSBundle mainBundle]];
    
    if (indexPath.row == 1) {
        
        UIViewController * dahboardViewController = [profileStroyboard instantiateViewControllerWithIdentifier:[StoryboardsAndSegues storyboardId_Dashboard]];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:dahboardViewController];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];

    }
    else if (indexPath.row == 0)
    {
        UIViewController * userProfileViewController = [profileStroyboard instantiateViewControllerWithIdentifier:[StoryboardsAndSegues storyboardId_UserProfile]];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:userProfileViewController];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];

    }
    else if (indexPath.row == 5)
    {
        [self moveToLanding];
    }
//    switch (indexPath.row) {
//        case 0:
//            
//            break;
//            
//        case 1:
//            
//            UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
//            NSArray *controllers = [NSArray arrayWithObject:profileViewController];
//            navigationController.viewControllers = controllers;
//            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
//
////            UINavigationController * dashboardViewControler = [profileStroyboard ];
//            break;
//        
//        case 2:
//            
//            break;
//        
//        case 3 :
//            
//            break;
//        
//        case 4 :
//            
//            break;
//            
//        case 5 :
//            // Logout
//            [self moveToLanding];
//
//            break;
//            
//        default:
//            
//            break;
//            
//    }
}


-(void) moveToLanding
{
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:IsSignedIn];
    [[NSUserDefaults standardUserDefaults] setObject:@" " forKey:accessToken];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:userName];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:userImage];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:userRating];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:IsUserAvailble];

    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.hubConnection stop];
    UIStoryboard * mainStroyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController * mainViewController = [mainStroyBoard instantiateInitialViewController];
    appDelegate.window.rootViewController = mainViewController;

}

#pragma mark - Webservice delagate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
//    [appDelegate stopActivityIndicatorForViewController:self];
    NSLog(@"%@",parsedData);
    if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
            NSDictionary * dictionaryForReturnObject = [parsedData objectForKey:@"ReturnObject"];
            if (dictionaryForReturnObject[@"Status"] != [NSNull null]) {
                //                        [entityNameObj setValue:[NSString stringWithFormat:@"%@", technicalSummaryDictionary[@"Rating"] ]  forKey:@"Rating"];
                NSLog(@"Status %@",[NSString stringWithFormat:@"%@", dictionaryForReturnObject[@"Status"]]);
                int status = [dictionaryForReturnObject[@"Status"]intValue];
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:isUserAvailable];
                [[NSUserDefaults standardUserDefaults]setInteger:status forKey:isUserAvailable];
                
            }
//
        
    }
//        else
//        {
//            [self showAlertWithMessage:[parsedData objectForKey:@"ErrorDescription"]];
//        }
//    }
//    else
//    {
//        [self showAlertWithMessage:[parsedData objectForKey:@"ErrorDescription"]];
//
//    }
}


-(void)errorRecieved:(NSString *)errorString withMsgType:(int)msgType
{
    NSLog(@"%@",errorString);
    
//    [appDelegate stopActivityIndicatorForViewController:self];
//    if ([errorString isEqualToString:@"Request failed: bad request (400)"]) {
//        [self showAlertWithMessage:@"Some error has occured, please try again"];
//    }
//    else
//    {
//        [self showAlertWithMessage:errorString];
//    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
