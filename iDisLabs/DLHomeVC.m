//
//  DLHomeVC.m
//  iDisLabs
//
//  Created by 曹 胜全 on 5/20/14.
//  Copyright (c) 2014 labplus. All rights reserved.
//

#import "DLHomeVC.h"
#import <CoreMotion/CoreMotion.h>
#import "MontionButton.h"
#import "SensorDeclareView.h"
#import "protocol_fetch.h"
#import "SensorInfoViewController.h"
#import "CollectDataVC.h"
#import "SensorModel.h"



static const float egf = 9.81;  ////earth’s gravitational field  地球引力重量

@interface DLHomeVC ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;

@property (strong, nonatomic) IBOutlet MontionButton *btnAcc_Z;
@property (strong, nonatomic) IBOutlet MontionButton *btnAcc_Y;
@property (strong, nonatomic) IBOutlet MontionButton *btnAcc_X;
@property (strong, nonatomic) IBOutlet MontionButton *btnAcc_XYZ;

@property (strong, nonatomic) MontionButton *btnLight;
@property (strong, nonatomic) MontionButton *btnTemperature;

@property (strong, nonatomic) MontionButton *btIntegrationSensorOne;
@property (strong, nonatomic) MontionButton *btIntegrationSensorTwo;



@property (nonatomic, strong) CMMotionManager *motionManager;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@property (strong, nonatomic) SensorInfoViewController *infoVc;
@property (nonatomic, strong) UIPopoverController *sensorPop;

@property (strong, nonatomic) NSMutableArray *sensorInfoArray;

@end

@implementation DLHomeVC


- (void)viewDidLoad
{
    [super viewDidLoad];    
    _motionManager = [[CMMotionManager alloc] init];
    
    [self.toolBar setBackgroundImage:[UIImage imageNamed:@"navi_bg"] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.leftView setBackgroundColor:[UIColor clearColor]];
    [self.rightView setBackgroundColor:[UIColor clearColor]];
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = YES;
    self.scrollView.delaysContentTouches = NO;
    
    UIImageView *gap = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gap"]];
    gap.frame = CGRectMake(0, 0, 1.5, 44);
    UIBarButtonItem *bar_gap = [[UIBarButtonItem alloc] initWithCustomView:gap];
    bar_gap.width = 1.5;
    UIButton *btnSetting = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSetting setImage:[UIImage imageNamed:@"btn_set"] forState:UIControlStateNormal];
    [btnSetting setImage:[UIImage imageNamed:@"btn_set_s"] forState:UIControlStateHighlighted];
    btnSetting.frame = CGRectMake(0, 0, 44, 44);
    UIBarButtonItem *barSet = [[UIBarButtonItem alloc] initWithCustomView:btnSetting];
    
    UIButton *btnHelp = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnHelp setImage:[UIImage imageNamed:@"btn_help"] forState:UIControlStateNormal];
    btnHelp.frame = CGRectMake(0, 0, 44, 44);
    UIBarButtonItem *barHelp = [[UIBarButtonItem alloc] initWithCustomView:btnHelp];
    
//    UIBarButtonItem *barHelp = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_help.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(doHelpAction:)];
    
    [self.navigationItem setRightBarButtonItems:@[barHelp,bar_gap,barSet]];
    
    UIBarButtonItem *bar_log = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]]];
    [self.navigationItem setLeftBarButtonItem:bar_log];
    
    _infoVc = [[SensorInfoViewController alloc] init];
    _sensorPop = [[UIPopoverController alloc] initWithContentViewController:_infoVc];
    [_sensorPop  setPopoverContentSize:CGSizeMake(285.0, 180.0)];
    
    /*self.btnAcc_X.leftTitle = @"1、加速度X";
    self.btnAcc_Y.leftTitle = @"2、加速度Y";
    self.btnAcc_Z.leftTitle = @"3、加速度Z";
    self.btnAcc_XYZ.leftTitle = @"4、加速度｜合成｜";*/
    
    //for test
    DatabaseOpration *testDb = [[DatabaseOpration alloc] init];
    [testDb queryDatabaseUseId:46];
    
    [self initDemoSensors];
}

