//
//  KWViewController.m
//  kw
//
//  Created by codygao on 16/11/1.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "KWViewController.h"
#import "HMAnim.h"

@interface KWViewController ()


@end

@implementation KWViewController{
    HMAnim *_anim;
}

-(instancetype)init{
    if (self = [super init]){
        self.modalPresentationStyle = UIModalPresentationCustom;
        
        _anim = [[HMAnim alloc] init];
        self.transitioningDelegate = _anim;
    }
    return  self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];

    [self setupUI];

}
-(void)setupUI{
    
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panaction:)];
    
    [self.view addGestureRecognizer:pan];
}

-(void)panaction:(UIPanGestureRecognizer *)pan{
    
    CGPoint p  = [pan translationInView:self.view];
    
    
    CGFloat angel = p.x / self.view.bounds.size.width*M_PI_4;
    
    NSLog(@"%f",angel);
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            //一开始将视图移动到下方
            self.view.layer.anchorPoint = CGPointMake(0.5, 1.5);
            self.view.layer.position = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height*1.5);
        case UIGestureRecognizerStateChanged:
            self.view.transform = CGAffineTransformMakeRotation(angel);
            
            break;
        case UIGestureRecognizerStateEnded:
            
            if (ABS(angel)> 0.29){
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
            break;
        case UIGestureRecognizerStateFailed:
            
        case UIGestureRecognizerStateCancelled:
        { [UIView animateWithDuration:0.5 animations:^{
                
                self.view.transform = CGAffineTransformIdentity;
                
            }completion:^(BOOL finished) {
                
                self.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
                self.view.layer.position = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height*0.5);
                
                
            }];
        }
        
            break;
        default:
            break;
    }
    
    
    
    
    
}


//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//}


@end
