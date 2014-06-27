//
//  CollectDataVC.m
//  iDisLabs
//
//  Created by 曹 胜全 on 6/15/14.
//  Copyright (c) 2014 labplus. All rights reserved.
//

#import "CollectDataVC.h"

@interface CollectDataVC ()
{
    
}
@end

@implementation CollectDataVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (UIBarButtonItem *) newBarButtonItemWithTitle:(NSString *) title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:16]];
    btn.frame = CGRectMake(0, 0, size.width + 18, 34);
    
    [btn setBackgroundImage:[[UIImage imageNamed:@"btn_c"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return bar;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.toolbar setBackgroundImage:[UIImage imageNamed:@"navi_bg"] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
//    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:[Utilities newButtonWithFrame:CGRectMake(0, 0, 50, 44) image:[UIImage imageNamed:@"btn_begin"] highlightImage:[UIImage imageNamed:@"btn_begin"]]];
//
//    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:[Utilities newButtonWithFrame:CGRectMake(0, 0, 50, 44) image:[UIImage imageNamed:@"btn_edit"] highlightImage:[UIImage imageNamed:@"btn_edit"]]];
//    
//    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithCustomView:[Utilities newButtonWithFrame:CGRectMake(0, 0, 50, 44) image:[UIImage imageNamed:@"btn_save"] highlightImage:[UIImage imageNamed:@"btn_save"]]];
    
    
    UIBarButtonItem *item1 = [self newBarButtonItemWithTitle:@"开始采集"];
    UIBarButtonItem *item2 = [self newBarButtonItemWithTitle:@"00:00.27.6"];
    UIBarButtonItem *item3 =  [self newBarButtonItemWithTitle:@"周期：20HZ"];
    UIBarButtonItem *item4 = [self newBarButtonItemWithTitle:@"编辑"];
    UIBarButtonItem *item5 = [self newBarButtonItemWithTitle:@"保存"];
    
    [self.navigationItem setLeftBarButtonItems:@[item1, item2, item3, item4, item5]];
    
    UIBarButtonItem *item6 = [self newBarButtonItemWithTitle:@"实验数据"];
    UIBarButtonItem *item7 = [self newBarButtonItemWithTitle:@"图表"];
    UIBarButtonItem *item8 = [self newBarButtonItemWithTitle:@"截图"];
    UIBarButtonItem *item9 = [self newBarButtonItemWithTitle:@"设置"];
    UIBarButtonItem *item10 = [self newBarButtonItemWithTitle:@"问题"];
    [self.navigationItem setRightBarButtonItems:@[item10, item9, item8, item7, item6]];
    
    
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [bg setImage:[UIImage imageNamed:@"home_bg"]];
    [self.view insertSubview:bg atIndex:0];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)pressHomeButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(IBAction)pressConfigButtonAction:(id)sender
{
    
}

- (void) beginCollection:(id)sender
{
    
}

@end
