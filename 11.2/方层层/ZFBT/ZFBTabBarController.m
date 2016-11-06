//
//  ZFBMainViewController.m
//  01-支付宝
//
//  Created by Chris on 16/7/9.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ZFBTabBarController.h"
#import "MTNavViewController.h"


@interface ZFBTabBarController ()

@end

@implementation ZFBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[UITabBar appearance] setTintColor:[UIColor redColor]];
    
    //支付宝
     UIViewController *homeVC = [self loadControllerWithClsName:@"ZFBHomeViewController" title:@"支付宝" imageName:@"TabBar_HomeBar_Spring" andSelectedImageName:@"TabBar_HomeBar_Spring_Sel"];

    //购物车
    UIViewController *friendsController = [self loadControllerWithClsName:@"ZFBBuyViewController" title:@"购物车" imageName:@"TabBar_buy" andSelectedImageName:@"TabBar_buy_Sel"];
    
    //地图
    UIViewController *mapVC = [self loadControllerWithClsName:@"ZFBFriendViewController" title:@"地图" imageName:@"TabBar_Friends_Spring" andSelectedImageName:@"TabBar_Friends_Spring_Sel"];

    //我的控制器
    UIViewController *mineController = [self loadControllerWithClsName:@"ZFBAssertViewController" title:@"我的" imageName:@"TabBar_Assets_Spring" andSelectedImageName:@"TabBar_Assets_Spring_Sel"];
    //把控制器添加到tabBarController上
    self.viewControllers = @[homeVC,friendsController,mapVC,mineController];

    [self addChildViewController:[self loadControllerWithClsName:@"ZFBAssertViewController" title:@"我的" imageName:@"TabBar_Assets_Spring" andSelectedImageName:@"TabBar_Assets_Spring_Sel"]];
    
}
- (UIViewController *)loadControllerWithStoryboard:(NSString *)storyboardName title:(NSString *)title imageNmae:(NSString *)imageName andSelectedImageName:(NSString *)sImageName{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    
    UIViewController *controller = [storyboard instantiateInitialViewController];
    
    return [self setupController:controller title:title imageName:imageName];

}
- (UIViewController *)loadControllerWithClsName:(NSString *)className title:(NSString *)title imageName:(NSString *)imageName andSelectedImageName:(NSString *)sImageName{
    //根据传入的类名创建生成一个类型
    Class clz = NSClassFromString(className);
    
    //根据类型，创建一个对象
    UIViewController *controller = [[clz alloc]init];
    
    return [self setupController:controller title:title imageName:imageName];
}

- (UIViewController *)setupController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)imageName{
    //设置控制器的tabBarItem文字
    controller.tabBarItem.title = title;
    //设置控制器的tabBar图片
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
      controller.tabBarItem.selectedImage =[[UIImage imageNamed:[NSString stringWithFormat:@"%@_Sel",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
    //创建一个导航控制器，并设置它的根控制器
    MTNavViewController *navController = [[MTNavViewController alloc]initWithRootViewController:controller];
    //返回一个导航控制器
    return navController;
}

@end
