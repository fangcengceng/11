//
//  Person.m
//  yibuxiazaitupian
//
//  Created by codygao on 16/11/6.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "Person.h"

@implementation Person
-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
}
@end
