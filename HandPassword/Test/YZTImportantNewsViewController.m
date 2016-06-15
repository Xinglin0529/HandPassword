//
//  YZTImportantViewController.m
//  HandPassword
//
//  Created by Dongdong on 16/5/5.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "YZTImportantNewsViewController.h"
#import <Masonry/Masonry.h>
#import "YZTImportantNewsModel.h"
#import "YZTImportantNewsCell.h"
#import "YZTSpecialCell.h"
#import "YZTSelectStockCell.h"
#import "YZTSelectStockModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "YZTGestureDefine.h"

@interface YZTImportantNewsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <YZTSelectStockModel *> *rowData;
@property (nonatomic, strong) YZTSelectStockCell *stockCell;
@end

@implementation YZTImportantNewsViewController

static NSString *const kYZTImportantNewsCell = @"YZTImportantNewsCell";
static NSString *const kYZTSpecialCell = @"YZTSpecialCell";
static NSString *const kYZTSelectStockCell = @"YZTSelectStockCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.rowData = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    for (int i = 0; i < 20; i++) {
        YZTSelectStockModel *model = [YZTSelectStockModel new];
        model.content = @"你好你好你好你好你好你好你好你你好你好你好你你好你好你好你你好你好你好你你好你好你好你你好你好你好你好你好你好你好你好111111";
        model.date = @"05月05日 15:15:24";
        model.know = @"追热点|事件驱动策略";
        if (i % 2 == 0) {
            model.relates = @[@"鲁阳节能",@"太阳鸟"];
        }
        [self.rowData addObject:model];
    }
    
    
    self.stockCell = [self.tableView dequeueReusableCellWithIdentifier:kYZTSelectStockCell];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.rowData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:kYZTSelectStockCell cacheByIndexPath:indexPath configuration:^(id cell) {
        [(YZTSelectStockCell *)cell configCellWithData:self.rowData[indexPath.section]];
    }];
//    return [YZTSelectStockCell cellHeight:self.rowData[indexPath.section]];
//    YZTSelectStockCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kYZTSelectStockCell];
//    [cell configCellWithData:self.rowData[indexPath.section]];
//    [cell setNeedsUpdateConstraints];
//    [cell updateConstraintsIfNeeded];
//    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    return size.height + 1.f;
    
//    static YZTSelectStockCell *cell = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        cell = [self.tableView dequeueReusableCellWithIdentifier:kYZTSelectStockCell];
//    });
//    [cell configCellWithData:self.rowData[indexPath.row]];
//    [cell setNeedsLayout];
//    [cell layoutIfNeeded];
//    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    return size.height + 1.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZTSelectStockCell *cell = [tableView dequeueReusableCellWithIdentifier:kYZTSelectStockCell];
    cell.backgroundColor = tableView.backgroundColor;
    [cell configCellWithData:self.rowData[indexPath.section]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[YZTSelectStockCell class] forCellReuseIdentifier:kYZTSelectStockCell];
    }
    return _tableView;
}

@end
