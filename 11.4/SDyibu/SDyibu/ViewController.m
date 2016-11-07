//
//  ViewController.m
//  SDyibu
//
//  Created by codygao on 16/11/6.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "Person.h"
@interface ViewController ()<UITableViewDataSource>
@property(nonatomic,strong)NSArray *arrayList;
@property(nonatomic,strong)NSOperationQueue *queue;

@end

@implementation ViewController{
    UITableView *_tv;
    NSMutableDictionary *_imgeDic;
    NSMutableDictionary *_opDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _queue = [[NSOperationQueue alloc] init];
    _imgeDic = [NSMutableDictionary dictionary];
    _opDic = [NSMutableDictionary dictionary];
    [self loadData];
    [self setupUI];
}

-(NSArray *)arrayList{
    if (_arrayList == nil){
        _arrayList = [NSArray array];
    }
    return _arrayList;
}

-(void)loadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"https://raw.githubusercontent.com/zhangxiaochuZXC/ServerFile01/master/apps.json"  parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        self.arrayList = [NSArray yy_modelArrayWithClass:[Person class] json:responseObject];
        [_tv reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}
-(void)setupUI{
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tv];
    [tv registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    tv.dataSource = self;
    tv.rowHeight = 100;
    _tv = tv;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.arrayList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Person *p = self.arrayList[indexPath.row];
    cell.textLabel.text = p.name;

    //先判断内存中有没有图片
    UIImage *image = [_imgeDic valueForKey:p.icon];
    if (image != nil ){
        cell.imageView.image = image;
        return  cell;
    }
    

 
    cell.imageView.image = [UIImage imageNamed:@"user_default"];
    [self.queue addOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1];

        NSURL *url = [NSURL URLWithString:p.icon];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:data];
        
        if (img){
            NSString *str = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:[p.icon stringByDeletingPathExtension]];
            NSLog(@"%@",str);
            [data writeToFile:str atomically:YES];
        }
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            cell.imageView.image = img;
            //存储
            if (img != nil){
            
                [_imgeDic setValue:img forKey:p.icon];
                //处理错行
                [_tv reloadData];
            }
        }];
    }];
    
    return  cell;
}

@end
