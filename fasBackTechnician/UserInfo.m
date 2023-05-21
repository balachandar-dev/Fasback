//
//  UserInfo.m
//  fasBackTechnician
//
//  Created by User on 09/08/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        //
    }
    [self restoreToDefaults];
    return self;
}

-(void) restoreToDefaults
{
    _fullName = @"";
    _ratingOfTechnician = @"";
    _technicianDescription = @"";
    _statusId = @"";
    _statusName =@"";
    _openWorkOrder = @"";
    _completedWorkOrder = @"";
    _averageTime = @"";
    
    _firstName = @"";
    _lastName = @"";
    _gender = @"";
    _dateOfBirth = @"";
    _primaryMobileNumber = @"";
    _secondaryMobileNumber = @"";
    _primaryEmailAddress =@"";
    _secondaryemailAddress = @"";
    _addressLineOne = @"";
    _addressLineTwo = @"";
    _countryId = @"";
    _countryName = @"";
    _stateId = @"";
    _stateName = @"";
    _countyid = @"";
    _countyName = @"";
    _cityId =@"";
    _cityName = @"";
    _zipCode = @"";
    _profileImage = @"";
    
    _jobName = @"";
    _jobExperience = @"";
}


@end
