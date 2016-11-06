//
//  ViewController.m
//  DownLoadProgress
//
//  Created by codygao on 16/10/29.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ViewController.h"
#import "FCCPainterView.h"

@interface ViewController ()
@property(nonatomic,strong)    FCCPainterView *painterview;

@end

@implementation ViewController{
    UISlider *_slider;
    UIProgressView *_progress;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 80, 100, 30)];
    

    _progress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 40, 100, 30)];
    
    _slider.value = 0;
    
    _slider.minimumValue = 0;
    _slider.maximumValue = 1;
    [_slider addTarget:self action:@selector(valuechanged:) forControlEvents:UIControlEventValueChanged];
    _progress.progress = 0;
    
    [self.view addSubview:_slider];
    [self.view addSubview:_progress];
    
   FCCPainterView  *view= [[FCCPainterView alloc] init];
    view.frame = CGRectInset(self.view.frame, 40, 200);
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    _painterview = view;
    


}

-(void)valuechanged:(UISlider*)sender{
    _progress.progress = sender.value;

    _painterview.progress = sender.value;
   

    
    
}



@end
