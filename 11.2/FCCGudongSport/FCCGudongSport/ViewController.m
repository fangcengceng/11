//
//  ViewController.m
//  FCCGudongSport
//
//  Created by codygao on 16/10/21.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ///初始化地图
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    ///把地图添加至view
    [self.view addSubview:_mapView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
