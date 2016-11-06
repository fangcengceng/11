//
//  FCCPainterView.m
//  DownLoadProgress
//
//  Created by codygao on 16/10/29.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "FCCPainterView.h"

@implementation FCCPainterView



-(void)setProgress:(CGFloat)progress{
    _progress = progress;
//    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:20 startAngle:0 endAngle: M_PI*2*_progress clockwise:YES];
    [path addLineToPoint:center];
    [path closePath];
    path.lineWidth = 4;
    [[UIColor redColor] setStroke];
//    [[UIColor yellowColor] setStroke];
//    [path stroke];
    [path stroke];
    
    
    



}


@end
