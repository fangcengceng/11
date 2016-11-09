//
//  ViewController.m
//  json
//
//  Created by codygao on 16/11/9.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

-(void)postJsonWith:(NSData*)data{
    
    NSURL *URL = [NSURL URLWithString:@"http://localhost/php/upload/postjson.php"];
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:URL];
    requestM.HTTPMethod = @"POST";
    requestM.HTTPBody = data;
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:requestM completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil && data != nil){
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
        }else{
            NSLog(@"%@",error);
        }
    }] resume];
    
    
    
}

//发送json字符串
-(void)POSTJSON_01{
    NSString *jsonStr = @"{\"name\":\"好人\"";
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    [self postJsonWith:data];
}

//字典序列化


-(void)postjson_02{
    NSDictionary *dic = @{@"name":@"压缩"};
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:NULL];
    [self postJsonWith:data];
}

//数组序列化成json
-(void)postJson_03{
    NSDictionary *dic = [NSDictionary dictionaryWithObject:@"牛头" forKey:@"name"];
    NSDictionary *dic2 = @{@"name":@"石头"};
    
    NSArray *array =  @[dic,dic2];
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:0 error:NULL];
    [self postJsonWith:data];
    
}
//自定义对象序列化为json格式的二进制
-(void)POST_04{
    Person *p = [[Person alloc] init];
    p.name = @"sss";
    [p setValue:@"18" forKey:@"age"];
    
    NSDictionary *dic = [p dictionaryWithValuesForKeys:@[@"name",@"_age"]];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:NULL];
    [self postJsonWith:data];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self POST_04];
}
@end
