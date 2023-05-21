//
//  WorkOrder.m
//  fasBackTechnician
//
//  Created by User on 08/08/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "WorkOrder.h"

@implementation WorkOrder

- (NSComparisonResult)compare:(WorkOrder *)otherObject {
    return [self.updatedTime compare:otherObject.updatedTime];
}



@end
