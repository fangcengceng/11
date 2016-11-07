//
//  AppsModel.m
//  12-SD异步下载网络图片
//
//  Created by zhangjie on 16/8/15.
//  Copyright © 2016年 zhangjie. All rights reserved.
//

#import "AppsModel.h"

@implementation AppsModel

+ (instancetype)appWithDict:(NSDictionary *)dict
{
    AppsModel *app = [[AppsModel alloc] init];
    
    // KVC字典转模型
    [app setValuesForKeysWithDictionary:dict];
    
    return app;
}

@end
