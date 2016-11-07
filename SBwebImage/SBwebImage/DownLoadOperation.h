//
//  DownLoadOperation.h
//  SBwebImage
//
//  Created by codygao on 16/11/6.
//  Copyright © 2016年 FCC. All rights reserved.
//

//自定义NSOpertion
#import <UIKit/UIKit.h>
@interface DownLoadOperation : NSOperation
//外界传来的URL
@property(nonatomic,copy)NSString *URLString;

//block，用作下载好的图片的回调
@property(nonatomic,copy)void(^imageBlock)(UIImage *image);


//快速创建类方法
+(instancetype)downloadOPWithImage:(NSString *)str block:(void(^)(UIImage *image))imageBlock;

@end
