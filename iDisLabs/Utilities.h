//
//  Utilities.h
//  iDisLabs
//
//  Created by 曹 胜全 on 5/20/14.
//  Copyright (c) 2014 labplus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLocalizedSetting.h"

@interface Utilities : NSObject

/**
 多语言设置, 目前支持 "zh-Hant", en, "zh-Hans" 三种语言
*/
+ (void) changeLocalizedLanaguage:(NSString *) toLanguage;

+ (UIButton *) newButtonWithFrame:(CGRect) frame image:(UIImage *) image highlightImage:(UIImage *) hImage;


@end
