//
//  SensorInfoViewController.h
//  iDisLabs
//
//  Created by 曹 胜全 on 6/8/14.
//  Copyright (c) 2014 labplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SensorModel.h"

@interface SensorInfoViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *infoSensorName;
@property (strong, nonatomic) IBOutlet UILabel *infoSensorPort;
@property (strong, nonatomic) IBOutlet UILabel *infoSensorValueRange;
@property (strong, nonatomic) IBOutlet UILabel *infoSensorRatio;
@property (strong, nonatomic) IBOutlet UILabel *infoSensorAccuracy;
@property (strong, nonatomic) IBOutlet UILabel *infoSensorSampleRate;

@property (nonatomic, strong) SensorModel *theSensor;


@end
