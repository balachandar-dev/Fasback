//
//  ViewSensorFactViewController.m
//  fasBackTechnician
//
//  Created by User on 02/09/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "ViewSensorFactViewController.h"
#import "AppDelegate.h"
#import "ConstantColors.h"
#import "StoryboardsAndSegues.h"
#import "HoldAndDiscardWorkOrderViewController.h"
#import "UIFont+PoppinsFont.h"

@interface ViewSensorFactViewController ()
{
    AppDelegate * appDelegate;
}
@end

@implementation ViewSensorFactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self chnagesInUI];
    [self restoreToDefaults];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - General


-(void) chnagesInUI
{
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;

    _checkoutButton.layer.cornerRadius = 4;
    _holdButton.layer.cornerRadius = 4;
    _holdButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _holdButton.layer.borderWidth = 1.0;
    
    if (height == 480) {
        //
    }
    else if (height == 568)
    {
        _holdButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:12];
        _checkoutButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:12];
        
    }
    else if (height == 667)
    {
        
    }
    else
    {
        
    }

}
-(void) restoreToDefaults
{
    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
    
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    arrayWithSnsorfactData = [[NSMutableArray alloc]init];
    
    [self webserviceForSensofactData];
    
    refreshControl = [[UIRefreshControl alloc] init];
    [self.sensorFactTableView addSubview:refreshControl];
    refreshControl.backgroundColor = [ConstantColors enabledButtonBackGroundColor];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self
                       action:@selector(reloadData)
             forControlEvents:UIControlEventValueChanged];
    
    if ([_workOrderInfo.action isEqualToString:@"Checked In"] || [_workOrderInfo.action isEqualToString:@"5"]) {
        _holdButton.hidden = NO;
        _checkoutButton.hidden = NO;
    }
    else
    {
        _holdButton.hidden = YES;
        _checkoutButton.hidden = YES;
        _bottomConstrainOfCollectionView.constant=0;
    }
}

-(void) showAlertWithMessage : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Web service

-(void) webserviceForSensofactData
{
    [appDelegate initActivityIndicatorForviewController:self];
    
    //    http://fasbackdevapi.azurewebsites.net/api/App/Technician/GetWorkOrderDetail/
    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/GetWorkOrderDetail/%@",[Webservice webserviceLink],_workOrderInfo.workOrderId];
    
//        NSString * stringWithUrl = [NSString stringWithFormat:@"https://api.sensorfact.com/datasubscription/v1/595e4348b04e9000057665fe"];
    [webservice requestMethod:stringWithUrl withMsgType:11];
    
}

#pragma mark - UIButton Actions

- (IBAction)backButtonlicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)holdButtonlicked:(id)sender {
    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_HoldAndDiscard] sender:nil];
    
}
- (IBAction)checkOutButtonClicked:(id)sender {
    [self performSegueWithIdentifier:[StoryboardsAndSegues segue_Checkout] sender:nil];
}

- (void)reloadData {
    [self webserviceForSensofactData];
    
    if (refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        refreshControl.attributedTitle = attributedTitle;
        
        [refreshControl endRefreshing];
    }
}

#pragma mark - UICollectionView Datasource & Delegates

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrayWithSnsorfactData count];
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"sensorfactCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UILabel * valueOfSensorFactLabel = (UILabel *)[collectionView viewWithTag:51];
    SensorFactData * eachData = [arrayWithSnsorfactData objectAtIndex:indexPath.row];
    
    NSString * currentTrend = [NSString stringWithFormat:@"%@", [eachData.currentTrendArray valueForKey: @"@lastObject"] ];
    NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
    [nf setMaximumFractionDigits:[eachData.precision intValue]];
    
    NSString * trimmedCurrentTrend = [nf stringFromNumber:[NSNumber numberWithFloat:[currentTrend floatValue]]];
    NSString * valueForSensorFactData = [NSString stringWithFormat:@"%@ %@",trimmedCurrentTrend, eachData.unitOfData];
    valueOfSensorFactLabel.text = valueForSensorFactData;

    UILabel * descriptionOfSensorFactLabel = (UILabel *)[collectionView viewWithTag:52];
     descriptionOfSensorFactLabel.text = eachData.discription;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UIColectionView FlowLayout Delegates

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((collectionView.frame.size.width/2)-0.5, (collectionView.frame.size.width/2)-0.5);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}


