//
//  MHLoginPwdInputView.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/11.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHLoginPwdInputView.h"
#import <Masonry/Masonry.h>

@interface MHLoginPasswordRightView ()

@property (nonatomic, strong) UIButton *visiableBtn;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *forgetBtn;

@end

@implementation MHLoginPasswordRightView

#pragma mark - Life cycle

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.visiableBtn];
        [self addSubview:self.lineView];
        [self addSubview:self.forgetBtn];
        
        [self.visiableBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.centerY.equalTo(self);
            make.width.equalTo(@42);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.visiableBtn.mas_trailing);
            make.centerY.equalTo(self);
            make.height.equalTo(@12);
            make.width.equalTo(@1);
        }];
        
        [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.lineView.mas_trailing).offset(13);
            make.centerY.equalTo(self);
            make.trailing.equalTo(self);
        }];
    }
    return self;
}

#pragma mark - Lazy load

- (UIButton *)visiableBtn {
    if (!_visiableBtn) {
        _visiableBtn = [UIButton new];
        
    }
    return _visiableBtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor blackColor];
    }
    return _lineView;
}

- (UIButton *)forgetBtn {
    if (!_forgetBtn) {
        _forgetBtn = [UIButton new];
        [_forgetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _forgetBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_forgetBtn setTitle:NSLocalizedString(@"Forgot?", nil) forState:UIControlStateNormal];
        [_forgetBtn setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _forgetBtn;
}

@end

@interface MHLoginPwdInputView ()

@property (nonatomic, strong) MHLoginPasswordRightView *pwdRightView;

@end

@implementation MHLoginPwdInputView

- (instancetype)init {
    if (self = [super init]) {
        [self setPlaceHolder:NSLocalizedString(@"Password", nil)];
        self.secureTextEntry = YES;
        self.pwdRightView = [MHLoginPasswordRightView new];
        self.pwdRightView.frame = CGRectMake(0, 0, 93, 0);
        self.rightView = self.pwdRightView;
        [self.pwdRightView.visiableBtn addTarget:self action:@selector(visiableBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)visiableBtnClicked {
    [self toggleSecureEntry];
}

#pragma mark - Private methods

- (void)toggleSecureEntry {
    self.pwdRightView.visiableBtn.selected = !self.pwdRightView.visiableBtn.selected;
    self.secureTextEntry = !self.secureTextEntry;
}

@end
