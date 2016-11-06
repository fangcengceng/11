//
//  ViewController.m
//  DrawBoard
//
//  Created by codygao on 16/10/28.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ViewController.h"
#import "PaintView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet PaintView *paintView;

@end

@implementation ViewController

//画笔宽度
- (IBAction)sliderValueChanged:(UISlider *)sender {
    _paintView.lineWidth = sender.value;
    
}

//保存图片

- (IBAction)savePictureButton:(UIButton *)sender {
    //截取图片
    //1、开启图片上下文,这个范围就是截图的范围
    UIGraphicsBeginImageContextWithOptions(self.paintView.frame.size, YES, 0);
    
    [self.paintView drawViewHierarchyInRect:self.paintView.bounds afterScreenUpdates:YES];
//    2、获取上下文中的图片
    UIImage *image =  UIGraphicsGetImageFromCurrentImageContext();
    //3、关闭上下文
    UIGraphicsEndImageContext();
   //保存到相册
    UIImageWriteToSavedPhotosAlbum(image, self, nil, @"huaban");
    
    
}



//画笔颜色
- (IBAction)colorButton:(UIButton *)sender {
    
    _paintView.bezierPath.color = sender.backgroundColor;
    
    _paintView.color = sender.backgroundColor;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //截取图片
    //1、开启图片上下文,这个范围就是截图的范围
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, YES, 0);
    
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
    //    2、获取上下文中的图片
    UIImage *image =  UIGraphicsGetImageFromCurrentImageContext();
    //3、关闭上下文
    UIGraphicsEndImageContext();
    //保存到相册
    UIImageWriteToSavedPhotosAlbum(image, self, nil, @"huaban");
    

}


@end