- (void) initDemoSensors
{
    self.sensorInfoArray = [NSMutableArray new];
    
    NSArray *sensorDemo = @[@{@"n": @"温度", @"p":@"1"},
                            @{@"n": @"力", @"p": @"2"},
                            @{@"n": @"光亮度", @"p": @"3"},
                            @{@"n": @"光亮度", @"p": @"4"},
                            @{@"n": @"光亮度", @"p": @"5"},
                            @{@"n": @"光亮度", @"p": @"6"},
                            @{@"n": @"光亮度", @"p": @"7"},
                            @{@"n": @"加速度X", @"p": @"13"},
                            @{@"n": @"加速度Y", @"p": @"14"},
                            @{@"n": @"加速度Z", @"p": @"15"},
                            @{@"n": @"加速度｜合成｜", @"p": @"16"},
                            @{@"n": @"电流", @"p": @"17"},
                            @{@"n": @"电压", @"p": @"18"}
                            ];
    
    for (int i=0; i < sensorDemo.count; i++)
    {
        SensorModel *oneSensor = [[SensorModel alloc] init];
        NSDictionary *sensor = [sensorDemo objectAtIndex:i];
        oneSensor.sensor_name = sensor[@"n"];
        oneSensor.sensor_port = [sensor[@"p"] intValue];
        [self.sensorInfoArray addObject:oneSensor];
    }
    
    [self reloadData];
}

- (void) reloadData
{
    NSArray *inners = [self.sensorInfoArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.sensorType==1"]];
    NSArray *inters = [self.sensorInfoArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.sensorType==3"]];
    NSArray *outers = [self.sensorInfoArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.sensorType==2"]];
    [self createLeftSensorViewWithInners:inners andInters:inters];
    [self createRightSensorViewWithSensors:outers];
}

- (void) doHelpAction:(id) sender
{
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self startUpdateMontion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) startUpdateMontion
{
    if ([self.motionManager isAccelerometerAvailable]) {
        self.motionManager.accelerometerUpdateInterval = 1.0;

        DLHomeVC * __weak weakSelf = self;
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            if (error == nil) {
                
                double x = accelerometerData.acceleration.x * egf;
                
                weakSelf.btnAcc_X.rightTitle = [NSString stringWithFormat:@" %f m/s^2", x];
                double y = accelerometerData.acceleration.y * egf;
                weakSelf.btnAcc_Y.rightTitle = [NSString stringWithFormat:@" %f m/s^2", y];
                
                double z = accelerometerData.acceleration.z * egf;
                weakSelf.btnAcc_Z.rightTitle = [NSString stringWithFormat:@" %f m/s^2", z] ;
                
            }else
                NSLog(@"error = %@", error);
        }];
    }

}

- (void) createLeftSensorViewWithInners:(NSArray *) inners andInters:(NSArray *) inters
{
    CGFloat w = 387.0;
    CGFloat x = 90.0;
    CGFloat h = 57.0;
    
    CGFloat y = 20.0;
    
    SensorDeclareView *innerSensor = [[[NSBundle mainBundle] loadNibNamed:@"SensorDeclareView" owner:self options:nil] firstObject];
    innerSensor.sensorTypeName = @"内置传感器";
    innerSensor.frame = CGRectMake(x, y, w, 60.0);
    [self.leftView addSubview:innerSensor];
    
    y += 60.0;
    NSInteger tag = 1;
    for (SensorModel *oneSensor in inners) {
        [self.leftView addSubview:[self newInnerSensoreWithFrame:CGRectMake(x, y, w, h) withTag:tag sensoreName:oneSensor.sensor_name withSensorModel:oneSensor]];
        y += h + 20;
        tag ++;
    }
    
    y += 16;
    SensorDeclareView *inteSensor = [[[NSBundle mainBundle] loadNibNamed:@"SensorDeclareView" owner:self options:nil] firstObject];
    inteSensor.sensorTypeName = @"集成传感器";
    inteSensor.frame = CGRectMake(x, y, w, 60.0);
    [self.leftView addSubview:inteSensor];
    y += 60.0;

    for (SensorModel *oneSensor in inters) {
        [self.leftView addSubview:[self newInterSensoreWithFrame:CGRectMake(x, y, w, h) withTag:tag sensoreName:oneSensor.sensor_name withSensorModel:oneSensor]];
        y += h + 20;
        tag ++;
    }
    
    y += 20;
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, y);
}

