//
//  RightTableViewCell.m
//  meituan
//
//  Created by codygao on 16/11/3.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "RightTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RightCountView.h"


@interface RightTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *monthSale;
@property (weak, nonatomic) IBOutlet UILabel *zanLabel;
@property (weak, nonatomic) IBOutlet UIImageView *xiaoshouImagV;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet RightCountView *rightCountView;



@end

@implementation RightTableViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.iconImage.layer.cornerRadius = 10;
    self.iconImage.layer.masksToBounds = YES;
    [self.rightCountView addTarget:self action:@selector(countChange:) forControlEvents:UIControlEventValueChanged];
    
    
}

-(void)setModel:(spusModel *)model{
    _model = model;
    
    self.nameLabel.text = model.name;
    self.priceLabel.text =[NSString stringWithFormat:@"%@",model.min_price];
    self.zanLabel.text = model.month_saled_content;
    self.monthSale.text = [NSString stringWithFormat:@"%@",model.praise_num];
 
    //处理字符串
    NSString *urlStr = [model.picture stringByDeletingPathExtension];
    // 2. 转为url
    NSURL *url = [NSURL URLWithString:urlStr];
    // 3. 设置图片 -> 负责设置图片的方法
    [self.iconImage sd_setImageWithURL:url];
    self.rightCountView.count = model.orderCount;
    

    
    
}


//监听值改变事件
-(void)countChange:(RightCountView*)sender{
    
    //需要将数量传递给模型
    _model.orderCount = sender.count;
    //通过代理将数据传递给控制器，用来记录
    
    if (sender.isIncrease){
        //增加需要动画
        [_delegate  cellDidIncreasecell:self foodModel:_model andStartP:sender.startP];
    }else{
        //减少不需要动画
        [_delegate cellDidDecreasecount:self foodModel:_model andStartP:sender.startP];
    }
    
    
    
    
}




@end
