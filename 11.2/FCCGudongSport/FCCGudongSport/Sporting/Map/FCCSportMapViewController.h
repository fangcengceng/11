//
//  FCCSportMapViewController.h
//  FCCGudongSport
//
//  Created by codygao on 16/10/21.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCCSportTracking.h"
@class FCCSportMapViewController;

@protocol FCCSportMapViewControllerDelegate <NSObject>

//运动地图控制器数据变化
-(void)sportMapControllerDidChangedData:(FCCSportMapViewController*)vc;

@end

@interface FCCSportMapViewController : UIViewController

@property(nonatomic,weak)id<FCCSportMapViewControllerDelegate>delegate;


/**
 运动最终模型
 */
@property(nonatomic,strong)FCCSportTracking *sportTrack;


/**
 地图视图
 */
@property(nonatomic,readonly)MAMapView *mapView;
@end