#pragma mark - UITableView Datasoure

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayWithSnsorfactData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewSensorfactTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[ViewSensorfactTableViewCell reuseIdentifier] forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ViewSensorfactTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ViewSensorfactTableViewCell reuseIdentifier]];
    }
    
    SensorFactData * eachData = [arrayWithSnsorfactData objectAtIndex:indexPath.row];
    
    NSString * currentTrend = [NSString stringWithFormat:@"%@", [eachData.currentTrendArray valueForKey: @"@lastObject"] ];
    //    if ([eachData.precision isEqualToString:@"0"]) {
    //        NSString * valueForSensorFactData = [NSString stringWithFormat:@"%d %@",[currentTrend intValue], eachData.unitOfData];
    //        cell.valueFromSensorLabel.text = valueForSensorFactData;
    //    }
    //    else
    //    {
    NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
    [nf setMaximumFractionDigits:[eachData.precision intValue]];
    
    NSString * trimmedCurrentTrend = [nf stringFromNumber:[NSNumber numberWithFloat:[currentTrend floatValue]]];
    NSString * valueForSensorFactData = [NSString stringWithFormat:@"%@ %@",trimmedCurrentTrend, eachData.unitOfData];
    cell.valueFromSensorLabel.text = valueForSensorFactData;
    //    }
    cell.descriptionLabel.text = eachData.discription;
    //    cell.numberOfWorksCompleted.text = arrayWithNumberOfWorkCompleted[indexPath.row];
    //    cell.statusOfWork.text = arrayWithStatus[indexPath.row];
    //    cell.iconImageView.image = [UIImage imageNamed:arrayWithIcons[indexPath.row]];
    //    cell.graphImageView.image = [UIImage imageNamed:arrayWithJobStatusImages[indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [refreshControl endRefreshing];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78.0f;
}

#pragma mark - UITableView Delegates

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Webservice delagate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];
    
    NSLog(@"%@",parsedData);
    if ([parsedData objectForKey:@"ReturnObject"] != [NSNull null]) {
        
        NSDictionary * resultData = [parsedData objectForKey:@"ReturnObject"];
        if (resultData[@"SensorFactData"] != [NSNull null]) {
            NSString * stringWithSensorFactData = [resultData objectForKey:@"SensorFactData"];
            NSData* data = [stringWithSensorFactData dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dictionaryWithSensorFactPoints = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([dictionaryWithSensorFactPoints objectForKey:@"result"] != [NSNull null]) {
                NSDictionary * dictionaryWithResults = [dictionaryWithSensorFactPoints objectForKey:@"result"];
                if (dictionaryWithResults[@"points"] != [NSNull null]) {
                    
                    NSArray * arrayWithPoints = [dictionaryWithResults objectForKey:@"points"];
                    if (arrayWithPoints.count != 0) {
                        for (int i = 0; i< arrayWithPoints.count; i++) {
                            
                            NSDictionary * eachSensorFactDataDictionary = [arrayWithPoints objectAtIndex:i];
                            SensorFactData * eachData = [[SensorFactData alloc]init];
                            eachData.discription = [eachSensorFactDataDictionary objectForKey:@"dis"];
                            eachData.unitOfData = [eachSensorFactDataDictionary objectForKey:@"unit"];
                            eachData.updatedDate = [eachSensorFactDataDictionary objectForKey:@"updated"];
                            eachData.currentTrendArray = [eachSensorFactDataDictionary objectForKey:@"curTrend"];
                            eachData.precision = [eachSensorFactDataDictionary objectForKey:@"precision"];
                            
                            [arrayWithSnsorfactData addObject:eachData];
                        }
                        [_sensorFactTableView reloadData];
                        [_sensorFsctCollectionView reloadData];
                    }
                    else
                    {
                    [self showAlertWithMessage:@"No data available"];
                    }

                }
                else
                {
                    [self showAlertWithMessage:@"No data available"];

                }
            }
            else
            {
                [self showAlertWithMessage:@"No data available"];
            }
        }
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
     HoldAndDiscardWorkOrderViewController * holdAndDiscardViewController = segue.destinationViewController;
     holdAndDiscardViewController.workOderId = _workOrderInfo.workOrderId;
     holdAndDiscardViewController.workOrderNo = _workOrderInfo.workOrderNumber;
     holdAndDiscardViewController.isHold = YES;
 }


@end
