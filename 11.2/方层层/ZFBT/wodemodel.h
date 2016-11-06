//
//  wodemodel.h
//  ZFBT
//
//  Created by codygao on 16/11/2.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface wodemodel : NSObject

@property(nonatomic,copy)NSString *icon,*intro,*name;


-(instancetype)initWithdic:(NSDictionary *)dic;
@end
