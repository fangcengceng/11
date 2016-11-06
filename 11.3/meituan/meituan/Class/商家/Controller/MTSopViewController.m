//
//  MTSopViewController.m
//  meituan
//
//  Created by codygao on 16/11/1.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "MTSopViewController.h"
#import "YYModel.h"
#import "foodSpusTags.h"
#import "Masonry.h"
#import "spusModel.h"
static NSString *leftCell = @"leftcell";
static NSString *rightCell = @"rightCell";

@interface MTSopViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MTSopViewController{
    NSArray<foodSpusTags*> *food_array;
    UITableView *_leftV;
    UITableView *_rightV;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];
    [self setupUI];
    
}
#pragma mark 加载json数据
-(void)loadData{
    //加载路径
    NSString *str = [[NSBundle mainBundle] pathForResource:@"food.json" ofType:nil];
    //json反序列化
    NSData *data = [NSData dataWithContentsOfFile:str];
    NSDictionary *json_dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSDictionary *dic = json_dic[@"data"];
    NSArray *food_spu_tagsArr = dic[@"food_spu_tags"];

//    yymodel 字典转模型
    food_array = [NSArray yy_modelArrayWithClass:[foodSpusTags class] json:food_spu_tagsArr];
    
}

-(void)setupUI{
    //左侧的tableView
    _leftV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//    _leftV.tableFooterView = [[UIView alloc] init];
    
    _leftV.dataSource = self;
    _leftV.delegate = self;
    [_leftV registerClass:[UITableViewCell class] forCellReuseIdentifier:leftCell];
    [self.view addSubview:_leftV];
    
    
    //右侧的tableView
    _rightV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _rightV.dataSource = self;
    _rightV.delegate = self;
    [_rightV registerClass:[UITableViewCell class] forCellReuseIdentifier:rightCell];
    [self.view addSubview:_rightV];
    
    [_leftV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.width.mas_equalTo(self.view.frame.size.width*0.25);
    }];
    
    [_rightV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_leftV);
        make.left.equalTo(_leftV.mas_right);
        make.width.mas_equalTo(self.view.frame.size.width*0.75);
    }];
    
    
}

#pragma mark tableView的代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == _leftV){
        return 1;
    }

    return food_array.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == _leftV){
        return food_array.count;
    }
    
    NSArray *array = food_array[section].spus;
    return array.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    if (tableView == _leftV){
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCell forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",food_array[indexPath.row].name];
        return  cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightCell forIndexPath:indexPath];
    
   NSArray<spusModel*> *array = food_array[indexPath.section].spus;
//    NSString *str = array[indexPath.row].name;
//    cell.textLabel.text = str;
    
    
    return  cell;
}




@end
