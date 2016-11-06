//
//  MTShopFoodCarView.m
//  meituan
//
//  Created by codygao on 16/11/4.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "MTShopFoodCarView.h"
#import "CZAdditions.h"


@interface MTShopFoodCarView ()

@property (weak, nonatomic) IBOutlet UIButton *checkButton;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *carButton;
@property (weak, nonatomic) IBOutlet UIButton *numberButton;

@end


@implementation MTShopFoodCarView

    
//    if ([_delegate respondsToSelector:@selector(clickTopresentShopCarController:)]){
//        [_delegate clickTopresentShopCarController:sender];




+(MTShopFoodCarView*)shopCarView{
    
    return  [[NSBundle mainBundle] loadNibNamed:@"MTShopFoodCarView" owner:self options:nil].lastObject;
    
    
}
-(void)awakeFromNib{
    [super awakeFromNib];
    _numberButton.hidden = YES;
}

#pragma mark 点击购物车自定义modal
- (IBAction)presentDetailVC:(UIButton *)sender {
    NSLog(@"ss");
    
}




-(void)setFoodList:(NSMutableArray<spusModel *> *)foodList{
    
    _foodList = foodList;
    
   __block NSInteger count = 0;
   __block float money = 0;
    
    //遍历数组，获取其中的值
    [foodList enumerateObjectsUsingBlock:^(spusModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
         count  += obj.orderCount;
        money += (obj.orderCount * [obj.min_price floatValue ]);
    }];
    
    
    if (count >0){
        _numberButton.hidden = NO;
        _carButton.selected = YES;
        [_numberButton setTitle:@(count).description forState:UIControlStateNormal];
        
    }else{
        _numberButton.hidden = YES;
        
    }
    
    if(money>20){
        _priceLabel.text = @(money).description;

         _checkButton.backgroundColor = [UIColor yellowColor];
        [_checkButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
    }else if (money >0){
        _checkButton.backgroundColor = [UIColor cz_colorWithHex:0xCCCCCC];
        [_checkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        _priceLabel.text = [NSString stringWithFormat:@"¥：还差%0.2f元",20-money];
    }else{
        _checkButton.backgroundColor = [UIColor cz_colorWithHex:0xCCCCCC];

        [_checkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        _priceLabel.text = @"购物车空空如也";
        _priceLabel.textColor = [UIColor grayColor];
    }
    
}









@end
