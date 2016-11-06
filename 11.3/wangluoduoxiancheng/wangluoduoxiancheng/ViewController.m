//
//  ViewController.m
//  wangluoduoxiancheng
//
//  Created by codygao on 16/11/5.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//根视图
@property(nonatomic,strong)UIScrollView *scrollV;

//图片
@property(nonatomic,strong)UIImageView *imgV;

@end

@implementation ViewController

-(void)loadView{
    [super loadView];
    self.scrollV = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.view = self.scrollV;
    
    self.imgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _imgV.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imgV];
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelectorInBackground:@selector(demo) withObject:nil];
    
//}
}

-(void)demo{
    
    NSURL *url = [NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/pic/item/c995d143ad4bd1130c0ee8e55eafa40f4afb0521.jpg"];
    NSData  *data = [NSData dataWithContentsOfURL:url];
    
   UIImage *img =  [UIImage imageWithData:data];
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:img waitUntilDone:NO];

    
}
-(void)updateUI:(UIImage*)imge{
    
    self.imgV.image = imge;
    
    self.scrollV.contentSize = imge.size;
    
}

@end
