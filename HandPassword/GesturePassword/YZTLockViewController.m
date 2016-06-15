//
//  YZTLockViewController.m
//  HandPassword
//
//  Created by Dongdong on 16/4/21.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "YZTLockViewController.h"
#import "YZTGestureDefine.h"
#import "YZTLockView.h"
#import "YZTLockCircleView.h"
#import "CALayer+Shake.h"
#import <Masonry.h>

@interface YZTLockLabel : UILabel

/*
 *  普通提示信息
 */
-(void)showNormalMsg:(NSString *)msg;

/*
 *  警示信息
 */
-(void)showWarnMsg:(NSString *)msg;

@end

@implementation YZTLockLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self viewPrepare];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self viewPrepare];
    }
    return self;
}

- (void)viewPrepare
{
    self.font = [UIFont systemFontOfSize:14.0f];
}

- (void)showNormalMsg:(NSString *)msg
{
    self.text = msg;
    self.textColor = CoreLockCircleLineNormalColor;
}

- (void)showWarnMsg:(NSString *)msg
{
    self.text = msg;
    self.textColor = [UIColor redColor];
    
    [self.layer shake];
}

@end

@interface YZTLockViewController ()

@property (nonatomic, strong) UIImageView *imgBg;
@property (nonatomic, strong) NSMutableArray<YZTLockCircleView *> *infoViews;//圆形指示数组
@property (nonatomic, strong) UILabel *welcomeLabel;//欢迎label
@property (nonatomic, strong) UILabel *userPhoneNumber;//手机号
@property (nonatomic, strong) YZTLockLabel *lockLabel;//提示label
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) YZTLockView *lockView;
@property (nonatomic, assign) NSInteger errorMaxCount;//密码错误次数
@property (nonatomic, assign) BOOL isSetNewPwd;
@property (nonatomic, strong) NSString *modifyCurrentTitle;//提示label的标题文字
@property (nonatomic, assign) CGFloat labelY;

@end

@implementation YZTLockViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildSubviews];
    [self event];
}

- (void)buildSubviews
{
    [self setupClockView];
    [self setNavigationItemTitle];
    [self setupLockViewTipLabel];
    if (self.coreLockType == CoreLockTypeSetPwd) {
        [self setupLockIndicatorView];
    }
    if (self.coreLockType == CoreLockTypeVeryfiPwd) {
        [self setupUserHeaderImage];
    }
}

- (void)setupUserHeaderImage
{
    UIImageView *head = [[UIImageView alloc] init];
    head.backgroundColor = [UIColor yellowColor];
    head.layer.cornerRadius = 64 / 2;
    head.clipsToBounds = YES;
    [self.view addSubview:head];
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(64, 64));
        make.bottom.equalTo(self.lockView.mas_top).offset(20);
    }];
}

//更改导航栏标题
- (void)setNavigationItemTitle
{
    NSString * title;
    switch (self.coreLockType) {
        case CoreLockTypeSetPwd:
        {
            title = @"设置手势密码";
        }
            break;
        case CoreLockTypeModifyPwd:
        {
            title = @"修改手势密码";
        }
            break;
        case CoreLockTypeVeryfiPwd:
        {
            title = @"登录";
        }
            break;
        default:
            break;
    }
    self.title = title;
}

//设置提示label
- (void)setupLockViewTipLabel
{
    switch (self.coreLockType) {
        case CoreLockTypeSetPwd:
        {
            self.modifyCurrentTitle = CoreLockPWDTitleFirst;
        }
            break;
        case CoreLockTypeModifyPwd:
        {
            self.modifyCurrentTitle = CoreLockVerifyNormalTitle;
        }
            break;
        case CoreLockTypeVeryfiPwd:
        {
            self.modifyCurrentTitle = @"";
        }
            break;
        default:
            break;
    }
    self.lockLabel = [[YZTLockLabel alloc]init];
    self.lockLabel.textColor = CoreLockCircleLineNormalColor;
    self.lockLabel.textAlignment = NSTextAlignmentCenter;
    self.lockLabel.font = [UIFont systemFontOfSize:14.0f];
    self.lockLabel.text = self.modifyCurrentTitle;
    [self.view addSubview:self.lockLabel];
    [self.lockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@10);
        make.trailing.equalTo(@-10);
        make.height.equalTo(@14);
        make.bottom.equalTo(self.lockView.mas_top).offset(40);
    }];
}

- (void)setupLockIndicatorView
{
    //圆形指示
    UIView * bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kIndicatorBackgroundViewWH, kIndicatorBackgroundViewWH));
        make.bottom.equalTo(self.lockView.mas_top);
    }];
    self.infoViews = [[NSMutableArray alloc] init];
    CGFloat singWH = (kIndicatorBackgroundViewWH-kMargin*2)/3;
    for (int i = 0; i < 9; i++) {
        YZTLockCircleView * infoView = [[YZTLockCircleView alloc] initWithFrame:CGRectMake(0, 0, singWH, singWH)];
        [bgView addSubview:infoView];
        [self.infoViews addObject:infoView];
        [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(@((singWH+kMargin) * (i % 3)));
            make.top.equalTo(@((singWH+kMargin)*(i/3)));
        }];
    }
}

