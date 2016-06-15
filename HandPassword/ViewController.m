//
//  ViewController.m
//  HandPassword
//
//  Created by Dongdong on 16/4/14.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "YZTItemView.h"
#import "YZTLockViewController.h"
#import "YZTGestureDefine.h"
#import "NSObject+Objc.h"
#import <YYKit.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "SubviewController.h"
#import "YZTLiveViewController.h"
#import "YZTCalendarViewController.h"
#import "YZTImportantNewsViewController.h"
#import "TestTableViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) UILabel *footerLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *rowTitles;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSSet *set;

@property (nonatomic, copy) UIView *(^CreateView)(UIColor *bgColor);
@property (nonatomic, strong) UISearchBar *s;
@end

@implementation ViewController

- (UIView *(^)(UIColor *))CreateView
{
    return ^UIView *(UIColor *color) {
        UIView *v = [UIView new];
        v.backgroundColor = color;
        return v;
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rowTitles = @[@"设置手势密码",@"验证手势密码",@"修改手势密码",@"开启手势密码"];

//    NSLog(@"propertyNames =========== %@",self.propertyNames);
//    NSLog(@"methodNames =========== %@",self.methodNames);
//    NSLog(@"ivarNames =========== %@",self.ivarNames);
//    NSLog(@"attributes =========== %@",self.attributes);
    
    SEL sel = NSSelectorFromString(@"setName:");
    ((void (*) (id, SEL, id))objc_msgSend)(self, sel, @"name");
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UISearchBar *s = [[UISearchBar alloc] init];
    s.frame = CGRectMake(0, 0, kScreenWidth, 44);
    s.delegate = self;
    self.tableView.tableHeaderView = s;
    self.s = s;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"收起" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.and.bottom.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    [textField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"--------------%@",x);
    }];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:[NSDate date]];
    
    NSLog(@"***********%ld",components.second);
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}

- (void)close:(id)sender
{
    [self.s resignFirstResponder];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rowTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text = self.rowTitles[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YZTLockViewController *lock = [[YZTLockViewController alloc] init];
    switch (indexPath.row) {
        case 0:
        {
            lock.coreLockType = CoreLockTypeSetPwd;
            [self.navigationController pushViewController:[YZTImportantNewsViewController new] animated:YES];
        }
            break;
        case 1:
        {
            lock.coreLockType = CoreLockTypeVeryfiPwd;
            [self.navigationController pushViewController:[YZTCalendarViewController new] animated:YES];
        }
            break;
        case 2:
        {
            lock.coreLockType = CoreLockTypeModifyPwd;
            [self.navigationController pushViewController:[YZTLiveViewController new] animated:YES];
        }
            break;
        case 3:
        {
            lock.coreLockType = CoreLockOpenPwd;
            [self.navigationController pushViewController:[SubviewController new] animated:YES];
        }
            break;
        default:
            break;
    }
//    [self.navigationController pushViewController:lock animated:YES];
    NSLog(@"name = %@",self.name);
    NSLog(@"screen.scale = %f",1/[UIScreen mainScreen].scale);
    [self customOperation];
}

- (void)customOperation
{
    NSString *url = @"patoa://pingan.com/main?tab=3&age=5";
    NSURLComponents *component = [NSURLComponents componentsWithString:url];
    NSLog(@"component = %@",component);
}

- (UILabel *)footerLabel
{
    if (!_footerLabel) {
        _footerLabel = [[UILabel alloc] init];
        _footerLabel.textAlignment = NSTextAlignmentRight;
        _footerLabel.font = [UIFont systemFontOfSize:14];
        _footerLabel.text = @"defaultTitle";
    }
    return _footerLabel;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
