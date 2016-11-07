//
//  DownLoadOperation.m
//  SBwebImage
//
//  Created by codygao on 16/11/6.
//  Copyright © 2016年 FCC. All rights reserved.
//

//下载图片,接受外界传来的地址，处理成图片，返回给控制器进行展示
#import "DownLoadOperation.h"

@implementation DownLoadOperation

-(void)main{
  
    
    
    NSURL *url = [NSURL URLWithString:self.URLString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    //取消正在下载的操作
    // 判断操作是否被取消
    if (self.isCancelled) {
        NSLog(@"取消 %@",self.URLString);
        return;
    }
    
    //返回给控制器，用block
    
    NSAssert(self.imageBlock != nil, @"图片下载完成的回调不能为空");
        //回到主线程把图片传递过去
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            self.imageBlock(image);
        }];
    
    
}

+(instancetype)downloadOPWithImage:(NSString *)str block:(void(^)(UIImage *image))imageBlock{
    
    DownLoadOperation *op = [[DownLoadOperation alloc] init];
    op.URLString = str;
    op.imageBlock = imageBlock;
    
    
    return  op;
}

@end
