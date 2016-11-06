//
//  FCCSportMaoModeViewController.h
//  FCCGudongSport
//
//  Created by codygao on 16/10/25.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

@interface FCCSportMaoModeViewController : UIViewController

/**
 定义地图类型
 */
@property(nonatomic,copy)void(^didSelecteModeType)(MAMapType type);

/**
 设置选中的地图样式
 */
@property(nonatomic,assign)MAMapType currentMapType;


@end
