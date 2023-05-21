//
//  AppDelegate.m
//  fasBackTechnician
//
//  Created by User on 21/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "AppDelegate.h"
#import <MFSideMenuContainerViewController.h>
#import "Constants.h"
#import "Webservice.h"
#import <AFNetworking.h>
#import <AFNetworkReachabilityManager.h>
@import GoogleMaps;

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@interface AppDelegate ()<UNUserNotificationCenterDelegate>
{
    UIActivityIndicatorView *spinner;
    AFNetworkReachabilityManager * reachabilityManager;
    NSTimer *timerForLocationUpdate, *timerToGetAPi;
}

@end

@implementation AppDelegate
@synthesize hub,hubConnection;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    shouldCallAPI = NO;
    [GMSServices provideAPIKey:@"AIzaSyAzaEVVtSdISQrSTv4FRTKSGFsNFHzZRGM"];
//    [GMSPlacesClient provideAPIKey:@"AIzaSyAzaEVVtSdISQrSTv4FRTKSGFsNFHzZRGM"];

    webservice = [[Webservice alloc]init];
    webservice.delegateObject = self;

    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:AFNetworkingReachabilityDidChangeNotification
                                               object:nil];

    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if( !error ){
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    }
    else {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
//    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
//    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
//    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
//
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(logoutNotification:)
                                                 name:@"Logout"
                                               object:nil];

    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    if ([[[NSUserDefaults standardUserDefaults] objectForKey:IsSignedIn] isEqualToString:@"YES"]) {
        [self startSignalRWithEmailId];
            UIStoryboard * mainStroyBoard = [UIStoryboard storyboardWithName:@"Profile" bundle:[NSBundle mainBundle]];
            MFSideMenuContainerViewController * controller = (MFSideMenuContainerViewController *)self.window.rootViewController;
    
            UINavigationController * mainViewController = [mainStroyBoard instantiateViewControllerWithIdentifier:@"DashboardNavigationController"];
    
            UIViewController * sideViewController = [mainStroyBoard instantiateViewControllerWithIdentifier:@"SideViewController"];
            [controller setCenterViewController:mainViewController];
            [controller setLeftMenuViewController:sideViewController];
    
        self.window.rootViewController = controller;
    }
    else
    {
        UIStoryboard * mainStroyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController * mainViewController = [mainStroyBoard instantiateInitialViewController];
        self.window.rootViewController = mainViewController;
    }
    
    
    
    self.locationTracker = nil;
    self.locationTracker = [[LocationTracker alloc]init];
    [self.locationTracker startLocationTracking];
    
    //Send the best location to server every 60 seconds
    //You may adjust the time interval depends on the need of your app.
    [self.locationUpdateTimer invalidate];
    self.locationUpdateTimer = nil;
    NSTimeInterval time = 10.0;
    self.locationUpdateTimer =
    [NSTimer scheduledTimerWithTimeInterval:time
                                     target:self
                                   selector:@selector(updateLocation)
                                   userInfo:nil
                                    repeats:YES];


    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillTerminate:)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    
//#if TARGET_IPHONE_SIMULATOR == 0
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *logPath = [documentsDirectory stringByAppendingPathComponent:@"console.log"];
//    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
//#endif
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
//    for (int i = 0; i<200; i++) {
//        sleep(1);
//    }
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
//    [hubConnection stop];
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:IsSignedIn] isEqualToString:@"YES"]) {
//    [hubConnection start];
//    }
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    NSLog(@"App terminated");
    [self saveContext];
}

#pragma mark - Location

-(void)updateLocation {
    NSLog(@"updateLocation");
    
    if ( self.locationTracker != nil )
    {
        
        [self.locationTracker updateLocationToServer];
    }
    else{
        
        [self.locationUpdateTimer  invalidate];
        self.locationUpdateTimer = nil;
        
        
        self.locationTracker = [[LocationTracker alloc]init];
        [self.locationTracker startLocationTracking];
        
        //Send the best location to server every 60 seconds
        //You may adjust the time interval depends on the need of your app.
        NSTimeInterval time = 10.0;
        self.locationUpdateTimer =
        [NSTimer scheduledTimerWithTimeInterval:time
                                         target:self
                                       selector:@selector(updateLocation)
                                       userInfo:nil
                                        repeats:YES];
        
    }
}


