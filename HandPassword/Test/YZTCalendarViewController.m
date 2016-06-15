//
//  YZTCalendarViewController.m
//  HandPassword
//
//  Created by Dongdong on 16/5/5.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "YZTCalendarViewController.h"
#import "YZTCalendarTopCell.h"
#import "YZTCalendarBottomCell.h"
#import "YZTCalendarModel.h"
#import <Masonry/Masonry.h>
#import "UITableView+FDTemplateLayoutCell.h"
#import "YZTGestureDefine.h"
#import <YYKit.h>
@interface YZTCalendarViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <YZTCalendarModel *> *rowData;
@end

@implementation YZTCalendarViewController

static NSString *const kYZTCalendarTopCell = @"YZTCalendarTopCell";
static NSString *const kYZTCalendarBottomCell = @"YZTCalendarBottomCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.rowData = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    for (int i = 0; i < 10; i++) {
        YZTCalendarModel *model = [YZTCalendarModel new];
        model.time = @"15:15\n已公布";
        model.currentValue = @"50.8";
        model.previousValue = @"51.3";
        model.forecastValue = @"--";
        if (i % 2 == 0) {
            model.content = @"你好你好你好你好你好好你好你好111";
        } else {
            model.content = @"你你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好111";
        }
        [self.rowData addObject:model];
    }

    self.tableView.fd_debugLogEnabled = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [YZTCalendarTopCell cellHeight:self.rowData[indexPath.row]];
//        return [tableView fd_heightForCellWithIdentifier:kYZTCalendarTopCell cacheByIndexPath:indexPath configuration:^(id cell) {
//            [(YZTCalendarTopCell *)cell configCellWithData:self.rowData[indexPath.section]];
//        }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rowData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 62.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self tableHeaderView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZTCalendarTopCell *cell = [tableView dequeueReusableCellWithIdentifier:kYZTCalendarTopCell];
    cell.backgroundColor = tableView.backgroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configCellWithData:self.rowData[indexPath.row]];
    return cell;
}

- (void)segmentControlSelectedAtIndex:(UISegmentedControl *)seg
{
    NSLog(@"selectedIndex = %ld",(long)seg.selectedSegmentIndex);
}

- (UIView *)tableHeaderView
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 62.f)];
    v.backgroundColor = self.tableView.backgroundColor;
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"全球",@"A股",@"日历"]];
    [seg setSelectedSegmentIndex:0];
    [seg addTarget:self action:@selector(segmentControlSelectedAtIndex:) forControlEvents:UIControlEventValueChanged];
    [v addSubview:seg];
    [seg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(v).insets(UIEdgeInsetsMake(15.f, 10.f, 15.f, 10.f));
    }];
    return v;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor colorWithRGB:0xefeff4];
        [_tableView registerClass:[YZTCalendarTopCell class] forCellReuseIdentifier:kYZTCalendarTopCell];
    }
    return _tableView;
}

@end
