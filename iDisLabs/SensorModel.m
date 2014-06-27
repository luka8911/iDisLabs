//
//  SensorModel.m
//  iDisLabs
//
//  Created by 曹 胜全 on 6/7/14.
//  Copyright (c) 2014 labplus. All rights reserved.
//

#import "SensorModel.h"

@implementation SensorModel

- (SensorType) sensorType
{
    if (self.sensor_port == 17 || self.sensor_port == 18) {
        return SensorType_Inter;
    }else if (self.sensor_port >=13 && self.sensor_port <= 16){
        return SensorType_Inner;
    }else if (self.sensor_port >= 1 && self.sensor_port <= 12){
        return SensorType_Outer;
    }else
        return SensorType_UnKnow;
}


@end
