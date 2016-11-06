//
//  MTChanelView.h
//  meituan
//
//  Created by codygao on 16/11/1.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol chanelViewDelegate<NSObject>
-(void)chanelViewDidSelectbu:(NSInteger)index;

@end
@interface MTChanelView : UIView
//点击中间按钮的代理事件
@property(nonatomic,weak)id< chanelViewDelegate> delegate;
//外界传来的偏移量，用来设置按钮的选中状态
@property(nonatomic,assign)NSInteger index;




@end
