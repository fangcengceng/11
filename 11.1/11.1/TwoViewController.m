//
//  TwoViewController.m
//  11.1
//
//  Created by codygao on 16/11/1.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController{
    UITextField *_t1;
    UITextField *_t2;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    UITextField *nameT = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, 100, 10)];
    field.backgroundColor = [UIColor redColor];
    nameT.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:field];
    [self.view addSubview:nameT];
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [bu sizeToFit];
    bu.center = self.view.center;

    [self.view addSubview:bu];
    [bu addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    _t1 = nameT;
    _t2 = field;
}

-(void)click:(UIButton*)bu{
    _myblock (@{@"name":_t2.text,@"text":_t1.text});
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
