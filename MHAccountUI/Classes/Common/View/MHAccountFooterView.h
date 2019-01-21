//
//  MHAccountFooterView.h
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/11.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHAccountFooterView : UIView

/**
 可能是登录或者注册按钮
 */
@property (nonatomic, readonly) UIButton *actionBtn;

/**
 facebook/google登录按钮点击回调
 */
@property (nonatomic, copy) void(^fbBtnCallBack)(void);
@property (nonatomic, copy) void(^googleBtnCallBack)(void);

#pragma mark - Sub class methods

- (NSString *)tipLblText;
- (NSString *)actionBtnText;

@end
