//
//  FCCSportTracking.h
//  FCCGudongSport
//
//  Created by codygao on 16/10/21.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import <MAMapKit/MAMapKit.h>
#import "FCCSportPolyline.h"

//GPS信号变化通知
extern NSString *const fccsportGPSSignalChangedNotification;


/**
 运动类型
 */
typedef NS_ENUM(NSInteger, FCCSportingType) {
    FCCSportingrun,
    FCCSportingwalk,
    FCCSportingbike,
};


/**
 运动状态
 */
typedef NS_ENUM(NSInteger,FCCsportingState){
    FCCsportingStateContinue,
    FCCsportingStateCancel,
    FCCsportingStateStop,
};

/// GPS信号状态
typedef enum : NSUInteger {
    FCCSportGPSSignalStateDisconnect,
    FCCSportGPSSignalStateBad,
    FCCSportGPSSignalStateNormal,
    FCCSportGPSSignalStateGood
} FCCSportGPSSignalState;


@interface FCCSportTracking : NSObject

//使用运动模型实例化追踪模型
-(instancetype)initWithSportType:(FCCSportingType)Type state:(FCCsportingState)state;

//运动模型
@property(nonatomic,assign,readonly)FCCSportingType sportType;

@property(nonatomic,readonly)CLLocation *startSportLocation;

/**
 运动状态
 */
@property(nonatomic,assign)FCCsportingState sportState;

//运动图形；
@property(nonatomic,strong,readonly)UIImage *sportImage;


/**
 追加位置，返回折线模型

 @param Location 终点
 */
-(FCCSportPolyline*)appendLocation:(CLLocation*)Location;


/**
 平均速度
 */
@property(nonatomic,readonly)double avgSpeed;

/**
 最大速度
 */
@property(nonatomic,readonly)double maxSpeed;

/**
 总时长
 */
@property(nonatomic,readonly)double toltalTime;

/**
 总距离
 */
@property(nonatomic,readonly)double totalDistance;

/**
 时间字符串的处理
 */
@property(nonatomic,copy)NSString *totalTimeStr;
@end
