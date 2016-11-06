//
//  ViewController.m
//  yibuxiazaitupian
//
//  Created by codygao on 16/11/6.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "Person.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()<UITableViewDataSource>
@property(nonatomic,weak)    UITableView *tv;

@end

@implementation ViewController{
    NSArray<Person*> *_arrayList;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadJson];
    [self setupUI];
}

-(void)setupUI{
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    tv.dataSource = self;
    [tv registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tv];

    self.tv = tv;
}




-(void)loadJson{
    [[AFHTTPSessionManager manager] GET:@"https://raw.githubusercontent.com/zhangxiaochuZXC/ServerFile01/master/apps.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray*  _Nullable responseObject) {
        
//        yymodel处理加载过来的json数据
       _arrayList = [NSArray yy_modelArrayWithClass:[Person class] json:responseObject];
        
//        //自定义解析
//        NSMutableArray *tempA = [NSMutableArray arrayWithCapacity:responseObject.count];
//        
//        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//           
//            Person *p = [[Person alloc] initWithDic:obj];
//            [tempA addObject:p];
//        }];
//        _arrayList = tempA.copy;
        
//        在主线程刷新UI,AFN已经处理好，默认刷新界面是在主线程
            [self.tv reloadData];

  
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  _arrayList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_arrayList[indexPath.row].icon] placeholderImage:[UIImage imageNamed:@"user_default"]];
        cell.textLabel.text =  _arrayList[indexPath.row].name;
       cell.detailTextLabel.text = _arrayList[indexPath.row].download;
    return  cell;
    
    
}


@end