#pragma mark - Activity Indicator


-(void)initActivityIndicatorForviewController:(UIViewController *)viewController  {
    
//    if (animatedImageView != nil) {
//        [animatedImageView stopAnimating];
//        [animatedImageView removeFromSuperview];
//        //[self.spinnerBg removeFromSuperview];
//    }
//
////    [@"checkbox_selected",@"cross_red",@"Feedback_star_filled",@"Phone",@"Feedback_star_filled"]
//    
//    NSArray * activityIndicatorCustomImageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"checkbox_selected"],[UIImage imageNamed:@"cross_red"],[UIImage imageNamed:@"Feedback_star_filled"],[UIImage imageNamed:@"Phone"], nil];
//    animatedImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.window.bounds.size.width - 25)/2, (self.window.bounds.size.height - 25)/2,25 ,25 )];
//    animatedImageView.animationImages = activityIndicatorCustomImageArray;
//    animatedImageView.animationDuration = 1.0f;
//    animatedImageView.animationRepeatCount = 0;
//    [animatedImageView startAnimating];
//    
//    
//    [viewController.view addSubview:animatedImageView];

    if (spinner != nil) {
        [spinner stopAnimating];
        [spinner removeFromSuperview];
        //[self.spinnerBg removeFromSuperview];
    }

     spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height /2);
    spinner.hidesWhenStopped = YES;
    [viewController.view addSubview:spinner];
    [spinner startAnimating];
    
    for (UIView * eachSubview in viewController.view.subviews) {
        eachSubview.userInteractionEnabled = NO;
    }
    [self performSelector:@selector(startActivityIndicator) withObject:nil afterDelay:0.5];
}

-(void)startActivityIndicator {
    if (spinner != nil)
    {
        [spinner startAnimating];
    }
}

 
-(void)stopActivityIndicatorForViewController : (UIViewController *) viewController
{
    if (spinner != nil) {
        [spinner stopAnimating];
        [spinner removeFromSuperview];
        //[self.spinnerBg removeFromSuperview];
    }
    for (UIView * eachSubview in viewController.view.subviews) {
        eachSubview.userInteractionEnabled = YES;
    }
}


#pragma mark - Remote Notification Delegate // <= iOS 9.x

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *strDevicetoken = [[NSString alloc]initWithFormat:@"%@",[[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    NSLog(@"Device Token = %@",strDevicetoken);
    [[NSUserDefaults standardUserDefaults] setObject:strDevicetoken forKey:@"devicetoken" ];
//    [GlobalObject sharedInstance].deviceToken = strDevicetoken;
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"Push Notification Information : %@",userInfo);
    
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"%@ = %@", NSStringFromSelector(_cmd), error);
    NSLog(@"Error = %@",error);
}

#pragma mark - UNUserNotificationCenter Delegate // >= iOS 10

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
    NSLog(@"User Info = %@",notification.request.content.userInfo);
    
    if ( [[UIApplication sharedApplication] applicationState] != UIApplicationStateActive )
    {
        completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound);
    }
    
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSLog(@"User Info = %@",response.notification.request.content.userInfo);
    
}

#pragma mark - Signal R

-(void) startSignalRWithEmailId
{
    NSDictionary *queryStr1 = [ NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:EMAILID], @"username",[[NSUserDefaults standardUserDefaults]objectForKey:@"devicetoken"], @"devicetoken" ,nil];
    NSLog(@"%@",queryStr1);
    
    hubConnection = [SRHubConnection connectionWithURLString:[NSString stringWithFormat:@"%@//signalr/hubs",[Webservice webserviceLink] ] queryString:queryStr1];
    [hubConnection setDelegate:self];
    hub = [hubConnection createHubProxy:@"fasBackHub"];
    
    
