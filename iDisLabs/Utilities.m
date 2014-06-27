//
//  Utils.m
//  iDisLabs
//
//  Created by 曹 胜全 on 5/20/14.
//  Copyright (c) 2014 labplus. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+ (void) changeLocalizedLanaguage:(NSString *) toLanguage
{
    [DLocalizedSetting changeDefaultLanguage:toLanguage];
}

+ (UIButton *) newButtonWithFrame:(CGRect) frame image:(UIImage *) image highlightImage:(UIImage *) hImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:hImage forState:UIControlStateHighlighted];
    return btn;
}


@end
