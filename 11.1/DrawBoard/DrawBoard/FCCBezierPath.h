//
//  FCCBezierPath.h
//  DrawBoard
//
//  Created by codygao on 16/10/28.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCCBezierPath : UIBezierPath
{
    UIColor *_color;
}

@property(nonatomic,strong)UIColor *color;
@end
