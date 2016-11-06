//
//  MTFoodDetailHeaderView.m
//  meituan
//
//  Created by codygao on 16/11/5.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "MTFoodDetailHeaderView.h"

@interface MTFoodDetailHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *saleL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *carButton;

@end

@implementation MTFoodDetailHeaderView
+(MTFoodDetailHeaderView*)foodDetailView{
    return [[NSBundle mainBundle] loadNibNamed:@"MTFoodDetailHeaderView" owner:self options:nil].lastObject;
}
- (IBAction)clickCarButton:(UIButton *)sender {
    
    UIWindow *winow = [UIApplication sharedApplication].keyWindow;
  CGPoint startP =  [self convertPoint:sender.center toView:winow];
    _detailmodel.orderCount ++;
    NSDictionary *dic = @{@"startP":[NSValue valueWithCGPoint:startP],
          @"foodMoel":_detailmodel};
    
//    通知动画
    [[NSNotificationCenter defaultCenter] postNotificationName:@"animationaNoti" object:nil userInfo:dic];

}


-(void)setDetailmodel:(spusModel *)detailmodel{
    _detailmodel = detailmodel;
    

    _nameL.text = detailmodel.name;
    _priceL.text = [NSString stringWithFormat:@"%@", detailmodel.min_price];
    _saleL .text = detailmodel.month_saled_content;
}
@end
