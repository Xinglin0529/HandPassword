//
//  SubviewController.m
//  HandPassword
//
//  Created by Dongdong on 16/4/29.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "SubviewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
#import "XDSegmentedControl.h"
#import "YZTGestureDefine.h"
#import <Static/RedView.h>
#import <Masonry/Masonry.h>

@interface SubviewController () <UIScrollViewDelegate>

@property (nonatomic, strong) XDSegmentedControl *segmentedControl;
@property (nonatomic, strong) UILabel *l;
@end

@implementation SubviewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.segmentedControl = [[XDSegmentedControl alloc] init];
    self.segmentedControl.frame = CGRectMake(0, 100, kScreenWidth, 44);
    self.segmentedControl.titles = @[@"小明",@"小亮",@"小白"];
//    [self.view addSubview:self.segmentedControl];
    
    
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.delegate = self;
    scroll.frame = CGRectMake(0, 200, kScreenWidth, 44);
    scroll.contentSize = CGSizeMake(kScreenWidth * self.segmentedControl.titles.count, 44);
    scroll.pagingEnabled = YES;
    scroll.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:scroll];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"tttttt" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    NSAttributedString *(^attributeString)(NSString *text) = ^NSAttributedString *(NSString *text) {
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        NSMutableAttributedString *a = [[NSMutableAttributedString alloc] initWithString:text];
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineSpacing = 5;
        [a addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, a.length)];
        [a addAttributes:attribute range:NSMakeRange(0, a.length)];
        return a;
    };
    
    UILabel *l = [[UILabel alloc] init];
    l.attributedText = attributeString(@"你好你好你好你好你好\n你好你好你好你好你好你\n好你好你好你好你好你好你好你\n好你好你好你好你好你好你好\n你好你好你好你好你好你好你好\n你好你好你好你好你好你好你好你");
    l.textAlignment = NSTextAlignmentLeft;
    l.font = [UIFont systemFontOfSize:14];
    l.lineBreakMode = NSLineBreakByCharWrapping;
    l.numberOfLines = 0;
    self.l = l;
    [self.view addSubview:l];
    
    [l mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@10);
        make.trailing.equalTo(@-10);
        make.top.equalTo(self.mas_topLayoutGuide);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@-0);
        make.top.equalTo(l.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    RedView *r = [[RedView alloc] initWithFrame:CGRectMake(0, 300, 60, 60)];
    [[UIApplication sharedApplication].keyWindow addSubview:r];
}

- (void)btnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (!btn.selected) {
        self.l.numberOfLines = 0;
    } else {
        self.l.numberOfLines = 5;
    }
    [self.view setNeedsLayout];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"height = %f",self.l.frame.size.height);
    });
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollView = %f",scrollView.contentOffset.x);
    CGFloat ratio = scrollView.contentOffset.x / scrollView.contentSize.width;
    [self.segmentedControl segmentedControlScrollIndicatorToIndex:(NSInteger)scrollView.contentOffset.x/kScreenWidth delta:ratio];
}


@end