- (MontionButton *) newInnerSensoreWithFrame:(CGRect)frame withTag:(NSInteger)tag sensoreName:(NSString *)name withSensorModel:(SensorModel *) oneSensor //内置
{
    MontionButton *btn = [MontionButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_normal_s"] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_normal_s"] forState:UIControlStateHighlighted];
    btn.tag = tag;
    btn.leftTitle = [NSString stringWithFormat:@"%d、%@", tag, name];
    btn.theSensor = oneSensor;
    
    [btn addTarget:self action:@selector(doSensoreClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //for long press action
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLongPressAction:)];
    [btn addGestureRecognizer:longPress];
    
    return btn;
}

- (MontionButton *) newInterSensoreWithFrame:(CGRect) frame withTag:(NSInteger) tag  sensoreName:(NSString *) name  withSensorModel:(SensorModel *) oneSensor   //集成
{
    MontionButton *btn = [MontionButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_normal_s"] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_normal_s"] forState:UIControlStateHighlighted];
    btn.leftTitle = [NSString stringWithFormat:@"%d、%@", tag, name];
    btn.tag = tag;
    btn.theSensor = oneSensor;
   
    [btn addTarget:self action:@selector(doSensoreClickAction:) forControlEvents:UIControlEventTouchUpInside];
    //for long press action
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLongPressAction:)];
    [btn addGestureRecognizer:longPress];
    
    return btn;
}

- (MontionButton *) newOuterSensoreWithFrame:(CGRect) frame withTag:(NSInteger) tag sensoreName:(NSString *) name  withSensorModel:(SensorModel *) oneSensor //外接
{
    MontionButton *btn = [MontionButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_normal_s"] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_normal_s"] forState:UIControlStateHighlighted];
    btn.bWidhBleMark = YES;
    btn.theSensor = oneSensor;
    
    btn.leftTitle = [NSString stringWithFormat:@"%d、%@", tag, name];
    
    [btn addTarget:self action:@selector(doSensoreClickAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    
    //for long press action
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLongPressAction:)];
    [btn addGestureRecognizer:longPress];
    
    return btn;
}

-(void)btnLongPressAction:(UILongPressGestureRecognizer *)longPress
{
    MontionButton *btn = (MontionButton *) longPress.view;
    CGRect rect = CGRectMake(btn.frame.origin.x, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height);
    self.infoVc.theSensor = btn.theSensor;
    [self.sensorPop presentPopoverFromRect:rect inView:longPress.view.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void) doSensoreClickAction:(MontionButton *) btn
{
    [btn setSelected:!btn.isSelected];
}


- (void) createRightSensorViewWithSensors:(NSArray *) outers
{
    CGFloat w = 387.0;
    CGFloat x = 26.0;
    CGFloat h = 57.0;
    
    CGFloat y = 20.0;
    
    SensorDeclareView *innerSensor = [[[NSBundle mainBundle] loadNibNamed:@"SensorDeclareView" owner:self options:nil] firstObject];
    innerSensor.sensorTypeName = @"外接传感器";
    
    innerSensor.frame = CGRectMake(x, y, w, 60.0);
    [self.rightView addSubview:innerSensor];
    y += 60.0;
    NSInteger tag = 1;
    for (SensorModel *oneSensor in outers) {
        [self.rightView addSubview:[self newOuterSensoreWithFrame:CGRectMake(x, y, w, h) withTag:tag sensoreName:oneSensor.sensor_name withSensorModel:oneSensor]];
        y += h + 20;
        ++ tag;
    }
    y += 20;
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, y);
}

- (IBAction)beginDisAction:(id)sender {
    
    CollectDataVC *collectDataVc = [[CollectDataVC alloc] init];
    [self.navigationController pushViewController:collectDataVc animated:NO];
}


@end
