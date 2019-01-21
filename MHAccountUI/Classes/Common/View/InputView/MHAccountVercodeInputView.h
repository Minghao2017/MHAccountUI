//
//  MHAccountVercodeInputView.h
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/11.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHAccountInputView.h"

/**
 验证码输入组件状态

 - MHAccountVercodeInputViewStatusNormal: 普通.默认状态
 - MHAccountVercodeInputViewStatusSending: 发送中
 - MHAccountVercodeInputViewStatusCountdown: 计时状态
 - MHAccountVercodeInputViewStatusResend: 重发
 */
typedef NS_ENUM(NSUInteger, MHAccountVercodeInputViewStatus) {
    MHAccountVercodeInputViewStatusNormal,
    MHAccountVercodeInputViewStatusSending,
    MHAccountVercodeInputViewStatusCountdown,
    MHAccountVercodeInputViewStatusResend,
};

@interface MHAccountVercodeInputView : MHAccountInputView

@property (nonatomic, readonly) UIButton *sendVerCodeBtn;

@property (nonatomic, assign) MHAccountVercodeInputViewStatus status;
@property (nonatomic, assign) NSUInteger countdown;

@end
