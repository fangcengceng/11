//
//  ViewController.m
//  11.1
//
//  Created by codygao on 16/11/1.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ViewController.h"
#import "TwoViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    UILabel *_l;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:label];
    _l = label;


}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    TwoViewController *two = [[TwoViewController alloc] init];
    two.myblock = ^(NSDictionary* str){
        _l.text = [str[@"name"] stringByAppendingString:str[@"text"]];
        
    };
    
    [self presentViewController:two animated:YES completion:nil];
    
}

@end
