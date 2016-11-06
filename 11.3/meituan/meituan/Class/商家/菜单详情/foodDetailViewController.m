//
//  foodDetailViewController.m
//  meituan
//
//  Created by codygao on 16/11/5.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "foodDetailViewController.h"
#import "Masonry.h"
#import "MTFoodDetailHeaderView.h"
#import "MTShopFoodCarView.h"
#import "UIImageView+WebCache.h"

@interface foodDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UIImageView *imgV;
@property(nonatomic,weak)UITableView *tv;


@end

@implementation foodDetailViewController{
    MTFoodDetailHeaderView *_headerV;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
   
    
}

-(void)setupUI{
    UITableView *tv = [[UITableView alloc] init];

    tv.delegate = self;
    MTFoodDetailHeaderView *headerV = [MTFoodDetailHeaderView foodDetailView];
    tv.tableHeaderView = headerV;
    tv.dataSource = self;
    [tv registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    tv.tableFooterView = [[UIView alloc] init];
        
    [self.view addSubview:tv];
    
    UIImageView *img = [[UIImageView alloc] init];
    [self.view addSubview :img];
    
    
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.height.mas_equalTo(280);
    }];
    
    _imgV = img;
    _tv = tv;
    _headerV = headerV;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    _tv.contentInset = UIEdgeInsetsMake(280, 0, 0, 0);

    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    float offsetX = scrollView.contentOffset.y;
    CGFloat height = -offsetX;
    
    
    if (height <0){
        height = 0;
    }
    
    [_imgV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];  
    
    
    NSString *str = [_foodmodel.picture stringByDeletingPathExtension];
    NSURL *url = [NSURL URLWithString:str];
    
    [_imgV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"button_shoppingCart_noEmpty"]];
    _headerV.detailmodel = self.foodmodel;
}


-(void)setFoodmodel:(spusModel *)foodmodel{
    
    _foodmodel = foodmodel;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}
@end
