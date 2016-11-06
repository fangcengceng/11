//
//  ModalViewController.m
//  kuwo
//
//  Created by codygao on 16/10/30.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

-(instancetype)init{
    if (self = [super init]){
//        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor redColor];
    [self setupUI];
}

-(void)setupUI{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    
    [self.view addGestureRecognizer:pan];

}

-(void)gestureAction:(UIPanGestureRecognizer*)recognizer{
    CGPoint point = [recognizer translationInView:recognizer.view];
    NSLog(@"%@",NSStringFromCGPoint(point));
    
    
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            
            break;
        
        case UIGestureRecognizerStateChanged:
            
            break;
        case UIGestureRecognizerStateEnded:
            
            break;
        case UIGestureRecognizerStateFailed:
            
            break;
        case UIGestureRecognizerStateCancelled:
            
            break;
        default:
            break;
    }
    
    
    
    
}





@end
