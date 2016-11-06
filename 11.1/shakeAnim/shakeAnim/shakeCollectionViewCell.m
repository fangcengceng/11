
//
//  shakeCollectionViewCell.m
//  shakeAnim
//
//  Created by codygao on 16/10/30.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "shakeCollectionViewCell.h"

@implementation shakeCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.contentView.backgroundColor = [UIColor redColor];
        self.contentView.layer.cornerRadius = 10;
        self.contentView.layer.masksToBounds = YES;
    }
    return  self;
}


@end
