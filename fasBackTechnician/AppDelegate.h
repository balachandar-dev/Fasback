//
//  AppDelegate.h
//  fasBackTechnician
//
//  Created by User on 21/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <SignalR.h>
#import <CoreLocation/CoreLocation.h>
#import "StepsInGoogleMap.h"
#import "Webservice.h"
#import "LocationTracker.h"
#import <UserNotifications/UserNotifications.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate,SRConnectionDelegate,CLLocationManagerDelegate,webProtocol>
{
    UIImageView* animatedImageView;
    Webservice * webservice;
    BOOL shouldCallAPI;
    NSString * deviceTokenReceived;
}

@property LocationTracker * locationTracker;
@property (nonatomic) NSTimer* locationUpdateTimer;



@property (strong, nonatomic) UIWindow *window;
@property CLLocationManager * locationManager;

@property NSTimer * timerToUpdateTechnicainLocation;

@property StepsInGoogleMap * eachStep;

@property SRHubProxy * hub;
@property SRHubConnection * hubConnection;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

-(void)initActivityIndicatorForviewController:(UIViewController *)viewController;
-(void)stopActivityIndicatorForViewController : (UIViewController *) viewController;

-(void) startSignalRWithEmailId;

@end

