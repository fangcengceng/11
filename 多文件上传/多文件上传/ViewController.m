//
//  ViewController.m
//  多文件上传
//
//  Created by codygao on 16/11/8.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSString *URLString = @"http://localhost/php/upload/upload-m.php";
    NSString *servierFileName = @"userfile[]";
    NSString *filePaht1 = [[NSBundle mainBundle] pathForResource:@"mm01.jpg" ofType:nil];
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"mm02.jpg" ofType:nil];
    NSArray *filePaths = @[filePaht1,filePath2];
    NSDictionary *textDic = @{@"status":@"今天11yue8hao"};
    
    [self uploadFileWithURLstring:URLString serverFileName:servierFileName filepath:filePaths texDic:textDic];
}
-(void)uploadFileWithURLstring:(NSString*)urlstr serverFileName:(NSString*)serverFileName filepath:(NSArray*)filepaths texDic:(NSDictionary*)dic{
    NSURL *url = [NSURL URLWithString:urlstr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
    [request setValue:@"multipart/form-data; boundary=itcast" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [self getHttpBody:serverFileName filePaths:filepaths texDic:dic];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error ==  nil && data != nil){
            NSLog(@"%@ %@",data,[response class]);
            NSLog(@"%@",data);
            NSArray* result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"%@",[result class]);
            
            [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"%@",obj);
            }];
            NSLog(@"xxd");
        }else{
            NSLog(@"%@",error);
        }
        
    }] resume];
    
    
}

-(NSData*)getHttpBody:(NSString*)serverFileName filePaths:(NSArray*)filePahs texDic:(NSDictionary*)textDic{
    NSMutableData *data = [NSMutableData data];
    
    //循环拼接文件二进制信息
    [filePahs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableString *stringM = [NSMutableString string];
        [stringM appendString:@"--itcast\r\n"];
        //拼接表单数据
        [stringM appendFormat:@"Content-Disposition: form-data; name=%@; filename=%@\r\n",serverFileName,[obj lastPathComponent]];
        //拼接文件类型
        [stringM appendFormat:@"Content-Type: image/jpeg\r\n"];
        [stringM appendString:@"\r\n"];
        
        //把前面的字符串信息拼接到请求体里面
        [data appendData:[stringM dataUsingEncoding:NSUTF8StringEncoding]];
        //拼接文件的二进制数据
        [data appendData:[NSData dataWithContentsOfFile:obj]];
        //拼接二进制数据后面的换行
        [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding] ];
    }];
    //拼接文件的文本信息
    [textDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSMutableString *str = [NSMutableString string];
        //拼接文本信息开始分隔符
        [str appendString:@"--itcast\r\n"];
        //拼接表单数据
        [str appendFormat:@"Content-Disposition: form-data; name=%@\r\n",key];
        //拼接单纯的换行
        [str appendString:@"\r\n"];
        //拼接文本信息
        [str appendFormat:@"%@\r\n",obj];
        //把文本信息拼接到请求体
        [data appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
        
    }];
    
    //拼接文件上传的结束分隔符
    [data appendData:[@"--itcast--" dataUsingEncoding:NSUTF8StringEncoding]];
    return data.copy;
    
}

@end
