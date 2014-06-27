//
//  SensorDeclareView.h
//  iDisLabs
//
//  Created by 曹 胜全 on 6/7/14.
//  Copyright (c) 2014 labplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SensorDeclareView : UIView
{
    __weak IBOutlet UILabel *lbName;
}

@property (nonatomic, copy) NSString *sensorTypeName;

@end