//    [hub on:@"RefreshDashboardScreen" perform:self selector:@selector(signalR_Response:)];
//    [hub on:@"NotificationCount" perform:self selector:@selector(onNotificationCount:)];

    [hubConnection setStarted:^{
        NSLog(@"Connection Started");
    }];
    [hubConnection setReceived:^(NSString *message) {
        NSLog(@"Connection Recieved Data: %@",message);
        
       

        
//        [self onNotificationCount:@""];
        //        [callingclassObject signalR_Response:message];
    }];
    //    [hubConnection setConnectionSlow:^{
    //        NSLog(@"Connection Slow");
    //    }];
    [hubConnection setReconnecting:^{
        NSLog(@"Connection Reconnecting");
    }];
   
    [hubConnection setReconnected:^{
        NSLog(@"Connection Reconnected");
    }];
    [hubConnection setClosed:^{
        NSLog(@"Connection Closed");
        
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:IsSignedIn] isEqualToString:@"YES"]) {
        __weak AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appdelegate.hubConnection start];
                }

        
//        NSLog(@"%u",hubConnection.state);
    }];
    [hubConnection setError:^(NSError *error) {
        NSLog(@"Connection Error %@",error);
    }];
    [hubConnection start];
    
    _eachStep = [[StepsInGoogleMap alloc]init];
//    _eachStep.latitudeString = @"13.0827";
//    _eachStep.longitudeString = @"80.2707";

    _locationManager=[[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    if (([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]))
    {
        [_locationManager requestWhenInUseAuthorization];
    }
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
        [_locationManager requestAlwaysAuthorization];
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
        _locationManager.allowsBackgroundLocationUpdates = YES;
    }
    
    //[locationManager requestWhenInUseAuthorization];
    // [locationManager startMonitoringSignificantLocationChanges];
    [_locationManager startUpdatingLocation];
    [self callWebserviceToUpdateTechnicianLocation];
    timerForLocationUpdate = [NSTimer scheduledTimerWithTimeInterval:30.0f target:self selector:@selector(callWebserviceToUpdateTechnicianLocation) userInfo:nil repeats:YES];
    
    timerToGetAPi =[NSTimer scheduledTimerWithTimeInterval:5.0
                                                    target:self
                                                  selector:@selector(onNotificationCount:)
                                                  userInfo:nil
                                                   repeats:YES];
//    [NSTimer scheduledTimerWithTimeInterval:30.0f
//                                     target:self selector:@selector(callWebserviceToUpdateTechnicianLocation) userInfo:nil repeats:YES];
}

-(void)onNotificationCount:(NSString *)status{
    
//    NSLog(@"Status %@",status);
//    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/Admin/Notification/GetInstantNotificationCount",[Webservice webserviceLink]];
//    [webservice requestMethod:stringWithUrl withMsgType:13];

}

//-(void)getInstantNo:(NSString *)status{
//    
//    NSLog(@"Status %@",status);
//    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/Admin/Notification/GetInstantNotificationCount",[Webservice webserviceLink]];
//    [webservice requestMethod:stringWithUrl withMsgType:13];
//    
//}

- (void) logoutNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:IsSignedIn];
    [[NSUserDefaults standardUserDefaults] setObject:@" " forKey:accessToken];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:userName];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:userImage];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:userRating];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:IsUserAvailble];
    
    [timerForLocationUpdate invalidate];
    [timerToGetAPi invalidate];
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.hubConnection stop];
    UIStoryboard * mainStroyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController * mainViewController = [mainStroyBoard instantiateInitialViewController];
    appDelegate.window.rootViewController = mainViewController;
    
    NSLog(@"Logout");
}

#pragma mark - Webservice

