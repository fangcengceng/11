//
//  FCCSportSpeaker.m
//  FCCGudongSport
//
//  Created by codygao on 16/10/29.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "FCCSportSpeaker.h"
#import <AVFoundation/AVFoundation.h>

@implementation FCCSportSpeaker{
    NSString *_typeString;
    //记录上次播报距离
    double _lastReportDistance;
    //语音合成器
//    AVSpeechSynthesizer *_speechSynthesizer;
    //声音字典
    NSDictionary *_voicedic;
    //语音播放器
    AVPlayer *_voicePlayer;
    
    //语音键值数组
    NSMutableArray *_voiceArray;
}

-(instancetype)init{
    if (self = [super init]){
        _unitDistance = 0.05;
        _lastReportDistance = 0;
//        _speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
        //加载json生成字典
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"voice.json" withExtension:nil subdirectory:@"voice.bundle"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        //反序列化
        _voicedic =[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        _voicePlayer = [[AVPlayer alloc] init];
        
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playitemDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        
        
    }
    return  self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)startSportWithType:(FCCSportingType)type{
    switch (type) {
        case FCCSportingrun:
            _typeString = @"跑步";
            break;
        case FCCSportingwalk:
            _typeString = @"走路";
            break;
        case FCCSportingbike:
            _typeString = @"骑行";
            break;
       
    }
    
    NSString *text = [@"开始" stringByAppendingString:_typeString];
    
    [self playVoiceWithText:text];
    
    
}

-(void)sportStateChanged:(FCCsportingState)state{
    
    NSString *text;
    switch (state) {
        case FCCsportingStateCancel:
            
            break;
        case FCCsportingStateContinue:
            
            break;
        case FCCsportingStateStop:
            
            break;
        
    }
    [self playVoiceWithText:text];
    
    
}
-(void)reportWithDistance:(double)distance timer:(NSTimeInterval)time speed:(double)speed{
    
    //判断
    if(distance < _lastReportDistance +_unitDistance){
        return;
    }
    
    //记录上次播报的距离
    _lastReportDistance = (NSInteger)(_lastReportDistance/_unitDistance)*_unitDistance;
    
    NSString *fmt = @"你已经 %@ %@ 公里 用时 %@ 平均速度 %@ 公里每小时 太棒了";
    
    NSString *distanceStr = @"0 . 0 5";
    NSString *timeStr = @"3 十 8 秒";
    NSString *speedStr = @"十 5 . 1 6";
    
    NSString *text = [NSString stringWithFormat:fmt, _typeString, distanceStr, timeStr, speedStr];
    
    [self playVoiceWithText:text];

}


-(void)playVoiceWithText:(NSString*)str{
    
    NSArray *array = [str componentsSeparatedByString:@" "];
    _voiceArray = [NSMutableArray arrayWithArray:array];
    [self playFirstVoice];
}

-(void)playFirstVoice{
    if (_voiceArray.count == 0){
        return;
    }

    NSString *key = _voiceArray.firstObject;
    [_voiceArray removeObjectAtIndex:0];

    NSString *mp3 = _voicedic[key];
    
    // 准备 URL
    NSURL *url = [[NSBundle mainBundle] URLForResource:mp3 withExtension:nil subdirectory:@"voice.bundle"];
    if (url == nil){
        [self playFirstVoice];
        return;
    }
    
 
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    [_voicePlayer replaceCurrentItemWithPlayerItem:item];

    [_voicePlayer play];
}


-(void)playitemDidEnd:(NSNotification*)noti{
    [self playFirstVoice];
}

//-(void)speeker{
////    //立即停止没有播放完的声音
////    [_speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
////    
////    //实例化语言
////    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:str];
////    //指定声音
////    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
////    utterance.voice = voice;
////    
////    
////    //朗读语言
////    [_speechSynthesizer speakUtterance:utterance];
//}

@end
