//
//  FCCBezierPath.m
//  DrawBoard
//
//  Created by codygao on 16/10/28.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "FCCBezierPath.h"

@implementation FCCBezierPath

+(instancetype)bezierPath{
    
    
    return [super bezierPath];
}


-(void)setColor:(UIColor *)color{
    _color = color;

}

-(UIColor *)color{
    return _color;
}
@end
