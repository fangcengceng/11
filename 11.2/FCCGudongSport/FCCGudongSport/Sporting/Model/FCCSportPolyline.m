//
//  FCCSportPolyline.m
//  FCCGudongSport
//
//  Created by codygao on 16/10/22.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "FCCSportPolyline.h"

@implementation FCCSportPolyline
+(instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count color:(UIColor *)color{
   
    FCCSportPolyline *polyLine = [self polylineWithCoordinates:coords count:count];
    polyLine.color = color;

    return polyLine;
}


@end
