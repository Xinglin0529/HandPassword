//
//  YZTLiveViewController.m
//  HandPassword
//
//  Created by Dongdong on 16/5/4.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "YZTLiveViewController.h"
#import "YZTLiveModel.h"
#import "YZTLiveProgressCell.h"
#import <Masonry/Masonry.h>
#import "YZTGestureDefine.h"
#import <CoreText/CoreText.h>
#import "UITableView+FDTemplateLayoutCell.h"

@interface YZTLiveViewController () <UITableViewDelegate, UITableViewDataSource, YZTLiveProgressCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<YZTLiveModel *> *rowData;
@property (nonatomic, assign) BOOL shouldSendNotification;
@property (nonatomic, strong) NSMutableDictionary *dic1;
@property (nonatomic, strong) NSMutableArray *array2;
@end

@implementation YZTLiveViewController

static NSString *const kYZTLiveProgressCell = @"YZTLiveProgressCell";

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.rowData = [[NSMutableArray alloc] init];
    self.dic1 = [[NSMutableDictionary alloc] init];
    self.array2 = [[NSMutableArray alloc] init];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [NSDate date];
    for (int i = 0; i < 30; i++) {
        YZTLiveModel *model = [YZTLiveModel new];
        model.time = @"15:15";
//        model.date = @"昨天";
        model.isShowAll = NO;
        
        if (i % 2 == 0) {
            model.imageUrls = @[@"http://posts.cdn.wallstcn.com/66/0e/13/437bfb7c39b08736280164acb7defde6.jpg"];
            model.content = @"你好你好你好你好好你好你好你好你好好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你你好你好你好你好你你好你好好你好你好111";
        } else if (i % 3 == 0) {
            model.imageUrls = @[@"http://posts.cdn.wallstcn.com/66/0e/13/437bfb7c39b08736280164acb7defde6.jpg",@"http://posts.cdn.wallstcn.com/66/0e/13/437bfb7c39b08736280164acb7defde6.jpg"];
            model.content = @"你好你好你好你好好你好你好你好你好好你好你好你好你你好你好好你好你好111";
        }
        else {
            model.content = @"你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好111";
        }
        [self.rowData addObject:model];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableHeight:) name:@"refreshTableHeight" object:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat height = [tableView fd_heightForCellWithIdentifier:kYZTLiveProgressCell cacheByIndexPath:indexPath configuration:^(id cell) {
//        [(YZTLiveProgressCell *)cell configCellWithData:self.rowData[indexPath.row] indexPath:indexPath];
//    }];
//    NSLog(@"height =========== %f",height);
//    return height;
//    return [YZTLiveProgressCell cellHeight:self.rowData[indexPath.row]];
    static YZTLiveProgressCell *cell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [self.tableView dequeueReusableCellWithIdentifier:kYZTLiveProgressCell];
    });
    [cell configCellWithData:self.rowData[indexPath.row] indexPath:indexPath];
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rowData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZTLiveProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:kYZTLiveProgressCell];
    cell.backgroundColor = tableView.backgroundColor;
    cell.line01.hidden = indexPath.row == 0;
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configCellWithData:self.rowData[indexPath.row] indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 62.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self tableHeaderView];
}

- (void)refreshTableView:(YZTLiveProgressCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    YZTLiveModel *model = self.rowData[indexPath.row];
    model.isShowAll = !model.isShowAll;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)refreshTableHeight:(NSNotification *)noti
{
    NSIndexPath *indexPath = noti.object;
    NSString *key = [NSString stringWithFormat:@"%ld-%ld",indexPath.section,indexPath.row];
    NSMutableArray *array = self.dic1[key];
    if (!array) {
        array = [[NSMutableArray alloc] init];
        [self.dic1 setObject:array forKey:key];
    }
    if (array.count < 2) {
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [array addObject:indexPath];
        NSLog(@"**********************************刷新cell%ld次",array.count);
    }
}

- (void)showZoomImage:(YZTLiveProgressCell *)cell image:(UIImage *)image
{
    NSLog(@"cell.imageView = %@",image);
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
        [_tableView registerClass:[YZTLiveProgressCell class] forCellReuseIdentifier:kYZTLiveProgressCell];
    }
    return _tableView;
}

@end
