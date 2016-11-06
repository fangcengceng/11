//
//  RightCountView.h
//  meituan
//
//  Created by codygao on 16/11/3.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightCountView : UIControl

//记录自己的数值变化,本质是传值
@property(nonatomic,assign)NSInteger count;;

@property(nonatomic,assign)BOOL isIncrease;

//记录动画的起点
@property(nonatomic,assign)CGPoint startP;
@end
