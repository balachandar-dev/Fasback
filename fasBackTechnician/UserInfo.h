//
//  UserInfo.h
//  fasBackTechnician
//
//  Created by User on 09/08/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject


@property (strong,nonatomic) NSString * fullName , * ratingOfTechnician, * technicianDescription, * statusId, * statusName, * openWorkOrder , * completedWorkOrder , * averageTime;
@property (strong, nonatomic) NSString * firstName , * lastName , * gender , * dateOfBirth , *primaryMobileNumber, * secondaryMobileNumber, * primaryEmailAddress , * secondaryemailAddress, * addressLineOne , * addressLineTwo , * countryId , * countryName,*stateId, * stateName, * countyid, * countyName, * cityId, * cityName ,* zipCode , * profileImage;

@property (nonatomic, strong) NSString * jobName , * jobExperience;











@end
