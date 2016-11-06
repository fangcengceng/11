//
//  FCCSportTracking.m
//  FCCGudongSport
//
//  Created by codygao on 16/10/21.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "FCCSportTracking.h"
#import "FCCSportTrackingLine.h"

NSString *const fccsportGPSSignalChangedNotification = @"fccsportGPSSignalChangedNotification";

@implementation FCCSportTracking{
    CLLocation *_startLocation;
    NSMutableArray<FCCSportTrackingLine*> *_trackingLines;
    CLLocation *_gpsPreLocation;
}

-(instancetype)initWithSportType:(FCCSportingType)type state:(FCCsportingState)state{
    if (self = [super init]){
        _sportType = type;
        _trackingLines = [NSMutableArray array];
        _sportState = state;
    }
    return  self;
}


-(CLLocation *)startSportLocation{
    return _trackingLines.firstObject.startLocation;
}

-(void)setSportState:(FCCsportingState)sportState{
    
    _sportState = sportState;
    
    if (sportState != FCCsportingStateContinue){
        _startLocation = nil;
    }
}



-(UIImage *)sportImage{
    UIImage *image;
    
    switch (_sportType) {
        case FCCSportingrun:
            image = [UIImage imageNamed:@"map_annotation_run"];
            break;
        
        case FCCSportingwalk:
            image = [UIImage imageNamed:@"map_annotation_walk"];
            break;
          
        case FCCSportingbike:
            image = [UIImage imageNamed:@"map_annotation_bike"];
            break;
        default:
            break;
    }
    
    return image;
    
}

/**
 检测gps信号的主方法
 */
-(FCCSportGPSSignalState)gpssignalWithLocation:(CLLocation*)location{
    
    FCCSportGPSSignalState state = FCCSportGPSSignalStateBad;
    if (location.speed <= 0){
        NSLog(@"现在可能在室内");
        [self postNotificationWithState:state];
        return state;
    }
    
    if (_gpsPreLocation == nil){
        _gpsPreLocation = location;
        [self postNotificationWithState:state];
    }
    
    //测试两点之间的时间差值
    NSTimeInterval delta = ABS([location.timestamp timeIntervalSinceDate:_gpsPreLocation.timestamp]);
//    NSLog(@"%f",delta);
    delta = ABS(delta - 1);
    if (delta <0.01){
        state = FCCSportGPSSignalStateGood;
    }else if (delta < 1){
        state = FCCSportGPSSignalStateNormal;
    }
    
    
    [self postNotificationWithState:state];
    
    //记录之前的点
    _gpsPreLocation = location;
    
    return state;
    
}

-(void)postNotificationWithState:(FCCSportGPSSignalState)state{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:fccsportGPSSignalChangedNotification object:@(state)];
}

//根据参数location修改用户的运动状态
-(void)checkSportStateWithlocation:(CLLocation*)location{
    
    if(self.startSportLocation == nil){
        return;
    }
    
    if (location.speed == 0 && _sportState== FCCsportingStateContinue){
        _sportState = FCCsportingStateCancel;
        NSLog(@"运动状态有继续切换为暂停");
    }
    if(location.speed > 0  && _sportState == FCCsportingStateCancel){
        _sportState = FCCsportingStateContinue;
        NSLog(@"运动状态切换为继续");
    }
}





#pragma mark --- 返回折线模型
-(FCCSportPolyline*)appendLocation:(CLLocation*)Location{
    //判断速度，性能优化
//    if (Location.speed <= 0){
//        return nil;
//    }
    
    if ([self gpssignalWithLocation:Location] < FCCSportGPSSignalStateNormal){
        return nil;
    }
    
    [self checkSportStateWithlocation:Location];
    if (_sportState != FCCsportingStateContinue){
        return nil;
    }
    
  
//    NSLog(@"%@",Location.timestamp);
//    NSLog(@"%f",[[NSDate date] timeIntervalSinceDate:Location.timestamp]);
    //目的：性能优化，减少不必要的室内杂线；
//    NSTimeInterval factor = 2;
//    if ([[NSDate date] timeIntervalSinceDate:Location.timestamp] >factor){
//        
//        return nil;
//    }
//    
    if (_startLocation == nil){
        
        _startLocation = Location;
        return nil;
    }
  
    
    FCCSportTrackingLine *trackLine = [[FCCSportTrackingLine alloc] initWithStartLocation:_startLocation endLocation:Location];
    
    //给运动轨迹数组添加元素
    [_trackingLines addObject:trackLine];
    NSLog(@"%f",self.avgSpeed);
   
    _startLocation = Location;
    
    
    return trackLine.polyLine;
    
}


-(double)avgSpeed{
    
    return [[_trackingLines valueForKeyPath:@"@avg.speed"] doubleValue];
}

-(double)maxSpeed{
    return [[_trackingLines valueForKeyPath:@"@max.speed"] doubleValue];
}

-(double)totalDistance{
    return [[_trackingLines valueForKeyPath:@"@sum.distanse"] doubleValue];
}

-(double)toltalTime{
    return [[_trackingLines valueForKeyPath:@"@sum.time"] doubleValue];
}

-(NSString *)totalTimeStr{
    NSInteger totalTime = (NSInteger)self.toltalTime;
   return  [NSString stringWithFormat:@"%02zd:%02zd:%02zd",totalTime/3600,(totalTime%3600)/60,totalTime%60];
}


@end
