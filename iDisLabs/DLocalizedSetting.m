//
//  DLanguageSetting.m
//  iDisLabs
//
//  Created by 曹 胜全 on 5/20/14.
//  Copyright (c) 2014 labplus. All rights reserved.
//

#import "DLocalizedSetting.h"

#define kUserDefaultLanaguage @"kUserDefaultLanaguage"

static NSBundle *currentBundle = nil;

@interface DLocalizedSetting()

@property (nonatomic, strong, readwrite) NSArray *supportLanguages;
@property (nonatomic, strong) NSString *defaultLanguage;

@end

@implementation DLocalizedSetting

+ (NSBundle *) bundle
{
    return currentBundle;
}

+ (void) initialize
{
    NSString *lang = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultLanaguage];
    NSString *currlang = [lang length] > 0 ? lang : [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] firstObject];  // 初始化为当前系统语言
    NSString *path = [[NSBundle mainBundle] pathForResource:currlang ofType:@"lproj"];
    currentBundle = [NSBundle bundleWithPath:path];
}

+ (void) changeDefaultLanguage:(NSString *) toLanguage
{
    NSArray *applangs =  [[NSBundle mainBundle] localizations];
    if ([applangs containsObject:toLanguage]) {
        [[NSUserDefaults standardUserDefaults] setObject:toLanguage forKey:kUserDefaultLanaguage];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSString *path = [[NSBundle mainBundle] pathForResource:toLanguage ofType:@"lproj"];
        currentBundle = [NSBundle bundleWithPath:path];
        
    }else
        NSLog(@"app不支持该语言 toLanguage ＝ %@", toLanguage);
}




@end
