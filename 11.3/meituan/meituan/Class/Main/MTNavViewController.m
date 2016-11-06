//
//  MTNavViewController.m
//  meituan
//
//  Created by codygao on 16/11/1.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "MTNavViewController.h"
#import "MTNormalController.h"

@interface MTNavViewController ()

@end

@implementation MTNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self.navigationBar setBarTintColor:[UIColor yellowColor]];
//    self.navigationBar.translucent = NO;
//
//    [self.navigationBar setShadowImage:[[UIImage alloc ] init]];
//    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    
    //    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}





@end
