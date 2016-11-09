//
//  FileDownLoader.m
//  文件下载
//
//  Created by codygao on 16/11/9.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "FileDownLoader.h"

@implementation FileDownLoader

+(instancetype)fileDownloader{
    
    static FileDownLoader *sharedLoader;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLoader = [[ FileDownLoader alloc] init];
    });
    return  sharedLoader;
    
}

-(void)downloadFileWithURL:(NSString*)urlStr{
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (connectionError == nil && data != nil){
            [data writeToFile:@" /Users/codygao/Desktop/soubou.zip "atomically:YES];
        }
        
    }];
    
    
}

@end
