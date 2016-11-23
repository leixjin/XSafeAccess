//
//  XSafeAccessViewController.m
//  XSafeAccess
//
//  Created by xiaolei.jin on 08/16/2016.
//  Copyright (c) 2016 xiaolei.jin. All rights reserved.
//

#import "XSafeAccessViewController.h"

@interface XSafeAccessViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *reasonArray;

@end

@implementation XSafeAccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([self class])];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reasonArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    cell.textLabel.text = self.reasonArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.row) {
        case 0:{
            NSArray *array = @[];
            [array objectAtIndex:98];
        }
            break;
            
        case 1:{
            NSArray *array = @[@"科科"];
            [array objectAtIndex:98];
        }
            break;
            
        case 2:{
            NSMutableArray *arrayM = @[@"科科"].mutableCopy;
            [arrayM objectAtIndex:98];
        }
            break;
        case 3:{
            NSMutableArray *arrayM = @[@"",@""].mutableCopy;
            [arrayM insertObject:@"xxx" atIndex:3];
        }
            break;
        case 4:{
            NSMutableArray *arrayM = @[].mutableCopy;
            [arrayM removeObjectAtIndex:0];
        }
            break;
        case 5:{
            NSMutableArray *arrayM = @[].mutableCopy;
            [arrayM replaceObjectAtIndex:0 withObject:@""];
        }
            break;
            
        default:
            break;
    }
}

- (NSArray *)reasonArray {
    if (!_reasonArray) {
        _reasonArray = @[@"不可变空数组越界", @"不可变数组越界", @"可变数组越界", @"可变数组插入保护", @"可变数组移除保护", @"可变数组替换保护"];
    }
    return _reasonArray;
}

@end
