//
//  MontionButton.m
//  iDisLabs
//
//  Created by 曹 胜全 on 5/21/14.
//  Copyright (c) 2014 labplus. All rights reserved.
//

#import "MontionButton.h"

@implementation MontionButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLabel];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initLabel];
    }
    return self;
}

- (void) initLabel
{
    lbLeft = [[UILabel alloc] init];
    lbRight = [[UILabel alloc] init];
    lbLeft.font = [UIFont systemFontOfSize:22];
    lbRight.font = [UIFont systemFontOfSize:22];
    [self addSubview:lbLeft];
    [self addSubview:lbRight];
    [self setTitle:@" " forState:UIControlStateNormal];
}

- (void) setRightTitle:(NSString *)rightTitle
{
    if (_rightTitle != rightTitle) {
        _rightTitle = rightTitle;
        lbRight.text = rightTitle;
        [self setNeedsLayout];
    }
}

- (void) setLeftTitle:(NSString *)leftTitle
{
    if (_leftTitle != leftTitle) {
        _leftTitle = leftTitle;
        lbLeft.text = leftTitle;
        [self setNeedsLayout];
    }
}

- (void) setBWidhBleMark:(BOOL)bWidhBleMark
{
    _bWidhBleMark = bWidhBleMark;
    
    if (_bWidhBleMark) {
        [self setImage:[UIImage imageNamed:@"ble"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"ble_s"] forState:UIControlStateSelected];
        [self setImage:[UIImage imageNamed:@"ble_s"] forState:UIControlStateHighlighted];
        
    }
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    lbLeft.font = self.titleLabel.font;
    lbRight.font = self.titleLabel.font;
    
    [self setTitle:@" " forState:UIControlStateNormal];

    lbLeft.textColor = self.titleLabel.textColor;
    lbRight.textColor = self.titleLabel.textColor;
    
    lbLeft.frame = CGRectMake(40,  (self.bounds.size.height - self.titleLabel.bounds.size.height)/2, [self.leftTitle sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}].width , [self.leftTitle sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}].height);
    
    CGSize rsize = [self.rightTitle sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    
    lbRight.frame = CGRectMake(self.bounds.size.width -rsize.width -40, (self.bounds.size.height - self.titleLabel.bounds.size.height)/2, rsize.width , rsize.height);

    if (self.bWidhBleMark) {
        UIImage *image = [self imageForState:UIControlStateNormal];
        if (image != nil) {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, 300, 0, 0)];
        }
    }
    
}


@end
