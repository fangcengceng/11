//
//  foodSpusTags.m
//  meituan
//
//  Created by codygao on 16/11/3.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "foodSpusTags.h"
#import "spusModel.h"
@implementation  foodSpusTags
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"spus" : [spusModel class]};
}
@end
