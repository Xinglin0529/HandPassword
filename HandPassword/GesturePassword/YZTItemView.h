//
//  YZTItemView.h
//  HandPassword
//
//  Created by Dongdong on 16/4/14.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LockItemViewDirect) {
    //正上
    LockItemViewDirecTop=1,
    
    //右上
    LockItemViewDirecRightTop,
    
    //右
    LockItemViewDirecRight,
    
    //右下
    LockItemViewDiretRightBottom,
    
    //下
    LockItemViewDirecBottom,
    
    //左下
    LockItemViewDirecLeftBottom,
    
    //左
    LockItemViewDirecLeft,
    
    //左上
    LockItemViewDirecLeftTop
};

@interface YZTItemView : UIView

/** 是否选中 */
@property (nonatomic, assign) BOOL selected;

/** 方向 */
@property (nonatomic, assign) LockItemViewDirect direct;

@end
