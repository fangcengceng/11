//
//  FCCTransitionAnimation.m
//  FCCModalAnmiation
//
//  Created by codygao on 16/10/24.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "FCCTransitionAnimation.h"

@interface FCCTransitionAnimation ()<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

@end

@implementation FCCTransitionAnimation{
    BOOL _isPresented;
    __weak id <UIViewControllerContextTransitioning> _transitionContext;
}


//
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
 
    _isPresented = YES;
    return  self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
 
    _isPresented = NO;
    return  self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    _transitionContext = transitionContext;
    return  2;
}

//modal动画的方式
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
//    1、获取容器视图
    UIView *containerView = [transitionContext containerView];
    //2、获取目标视图
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *view = _isPresented? toView : fromView;
    //将目标视图添加到容器视图上
    if (_isPresented){
        [containerView addSubview:view];
    }
    
    //  4 、动画
    [self transitionAnim:view];
    


    
    
}

//动画完成之后调用
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    //5、结束转场
    [_transitionContext completeTransition:YES];
}


//转场动画

-(void)transitionAnim:(UIView*)view{
    

        CGFloat screenWidth = view.frame.size.width;
        //
        CGFloat screenHeight = view.frame.size.height;
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        
        CGFloat rightmargin = 16;
       CGFloat topMargin = 28;
        //矩形宽度
        CGFloat radius = 30;
        
        CGRect rect = CGRectMake(screenWidth - radius-rightmargin, topMargin, radius, radius);
        
        UIBezierPath *beginpath = [UIBezierPath bezierPathWithOvalInRect:rect];
        
        //绘制开始路径
        layer.path = beginpath.CGPath;

        //利用勾股定理计算绘制路径的终点位置
        CGFloat maxRadius = sqrt(screenWidth*screenWidth + screenHeight*screenHeight);
        
        UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(rect, -maxRadius, -maxRadius)];
    
        view.layer.mask = layer;
     //动画方式,layer不能用块动画
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.duration = [self transitionDuration:_transitionContext];
    
    // 判断是否是展现
    if (_isPresented) {
        anim.fromValue = (__bridge id _Nullable)(beginpath.CGPath);
        anim.toValue = (__bridge id _Nullable)(endPath.CGPath);
    } else {
        anim.fromValue = (__bridge id _Nullable)(endPath.CGPath);
        anim.toValue = (__bridge id _Nullable)(beginpath.CGPath);
    }
    
        anim.fillMode = kCAFillModeForwards;
        anim.removedOnCompletion = NO;
    
         anim.delegate = self;
        [layer addAnimation:anim forKey:nil];
        
    
    
}

@end
