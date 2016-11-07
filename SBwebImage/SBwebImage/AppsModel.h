//
//  AppsModel.h
//  12-SD异步下载网络图片
//
//  Created by zhangjie on 16/8/15.
//  Copyright © 2016年 zhangjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppsModel : NSObject

/// APP名称
@property (nonatomic,copy) NSString *name;
/// APP下载量
@property (nonatomic,copy) NSString *download;
/// APP图标
@property (nonatomic,copy) NSString *icon;

/**
 *  方便外界实现字典转模型的类方法
 *
 *  @param dict 外界传入字典
 *
 *  @return 返回模型对象
 */
+ (instancetype)appWithDict:(NSDictionary *)dict;

@end
