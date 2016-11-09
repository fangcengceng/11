//
//  FileDownLoader.h
//  文件下载
//
//  Created by codygao on 16/11/9.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileDownLoader : NSObject

+(instancetype)fileDownloader;

-(void)downloadFileWithURL:(NSString*)urlStr;

@end
