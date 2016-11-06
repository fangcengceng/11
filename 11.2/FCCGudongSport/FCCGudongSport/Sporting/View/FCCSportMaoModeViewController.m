//
//  FCCSportMaoModeViewController.m
//  FCCGudongSport
//
//  Created by codygao on 16/10/25.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "FCCSportMaoModeViewController.h"

@interface FCCSportMaoModeViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *maptypeButton;


@end

@implementation FCCSportMaoModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for(UIButton *bu in _maptypeButton){
      bu.selected = ( _currentMapType == bu.tag);
    }
    
    
}
- (IBAction)didSelectMapType:(UIButton *)sender {
    if (sender.tag == _currentMapType){
        return;
    }
    _currentMapType = sender.tag;
    
    
    if (_didSelecteModeType!= nil){
        
        _didSelecteModeType(_currentMapType);
    }
    
    for (UIButton *bu in _maptypeButton){
        bu.selected = (bu == sender);
    }
     
}




@end
