//
//  foodDetailViewController.h
//  meituan
//
//  Created by codygao on 16/11/5.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "spusModel.h"

@interface foodDetailViewController : UIViewController
@property(nonatomic,strong)spusModel *foodmodel;
@property(nonatomic,strong)NSIndexPath *indexpath;
@end
