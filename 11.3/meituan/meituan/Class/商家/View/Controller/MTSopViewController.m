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
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"
#import "MTShopFoodCarView.h"
#import "MTShopingcarViewController.h"
#import "MTNormalController.h"
static NSString *leftCell = @"leftcell";
static NSString *rightCell = @"rightCell";

@interface MTSopViewController ()<UITableViewDataSource,UITableViewDelegate,RightTableViewCellDelegate,CAAnimationDelegate>
@property(nonatomic,weak)MTShopFoodCarView *carView;
@end

@implementation MTSopViewController{
    NSArray<foodSpusTags*> *food_array;
    UITableView *_leftV;
    UITableView *_rightV;
    
    //记录菜品模型,并且需要在动画结束的时刻传递，而不是底部的购物车视图一创建就添加
    NSMutableArray<spusModel*> *_foodList;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];
    [self setupUI];
    [_leftV selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    _foodList = [NSMutableArray array];
    
   
    //监听购物车添加事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(carCoutn:) name:@"animationaNoti" object:nil];
    
}

-(void)carCoutn:(NSNotification*)noti{
    spusModel *model = noti.userInfo[@"foodMoel"];
    if (![_foodList containsObject:model]){
        [_foodList addObject:model];
    }

    _carView.foodList = _foodList;
    [_rightV reloadData];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    _leftV = [[UITableView alloc] init];
    _leftV.tableFooterView = [[UIView alloc] init];
    _leftV.tableHeaderView = [[UIView alloc] init];
    _leftV.dataSource = self;
    _leftV.delegate = self;
    [_leftV registerClass:[LeftTableViewCell class] forCellReuseIdentifier:leftCell];
    [self.view addSubview:_leftV];
    
    
    //右侧的tableView
    _rightV = [[UITableView alloc] init];
    _rightV.dataSource = self;
    _rightV.delegate = self;
    [_rightV registerNib:[UINib nibWithNibName:@"RightTableViewCell" bundle:nil ] forCellReuseIdentifier:rightCell];
    _rightV.sectionHeaderHeight = 23;
    _leftV.tableFooterView = [[UIView alloc] init];
    _rightV.tableFooterView = [[UIView alloc] init];
    _rightV.rowHeight = 100;
    [self.view addSubview:_rightV];
    
    [_leftV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-46);
        make.width.mas_equalTo(86);
       
    }];
    
    [_rightV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_leftV);
        make.left.equalTo(_leftV.mas_right);
        make.right.equalTo(self.view);
    }];
    [self setupCarView];
 
}
#pragma mark 底部的购物车视图
-(void)setupCarView{
    MTShopFoodCarView *carView = [MTShopFoodCarView shopCarView];
    
    [self.view addSubview:carView];
    
    [carView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(-46);
    }];
    

    _carView = carView;
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
         LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCell forIndexPath:indexPath];
        foodSpusTags *model = food_array[indexPath.row];
        cell.model = model;

        return  cell;
    }
    RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rightCell forIndexPath:indexPath];
    
    //代理
    cell.delegate = self;
   NSArray<spusModel*> *array = food_array[indexPath.section].spus;
    spusModel *model = array[indexPath.row];
    cell.model = model;
    NSLog(@"%@",model.picture);
    
    return  cell;
}

    

    
    



#pragma mark 底部购物车的代理方法
-(void)clickTopresentShopCarController:(UIButton *)sender{
    
    MTShopingcarViewController *vc = [[MTShopingcarViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
    
}

#pragma mark RightTableViewCellDelegate
//点击增加按钮的动画效果
-(void)cellDidIncreasecell:(RightTableViewCell *)cell foodModel:(spusModel *)model andStartP:(CGPoint)startPoint{
    //将菜品保存到数组中
    if(![_foodList containsObject:model]){
        [_foodList addObject:model];
    }
    
    
    
//    创建视图
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_food_count_bg"]];
    //将图片添加到主window上
    imageV.center = startPoint;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:imageV];
    
    //添加关键帧核心动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //KVC赋值
    [anim setValue:imageV forKey:@"imageV"];
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:startPoint];
    
    CGPoint endP = CGPointMake(57, window.bounds.size.height - 46);
    // 控制点
    CGPoint controlP = CGPointMake(startPoint.x - 130, startPoint.y - 120);
    [path addQuadCurveToPoint:endP controlPoint:controlP];
    anim.path = path.CGPath;
    
    //动画结束后，需要将图片框移除，不让的话不停的创建view内存🎺太大
    anim.delegate = self;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    [imageV.layer addAnimation:anim forKey:nil];
}

//动画结束，移除图片框
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    //取值imagV
    UIImageView *imageV = [anim valueForKey:@"imageV"];
    
    [imageV removeFromSuperview];
    //将模型数据传递给底部的购物车视图
    _carView.foodList = _foodList;
    
    
}

//点击减少那妞的
-(void)cellDidDecreasecount:(RightTableViewCell *)cell foodModel:(spusModel *)model andStartP:(CGPoint)startPoint{
    if (model.orderCount == 0){
        [_foodList removeObject:model];
    }

    _carView.foodList = _foodList;
    
}

#pragma mark 设置组头
////
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    if (tableView == _leftV){
//        return nil;
//    }
//        UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"rightheader"];
//        UILabel *label = [[UILabel alloc] init];
//        label.text = food_array[section].name;
//        [header.contentView addSubview:label];
//        return  header;
//  
//}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView == _leftV){
        return nil;
    }
    
    return food_array[section].name;
}

#pragma mark 两级联动
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftV){
    
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        [_rightV scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
        return;
    }
    

    
    MTNormalController *vc = [[MTNormalController alloc] init];
    
    vc.indexpath = indexPath;
    vc.array = food_array;
    vc.model = _foodList;
    
    [self.navigationController pushViewController:vc animated:YES];
   
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _leftV) {
        return;
    }

    if (!(_rightV.isDragging || _rightV.isDecelerating || _rightV.isTracking)) {
        return;
    }

    NSInteger row = indexPath.section;
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    
    
    // 让分类列表选中行
    [_leftV selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionTop];
    
}





@end