- (void)updateCircleColor:(NSString *)indexs
{
    NSMutableArray * a = [[NSMutableArray alloc] init];
    for (int i = 0; i < indexs.length; i++) {
        [a addObject:[indexs substringWithRange:NSMakeRange(i, 1)]];
    }
    for (int j = 0; j < a.count; j++) {
        int m= [a[j] intValue];
        for (int k = 0; k < self.infoViews.count; k++) {
            if (m == k) {
                YZTLockCircleView * info = self.infoViews[k];
                info.selected = YES;
            }
        }
    }
}
- (void)clear
{
    for (YZTLockCircleView * info in self.infoViews) {
        info.selected = NO;
    }
}

- (void)setupClockView
{
    YZTLockView * lockView = [[YZTLockView alloc]initWithFrame:CGRectZero];
    lockView.backgroundColor = [UIColor clearColor];
    lockView.coreLockType = self.coreLockType;
    self.lockView = lockView;
    [self.view addSubview:lockView];
    [lockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(32);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenWidth));
    }];
}

+ (BOOL)hasPwd
{
    NSString *pwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    return pwd !=nil;
}

- (void)event
{
    __weak typeof(self) weakself = self;
    /*
     *  设置密码
     */
    /** 开始输入：第一次 */
    self.lockView.setPWBeginBlock = ^() {
        [weakself.lockLabel showNormalMsg:CoreLockPWDTitleFirst];
    };
    
    /** 开始输入：确认 */
    self.lockView.setPWConfirmlock = ^() {
        [weakself.lockLabel showNormalMsg:CoreLockPWDTitleConfirm];
    };
    
    /** 密码长度不够 */
    self.lockView.setPWSErrorLengthTooShortBlock = ^(NSUInteger currentCount) {
        [weakself.lockLabel showWarnMsg:[NSString stringWithFormat:@"密码位数不足%@位,请重新输入!",@(CoreLockMinItemCount)]];
        
    };
    
    /** 两次密码不一致 */
    self.lockView.setPWSErrorTwiceDiffBlock = ^(NSString *pwd1,NSString *pwdNow) {
        
        [weakself.lockLabel showWarnMsg:CoreLockPWDDiffTitle];
        
    };
    
    /** 第一次输入密码：正确 */
    self.lockView.setPWFirstRightBlock = ^( NSString *pwd) {
        /**
         *  此处更新密码指示
         */
        [weakself updateCircleColor:pwd];
        [weakself.lockLabel showNormalMsg:CoreLockPWDTitleConfirm];
    };
    
    /** 再次输入密码一致 */
    self.lockView.setPWTwiceSameBlock = ^(NSString *pwd) {
        
        [weakself.lockLabel showNormalMsg:CoreLockPWSuccessTitle];
        
        //存储密码
        [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:@"password"];
        
        //禁用交互
        weakself.view.userInteractionEnabled = NO;
        
        if (weakself.coreLockType == CoreLockTypeSetPwd) {
            
        }
        [weakself exitCurrentViewController];
    };
    
    /*
     *  验证密码
     */
    
    /** 开始 */
    self.lockView.verifyPWBeginBlock = ^() {
        
        [weakself.lockLabel showNormalMsg:CoreLockVerifyNormalTitle];
    };
    
    /** 验证 */
    self.lockView.verifyPwdBlock = ^(NSString *pwd) {
        
        //取出本地密码
        NSString *pwdLocal = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
        
        BOOL res = [pwdLocal isEqualToString:pwd];
        
        if(res){//密码一致
            
            weakself.errorMaxCount = 0;
            
            
            if(CoreLockTypeVeryfiPwd == _coreLockType) {
                [weakself.lockLabel showNormalMsg:CoreLockVerifySuccesslTitle];
                //密码验证成功
                [weakself exitCurrentViewController];
            }
            
            if (CoreLockTypeModifyPwd == _coreLockType) {
                //修改密码
                YZTLockViewController *lock = [[YZTLockViewController alloc] init];
                lock.coreLockType = CoreLockTypeSetPwd;
                [weakself.navigationController pushViewController:lock animated:YES];
            }
            
        } else {//密码不一致
            
            [weakself.lockLabel showWarnMsg:CoreLockVerifyErrorPwdTitle];
            
            weakself.errorMaxCount ++;
            
            [weakself.lockLabel showWarnMsg:[NSString stringWithFormat:@"密码错误，还可以再输入%d次",(5 - (int)self.errorMaxCount)]];
            
            if (weakself.errorMaxCount == 5) {
                weakself.view.userInteractionEnabled = NO;
                weakself.errorMaxCount = 0;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakself deleteHandPassWord];
                });
            }
        }
        return res;
    };
    
    /*
     *  修改
     */
    
    /** 开始 */
    self.lockView.modifyPwdBlock = ^() {
        [weakself.lockLabel showNormalMsg:weakself.modifyCurrentTitle];
    };
}

- (void)deleteHandPassWord
{
    //清除手势密码
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
}

- (void)exitCurrentViewController
{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
