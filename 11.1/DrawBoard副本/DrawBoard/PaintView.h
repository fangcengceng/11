//
//  PaintView.h
//  DrawBoard
//
//  Created by codygao on 16/10/28.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCCBezierPath.h"

@interface PaintView : UIView
//画笔线宽
@property(nonatomic,assign)CGFloat lineWidth;
//自定义贝塞尔路径
//@property(nonatomic,strong) FCCBezierPath *bezierPath;
//颜色
@property(nonatomic,strong)UIColor *color;

@end
