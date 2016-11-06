//
//  MTFoodDetailHeaderView.h
//  meituan
//
//  Created by codygao on 16/11/5.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "spusModel.h"

@interface MTFoodDetailHeaderView : UIView
+(MTFoodDetailHeaderView*)foodDetailView;

@property(nonatomic,strong)spusModel *detailmodel;
@end
