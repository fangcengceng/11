//
//  MTNormalController.m
//  meituan
//
//  Created by codygao on 16/11/5.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "MTNormalController.h"
#import "foodDetailViewController.h"
#import "MTShopFoodCarView.h"
#import "Masonry.h"
@interface MTNormalController ()<UIPageViewControllerDataSource,CAAnimationDelegate>

@end

@implementation MTNormalController{
    MTShopFoodCarView *_carV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _carV.foodList = _model;

    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animtion:) name:@"animationaNoti" object:nil];
    
}

-(void)animtion:(NSNotification*)noti{
    
    NSLog(@"%@ %@", noti.object, noti.userInfo);
    CGPoint startPoint = [noti.userInfo[@"startP"] CGPointValue];
    
    if(![_model containsObject:noti.userInfo[@"foodMoel"]]){
        [_model addObject:noti.userInfo[@"foodMoel"]];
    }
    
    // 开始动画!
    // - 1.添加图片框
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_food_count_bg"]];
    imgView.center = startPoint;
    
    // - 将图片框添加给窗口
    UIWindow *keyW = [UIApplication sharedApplication].keyWindow;
    [keyW addSubview:imgView];
    
    // - 2.开启核心动画,让图片框运动
    // 1.创建对象
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // 通过kvc给动画绑定imgView!
    // 只有kvc可以这么做,其他的对象,不ok!
    [anim setValue:imgView forKey:@"imgV"];
    
    // 2.设置属性
    // - 路径对象
    UIBezierPath *path = [UIBezierPath bezierPath];
    // - 移动到起点
    [path moveToPoint:startPoint];
    // - 添加完美曲线!
    /**
     * 参数1 -> 结束时的点
     * 参数2 -> 控制点
     */
    // 结束点
    CGPoint endP = CGPointMake(50, keyW.bounds.size.height - 45);
    // 控制点
    CGPoint controlP = CGPointMake(startPoint.x - 130, startPoint.y - 120);
    // 添加完美路径
    [path addQuadCurveToPoint:endP controlPoint:controlP];
    
    anim.path = path.CGPath;
    
    // 不让闪回去
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    anim.duration = 1;
    
    // 设置动画的代理
    anim.delegate = self;
    
    // 3.添加
    [imgView.layer addAnimation:anim forKey:nil];
    
}

// 核心动画的代理方法
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    // 1.移除图片框
    // - 取出图片框
    UIImageView *imgV = [anim valueForKey:@"imgV"];
    // - 移除核心动画
    [imgV.layer removeAllAnimations];
    
    // - 移除
    [imgV removeFromSuperview];
    _carV.foodList = _model;
    
}
#pragma mark - 移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setupUI{
    foodDetailViewController *vc = [self foodDetailVCWithIndex:_indexpath];
    
    UIPageViewController *pgVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pgVC.dataSource = self;
    
    [pgVC setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    //添加父子控制器
    pgVC.view.backgroundColor = [UIColor grayColor];
    [self addChildViewController:pgVC];
    [self.view addSubview:pgVC.view];
    pgVC.view.bounds = self.view.bounds;
    [pgVC didMoveToParentViewController:self];
    
    //添加购物车视图
    MTShopFoodCarView *carV = [MTShopFoodCarView shopCarView];
    [self.view addSubview:carV];
    [carV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        
    }];
    
    _carV = carV ;
    
}


#pragma Mark pageVC的代理方法

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(foodDetailViewController *)viewController{
    
    NSIndexPath *currentPath = viewController.indexpath;
    NSInteger section = currentPath.section;
    NSInteger row = currentPath.row;
    row -- ;
    if (row < 0) {
        
        // 1.rwo< 0说明当前组的第0个正在显示 -> 上一组的最后一个!
        
        section--;
        if (section < 0) {
            NSLog(@"没有上一个啦!");
            return nil;
        }
        // 上一组的最后一个!
        row = _array[section].spus.count - 1;
        
        
    }

    
    NSIndexPath *newpath = [NSIndexPath indexPathForRow:row inSection:section];
    return  [self foodDetailVCWithIndex:newpath];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(foodDetailViewController *)viewController{
    NSIndexPath *currentPath = viewController.indexpath;
    NSInteger section = currentPath.section;
    NSInteger row = currentPath.row;
    row ++ ;
    
    if (row == _array[section].spus.count) {
        
        // 下一组,第0行
        section++;
        row = 0;
        
        if (section == _array.count) {
            NSLog(@"已经是最后一个啦!"); // 通过SVProgressHUD给用户提示!
            return nil;
        }
    }

    NSIndexPath *newpath = [NSIndexPath indexPathForRow:row inSection:section];
    return  [self foodDetailVCWithIndex:newpath];}

#pragma mark 创建菜单详情控制器的方法
-(foodDetailViewController*) foodDetailVCWithIndex:(NSIndexPath *)index{

    foodDetailViewController *vc =[[foodDetailViewController alloc] init];
    
    vc.foodmodel =  _array[index.section].spus[index.row];
    vc.indexpath = index;
    return  vc;
}


@end
