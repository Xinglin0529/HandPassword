//
//  YZTImageContainerView.h
//  HandPassword
//
//  Created by Dongdong on 16/5/13.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YZTImageContainerViewDelegate <NSObject>

- (void)showBigImage:(UIImage *)image;

@end

@interface YZTImageContainerView : UIView

@property (nonatomic, weak) id<YZTImageContainerViewDelegate>delegate;
@property (nonatomic, strong) NSArray<NSString *> *imageUrls;
- (void)setImageWithUrls:(NSArray<NSString *> *)imageUrls indexPath:(NSIndexPath *)indexPath;

@end
