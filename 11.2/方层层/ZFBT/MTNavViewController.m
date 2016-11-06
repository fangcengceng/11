//
//  MTNavViewController.m
//  meituan
//
//  Created by codygao on 16/11/1.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "MTNavViewController.h"

@interface MTNavViewController ()

@end

@implementation MTNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    
    statusBarView.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar"] forBarMetrics:UIBarMetricsDefault];
    
    
//    self.navigationBar.translucent = NO;
//
//    [self.navigationBar setShadowImage:[[UIImage alloc ] init]];
//    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    
    //    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],
                                                 NSFontAttributeName:[UIFont systemFontOfSize:18]
                                                 
                                                 }];
    
    

}





@end
