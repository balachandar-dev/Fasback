//
//  StoryboardsAndSegues.m
//  FasBackTechnician
//
//  Created by User on 19/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "StoryboardsAndSegues.h"

@implementation StoryboardsAndSegues

/*
 * storyboardId
 */
//Login
//+ (NSString *) storyboardId_Login_UsernamePassword;
//+ (NSString *) storyboardId_Login_AccountLocked;


// Profile
+ (NSString *) storyboardId_Dashboard
{
    return @"DashboardViewController";
}

+ (NSString *) storyboardId_UserProfile
{
    return @"UserProfileViewController";
}


/*
 * segue
 */
// Sign Up
+ (NSString *) segue_SignIn
{
    return @"segue_SignIn";
}
+ (NSString *) segue_EnterInviteCode
{
    return @"segue_EnterInviteCode";
}
+ (NSString *) segue_EnterActivationCode
{
    return @"segue_EnterActivationCode";
}
+ (NSString *) segue_ForgotPassword
{
    return @"segue_ForgotPassword";
}
+ (NSString *) segue_SetNewPassword
{
    return @"segue_SetNewPassword";
}
+ (NSString *) segue_SetPassword
{
    return @"segue_SetPassword";
}
+ (NSString *) segue_ConformDetailsPage
{
    return @"segue_ConformDetailsPage";
}
+ (NSString *) segue_SuccessChangingPassword
{
    return @"segue_SuccessChangingPassword";
}
+ (NSString *) segue_SuccessAndFailureSettingPassword
{
    return @"segue_SuccessAndFailureSettingPassword";
}


// Profile
+ (NSString *) segue_JobList
{
    return @"segue_JobList";
}

+ (NSString *) segue_AcceptAndRejectWork
{
    return @"segue_AcceptAndRejectWork";
}

+ (NSString *) segue_NewWorkOrder
{
    return @"segue_NewWorkOrder";
}

+ (NSString *) segue_NotificationList
{
    return @"segue_NotificationList";
}

+ (NSString *) segue_ConfirmWorkOrder
{
    return @"segue_ConfirmWorkOrder";
}


+ (NSString *) segue_Completed
{
    return @"segue_Completed";
}

+ (NSString *) segue_Checkout
{
    return @"segue_Checkout";
}

+ (NSString *) segue_Dashboard
{
    return @"segue_Dashboard";
}

+ (NSString *) SegueToDisplayList
{
    return @"SegueToDisplayList";
}

+ (NSString *) segue_sensorfact
{
    return @"segue_sensorfact";
}

+ (NSString *) segue_GetLocation
{
    return @"segue_GetLocation";
}

+ (NSString *) segue_HoldAndDiscard
{
    return @"segue_HoldAndDiscard";
}

+ (NSString *) segue_editProfile
{
    return @"segue_editProfile";
}

+ (NSString *) segue_EstimatedETA
{
    return @"segue_EstimatedETA";
}




/* 
 * unwind segue
 */


+ (NSString *) unwindToAcceptOrRejectViewController
{
    return @"unwindToAcceptOrRejectViewController";
}


+ (NSString *) unwindToHoldOrRejectViewController
{
    return @"unwindToHoldOrRejectViewController";
}

+ (NSString *) unwindToEditProfileViewController
{
    return @"unwindToEditProfileViewController";
}




@end
