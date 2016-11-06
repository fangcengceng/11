//
//  FCCSportTrackingLine.m
//  FCCGudongSport
//
//  Created by codygao on 16/10/22.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "FCCSportTrackingLine.h"

@implementation FCCSportTrackingLine

-(instancetype)initWithStartLocation:(CLLocation *)startLocation endLocation:(CLLocation *)endLocation{
    
    if (self = [super init]){
        //get方法，readonly只会生成get方法，不会生成set方法
        _startLocation = startLocation;
        _endLocation = endLocation;
    }
    
    return self;
}

-(FCCSportPolyline *)polyLine{
    CLLocationCoordinate2D coord[2];
    
    coord[0] = _startLocation.coordinate;
    coord[1] = _endLocation.coordinate;
    
//    NSLog(@"%f-- %f-- %f",self.speed,self.distanse,self.time);
    
    //设置放大比例因子
    CGFloat factor = 8;
    
    CGFloat red = factor * self.speed / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:1 blue:0 alpha:1];
    
    return [FCCSportPolyline polylineWithCoordinates:coord count:2 color:color];

}


-(double )speed{

    return (_startLocation.speed + _endLocation.speed)*0.5 *3.6;
    
}

-(NSTimeInterval)time{
    return  [_endLocation.timestamp timeIntervalSinceDate:_startLocation.timestamp];
}

-(double)distanse{
    return [_endLocation distanceFromLocation:_startLocation]*0.001;
}
@end
