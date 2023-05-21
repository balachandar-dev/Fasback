//
//  WorkOrder.h
//  fasBackTechnician
//
//  Created by User on 08/08/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkOrder : NSObject

@property NSString * imageProfileString, * workOrderNumner, * workOrderStatusId, * updatedTime, * equipmentId, * equipmentName, * workOrderName, * workOrderId , * highlightedText, * requestType, * statusOfWorkOrder , * ratingOfWorkOrder, * feedbackDecription;
@property NSDate * createdOnDate;

- (NSComparisonResult)compare:(WorkOrder *)otherObject;


@end
