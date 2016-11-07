//
//  FCCModalViewController.m
//  FCCModalAnmiation
//
//  Created by codygao on 16/10/24.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "FCCModalViewController.h"
#import "FCCTransitionAnimation.h"

@interface FCCModalViewController ()

@end

@implementation FCCModalViewController{
    FCCTransitionAnimation *_animation;
}


////支持加载sb
//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    
//    
//    
//}

//支持纯代码
-(instancetype)init{
    if (self = [super init]){
        self.modalPresentationStyle = UIModalPresentationCustom;
        _animation = [[FCCTransitionAnimation alloc] init];
        self.transitioningDelegate = _animation;
    }
    
    return  self;
    
    
}

-(void)viewDidLoad{
    
    [super viewDidLoad ];
    self.view.backgroundColor = [UIColor redColor];
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iPhone-6-Wallpaper"]];
    img.frame = self.view.bounds;
    [self.view addSubview:img];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end