-(void) callWebserviceToUpdateTechnicianLocation
{
//    {
//        "LocationLatitude": "24.5955",
//        "LocationLongitude": "73.7755"
//    }
//    NSLog(@"Status %@",status);

    NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/Admin/Notification/GetInstantNotificationCount",[Webservice webserviceLink]];
    [webservice requestMethod:stringWithUrl withMsgType:13];
    
    shouldCallAPI = YES;
}

#pragma mark - Webservice delagate

-(void)dataIsRecieved:(id)parsedData withMsgType:(int)msgType
{
    NSLog(@"%@",parsedData);
    
    if (msgType == 12) {
        if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
            if ([parsedData objectForKey:@"Role"] == [NSNumber numberWithLong:4]) {
                [[NSUserDefaults standardUserDefaults]setObject:[parsedData objectForKey:@"access_token"] forKey:accessToken];
                
            }
            else
            {
                //            [self showAlertWithMessage:@"Please enter valid credentials"];
            }
        }
        else
        {
            
        }
    }
    else
    {
        if ([[parsedData objectForKey:@"IsSuccess"] isEqual: [NSNumber numberWithBool:YES]]) {
            NSLog(@"parsedData %@",parsedData);
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            notification.fireDate = [NSDate date];
            if ([[[parsedData objectForKey:@"ReturnObject"] objectForKey:@"NotificationCount"] intValue] == 0) {

            }
            else if ([[[parsedData objectForKey:@"ReturnObject"] objectForKey:@"NotificationCount"] intValue] == 1) {
                notification.alertBody = [NSString stringWithFormat:@"%@", [[parsedData objectForKey:@"ReturnObject"] objectForKey:@"Message"] ];
            }
            else
            {
            notification.alertBody = [NSString stringWithFormat:@"No of notifications %@", [[parsedData objectForKey:@"ReturnObject"] objectForKey:@"NotificationCount"] ];
            }
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"NotificationCount"
             object:[parsedData objectForKey:@"ReturnObject"]];
        }
    }
    
    
}


-(void)errorRecieved:(NSString *)errorString withMsgType:(int)msgType
{
//    [appDelegate stopActivityIndicatorForViewController:self];
//    [self showAlertWithMessage:errorString];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
//    [self showAlertWithMessage:@"Failed to Get Your Location"];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    
    
    if (currentLocation != nil) {
        _eachStep.longitudeString = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        _eachStep.latitudeString = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        
        if (shouldCallAPI) {
            NSDictionary * postDataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:_eachStep.latitudeString,@"LocationLatitude",_eachStep.longitudeString,@"LocationLongitude", nil];
            
            NSLog(@"postDataDictionary for update technician %@",postDataDictionary);
            
            NSString * stringWithUrl = [NSString stringWithFormat:@"%@/api/App/Technician/UpdateTechnicianLocation",[Webservice webserviceLink]];
            
            [webservice requestMethodForPost:stringWithUrl withData:postDataDictionary withTag:12];

            shouldCallAPI = NO;
        }
//        GMSMarker * markerForCurrentLocation;
//        if (!markerForCurrentLocation) {
//            markerForCurrentLocation = [[GMSMarker alloc] init];
//            markerForCurrentLocation.position = CLLocationCoordinate2DMake([startLocation.latitudeString floatValue]
//                                                                           , [startLocation.longitudeString floatValue]);
//            markerForCurrentLocation.title = @"";
//            markerForCurrentLocation.snippet = @"";
//            markerForCurrentLocation.map = mapView;
//        }
//        [self callTimerToCallGoogleDirectionApi];
    }
}

#pragma mark - Reachability

- (void)reachabilityChanged:(NSNotification *)notification
{
    if([[AFNetworkReachabilityManager sharedManager] isReachable])
    {
        NSLog(@"Reachable");
//        [hubConnection start];

    }
    else
    {
        NSLog(@"Not Reachable");
//        [hubConnection stop];
    }
}

-(BOOL) isReachable
{
    return reachabilityManager.reachable;
}



#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"fasBackTechnician"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
