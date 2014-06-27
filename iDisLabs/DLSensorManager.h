//
//  DLSensorManager.h
//  iDisLabs
//
//  Created by 曹 胜全 on 6/7/14.
//  Copyright (c) 2014 labplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SensorModel.h"

@interface DLSensorManager : NSObject

- (NSArray *) defaultInnerSensors;  //类置

- (NSArray *) integrationSensors;  //集成

- (NSArray *) outerSensors; //外接

@end
