//
//  HMAnim.m
//  kw
//
//  Created by codygao on 16/11/1.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "HMAnim.h"
@interface HMAnim()<UIViewControllerAnimatedTransitioning>

@end


@implementation HMAnim
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return  self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    
    
    return  3;
    
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    //获取转场容器
    UIView *containerView= [transitionContext containerView];
    
    //获得目标视图
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.bounds = containerView.frame;
    
    //添加目标视图
    [containerView addSubview:toView];
    
    //动画
    // 1.修改视图的锚点和position!
    toView.layer.anchorPoint = CGPointMake(0.5, 1.5);
    toView.layer.position = CGPointMake(containerView.bounds.size.width * 0.5, containerView.bounds.size.height * 1.5);
    
    // 2.躺着,转动 -90°
    toView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    
    // 3.动画清除所有形变
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        // 3.1 清除形变,动画显示到屏幕上!
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        // 3.2 结束以后,恢复所有的默认值!
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.layer.position = containerView.center;
        
    }];
    

    
    
    
    //[self anim:toView];
    //结束会话
    [transitionContext completeTransition:YES];
    
}


//动画
-(void)anim:(UIView*)view {
    view.layer.anchorPoint = CGPointMake(0.5, 1.5);
    view.layer.position = CGPointMake(view.frame.size.width*0.5, view.frame.size.height*1.5);
    
    view.transform = CGAffineTransformMakeRotation(-M_PI_2);
    
    [UIView animateWithDuration:3 animations:^{
        
        view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        view.layer.position = CGPointMake(view.frame.size.width*0.5, view.frame.size.height*0.5);
        view.layer.anchorPoint = CGPointMake(0.5, 0.5);
    }];
    
    
    
    
}

@end
