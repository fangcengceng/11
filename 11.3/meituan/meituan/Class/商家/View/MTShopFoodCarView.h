//
//  MTShopFoodCarView.h
//  meituan
//
//  Created by codygao on 16/11/4.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "spusModel.h"
@protocol MTShopFoodCarViewDelegate<NSObject>

-(void)clickTopresentShopCarController:(UIButton*)sender foodList:(NSMutableArray*)array;

@end


@interface MTShopFoodCarView : UIView

//自定义类方法
+(MTShopFoodCarView*)shopCarView;

//接收外界传来的模型数组，填充子控件
@property(nonatomic,strong)NSMutableArray< spusModel*> *foodList;


@property(nonatomic,weak)id <MTShopFoodCarViewDelegate>delegate;



@end
