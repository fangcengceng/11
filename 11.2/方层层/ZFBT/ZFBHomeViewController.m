//
//  ZFBHomeViewController.m
//  ZFBT
//
//  Created by codygao on 16/11/2.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ZFBHomeViewController.h"
#import "Masonry.h"
#import "RightTableViewCell.h"
@interface ZFBHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZFBHomeViewController{
    NSArray *_array;
    UITableView *_left;
    UITableView *_right;
    NSMutableArray *_groupArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付宝";
    _groupArr = [NSMutableArray array];

         _array = @[@"衣服",@"化妆品",@"引用水",@"副食品",@"小吃",@"衣服",@"化妆品",@"引用水",@"副食品",@"小吃"];
    [self setupUI];


}

-(void)setupUI{
    
    UITableView *left = [[UITableView alloc] init ];
                         
[left registerClass:[UITableViewCell class] forCellReuseIdentifier:@"left"];
    
    left.dataSource = self;
    left.delegate =self;
    [self.view addSubview:left];
    _left = left;
    
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(1);
        make.width.mas_equalTo(self.view.frame.size.width*0.25);
    
    }];

    //右侧的
    UITableView *right = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [right registerClass:[UITableViewCell class] forCellReuseIdentifier:@"right"];
    
    right.dataSource = self;
    right.delegate =self;
    [self.view addSubview:right];
    _right = right;
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(left);
        make.left.equalTo(left.mas_right);
        make.top.equalTo(left);
        make.width.mas_equalTo(self.view.frame.size.width*0.75);
        
    }];
    
    //中间的黄线
    UIView *yellowview = [[UIView alloc] init];
    yellowview.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowview];
    [yellowview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(left);
        make.top.bottom.equalTo(left);
        make.width.mas_equalTo(3);
    }];
}
#pragma mark 左侧的tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _right){
        return 10;
    }
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _left){
       return  10;
    }
    
    return _array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _left ){

    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"left" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        NSString *str = [NSString stringWithFormat:@"第%ld类",indexPath.row];
        cell.textLabel.text = str ;
        [_groupArr addObject:str];
        return cell ;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"right" forIndexPath:indexPath];
    
      cell.textLabel.text = _array[indexPath.row];
    return  cell;
   }


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (tableView == _right){
    
        return [NSString stringWithFormat:@"第%ld类",section];
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _right){
        return;
    }
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
    // 让列表视图滚动!
    [_right scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _left){
        return;
    }
    
    // 如果不是用户滚动的菜品,不做操作!
    if (!(_right.isDragging || _right.isDecelerating || _right.isTracking)) {
        return;
    }
    
    // 计算需要选中的索引信息
    NSInteger row = indexPath.section;
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    
    
    // 让分类列表选中行
    [_left selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionTop];
    

    
    
}


@end
