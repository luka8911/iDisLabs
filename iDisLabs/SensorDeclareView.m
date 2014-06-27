//
//  SensorDeclareView.m
//  iDisLabs
//
//  Created by 曹 胜全 on 6/7/14.
//  Copyright (c) 2014 labplus. All rights reserved.
//

#import "SensorDeclareView.h"

@implementation SensorDeclareView

- (void) setSensorTypeName:(NSString *)sensorTypeName
{
    if (_sensorTypeName != sensorTypeName) {
        _sensorTypeName = sensorTypeName;
        lbName.text = _sensorTypeName;
    }
}

@end
