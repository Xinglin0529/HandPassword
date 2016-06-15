//
//  YZTLockView.h
//  HandPassword
//
//  Created by Dongdong on 16/4/21.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZTLockViewController.h"

@interface YZTLockView : UIView

/*****************************设置密码****************************/

/** 开始输入，第一次 */
@property (nonatomic, copy) void (^setPWBeginBlock)();

/** 开始输入，确认密码*/
@property (nonatomic, copy) void (^setPWConfirmlock)();

/** 设置密码出错：长度不够 */
@property (nonatomic, copy) void (^setPWSErrorLengthTooShortBlock)(NSUInteger currentCount);

/** 设置密码出错：再次密码不一致 */
@property (nonatomic, copy) void (^setPWSErrorTwiceDiffBlock)(NSString *pwd1,NSString *pwdNow);

/** 设置密码：第一次输入正确*/
@property (nonatomic, copy) void (^setPWFirstRightBlock)(NSString *pwd);

/** 再次密码输入一致 */
@property (nonatomic, copy) void (^setPWTwiceSameBlock)(NSString *pwd);

/*****************************重设密码****************************/

-(void)resetPwd;

/*****************************验证密码****************************/

/** 验证密码开始*/
@property (nonatomic, copy) void (^verifyPWBeginBlock)();

/** 验证密码 */
@property (nonatomic, copy) BOOL (^verifyPwdBlock)(NSString *pwd);

/*****************************修改密码****************************/

/** 再次密码输入一致 */
@property (nonatomic, copy) void (^modifyPwdBlock)();


/** 密码修改成功 */
@property (nonatomic, copy) void (^modifyPwdSuccessBlock)();

@property (nonatomic, assign) CoreLockType coreLockType;

@end
