//
//  RightTableViewCell.h
//  meituan
//
//  Created by codygao on 16/11/3.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "spusModel.h"

@class  RightTableViewCell;
@protocol RightTableViewCellDelegate <NSObject>

-(void)cellDidIncreasecell:(RightTableViewCell *)cell foodModel:(spusModel*)model andStartP:(CGPoint)startPoint;
-(void)cellDidDecreasecount:(RightTableViewCell *)cell foodModel:(spusModel*)model andStartP:(CGPoint)startPoint;

@end

@interface RightTableViewCell : UITableViewCell
@property(nonatomic,strong)spusModel *model;
@property(nonatomic,weak)id<RightTableViewCellDelegate> delegate;

@end
