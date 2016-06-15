//
//  YZTGestureDefine.h
//  HandPassword
//
//  Created by Dongdong on 16/4/14.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define         UICOLORWITHRGB(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

//iphone 4s
#define         kIsIphone4s (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 480)))

//iphone 5
#define         kIsIphone5 (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568)))

// 屏幕总宽
#define         kScreenWidth ([UIScreen mainScreen].bounds.size.width)
// 屏幕总高
#define         kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define kIndicatorBackgroundViewWH 44
#define kMargin 4

/*
 *  背景色
 */
#define CoreLockViewBgColor UICOLORWITHRGB(13,52,89,1)

/*
 *  外环线条颜色：默认
 */
#define CoreLockCircleLineNormalColor UICOLORWITHRGB(200,200,200,1)


/*
 *  外环线条颜色：选中
 */
#define CoreLockCircleLineSelectedColor UICOLORWITHRGB(34,178,246,1)


/*
 *  实心圆
 */
#define CoreLockCircleLineSelectedCircleColor UICOLORWITHRGB(34,178,246,1)


/*
 *  实心圆
 */
#define CoreLockLockLineColor UICOLORWITHRGB(34,178,246,1)


/*
 *  警示文字颜色
 */
#define CoreLockWarnColor UICOLORWITHRGB(254,82,92,1)



/** 选中圆大小比例 */
extern const CGFloat CoreLockArcWHR;



/** 选中圆大小的线宽 */
extern const CGFloat CoreLockArcLineW;




/** 最低设置密码数目 */
extern const NSUInteger CoreLockMinItemCount;



/********************************设置密码********************************/

/** 设置密码提示文字：第一次 */
extern NSString *const CoreLockPWDTitleFirst;


/** 设置密码提示文字：确认 */
extern NSString *const CoreLockPWDTitleConfirm;


/** 设置密码提示文字：再次密码不一致 */
extern NSString *const CoreLockPWDDiffTitle;


/** 设置密码提示文字：设置成功 */
extern NSString *const CoreLockPWSuccessTitle;



/*********************************验证密码*******************************/

/** 验证密码：普通提示文字 */
extern NSString *const CoreLockVerifyNormalTitle;


/** 验证密码：密码错误 */
extern NSString *const CoreLockVerifyErrorPwdTitle;



/** 验证密码：验证成功 */
extern NSString *const CoreLockVerifySuccesslTitle;

/*********************************修改密码********************************/

/** 修改密码：普通提示文字 */
extern NSString *const CoreLockModifyNormalTitle;
