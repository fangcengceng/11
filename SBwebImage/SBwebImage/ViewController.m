//
//  ViewController.m
//  SBwebImage
//
//  Created by codygao on 16/11/6.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ViewController.h"
#import "DownLoadOperation.h"
#import "AFNetworking.h"
#import "AppsModel.h"
#import "downloadManage.h"

@interface ViewController ()
@property(nonatomic,strong)UIImageView *imgV;
@end

@implementation ViewController{
    //全局队列
    NSOperationQueue *_queue;
    //模型数组
    NSArray *_appList;
    //操作缓存池
    NSMutableDictionary *_opdic;
    
    //记录上次图片给地址
    NSString *_lastURL;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    _queue = [[NSOperationQueue alloc] init];
    _appList = [NSArray array];
    _opdic = [NSMutableDictionary dictionary];
    [self loadJsonData];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   
    _imgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_imgV];
    
    _queue = [[NSOperationQueue alloc] init];
    

    int random = arc4random_uniform((uint32_t) _appList.count);

    
    AppsModel *model = _appList[random];
    NSString *urlStr = model.icon;
    
    //判断本次地址是否和删词地址一样，如果不一样就取消上次的下载操作
    if (![model.icon isEqualToString:_lastURL] && _lastURL != nil){
        [[downloadManage  sharedMange] cancelWithLastURLString:_lastURL];
    }
    
    //保存本次图片地址，当再次点击屏幕的时候，本次的地址就辩称跟上次的地址
    _lastURL = urlStr;
    
    [[downloadManage sharedMange] downloadWithURLString:urlStr finishedBlock:^(UIImage *image) {
        _imgV.image = image;
    }]; 
}


/// AFN加载json数据
- (void)loadJsonData
{
    // 创建网络请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 发送GET请求获取json数据
    [manager GET:@"https://raw.githubusercontent.com/zhangxiaochuZXC/ServerFile01/master/apps.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *responseObject) {
        
        // responseObject 是个数组,里面放的是字典
        NSLog(@"%@ -- %@",[responseObject class],responseObject);
        
        // 可变临时数组
        NSMutableArray *tmpM = [NSMutableArray arrayWithCapacity:responseObject.count];
        
        // 下一步 : 遍历字典数组,取出字典,实现字典转模型
        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            // 字典转模型
            AppsModel *app = [AppsModel appWithDict:obj];
            // 把模型对象添加到可变临时数组
            [tmpM addObject:app];
        }];
        
        // 循环结束就拿到模型数组了;下一步 : 定义数据源数组,把临时的模型数组赋值给数据源数组,实现数据的展示
        _appList = tmpM.copy;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


@end
