//
//  ViewController.m
//  kuwo
//
//  Created by codygao on 16/10/30.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ModalViewController *vc = [[ModalViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
    
    
    
}


@end
