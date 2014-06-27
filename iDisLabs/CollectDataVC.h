//
//  CollectDataVC.h
//  iDisLabs
//
//  Created by 曹 胜全 on 6/15/14.
//  Copyright (c) 2014 labplus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLHomeVC.h"

@interface CollectDataVC : UIViewController

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) DLHomeVC *homeViewDisplay;
-(IBAction)pressHomeButtonAction:(id)sender;
-(IBAction)pressConfigButtonAction:(id)sender;

@end
