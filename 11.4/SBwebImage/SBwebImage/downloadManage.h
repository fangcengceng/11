//
//  downloadManage.h
//  SBwebImage
//
//  Created by codygao on 16/11/6.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface downloadManage : NSObject
+(instancetype)sharedMange;
//单例下载图片主方法
- (void)downloadWithURLString:(NSString *)URLString finishedBlock:(void(^)(UIImage *image))finishedBlock;
//取消下载的主方法
- (void)cancelWithLastURLString:(NSString *)lastURLString;

@end
