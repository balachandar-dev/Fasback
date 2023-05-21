//
//  GetLocationViewController.h
//  fasBackTechnician
//
//  Created by User on 12/09/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Webservice.h"
#import <GoogleMaps/GoogleMaps.h>
#import "StepsInGoogleMap.h"
#import <CoreLocation/CoreLocation.h>
#import "PaddingLabel.h"

@interface GetLocationViewController : UIViewController<webProtocol,CLLocationManagerDelegate>
{
    Webservice *webservice;
    NSMutableArray * arrayWithSteps;
    GMSMapView *mapView;
    
    CLLocationManager * locationManager;

    StepsInGoogleMap * startLocation;
    
    NSString * durationString;
    
    float height, width;
}

@property StepsInGoogleMap * endLocation;
@property NSString * addressOfCustomer;
@property NSString * contactNumber;

@property (weak, nonatomic) IBOutlet PaddingLabel *etaLabel;

@property (weak, nonatomic) IBOutlet UIView *backgroundViewForMapView;
@property (weak, nonatomic) IBOutlet UILabel *addressLineLabel;
@property (weak, nonatomic) IBOutlet UIButton *callCustomerButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end
