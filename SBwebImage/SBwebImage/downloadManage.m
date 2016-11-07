//
//  downloadManage.m
//  SBwebImage
//
//  Created by codygao on 16/11/6.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "downloadManage.h"
#import "DownLoadOperation.h"

@implementation downloadManage{
    NSOperationQueue *_queue;
    NSMutableDictionary *_opdic;
    NSMutableDictionary *_imageDic;
}

+(instancetype)sharedMange{
    
    static id manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[downloadManage alloc] init];
    });
    return  manager;
}

-(instancetype)init{
    if (self = [super init ]){
        _queue = [[NSOperationQueue alloc] init];
        _opdic = [NSMutableDictionary dictionary];
        
    }
    return  self;
}


- (void)downloadWithURLString:(NSString *)URLString finishedBlock:(void(^)(UIImage *image))finishedBlock{
    //判断有没有缓存
    if([self  checkCacheWithURLstr:URLString]){
        if (finishedBlock){
            finishedBlock([_imageDic valueForKey:URLString]);
        }
        return;
    }
    
    
    
    
    // 避免重复建立下载操作
    if ([_opdic objectForKey:URLString] != nil) {
        return;
    }
    
    // 创建操作对象
    DownLoadOperation *op = [DownLoadOperation downloadOPWithImage:URLString block:^(UIImage *image) {
        
        // 回调控制器传入的代码块
        if (finishedBlock) {
                finishedBlock(image);
            
        }
        [_imageDic setValue:image forKey:URLString];
        
        // 图片下载结束,移除对应的操作
        [_opdic removeObjectForKey:URLString];
    }];
    
    // 把操作添加到操作缓存池
    [_opdic setObject:op forKey:URLString];
    
    // 把操作添加到队列
    [_queue addOperation:op];

}
// 取消操作主方法
- (void)cancelWithLastURLString:(NSString *)lastURLString
{
    // 获取上次下载操作
    DownLoadOperation *lastOP = [_opdic objectForKey:lastURLString];
    
    if (lastOP != nil) {
        // 发送取消消息
        [lastOP cancel];
        // 把取消的操作从操作缓存池移除
        [_opdic removeObjectForKey:lastURLString];
    }
}


//检查是否有内存缓存
-(BOOL)checkCacheWithURLstr:(NSString *)urlstr{
    
    //判断内存缓存
    if ([_imageDic objectForKey:urlstr] != nil){
        return  YES;
    }
    
    //判断沙盒缓存
    
    NSString *pathstr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject ;
    NSString *str = [urlstr lastPathComponent];
    
    NSString *path = [pathstr stringByAppendingPathComponent:str];
    
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    if (image != nil){
        [_imageDic setValue:image forKey:urlstr];
        return  YES;
    }
    
    
    return  NO;
}


@end
