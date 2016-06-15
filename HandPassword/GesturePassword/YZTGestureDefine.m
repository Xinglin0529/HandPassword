//
//  YZTGestureDefine.m
//  HandPassword
//
//  Created by Dongdong on 16/4/14.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "YZTGestureDefine.h"

/** 选中圆大小比例 */
const CGFloat CoreLockArcWHR = .3f;


/** 选中圆大小的线宽 */
const CGFloat CoreLockArcLineW = 1.0f;





/********************************设置密码********************************/

/** 最低设置密码数目 */
const NSUInteger CoreLockMinItemCount = 4;


/** 设置密码提示文字 */
NSString *const CoreLockPWDTitleFirst = @"绘制解锁图案";



/** 设置密码提示文字：确认 */
NSString *const CoreLockPWDTitleConfirm = @"再次绘制解锁图案";


/** 设置密码提示文字：再次密码不一致 */
NSString *const CoreLockPWDDiffTitle = @"两次密码不一致,请重新设置!";

/** 设置密码提示文字：设置成功 */
NSString *const CoreLockPWSuccessTitle = @"密码设置成功!";


/********************************验证密码********************************/

/** 验证密码：普通提示文字 */
NSString *const CoreLockVerifyNormalTitle = @"请输入原手势密码";


/** 验证密码：密码错误 */
NSString *const CoreLockVerifyErrorPwdTitle = @"输入密码错误";


/** 验证密码：验证成功 */
NSString *const CoreLockVerifySuccesslTitle = @"密码正确";

/********************************修改密码********************************/

/** 修改密码：普通提示文字 */
NSString *const CoreLockModifyNormalTitle = @"请输入旧密码";