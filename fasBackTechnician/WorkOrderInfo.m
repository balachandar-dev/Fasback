//
//  WorkOrderInfo.m
//  fasBackTechnician
//
//  Created by User on 09/08/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "WorkOrderInfo.h"

@implementation WorkOrderInfo


-(id) init
{
    
    self = [super init];
    if (self) {
        //
    }
    return  self;
}

-(void) restoreToDefaults
{
    _profileImageString = @"";
    _customerId = @"";
    _customerLegalName = @"";
    _remainingTime = @"";
    _workOrderNumber = @"";
    _workOrderId = @"";
    _requestedEtaId = @"";
    _contactPersonName = @"";
    _contactEmail = @"";
    _contactPhoneNumber =@"";
    _locationLatitudeCustomer =@"";
    _locationLongitudeCustomer =@"";
    _contactAddress=@"";
    _contactCountryId=@"";
    _contactCountryName = @"";
    _contactStateId=@"";
    _contactStateName= @"";
    _contactCountyId=@"";
    _contactCountyName=@"";
    _contactCityId = @"";
    _contactCityName=@"";
    _contactZipCode=@"";
    _workOrderType =@"";
    _requestedOn=@"";
    _locationAddress=@"";
    _descriptionOfWorkOrder=@"";
    _action = @"";
    _requestedETADate = [NSDate date];
}
@end
