//
//  FCCSportTrackingLine.h
//  FCCGudongSport
//
//  Created by codygao on 16/10/22.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import "FCCSportPolyline.h"
#import "FCCSportTracking.h"


/**
 轨迹追踪模型，记录运动起点和终点
 */
@interface FCCSportTrackingLine : NSObject

/**
 轨迹最终模型初始化

 @param startLocation 运动起点
 @param endLocation   运动终点

 */
-(instancetype)initWithStartLocation:(CLLocation*)startLocation endLocation:(CLLocation*)endLocation;

/**
 运动起点
 */
@property(nonatomic,strong,readonly)CLLocation *startLocation;

/**
 运动终点
 */
@property(nonatomic,strong,readonly)CLLocation *endLocation;

/**
 运动轨迹折线
 */
@property(nonatomic,readonly)FCCSportPolyline *polyLine;


/**
 运动轨迹平均速度
 */
@property(nonatomic,readonly)double speed;

/**
 运动模型类型
 */
@property(nonatomic,assign)FCCSportingType type;


@property(nonatomic,readonly)NSTimeInterval time;

@property(nonatomic,readonly)double distanse;


@end
