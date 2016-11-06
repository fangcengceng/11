//
//  FCCSportSportingViewController.m
//  FCCGudongSport
//
//  Created by codygao on 16/10/21.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "FCCSportSportingViewController.h"
#import "CZAdditions.h"
#import "FCCSportSpeaker.h"
#import "FCCSportMapViewController.h"

@interface FCCSportSportingViewController ()<FCCSportMapViewControllerDelegate>
@property(nonatomic,strong)FCCSportMapViewController *mapViewController;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (weak, nonatomic) IBOutlet UILabel *speedLabel;

@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contineButtonCenterX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pauseButtonCenterX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *finishButtonCenterX;

@property (weak, nonatomic) IBOutlet UIButton *continueButton;



@end

@implementation FCCSportSportingViewController{
    FCCSportSpeaker *_sportSpeaker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMapController];
    [self setupBackgroudColor];
    _sportSpeaker = [[FCCSportSpeaker alloc] init];

}

#pragma mark ---FCCSportMapViewControllerDelegate

-(void)sportMapControllerDidChangedData:(FCCSportMapViewController *)vc{
    _distanceLabel.text = [NSString stringWithFormat:@"%0.2f",vc.sportTrack.totalDistance];
    _timeLabel.text = vc.sportTrack.totalTimeStr;
    _speedLabel.text = [NSString stringWithFormat:@"%0.2f",vc.sportTrack.avgSpeed];
    if (vc.sportTrack.sportState == FCCsportingStateCancel && _pauseButton.alpha == 1 ){
        [self changeSportState:_pauseButton];
    }
    
    if (vc.sportTrack.sportState == FCCsportingStateContinue && _pauseButton.alpha == 0){
        [self changeSportState:_continueButton];
    }
    //语音播报
    FCCSportTracking *track = vc.sportTrack;
    [_sportSpeaker reportWithDistance:track.totalDistance timer:track.toltalTime speed:track.avgSpeed];
    
}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    // 设置罗盘位置
    CGFloat x = _mapButton.center.x - _mapViewController.mapView.compassSize.width * 0.5;
    CGFloat y = _mapButton.center.y - _mapViewController.mapView.compassSize.height * 0.5;
    
    _mapViewController.mapView.compassOrigin = CGPointMake(x, y);
}


- (IBAction)showMapViewController {
  
    [self presentViewController:_mapViewController animated:YES completion:nil];
}

//背景渐变颜色
-(void)setupBackgroudColor{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.bounds = self.view.bounds;
    layer.position = self.view.center;
    layer.backgroundColor = [UIColor redColor].CGColor;
    //设置渐变颜色数组
    CGColorRef color1 = [UIColor cz_colorWithHex:0x0e1428].CGColor;
    CGColorRef color2 = [UIColor cz_colorWithHex:0x406479].CGColor;
    CGColorRef color3 = [UIColor cz_colorWithHex:0x406578].CGColor;
    
    layer.colors = @[(__bridge UIColor*)color1,(__bridge UIColor*)color2,(__bridge UIColor*)color3];
    layer.locations = @[@0,@0.6,@1];
    

    [self.view.layer insertSublayer:layer atIndex:0];
    
    
}


//添加父子控制器,咕咚6.0版本
-(void)setupMapController{
 
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"FCCSportSporting" bundle:nil];
    _mapViewController = [sb instantiateViewControllerWithIdentifier:@"mapViewController"];
    //设置运动轨迹模型
    _mapViewController.sportTrack = [[FCCSportTracking alloc] initWithSportType:_sportType state:FCCsportingStateContinue];
    
    //设置代理
    _mapViewController.delegate = self;
    
    //开始运动播报
    [_sportSpeaker startSportWithType:_sportType];
    
    
}

- (IBAction)changeSportState:(UIButton *)sender {
    
    FCCsportingState state = sender.tag -1;
    _mapViewController.sportTrack.sportState = state;
    // 1. 根据按钮的 tag 来决定按钮的偏移量
    CGFloat offset = (state == FCCsportingStateCancel) ? -80 : 80;
    
    // 2. 设置按钮的约束值
    _pauseButtonCenterX.constant += offset;
    _contineButtonCenterX.constant += offset;
    _finishButtonCenterX.constant -= offset;
    
    [UIView animateWithDuration:0.25 animations:^{
        _pauseButton.alpha = (sender != _pauseButton);
        [self.view layoutIfNeeded];
        
    }];
    
    [_sportSpeaker sportStateChanged:state];
    

}




@end
