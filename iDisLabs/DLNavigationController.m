//
//  TJNavigationController.m
//  DesignerTJ
//
//  Created by 曹 胜全 on 13-12-22.
//
//

#import "DLNavigationController.h"

@interface DLNavigationController ()<UINavigationBarDelegate>

@property (nonatomic, strong) UIView *statusBarView;

@end

@implementation DLNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (void) loadView
//{
//    [super loadView];
//
//}

- (id) init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//    [self.navigationBar setBackgroundColor:[UIColor yellowColor]];
    _statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.height, 20)];
    [_statusBarView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:_statusBarView];
    
    _dlNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.height, 44)];
    self.dlNavigationBar.tintColor = [UIColor whiteColor];
    [self.dlNavigationBar setBackgroundImage:[UIImage imageNamed:@"navi_bg"] forBarMetrics:UIBarMetricsDefault];
    self.dlNavigationBar.translucent = NO;
    [self.view addSubview:self.dlNavigationBar];
    self.dlNavigationBar.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.tjNavigationBar.frame = CGRectMake(0, 20, self.view.bounds.size.width, 44);
}


#pragma mark-- MenuClick

- (void)menuItemClick:(NSNotification *) noti
{
   
}


- (void) hideMenuItems
{

}


- (void) menuClick:(NSNotification *)sender
{

}


#pragma mark--  pushViewController


- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"self.viewcontrollers = %@", self.viewControllers);
//    if ([viewController isKindOfClass:[CuctomerVC class]]) {
//        [self checkInnerCustomerVc];
//    }
    [super pushViewController:viewController animated:animated];
    [self.dlNavigationBar pushNavigationItem:viewController.navigationItem animated:animated];
    
    NSLog(@"self.viewcontrollers = %@", self.viewControllers);

}

- (UIViewController *) popViewControllerAnimated:(BOOL)animated
{
    UIViewController *vc = [super popViewControllerAnimated:animated];
    [self.dlNavigationBar popNavigationItemAnimated:animated];
    return vc;
}


- (NSArray *) popToRootViewControllerAnimated:(BOOL) animated
{
    NSArray *pops = [super popToRootViewControllerAnimated:animated];
    for (int i = 0; i<pops.count; i++) {
        [self.dlNavigationBar popNavigationItemAnimated:NO];
    }
    return pops;
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray *pops = [super popToViewController:viewController animated:animated];
    
    UINavigationItem *desNaviItem = viewController.navigationItem;
    while (self.dlNavigationBar.topItem != desNaviItem) {
        [self.dlNavigationBar popNavigationItemAnimated:NO];
    }
    return pops;
}

#pragma mark-- UINavigationBarDelegate

/*
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    [self popViewControllerAnimated:YES];
    return YES;
}
*/


- (BOOL) shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}


@end
