//
//  spusModel.h
//  meituan
//
//  Created by codygao on 16/11/3.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface spusModel : NSObject
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* month_saled_content;
@property(nonatomic,copy)NSString* picture;
@property(nonatomic,strong)NSNumber *min_price;
@property (strong, nonatomic) NSNumber *praise_num;
//记录右侧添加的数量;
@property(nonatomic,assign)NSInteger orderCount;
@end
