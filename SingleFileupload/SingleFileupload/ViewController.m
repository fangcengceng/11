//
//  ViewController.m
//  SingleFileupload
//
//  Created by codygao on 16/11/8.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSString *URLString = @"http://localhost/php/upload/upload.php";

    NSString *serverFileName = @"userfile";

  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"mm01.jpg" ofType:nil];

    [self uploadFileWithURL:URLString serverName:serverFileName filepaht:filePath];
}

-(void)uploadFileWithURL:(NSString*)urlstring serverName:(NSString *)serverName filepaht:(NSString*)filepath{
    
    NSURL *url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //设置请求头信息
    [request setValue:@"multipart/form-data; boundary=itcast"  forHTTPHeaderField:@"Content-Type"];
    
    //设置请求方法
    request.HTTPMethod = @"POST";
    request.HTTPBody = [self getHTTPBodyWithserverFileName:serverName filePaht:filepath];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil && data!= nil){
            //处理响应
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            NSLog(@"%@",result);
        }else{
            NSLog(@"%@",error);
        }
        
        
    }] resume];
    
}
//设置请求体主方法
-(NSData*)getHTTPBodyWithserverFileName:(NSString*)serverFileName filePaht:(NSString*)filePaht {
    
    //定会dataM 拼接请求体的二进制信息
    NSMutableData *data = [NSMutableData data];
    //拼接二进制前面的字符串
    NSMutableString *stringM = [NSMutableString string];
    
    //拼接文件开始的分隔符
    [stringM appendString:@"--itcast\r\n"];
    //拼接表单数据
    [stringM appendFormat:@"Content-Disposition: form-data; name=%@; filename=%@\r\n",serverFileName,[filePaht lastPathComponent]];
    //拼接文件类型
    [stringM appendString:@"Content-Type: image/jpeg\r\n"];
    //拼接换行
    [stringM appendString:@"\r\n"];

    //把这部分文字转化为二进制数据拼接起来
    [data appendData:[stringM dataUsingEncoding:NSUTF8StringEncoding]];
    //拼接二进制数据
    [data appendData:[NSData dataWithContentsOfFile:filePaht]];
    //拼接文件结束的分隔符
    NSString *end = @"\r\n--itcast--";
    [data appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    return  data.copy;


    
    
    return data;
}

@end
