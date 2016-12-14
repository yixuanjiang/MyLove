//
//  YXBaiDuMapVC.m
//  MyLove
//
//  Created by 265g on 16/11/3.
//  Copyright © 2016年 Company. All rights reserved.
//

#import "YXBaiDuMapVC.h"
#import "YXBaiDuMapVC.h"


@interface YXBaiDuMapVC () <BMKMapViewDelegate,BMKLocationServiceDelegate>

@property (nonatomic, strong)BMKMapView *mapView;
@property (nonatomic, strong)BMKLocationService *locService;
//定位按钮
@property (nonatomic, strong) UIButton *locationBtn;
//街景按钮
@property (nonatomic, strong) UIButton *panoBtn;

@property(strong, nonatomic) BaiduPanoramaView  *panoramaView;
@end

@implementation YXBaiDuMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"地图";
    
    //定位
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    _mapView = [[BMKMapView alloc] init];
    _mapView.frame = self.view.bounds;
    _mapView.showsUserLocation = YES;//显示定位图层
    self.view = _mapView;
    
    
    //设置定位模式按钮
    [self setUpLocationBtn];
    
    //设置街景按钮
    [self setUpPanoBtn];

}

#pragma mark - 设置定位模式按钮setUpLocationBtn
- (void)setUpLocationBtn
{
    self.locationBtn = [[UIButton alloc] init];
    self.locationBtn.frame = CGRectMake(10, SCREEN_HEIGHT - 55, 25, 25);
    [self.locationBtn setImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
    [self.locationBtn setImage:[UIImage imageNamed:@"跟踪"] forState:UIControlStateSelected];
    [self.locationBtn addTarget:self action:@selector(locationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:self.locationBtn];
}

#pragma mark - 设置街景按钮
- (void)setUpPanoBtn
{
    self.panoBtn = [[UIButton alloc] init];
    self.panoBtn.frame = CGRectMake(10, self.locationBtn.frame.origin.y - 25 - 20, 25, 25);
    [self.panoBtn setImage:[UIImage imageNamed:@"街景"] forState:UIControlStateNormal];
    [self.panoBtn addTarget:self action:@selector(panoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:self.panoBtn];
}

#pragma mark - 定位按钮点击
- (void)locationBtnClick:(UIButton *)sender
{
    NSLog(@"%s",__func__);
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        _mapView.showsUserLocation = NO;
        _mapView.userTrackingMode = BMKUserTrackingModeFollow;
        _mapView.showsUserLocation = YES;
    }else
    {
        _mapView.showsUserLocation = NO;
        _mapView.userTrackingMode = BMKUserTrackingModeNone;
        _mapView.showsUserLocation = YES;
    }
     
}

#pragma mark - 街景按钮点击
- (void)panoBtnClick:(UIButton *)sender
{
    NSLog(@"%s",__func__);
        
    // key 为在百度LBS平台上统一申请的接入密钥ak 字符串
    self.panoramaView = [[BaiduPanoramaView alloc] initWithFrame:self.view.bounds key:@"dE9hEYcOnOYp3yIbiuhAnKqxgn4KniMK"];
    // 为全景设定一个代理
//    self.panoramaView.delegate = self;
    [self.view addSubview:self.panoramaView];
    [self.panoramaView setPanoramaImageLevel:ImageDefinitionMiddle];
    // 设定全景的pid， 这是指定显示某地的全景，/Work/Code/app/panosdk2/ios/demo/BaiduPanoDemo/BaiduPanoDemo也可以通过百度坐标进行显示全景
//    [self.panoramaView setPanoramaWithPid:@"01002200001309101607372275K"];
    

    // 坐标
    [self.panoramaView setPanoramaWithLon:_locService.userLocation.location.coordinate.longitude lat:_locService.userLocation.location.coordinate.latitude];
 
    
}

//实现相关delegate 处理位置信息更新
#pragma mark - 处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
    [_mapView updateLocationData:userLocation];
    
}
#pragma mark - 处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    BMKCoordinateSpan span = BMKCoordinateSpanMake(0.01,0.01);
    _mapView.region = BMKCoordinateRegionMake(center, span);
    
    [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

@end
