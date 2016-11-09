//
//  ViewController.m
//  get请求
//
//  Created by codygao on 16/11/7.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *mimafield;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readLoad];

}

//Post请求登陆方式
- (IBAction)login:(id)sender {

    NSURL *url = [NSURL URLWithString:@"http://localhost/php/login/login.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [self htttpBody];

    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data != nil && error == nil){

            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if ([dic[@"userId"] intValue] == 1){
                NSLog(@"登陆成功");
//                登陆成功在存储，其他时间不需要存储
                [self savedata];
                
            }else{
                NSLog(@"密码或者账号不正确");
             }
        }else{
            NSLog(@"%@",error);
            
        }
      }] resume];
}



-(NSData*)htttpBody{
    NSString *passworld = [self base64str:self.mimafield.text];
    NSLog(@"%@",passworld);
    
    NSString *str = [NSString stringWithFormat:@"username=%@&password=%@",self.textField.text,passworld];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

-(NSString*)base64str:(NSString *)str {
    //对密码进行加密
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    //把二进制数据编码之后转化为字符串
    NSString *encodeStr = [data base64EncodedStringWithOptions:0];
    return encodeStr;
}

-(NSString *)base64encodestr:(NSString*)encodestr{
    if (encodestr.length == 0){
        return nil;
    }
    //把编码后的字符串转化为字符串
    NSData *data = [[NSData alloc] initWithBase64EncodedString:encodestr options:0];
    NSString *decodeStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return decodeStr;
}

-(void)savedata{
    NSUserDefaults *defalut = [NSUserDefaults standardUserDefaults];
    [defalut setValue:self.textField.text forKey:@"姓名"];
    NSString *passWorld = [self base64str:self.mimafield.text];
    [defalut setValue:passWorld forKey:@"密码"];

}

-(void)readLoad{
   self.textField.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"姓名"];
    NSString *passworld = [self base64encodestr:[[NSUserDefaults standardUserDefaults] valueForKey:@"密码"]];
    self.mimafield.text = passworld;

}

#pragma mark get请求
-(void)demo{
    NSString *loginstr = [NSString stringWithFormat: @"http://localhost/php/login/login.php?username=%@&password=%@",self.textField.text,self.mimafield.text];
    NSString *str = [loginstr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:str];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil&& data != nil ){
            
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if ([result [@"userId"] integerValue]== 1){
                NSLog(@"登陆成功");
            }else{
                NSLog(@"登陆失败");
            }
            
        }else{
            NSLog(@"%@",error);
        }
        
    }] resume];

}

@end
