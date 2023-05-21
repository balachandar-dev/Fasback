//
//  GetLocationViewController.m
//  fasBackTechnician
//
//  Created by User on 12/09/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "GetLocationViewController.h"
#import "AppDelegate.h"
#import "ConstantColors.h"
#import "UIFont+PoppinsFont.h"

@interface GetLocationViewController ()
{
    AppDelegate * appDelegate;
}
@end

@implementation GetLocationViewController

static NSInteger const WEBSERVICE_TO_GET_ROUTES_TAG = 1101;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
   
    [self restoreToDefaults];
    [self UIChanges];
   
    

    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self addMap];

}
-(void)viewDidLayoutSubviews
{
}

#pragma mark - General

-(void) UIChanges
{
    _callCustomerButton.layer.cornerRadius = 4;
    _cancelButton.layer.cornerRadius = 4;
    _cancelButton.layer.borderColor = [[ConstantColors coolGray] CGColor];
    _cancelButton.layer.borderWidth = 1.0;
    if (height == 480) {
        _addressLineLabel.font = [UIFont poppinsNormalFontWithSize:14];
        _etaLabel.font = [UIFont poppinsSemiBoldFontWithSize:12];
        _cancelButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:12];
        _callCustomerButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:12];

    }
    else if (height == 568)
    {
        _addressLineLabel.font = [UIFont poppinsNormalFontWithSize:14];
        _etaLabel.font = [UIFont poppinsSemiBoldFontWithSize:12];
        _cancelButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:12];
        _callCustomerButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:12];
    }
    else if (height == 667)
    {
        
    }
    else
    {
        _addressLineLabel.font = [UIFont poppinsNormalFontWithSize:16];
        _etaLabel.font = [UIFont poppinsSemiBoldFontWithSize:14];
        _cancelButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:14];
        _callCustomerButton.titleLabel.font = [UIFont poppinsSemiBoldFontWithSize:14];
    }
}

-(void) restoreToDefaults
{
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;

    startLocation = [[StepsInGoogleMap alloc]init];

    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    
    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;
    
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    arrayWithSteps = [[NSMutableArray alloc]init];
    
    _addressLineLabel.text = _addressOfCustomer;
}
-(void) addMap
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[_endLocation.latitudeString floatValue]
                                                            longitude:[_endLocation.longitudeString floatValue]
                                                                 zoom:6];
    mapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, _backgroundViewForMapView.frame.size.width, _backgroundViewForMapView.frame.size.height) camera:camera];
    mapView.myLocationEnabled = YES;
    [self.backgroundViewForMapView addSubview: mapView];
    
    mapView.settings.compassButton = YES;
    
    mapView.settings.myLocationButton = YES;

    [self callGoogleDirectionAPi];

   

}

-(void) drawLine
{
//    GMSMutablePath * path = [[GMSMutablePath alloc]init];
//    StepsInGoogleMap * eachStep;
//    for (int i =0; i<arrayWithSteps.count; i++) {
//    eachStep = [[StepsInGoogleMap alloc]init];
//        eachStep = arrayWithSteps[i];
//    [path addLatitude:[eachStep.latitudeString floatValue] longitude:[eachStep.longitudeString floatValue]];
//
//    }
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[eachStep.latitudeString floatValue]
//                                                            longitude:[eachStep.longitudeString floatValue]
//                                                                 zoom:12];

//    [mapView animateToCameraPosition:camera];
//    GMSPolyline *poly = [GMSPolyline polylineWithPath:path];
//    poly.strokeColor = [UIColor redColor];
//    poly.tappable = TRUE;
//    poly.map = mapView;
    
    
}
-(void)showAlertWithMessage : (NSString *) message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void) callTimerToCallGoogleDirectionApi
{
    NSTimer* callTimer;
    if (!callTimer) {
    callTimer = [NSTimer scheduledTimerWithTimeInterval: 5.0 target: self selector: @selector(callGoogleDirectionAPi) userInfo: nil repeats: YES];
    }
}


#pragma mark - UIButton Actions 

- (IBAction)cancelButtonclicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)callCustomerButtonClicked:(id)sender {
    if (_contactNumber != nil) {
        
        NSCharacterSet *illegalCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
        _contactNumber = [[_contactNumber componentsSeparatedByCharactersInSet:illegalCharSet] componentsJoinedByString:@""];
        
        NSURL *phoneNumber = [[NSURL alloc] initWithString: _contactNumber];
        if (phoneNumber != nil) {
            NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phoneNumber]];
            
            if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
                [[UIApplication sharedApplication] openURL:phoneUrl];
            } else
            {
                [self showAlertWithMessage:@"Call facility is not available!!!"];
            }
        }
    }
    else
    {
        [self showAlertWithMessage:@"Phone number not available"];
    }

}

#pragma mark - Webservice

