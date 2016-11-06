//
//  Person.h
//  yibuxiazaitupian
//
//  Created by codygao on 16/11/6.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property(nonatomic,copy)NSString *download;

@property(nonatomic,copy)NSString *icon;

@property(nonatomic,copy)NSString *name;


-(instancetype)initWithDic:(NSDictionary*)dic;
@end
