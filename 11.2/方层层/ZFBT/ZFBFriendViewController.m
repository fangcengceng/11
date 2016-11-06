//
//  ZFBFriendViewController.m
//  ZFBT
//
//  Created by codygao on 16/11/2.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ZFBFriendViewController.h"
#import <MAMapKit/MAMapKit.h>
@interface ZFBFriendViewController ()

@end

@implementation ZFBFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"地图";
    ///初始化地图
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    ///把地图添加至view
    [self.view addSubview:mapView];
    
    mapView.showsUserLocation = YES;
    


}



@end
