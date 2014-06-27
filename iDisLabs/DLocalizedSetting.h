//
//  DLanguageSetting.h
//  iDisLabs
//
//  Created by 曹 胜全 on 5/20/14.
//  Copyright (c) 2014 labplus. All rights reserved.
//

#import <Foundation/Foundation.h>

//"zh-Hant", en, "zh-Hans"  支持三种语言

#define DLS(key, comment) \
[[DLocalizedSetting bundle] localizedStringForKey:(key) value:@"" table:nil]

@interface DLocalizedSetting : NSObject

+ (NSBundle *) bundle;
+ (void) changeDefaultLanguage:(NSString *) toLanguage;

@end