-(void) callGoogleDirectionAPi
{
    [appDelegate initActivityIndicatorForviewController:self];
    
      
// NSString * stringWithUrl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=38.082177,-96.290297&destination=%@,%@&mode=driving&key=AIzaSyAzaEVVtSdISQrSTv4FRTKSGFsNFHzZRGM",_endLocation.latitudeString,_endLocation.longitudeString];
    NSString * stringWithUrl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=%@,%@&destination=%@,%@&mode=walking&key=AIzaSyAzaEVVtSdISQrSTv4FRTKSGFsNFHzZRGM",startLocation.latitudeString,startLocation.longitudeString,_endLocation.latitudeString,_endLocation.longitudeString];

//    NSString * stringWithUrl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=20.196897,77.087894&destination=13.133269,80.236193&mode=walking&key=AIzaSyAzaEVVtSdISQrSTv4FRTKSGFsNFHzZRGM"];

    [webservice requestMethod:stringWithUrl withMsgType:WEBSERVICE_TO_GET_ROUTES_TAG];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Webservice delagate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    NSLog(@"%@",parsedData);
    [appDelegate stopActivityIndicatorForViewController:self];
    if ([parsedData objectForKey:@"routes"] != [NSNull null]) {
        if([[parsedData objectForKey:@"routes"] count] != 0)
        {
            NSArray * routesArray = [parsedData objectForKey:@"routes"];
            if ([routesArray objectAtIndex:0] != [NSNull null]) {
                NSDictionary * routeDictionary = [routesArray objectAtIndex:0];
                
                NSString *encodedPath       = [routeDictionary[@"overview_polyline"] objectForKey:@"points"];
                
                GMSMutablePath *path = [GMSMutablePath path];
                path = [GMSPath pathFromEncodedPath:encodedPath].mutableCopy;
                
                GMSPolyline *polyPath = [GMSPolyline polylineWithPath:path];
                polyPath.strokeColor        = [UIColor blueColor];
                polyPath.strokeWidth        = 3.5f;
                polyPath.map = mapView;

//                GMSPolyline *polyPath       = [GMSPolyline polylineWithPath:[GMSPath pathFromEncodedPath:encodedPath]];
//                polyPath.strokeColor        = [UIColor blueColor];
//                polyPath.strokeWidth        = 3.5f;
//                polyPath.map                = mapView;
                
                if ([[routeDictionary objectForKey:@"legs"] objectAtIndex:0]!= [NSNull null]) {
                    
                    NSDictionary * legDictionary = [[routeDictionary objectForKey:@"legs"] objectAtIndex:0];
                    if ([legDictionary objectForKey:@"duration"] != [NSNull null]) {
                        durationString = [[legDictionary objectForKey:@"duration"] objectForKey:@"text"];
                        int secondsToReach = [[[legDictionary objectForKey:@"duration"] objectForKey:@"value"] intValue];
                        NSDate *tenMinsLater = [[NSDate date] dateByAddingTimeInterval:secondsToReach];

                        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                        [dateFormat setDateFormat:@"hh:mm a"];
                        NSString * etaTime =[dateFormat stringFromDate:tenMinsLater];
                        
                        NSLog(@"etaTime%@",etaTime);

                        _etaLabel.text = [NSString stringWithFormat:@" ETA Time : %@ ",etaTime];

                    }
                    if ([legDictionary objectForKey:@"end_location"] != [NSNull null]) {
                        NSDictionary * stepsDictionary = [legDictionary objectForKey:@"end_location"];

                        _endLocation = [[StepsInGoogleMap alloc]init];
                        _endLocation.latitudeString = [stepsDictionary objectForKey:@"lat"];
                        _endLocation.longitudeString = [stepsDictionary objectForKey:@"lng"];

                        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[_endLocation.latitudeString floatValue]
                                                                                longitude:[_endLocation.longitudeString floatValue]
                                                                                     zoom:12];
                        
                        [mapView animateToCameraPosition:camera];

                        GMSMarker *marker = [[GMSMarker alloc] init];
                        marker.position = CLLocationCoordinate2DMake([_endLocation.latitudeString floatValue], [_endLocation.longitudeString floatValue]);
                        marker.title = @"";
                        marker.snippet = @"";
                        marker.map = mapView;
                        
//                        NSArray * stepsArray = [legDictionary objectForKey:@"steps"];
//                    if (stepsArray.count != 0) {
//                        for (int i = 0; i<stepsArray.count; i++) {
//                            NSDictionary * stepsDictionary = [stepsArray objectAtIndex:i];
//                            StepsInGoogleMap * eachStep = [[StepsInGoogleMap alloc]init];
//                            
//                            eachStep.latitudeString = [[stepsDictionary objectForKey:@"start_location"] objectForKey:@"lat"];
//                            eachStep.longitudeString = [[stepsDictionary objectForKey:@"start_location"] objectForKey:@"lng"];
//
//                            [arrayWithSteps addObject:eachStep];
//                            
//                            if (i == stepsArray.count - 1) {
//                                eachStep.latitudeString = [[stepsDictionary objectForKey:@"end_location"] objectForKey:@"lat"];
//                                eachStep.longitudeString = [[stepsDictionary objectForKey:@"end_location"] objectForKey:@"lng"];
//                                
//                                [arrayWithSteps addObject:eachStep];
//                            }
//                        }
//                        NSLog(@"arrayWithSteps %@",arrayWithSteps);
//                        [self drawLine];
//                    }
                    }
                }
            }
            
            //            for(int i = 0  ; i<routesArray.count ; i++)
            //            {
            //                
            //            }
        }
    }
    
}


-(void)errorRecieved:(NSString *)errorString withMsgType:(int)msgType
{
    [appDelegate stopActivityIndicatorForViewController:self];
    [self showAlertWithMessage:errorString];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    [self showAlertWithMessage:@"Failed to Get Your Location"];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        startLocation.longitudeString = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        startLocation.latitudeString = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        
        GMSMarker * markerForCurrentLocation;
        if (!markerForCurrentLocation) {
        markerForCurrentLocation = [[GMSMarker alloc] init];
        }
        markerForCurrentLocation.position = CLLocationCoordinate2DMake([startLocation.latitudeString floatValue]
                                                     , [startLocation.longitudeString floatValue]);
        markerForCurrentLocation.title = @"";
        markerForCurrentLocation.snippet = @"";
        markerForCurrentLocation.map = mapView;
        
        [self callTimerToCallGoogleDirectionApi];
    }
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
