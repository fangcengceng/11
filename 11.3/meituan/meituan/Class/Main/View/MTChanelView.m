
//
//  MTChanelView.m
//  meituan
//
//  Created by codygao on 16/11/1.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "MTChanelView.h"
#import "Masonry.h"

@implementation MTChanelView{
    UIButton *_selectedBu;
    NSArray<UIButton*> *_buArr;
    UIButton *_firstBu;
    UILabel *_yelloLabel;
    NSLayoutConstraint *_leftLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]){
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
        _firstBu.selected = YES;

    }
    return  self;
}

-(void)setupUI{
    
   
    UIButton *bu1 = [self button:@"点菜" tag:0];
    UIButton *bu2 = [self button:@"评价" tag:1];
    UIButton *bu3 = [self button:@"商家" tag:2];
    _firstBu = bu1;
    NSArray *array = @[bu1,bu2,bu3];
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
    }];
    UILabel *yellowV = [[UILabel alloc] init];
    yellowV.backgroundColor = [UIColor yellowColor];
    [self insertSubview:yellowV aboveSubview:bu3];
    _yelloLabel = yellowV;
    [yellowV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bu1);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(5);
        make.width.mas_equalTo(bu3.mas_width);
        
    }];
    _buArr = self.subviews;
    
    
}

-(UIButton *)button:(NSString*)buttonText tag:(NSInteger)tag{
    UIButton *bu = [[UIButton alloc] init];
    [bu setTitle:buttonText forState:UIControlStateNormal];
    bu.tag = tag;
    [bu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bu setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [bu addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bu];
    return bu;
}
#pragma mark 监听按钮的点击事件
-(void)click:(UIButton*)sender{
//    点击是让scrollview滚动
    
    if ([_delegate respondsToSelector:@selector(chanelViewDidSelectbu:)]){
        [_delegate chanelViewDidSelectbu:sender.tag];
    }
    
    _selectedBu.selected = NO;
    sender.selected = YES;
    _selectedBu = sender;
    
    [UIView animateWithDuration:0.25 animations:^{
        //点击按钮移动黄条
      [_yelloLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(sender.mas_left);
          make.bottom.equalTo(self);
          make.height.mas_equalTo(5);
          make.width.mas_equalTo(_firstBu.mas_width);
          
      }];
    } completion:^(BOOL finished) {
           [self layoutIfNeeded];
    }];
 
    
    
}

//外界传来的index更改黄条和按钮的选中
-(void)setIndex:(NSInteger)index{
    _index = index;
//    遍历数组，更改按钮的状态
    _selectedBu.selected = NO;
    _buArr[index].selected = YES;
    _selectedBu = _buArr[index];
    
    
    [UIView animateWithDuration:0.25 animations:^{
        [_yelloLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_buArr[index].mas_left);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(5);
            make.width.mas_equalTo(_firstBu.mas_width);
            
        }];
    } completion:^(BOOL finished) {
        [self layoutIfNeeded];
    }];
    
    
    
    
    
    
 
}


@end
