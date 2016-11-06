//
//  ViewController.m
//  popVIew
//
//  Created by codygao on 16/11/1.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ViewController.h"
#import "popViewController.h"

@interface ViewController ()<UIPopoverPresentationControllerDelegate>

@end

@implementation ViewController{
    UIButton *_bu1;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [bu sizeToFit];
    bu.center = self.view.center;
    
    UIButton *bu1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    bu1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:bu1];
    _bu1 = bu1;
    
    [bu addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bu];

}

-(void)click:(UIButton*)bu{
    popViewController *vc = [[popViewController alloc] init];
    //设置代理(必须设置，不然以普通样式展示)
    vc.popoverPresentationController.delegate = self;
    vc.popoverPresentationController.sourceView = bu;
    //指定弹窗大小
    vc.preferredContentSize = CGSizeMake(120, 40);
    //设置箭头朝上
    vc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    //设置箭头的位置
    CGSize size = bu.bounds.size;
    vc.popoverPresentationController.sourceRect =  CGRectMake(size.width*0.5, size.height, 0, 0);
    //设置绕开控件，同一时间只能模态展现一个控制器
    vc.popoverPresentationController.passthroughViews = @[_bu1];
    //present
    [self presentViewController:vc animated:YES completion:nil];
}
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    //不适用系统默认的样式
    return  UIModalPresentationNone;
}

@end
