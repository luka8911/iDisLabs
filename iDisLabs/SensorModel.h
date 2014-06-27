//
//  SensorModel.h
//  iDisLabs
//
//  Created by 曹 胜全 on 6/7/14.
//  Copyright (c) 2014 labplus. All rights reserved.
//

#import <Foundation/Foundation.h>


enum _SensorType
{
    SensorType_UnKnow = 0,
    SensorType_Inner = 1,
    SensorType_Outer = 2,
    SensorType_Inter = 3
};
typedef enum _SensorType SensorType;


@interface SensorModel : NSObject

@property (nonatomic, strong) NSString *sensor_name;
@property (nonatomic, assign) int sensor_port;
@property (nonatomic, strong) NSString *sensor_range;
@property (nonatomic, strong) NSString *sensor_ratio;
@property (nonatomic, strong) NSString *sensor_accuracy;
@property (nonatomic, strong) NSString *sensor_rate;
@property (nonatomic, strong) NSString *sensor_status;
@property (nonatomic, assign) BOOL sensor_selected;

@property (nonatomic, assign) SensorType sensorType;


@end
