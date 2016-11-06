//
//  FCCSportSpeaker.h
//  FCCGudongSport
//
//  Created by codygao on 16/10/29.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCCSportTracking.h"
@interface FCCSportSpeaker : NSObject
//指定类型
-(void)startSportWithType:(FCCSportingType)type;
//运动状态
-(void)sportStateChanged:(FCCsportingState)state;
//整单位距离的播报
-(void)reportWithDistance:(double)distance timer:(NSTimeInterval)time speed:(double)speed;

//单位播报距离

@property(nonatomic,assign)double unitDistance;



@end
