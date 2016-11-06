//
//  FCCSportGPSMapCustomTypeButton.m
//  FCCGudongSport
//
//  Created by codygao on 16/10/25.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "FCCSportGPSMapCustomTypeButton.h"
#import "FCCSportTracking.h"

@implementation FCCSportGPSMapCustomTypeButton

-(void)awakeFromNib{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gpsChagnged:) name:fccsportGPSSignalChangedNotification object:nil];
}

-(void)dealloc{
    
    //注销通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
-(void)gpsChagnged:(NSNotification*)noti{
    
    // 1. 从通知中获取 GPS 强度信号
    FCCSportGPSSignalState state = [noti.object integerValue];
    
    // 2. 根据 state 设置按钮的图像和标题
    NSString *imageName = (_isMapButton) ? @"ic_sport_gps_map_" : @"ic_sport_gps_";
    
    NSString *title;
    
    switch (state) {
        case FCCSportGPSSignalStateDisconnect:
            title = @"  GPS已经断开";
            imageName = [imageName stringByAppendingString:@"disconnect"];
            break;
        case FCCSportGPSSignalStateBad:
            title = @"  请绕开高楼大厦";
            imageName = [imageName stringByAppendingString:@"connect_1"];
            break;
        case FCCSportGPSSignalStateNormal:
            imageName =[imageName stringByAppendingString: @"connect_2"];
            break;
        case FCCSportGPSSignalStateGood:
            imageName = [imageName stringByAppendingString:@"connect_3"];
            break;
    }
    
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    // 根据是否存在标题设置右侧的内容间距
    UIEdgeInsets insets = self.contentEdgeInsets;
    insets.right = (title == nil) ? 4 : 8;
    self.contentEdgeInsets = insets;
    
}


@end
