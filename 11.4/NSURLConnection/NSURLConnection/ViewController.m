//
//  ViewController.m
//  NSURLConnection
//
//  Created by codygao on 16/11/7.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webV = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webV];
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURL *url1 = [NSURL URLWithString:@"http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20/time/1457168894/type/0?channel=appstore&uuid=19C2BF6A-94F8-4503-8394-2DCD07C36A8F&net=5&model=iPhone&ver=1.0.5"];
   
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:15];
    [request setValue:@"iPhone AppleWebKit" forHTTPHeaderField:@"user-Agent"];
    
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        NSLog(@"response == %@,data == %@",response,data);
        if (connectionError == nil && data != nil){
            
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [webV loadHTMLString:html baseURL:url];
            
        }else{
            NSLog(@"%@",connectionError);
        }
        
    }];

    
}


@end
