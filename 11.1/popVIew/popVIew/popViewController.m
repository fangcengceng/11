//
//  popViewController.m
//  popVIew
//
//  Created by codygao on 16/11/1.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "popViewController.h"

@interface popViewController ()

@end

@implementation popViewController


-(instancetype)init{
    if (self = [super init]){
        self.modalPresentationStyle = UIModalPresentationPopover;
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];

}




@end
