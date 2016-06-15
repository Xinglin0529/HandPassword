//
//  YZTImageContainerView.m
//  HandPassword
//
//  Created by Dongdong on 16/5/13.
//  Copyright © 2016年 Dongdong. All rights reserved.
//

#import "YZTImageContainerView.h"
#import <Masonry/Masonry.h>
#import <YYWebImageManager.h>
#import "YZTGestureDefine.h"

#define kYZTMaxImageWidth (kScreenWidth - 10.f * 2 - 40.f - 3 * 5.f)
#define kYZTDefaultImageHeight  100.f

@interface YZTImageContainerView ()

@property (nonatomic, strong) NSMutableArray<UIImageView *> *ivList;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end

@implementation YZTImageContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self yzt_setupSubviews];
    }
    return self;
}

- (void)setImageWithUrls:(NSArray<NSString *> *)imageUrls indexPath:(NSIndexPath *)indexPath
{
    self.imageUrls = imageUrls;
    self.currentIndexPath = indexPath;
}

- (void)setImageUrls:(NSArray<NSString *> *)imageUrls
{
    _imageUrls = imageUrls;
    
    for (UIImageView *imageView in self.ivList) {
        imageView.hidden = YES;
    }
    
    if (imageUrls.count == 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@0);
            make.height.mas_equalTo(@0);
        }];
        return;
    }
    
    dispatch_group_t group = dispatch_group_create();
    
    __weak typeof(self) weakSelf = self;
    __block UIImageView *temp;
    __block CGFloat height = 0.f;
    for (NSInteger i = 0; i < imageUrls.count; i++) {
        dispatch_group_enter(group);
        [[YYWebImageManager sharedManager] requestImageWithURL:[NSURL URLWithString:imageUrls[i]] options:0 progress:nil transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                UIImageView *imageView = strongSelf.ivList[i];
                imageView.hidden = NO;
                imageView.image = image;
                CGSize size = CGSizeMake(image.size.width <= kYZTMaxImageWidth ? image.size.width : kYZTMaxImageWidth, kYZTMaxImageWidth * image.size.height / image.size.width);
                if (i == 0) {
                    [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.size.mas_equalTo(CGSizeMake(size.width, size.height));
                    }];
                    height += size.height;
                } else {
                    [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.size.mas_equalTo(CGSizeMake(size.width, size.height));
                    }];
                    height += 5.f;
                    height += size.height;
                }
                temp = imageView;
                dispatch_group_leave(group);
            });
        }];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(height));
        }];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTableHeight" object:self.currentIndexPath];

    });
    
//    for (NSInteger i = 0; i < imageUrls.count; i++) {
//        UIImageView *imageView = self.ivList[i];
//        imageView.hidden = NO;
//        if (i == 0) {
//            [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.size.mas_equalTo(CGSizeMake(kYZTMaxImageWidth, kYZTDefaultImageHeight));
//            }];
//            height += kYZTDefaultImageHeight;
//        } else {
//            [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.size.mas_equalTo(CGSizeMake(kYZTMaxImageWidth, kYZTDefaultImageHeight));
//            }];
//            height += 5.f;
//            height += kYZTDefaultImageHeight;
//        }
//        temp = imageView;
//    }
//    
//    [self mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@(height));
//    }];
    
}

- (CGFloat)adjustImageHeight:(UIImage *)image
{
    return 1;
}

- (void)yzt_setupSubviews
{
    NSMutableArray<UIImageView *> *temp = [[NSMutableArray alloc] init];
    
    UIImageView *tem;
    for (NSInteger i = 0; i < 9; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        if (i == 0) {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(@0);
                make.top.mas_equalTo(@0);
            }];
        } else {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(@0);
                make.top.mas_equalTo(tem.mas_bottom).offset(5.f);
            }];
        }
        tem = imageView;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
    self.ivList = temp;
}

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView *)tap.view;
    if (self.delegate && [self.delegate respondsToSelector:@selector(showBigImage:)]) {
        [self.delegate showBigImage:imageView.image];
    }
}

@end
