//
//  ViewController.h
//  FCCModalAnmiation
//
//  Created by codygao on 16/10/24.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/**
 用于判断modal出来的控制器是以sb加载还是纯代码加载，支持两种方式
 */
@property(nonatomic,assign) BOOL vcFromStoryboard;


@end

