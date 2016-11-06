//
//  PaintView.m
//  DrawBoard
//
//  Created by codygao on 16/10/28.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "PaintView.h"

@implementation PaintView{
    CGPoint _startP;
    NSMutableArray<FCCBezierPath*> *_pathArr;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    _pathArr = [NSMutableArray array];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    //实例化路径
    _bezierPath = [FCCBezierPath bezierPath];

//    _bezierPath.color = self.color;
    _bezierPath.lineWidth = self.lineWidth*10;
    //获取触摸点
    CGPoint startP = [touch locationInView:self];
    
    [_bezierPath moveToPoint:startP];
    //将路径添加到集合中去
    [_pathArr addObject:_bezierPath];


}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [touches.anyObject locationInView:self];
    [_bezierPath addLineToPoint:point];
    [self setNeedsDisplay];

}



- (void)drawRect:(CGRect)rect {
    //遍历路径绘制路径
    for(FCCBezierPath *path in _pathArr){
        path.lineJoinStyle = kCGLineJoinRound;
        [self.color setStroke];
//        [path.color setStroke];
        [path stroke];
        
    }
    
    
   
    
}
-(void)setBezierPath:(FCCBezierPath *)bezierPath{
    _bezierPath = bezierPath;
}



-(void)setLineWidth:(CGFloat)lineWidth{
    _lineWidth = lineWidth;

}
@end
