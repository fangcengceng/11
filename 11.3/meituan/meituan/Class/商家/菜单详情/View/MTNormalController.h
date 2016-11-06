//
//  MTNormalController.h
//  meituan
//
//  Created by codygao on 16/11/5.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "spusModel.h"
#import "foodSpusTags.h"
@interface MTNormalController : UIViewController
@property(nonatomic,strong)NSIndexPath *indexpath;

@property(nonatomic,strong)NSMutableArray<spusModel*> *model;

@property(nonatomic,strong)NSArray<foodSpusTags*> *array;
@end
