//
//  LeftTableViewCell.m
//  meituan
//
//  Created by codygao on 16/11/3.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "LeftTableViewCell.h"
#import "Masonry.h"
#import "UIColor+CZAddition.h"
@implementation LeftTableViewCell{
    UILabel *_label;
  
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setupUI];
    }
    return  self;
}
-(void)setupUI{
    
    _label = [[UILabel alloc ] init];
    _label.numberOfLines = 2;
    _label.font = [UIFont systemFontOfSize:13];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_label];
    // 3.设置选中的背景
    UIView *selectBg = [[UIView alloc] init];
    selectBg.backgroundColor = [UIColor cz_colorWithHex:0xffffff];
    
    self.selectedBackgroundView = selectBg;
    UIView *yellowView = [[UIView alloc]init];
    yellowView.backgroundColor = [UIColor yellowColor];
    [selectBg addSubview:yellowView];
    //设置默认背景颜色
     self.contentView.backgroundColor = [UIColor cz_colorWithHex:0xf8f8f8];
    
    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(4);
        make.left.centerY.equalTo(selectBg);
        make.height.mas_equalTo(28);
    }];

    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(4);
        make.right.equalTo(self.contentView).offset(-3);
    }];
}

-(void)setModel:(foodSpusTags *)model{
    _model = model;
      _label.text = [NSString stringWithFormat:@"%@",model.name];

}




@end
