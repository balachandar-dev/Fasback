//
//  StoryboardsAndSegues.h
//  FasBackTechnician
//
//  Created by User on 19/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryboardsAndSegues : NSObject

/*
 * storyboardId
 */
//Login
+ (NSString *) storyboardId_Login_UsernamePassword;
+ (NSString *) storyboardId_Login_AccountLocked;


// Profile
+ (NSString *) storyboardId_Dashboard;
+ (NSString *) storyboardId_UserProfile;



/*
 * segue
 */
// Sign Up
+ (NSString *) segue_SignIn;
+ (NSString *) segue_EnterInviteCode;
+ (NSString *) segue_EnterActivationCode;
+ (NSString *) segue_ForgotPassword;
+ (NSString *) segue_SetNewPassword;
+ (NSString *) segue_SetPassword;
+ (NSString *) segue_ConformDetailsPage;
+ (NSString *) segue_SuccessChangingPassword;
+ (NSString *) segue_SuccessAndFailureSettingPassword;


// Profile
+ (NSString *) segue_JobList;
+ (NSString *) segue_AcceptAndRejectWork;
+ (NSString *) segue_NotificationList;
+ (NSString *) segue_NewWorkOrder;
+ (NSString *) segue_ConfirmWorkOrder;
+ (NSString *) segue_Completed;
+ (NSString *) segue_Checkout;
+ (NSString *) segue_Dashboard;
+ (NSString *) SegueToDisplayList;
+ (NSString *) segue_sensorfact;
+ (NSString *) segue_GetLocation;
+ (NSString *) segue_HoldAndDiscard;
+ (NSString *) segue_editProfile;
+ (NSString *) segue_EstimatedETA;


/*
 * unwind segue
 */


+ (NSString *) unwindToAcceptOrRejectViewController;
+ (NSString *) unwindToHoldOrRejectViewController;
+ (NSString *) unwindToEditProfileViewController;

@end
