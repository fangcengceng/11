//
//  ViewController.m
//  SD异步下载图片
//
//  Created by codygao on 16/11/6.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "APPModel.h"

@interface ViewController ()
@property(nonatomic,strong)NSArray *arrayList;
@property(nonatomic,strong)NSOperationQueue *queue;
@end

@implementation ViewController

-(NSArray *)arrayList{
    if (_arrayList == nil){
        _arrayList = [NSArray array];
        
    }
    return  _arrayList;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadJson];
    
    
}
#pragma 加载json数据
-(void)loadJson{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"https://raw.githubusercontent.com/zhangxiaochuZXC/ServerFile01/master/apps.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray*  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
//        self.arrayList = [NSArray yy_modelArrayWithClass:[APPModel class] json:responseObject];
//        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"ss";
    return  cell;
}

@end
