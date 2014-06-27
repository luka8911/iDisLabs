//
//  MontionButton.h
//  iDisLabs
//
//  Created by 曹 胜全 on 5/21/14.
//  Copyright (c) 2014 labplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SensorModel.h"

@interface MontionButton : UIButton
{
    UILabel *lbLeft;
    UILabel *lbRight;
}

@property (nonatomic, copy) NSString *leftTitle;

@property (nonatomic, strong) NSString *rightTitle;

@property (nonatomic, assign) BOOL bWidhBleMark;

@property (nonatomic, strong) SensorModel *theSensor;


@end
