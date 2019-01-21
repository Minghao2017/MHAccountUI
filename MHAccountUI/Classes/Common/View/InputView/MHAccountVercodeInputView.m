//
//  MHAccountVercodeInputView.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/11.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHAccountVercodeInputView.h"

@interface MHAccountVercodeInputView ()

@property (nonatomic, strong) UIButton *sendVerCodeBtn;

@end

@implementation MHAccountVercodeInputView

#pragma mark - Life cycle

- (instancetype)init {
    if (self = [super init]) {
        [self setPlaceHolder:NSLocalizedString(@"Verification Code", nil)];
        self.keyboardType = UIKeyboardTypePhonePad;
        
        self.sendVerCodeBtn.frame = CGRectMake(0, 0, 60, 0);
        self.rightView = self.sendVerCodeBtn;
        self.maxLengthOfTextField = 6;
    }
    return self;
}

- (UIButton *)sendVerCodeBtn {
    if (!_sendVerCodeBtn) {
        _sendVerCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendVerCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sendVerCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        _sendVerCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        if (@available(iOS 11.0, *)) {
            _sendVerCodeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentTrailing;
        } else {
            _sendVerCodeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
        [_sendVerCodeBtn setTitle:NSLocalizedString(@"Send", nil) forState:UIControlStateNormal];
    }
    return _sendVerCodeBtn;
}

#pragma mark - Private method

- (void)updateSendVerCodeBtnEnableStatus {
    switch (self.status) {
        case MHAccountVercodeInputViewStatusNormal:
            self.sendVerCodeBtn.enabled = YES;
            break;
        case MHAccountVercodeInputViewStatusSending:
            self.sendVerCodeBtn.enabled = NO;
            break;
        case MHAccountVercodeInputViewStatusCountdown:
            self.sendVerCodeBtn.enabled = NO;
            break;
        case MHAccountVercodeInputViewStatusResend:
            self.sendVerCodeBtn.enabled = YES;
            break;
    }
}

#pragma mark - Setters

- (void)setStatus:(MHAccountVercodeInputViewStatus)status {
    _status = status;
    
    switch (status) {
        case MHAccountVercodeInputViewStatusNormal:
            [self.sendVerCodeBtn setTitle:NSLocalizedString(@"Send", nil) forState:UIControlStateNormal];
            break;
        case MHAccountVercodeInputViewStatusSending:
            [self.sendVerCodeBtn setTitle:NSLocalizedString(@"Sending", nil) forState:UIControlStateNormal];
            break;
        case MHAccountVercodeInputViewStatusCountdown:
            [self.sendVerCodeBtn setTitle:[self countdownDisplayString:self.countdown] forState:UIControlStateNormal];
            break;
        case MHAccountVercodeInputViewStatusResend:
            [self.sendVerCodeBtn setTitle:NSLocalizedString(@"Resend", nil) forState:UIControlStateNormal];
            break;
    }
    [self updateSendVerCodeBtnEnableStatus];
}

- (void)setCountdown:(NSUInteger)countdown {
    _countdown = countdown;
    
    if (self.status == MHAccountVercodeInputViewStatusCountdown) {
        [self.sendVerCodeBtn setTitle:[self countdownDisplayString:countdown] forState:UIControlStateNormal];
    }
}

#pragma mark - Private methods

- (NSString *)countdownDisplayString:(NSInteger)countdown {
    return [NSString stringWithFormat:@"%lds", countdown];
}

@end
