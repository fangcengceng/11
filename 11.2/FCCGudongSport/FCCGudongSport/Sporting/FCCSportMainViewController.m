//
//  FCCSportSportingViewController.m
//  FCCGudongSport
//
//  Created by codygao on 16/10/21.
//  Copyright © 2016年 HM. All rights reserved.
//




#import "FCCSportMainViewController.h"
#import "FCCSportSportingViewController.h"
#import "FCCSportTracking.h"



@interface FCCSportMainViewController ()

@end

@implementation FCCSportMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)sporting:(UIButton *)sender {
    //给运动模型枚举赋值
    FCCSportingType type = sender.tag;

    //从storyboard中加载
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"FCCSportSporting" bundle:nil];
    
    
    FCCSportSportingViewController *vc = [sb instantiateInitialViewController];
    vc.sportType = type - 1;
    [self presentViewController:vc animated:YES completion:nil];

    
}



@end
