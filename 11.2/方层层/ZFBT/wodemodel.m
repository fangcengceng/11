//
//  wodemodel.m
//  ZFBT
//
//  Created by codygao on 16/11/2.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "wodemodel.h"

@implementation wodemodel
-(instancetype)initWithdic:(NSDictionary *)dic{

    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
}
@end
