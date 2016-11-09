//
//  ViewController.m
//  IMITateAFNLogin
//
//  Created by codygao on 16/11/9.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController{
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self loadHTML];
}

-(void)httpsDemo{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html" ,nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlstr = @"https://mail.itcast.cn";
    [manager GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *html = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark 其他用法BaseURL
-(void)baseurl{
    AFHTTPSessionManager *manage = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://localhost/"]];
    [manage GET:@"demo.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject class]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma  mark 文件下载
-(void)downloadFile{
    //下载地址
    NSString *URLString = @"http://localhost/sogou.zip";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%f",downloadProgress.fractionCompleted);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
           NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        
        NSURL *locationURL = [NSURL fileURLWithPath:filePath];
        
        return  locationURL;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"%@",filePath.path);
    }];
    [downloadTask resume];
}
#pragma mark AFN实现上传文件
-(void)upLoadFile{
    // 网络请求地址
    NSString *URLStr = @"http://localhost/php/upload/upload-m.php";
    //发送POST请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{
                                 @"status":@"zhansan"
                                 };
    [manager POST:URLStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"mm01.jpg" ofType:nil];
        NSData *data1 = [NSData dataWithContentsOfFile:filePath1];
        //拼接数据
        [formData appendPartWithFileData:data1 name:filePath1 fileName:@"userfile[]" mimeType:@"image/jpg"];
        
        //文件二
        NSString *filepath2 = [[NSBundle mainBundle] pathForResource:@"mm02.jpg" ofType:nil];
        NSData *data2 = [NSData dataWithContentsOfFile:filepath2];
        [formData appendPartWithFileData:data2 name:filepath2 fileName:@"userfile[]" mimeType:@"image/jpg"];

        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@%@",[responseObject class],responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
#pragma  AFN发送get请求
-(void)GETdemo{
    
    NSString *URLString = @"http://localhost/demo.json";

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URLString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@,%@",responseObject, [responseObject class]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
 
}
#pragma mark  登陆
-(void)GETloginDemo{
    // 登陆地址
    NSString *URLString = @"http://localhost/php/login/login.php";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"username"] = @"zhangsan";
    parameters [@"password"] = @"zhang";
    
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject class]);
        //存储用户
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
    
}
#pragma mark post请求
-(void)POSTLogin{
    NSString *URLString = @"http://localhost/php/login/login.php";

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"username"] = @"zhangsan";
    dic[@"password"]= @"zhang";
    
    [[AFHTTPSessionManager manager] POST:URLString parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {

        NSLog(@"%@",responseObject);
    
        
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
#pragma  mark AFN常见错误
-(void)loadHTML{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
[manage GET:@"http://www.baidu.com" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
    NSString *html = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSLog(@"%@",html);

} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"%@",error);
}];
}




@end
