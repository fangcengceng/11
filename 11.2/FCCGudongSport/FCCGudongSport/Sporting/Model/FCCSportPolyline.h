//
//  FCCSportPolyline.h
//  FCCGudongSport
//
//  Created by codygao on 16/10/22.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface FCCSportPolyline : MAPolyline

/**
 返回自定义poline折线
 @param coords 经纬度坐标
 @param count  坐标点数量
 @param color  折线颜色
 */
+(instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count color:(UIColor*)color;


/**
 折线颜色属性
 */
@property(nonatomic,strong)UIColor *color;


@end
