//
//  WorkOrderInfo.h
//  fasBackTechnician
//
//  Created by User on 09/08/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkOrderInfo : NSObject

@property (nonatomic,strong) NSString * profileImageString , * customerId , * customerLegalName, * remainingTime , * workOrderNumber, * workOrderId , * requestedEtaId, * contactPersonName, * contactEmail , * contactPhoneNumber , * locationLatitudeCustomer , * locationLongitudeCustomer , * contactAddress, * contactCountryId, * contactCountryName, *contactStateId, * contactStateName,*contactCountyId, * contactCountyName, * contactCityId, *contactCityName, * contactZipCode, * workOrderType , * requestedOn, * locationAddress, * descriptionOfWorkOrder, * action;


@property (nonatomic,strong) NSDate * requestedETADate;


@end
