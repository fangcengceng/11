//
//  RightCountView.m
//  meituan
//
//  Created by codygao on 16/11/3.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "RightCountView.h"

@interface RightCountView ()
@property(nonatomic,weak)IBOutlet UIButton *minusBu;
@property(nonatomic,weak)IBOutlet UIButton *plusBu;
@property(nonatomic,weak)IBOutlet UILabel *countlable;
@end


@implementation RightCountView
-(void)awakeFromNib{
    [super awakeFromNib];
    _count = 0;
}




-(IBAction)minusClick:(UIButton*)sender{
    
    //通过self点方法，调用count的set方法
    self.count --;
    self.isIncrease = NO;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    
    }

-(IBAction)plusClick:(UIButton*)sender{
    self.isIncrease = YES;
    self.count ++;
    
    //将坐标点转化为相对于父视图的坐标位置
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    _startP = [self convertPoint:sender.center toView:window];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    

    
}


-(void)setCount:(NSInteger)count{
    _count = count;
    NSLog(@"xxx");
    
    if (count <= 0){
        self.minusBu.alpha = 0;
        self.countlable.alpha = 0;
    }
    if (count > 0){
        self.minusBu.alpha= 1;
        self.countlable.alpha = 1;
    }
    
    self.countlable.text = [NSString stringWithFormat:@"%ld",count];
    
}


@end
