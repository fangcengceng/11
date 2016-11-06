//
//  FCCSportMapViewController.m
//  FCCGudongSport
//
//  Created by codygao on 16/10/21.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "FCCSportMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "FCCSportTrackingLine.h"
#import "FCCSportTracking.h"
#import "FCCTransitionAnimation.h"
#import "FCCSportMaoModeViewController.h"

@interface FCCSportMapViewController ()<MAMapViewDelegate,UIPopoverPresentationControllerDelegate>
//起始位置
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation FCCSportMapViewController{

     BOOL _hasSetStartLocation;
    FCCTransitionAnimation *_animator;
}
//自定义转转场动画

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super initWithCoder:aDecoder])
    {
        _animator = [[FCCTransitionAnimation alloc] init];
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = _animator;
    }

    return self;

}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setupMapUI];

}
- (void)viewDidLoad {
    [super viewDidLoad];

   

}
#pragma mark --------MAMapViewDelegate
//位置 @brief 位置或者设备方向更新后调用此接口

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    
//   如果位置不更新，返回
    if (!updatingLocation){
        return;
    }
//    
//    if (_sportTrack.sportState != FCCsportingStateContinue){
//        return;
//    }
//    
    [mapView setCenterCoordinate:userLocation.coordinate animated:YES];
    
    
    //判断起始位置是否存在,设置大头针
    if (!_hasSetStartLocation && _sportTrack.startSportLocation != nil){
        _hasSetStartLocation = YES;
       
        
        //实例化大头针
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
        
        //确定大头针位置
        annotation.coordinate = _sportTrack.startSportLocation.coordinate;
        
        [mapView addAnnotation:annotation];
//        NSLog(@"%f",userLocation.coordinate.latitude);
 
    }
    
//    NSLog(@"%@",userLocation.location);
    
    //添加折线
    [mapView addOverlay:[_sportTrack appendLocation:userLocation.location]];
    [self displayUILable];
    
    //通知代理数据更新
    [_delegate sportMapControllerDidChangedData:self];
    
}
//时间和距离标签的显示
-(void)displayUILable{
    //设置时间标签,抽取到sportTrack中
     self.timeLabel.text = _sportTrack.totalTimeStr;
    //设置距离标签
    self.distanceLabel.text = [NSString stringWithFormat:@"%.02f",_sportTrack.totalDistance];
    
    
}

//自定义大头针
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    NSLog(@"---%@",annotation);
    //判断如果是系统的小蓝点（也是大头针），不做处理；
    //
    if (![annotation isKindOfClass:[MAPointAnnotation class]]){
        
        return nil;
    }
  
    //实例化大头针视图,先从缓存池中区
    static NSString *annimationReuseId = @"annimationViewId";
    MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annimationReuseId];
    if (annotationView == nil){
        annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annimationReuseId];
    }
    UIImage *image =  _sportTrack.sportImage;
    annotationView.image = image;
    annotationView.centerOffset = CGPointMake(0, -image.size.height*0.5);
    return annotationView;
}

#pragma mark 关闭地图视图方法
- (IBAction)closeMapAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//折线渲染器的方法，可以显示地图折线,是基类，需要用子类来实现
-(MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay{
//    NSLog(@"%@",overlay);//就是传进来的plyline;
    //实例化渲染器
    FCCSportPolyline *polyLine = (FCCSportPolyline*)overlay;
    
    MAPolylineRenderer *render = [[MAPolylineRenderer alloc] initWithOverlay:polyLine];
    //设置属性
    render.lineWidth = 10;
    render.strokeColor = polyLine.color;
    
    return render;

}
#pragma mark UIPopoverPresentationControllerDelegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

#pragma mark popViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //判断
    if (![segue.destinationViewController isKindOfClass:[FCCSportMaoModeViewController class]]){
        return;
    }
    
    FCCSportMaoModeViewController *modeVc = segue.destinationViewController;
    
//    NSLog(@"%@",segue.destinationViewController.popoverPresentationController);
//    NSLog(@"%@",segue.destinationViewController);
//    
    segue.destinationViewController.popoverPresentationController.delegate = self;
    modeVc.preferredContentSize = CGSizeMake(0, 120);
    modeVc.didSelecteModeType = ^(MAMapType type){
        self.mapView.mapType = type;
        
    };
    
    modeVc.currentMapType = self.mapView.mapType;
 
}




-(void)setupMapUI{
    ///集成高德地图
    ///初始化地图
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    ///把地图添加至view
    [self.view addSubview:mapView];
    [self.view insertSubview:mapView atIndex:0];
    //确定定位点,显示用户位置
    mapView.showsUserLocation = YES;
    //显示用户信息
    mapView.userTrackingMode = MAUserTrackingModeFollow;
    //显示比例尺
    mapView.showsScale = YES;
    //3D关闭相机旋转
   // mapView.rotateCameraEnabled = NO;
    
    //后台更新位置
    mapView.allowsBackgroundLocationUpdates = YES;
    
    //不允许暂停更新
    mapView.pausesLocationUpdatesAutomatically = NO;
    
    //设置代理，跟新位置数据
    mapView.delegate = self;
    
    
    //记录成员变量
    _mapView = mapView;
}



@end
