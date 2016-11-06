//
//  LeftTableViewCell.h
//  meituan
//
//  Created by codygao on 16/11/3.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "foodSpusTags.h"
@interface LeftTableViewCell : UITableViewCell
//model数据
@property(nonatomic,strong)foodSpusTags *model;
//黄色小条
@property(nonatomic,strong)UIView* yellowV;

@end
