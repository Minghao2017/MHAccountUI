//
//  MHAccountLogoButton.h
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/17.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHAccountLogoButton : UIControl

@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, readonly) UILabel *titleLbl;

/**
 点击事件回调
 */
@property (nonatomic, copy) void(^callBack)(void);

/**
 使内容水平居中
 */
- (void)makeContentCenter;

+ (instancetype)bigFBLogoButton;
+ (instancetype)bigGoogleLogoButton;

+ (instancetype)smallFBLogoButton;
+ (instancetype)smallGoogleLogoButton;

@end

NS_ASSUME_NONNULL_END
