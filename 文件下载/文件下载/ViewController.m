//
//  ViewController.m
//  文件下载
//
//  Created by codygao on 16/11/9.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ViewController.h"
#import "FileDownLoader.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *urlstr = @"http://localhost/sogou.zip";
    FileDownLoader *filedownloader = [FileDownLoader fileDownloader];
    
    [filedownloader downloadFileWithURL:urlstr];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
