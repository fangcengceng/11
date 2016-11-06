//
//  ZFBAssertViewController.m
//  ZFBT
//
//  Created by codygao on 16/11/2.
//  Copyright © 2016年 FCC. All rights reserved.
//

#import "ZFBAssertViewController.h"
#import "wodemodel.h"

@interface ZFBAssertViewController ()

@end

@implementation ZFBAssertViewController{
    NSArray<wodemodel*> *_list;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我的";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mode"];
    [self loadData];
    

}

-(void)loadData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MessageSource.json" ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    NSMutableArray *temp = [NSMutableArray array];
    
    for(NSDictionary *dic in array){
        wodemodel *model = [[wodemodel alloc] initWithdic:dic];
        [temp addObject:model];
    }
    
    _list = temp;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mode" forIndexPath:indexPath];
    
    cell.textLabel.text = _list[indexPath.row].name;
    return  cell;
}
@end
