//
//  ViewController.m
//  shakeAnim
//
//  Created by codygao on 16/10/30.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ViewController.h"
#import "shakeCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *shakeButton;

@end

@implementation ViewController{
    UICollectionView *_view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];

}
- (IBAction)shake:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString: @"shake"]){
        [self startShake];
        [sender setTitle:@"tingzhi" forState:UIControlStateNormal];
        return;
    }
    if ([sender.titleLabel.text isEqualToString: @"tingzhi"]){
        [sender setTitle:@"shake" forState:UIControlStateNormal];
        [self stopShake];
    }
    
}

-(void)stopShake{
    
    [_view.visibleCells enumerateObjectsUsingBlock:^(__kindof UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.layer removeAllAnimations];
        
    }];
    _view.scrollEnabled = YES;
    
}

-(void)startShake{
    //开始抖动时将collectionView的抖动设置为不可滚动
    _view.scrollEnabled= NO;
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.values = @[@(M_PI_4),@(-M_PI_4),@(M_PI_4)];
    
    [_view.visibleCells enumerateObjectsUsingBlock:^(__kindof UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        anim.duration = 3;
        anim.repeatCount = CGFLOAT_MAX;
        [obj.layer addAnimation:anim forKey:nil];
    }];
    
    
}


-(void)setupUI{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(50, 50);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 20;
    UICollectionView *view = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [view registerClass:[shakeCollectionViewCell class] forCellWithReuseIdentifier:@"shake_cell"];
    view.dataSource = self;
    [self.view addSubview:view];
    _view = view;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  100;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    shakeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shake_cell" forIndexPath:indexPath];
    
    return cell;
}
@end
