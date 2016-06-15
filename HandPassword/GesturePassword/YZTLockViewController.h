//
//  YZTLockViewController.h
//  HandPassword
//
//  Created by Dongdong on 16/4/21.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CoreLockType) {
    //设置密码
    CoreLockTypeSetPwd = 0,
    
    //输入并验证密码
    CoreLockTypeVeryfiPwd,
    
    //修改密码
    CoreLockTypeModifyPwd,
    
    //开启手势密码
    CoreLockOpenPwd
};

@interface YZTLockViewController : UIViewController

@property (nonatomic, assign) CoreLockType coreLockType;

@end
