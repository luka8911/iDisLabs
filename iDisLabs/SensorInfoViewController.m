//
//  SensorInfoViewController.m
//  iDisLabs
//
//  Created by 曹 胜全 on 6/8/14.
//  Copyright (c) 2014 labplus. All rights reserved.
//

#import "SensorInfoViewController.h"


@implementation SensorInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
}

- (void) setTheSensor:(SensorModel *)theSensor
{
    if (_theSensor != theSensor) {
        _theSensor = theSensor;
        
        self.infoSensorName.text = [[NSString alloc] initWithFormat:@"传感器名称: %@", _theSensor.sensor_name];
        
        self.infoSensorPort.text = [[NSString alloc] initWithFormat:@"端口号: %d", _theSensor.sensor_port];
        self.infoSensorValueRange.text = [[NSString alloc] initWithFormat:@"量程: %@", _theSensor.sensor_range];
        self.infoSensorRatio.text = [[NSString alloc] initWithFormat:@"分辨率: %@",_theSensor.sensor_rate];
        self.infoSensorAccuracy.text = [[NSString alloc] initWithFormat:@"精度: %@", _theSensor.sensor_accuracy];
        self.infoSensorSampleRate.text = [[NSString alloc] initWithFormat:@"最大采样率: %@", _theSensor.sensor_rate];
    }
}

@end
