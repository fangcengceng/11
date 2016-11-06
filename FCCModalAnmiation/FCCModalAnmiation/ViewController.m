//
//  ViewController.m
//  FCCModalAnmiation
//
//  Created by codygao on 16/10/24.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "FCCModalViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _vcFromStoryboard = NO;

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self presentModalVc];

}

-(void)presentModalVc{
    
    if(!_vcFromStoryboard){
        FCCModalViewController *vc = [[FCCModalViewController alloc] init];
        
        [self presentViewController:vc animated:YES completion:nil];
 
    }else{
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"FCCModalViewController" bundle:nil];
        FCCModalViewController *vc = [sb instantiateInitialViewController];
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    
}



@end
