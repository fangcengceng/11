//
//  MainViewController.m
//  meituan
//
//  Created by codygao on 16/11/1.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "MainViewController.h"
#import "Masonry.h"
#import "MTSopViewController.h"
#import "CZAdditions.h"
#import "MTChanelView.h"
#define kHeaderHeight 128

@interface MainViewController ()<UIGestureRecognizerDelegate,chanelViewDelegate,UIScrollViewDelegate>
@end

@implementation MainViewController{
    UIView *_headerV;
    MTChanelView *_chanelV;
    UIScrollView *_scrollV;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发现";
    
    [self setupUI];
    [self setupGesture];
  

}


//添加手势
-(void)setupGesture{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    pan.delegate = self;
    [self.view addGestureRecognizer: pan];
}
//添加主视图
-(void)setupUI{
    UIView *headerV = [[UIView alloc] init];
    headerV.backgroundColor = [UIColor redColor];
    [self.view addSubview:headerV];
    [headerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(128);
    }];
    _headerV = headerV;
    MTChanelView *channelV = [[MTChanelView alloc] init];
    channelV.delegate = self;
    [self.view addSubview:channelV];
    [channelV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerV.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(35);
    }];
    _chanelV = channelV;
    UIScrollView *scrollV = [self setScrollV];
    scrollV.backgroundColor = [UIColor whiteColor];
    scrollV.delegate = self;
    [self.view addSubview:scrollV];
    [scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(channelV.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    _scrollV = scrollV;
}
//搭建底部的滚动视图
-(UIScrollView*)setScrollV{
    UIScrollView *scrollV = [[UIScrollView alloc] init];
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.bounces = NO;
    scrollV.pagingEnabled = YES;
    
    NSArray *array = @[@"MTSopViewController",@"MTCommanViewController",@"MTInfoViewController"];
    
    //遍历数组，将字符串转化为控制器
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:array.count];
    
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class clz = NSClassFromString(obj);
        UIViewController *vc = [[clz alloc] init];
        NSAssert([vc isKindOfClass:[UIViewController class]], @"%@不存在",obj);
        vc.view.backgroundColor = [UIColor cz_randomColor];
        
        [self addChildViewController:vc];
        
        
        [scrollV addSubview:vc.view];
        
        [vc didMoveToParentViewController:self];
    
        [temp addObject:vc.view];
    }];
    
    [temp mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    [temp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(scrollV);
        make.size.equalTo(scrollV);
        
    }];
    
    return  scrollV;
   
}

//监听手势

-(void)panGesture:(UIPanGestureRecognizer*)recognizer{
    CGPoint p = [recognizer translationInView:self.view];

    //判断x轴方向不改变，y轴方向改变
    if (ABS(p.x) >ABS(p.y)){
        return;
    }
    //重置
    [recognizer setTranslation:CGPointZero inView:self.view];
    //根据顶部视图计算出一个高度
    CGFloat height = p.y + _headerV.bounds.size.height;
    //计算单位透明度的变化量
    CGFloat percent = 1.0/(kHeaderHeight - 64);
    //计算需要的透明度
    CGFloat needAlpha = (height - 64)*percent;
    //需要的alpha
    CGFloat alpha = 1 - needAlpha;
    self.navigationController.navigationBar.alpha = alpha;
    if (height > 128){
        height = 128;
    }
    if (height < 64){
        height = 64;
    }
    
    [_headerV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
    //重写布局子控件
    [self.view layoutIfNeeded];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return  YES;
}
#pragma mark chanelViewDelegate
-(void)chanelViewDidSelectbu:(NSInteger)index{
    CGRect rect = CGRectMake(index*self.view.frame.size.width, 0, self.view.frame.size.width, _scrollV.frame.size.height);
    [_scrollV scrollRectToVisible:rect animated:NO];
}

//底部的scrollView滚动的时候，按钮的索引页改变

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat contentOffX = scrollView.contentOffset.x;
    
    NSInteger index = (contentOffX / scrollView.frame.size.width);

    _chanelV.index = index;
    
}

@end
