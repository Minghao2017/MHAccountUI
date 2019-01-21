//
//  MHSignupPwdInputView.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/12.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHSignupPwdInputView.h"
#import <Masonry/Masonry.h>

@interface MHSignupPasswordRightView ()

@property (nonatomic, strong) UIButton *visiableBtn;

@end

@implementation MHSignupPasswordRightView

#pragma mark - Life cycle

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.visiableBtn];
        
        [self.visiableBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.width.equalTo(@42);
            make.leading.equalTo(self);
        }];
    }
    return self;
}

#pragma mark - Lazy load

- (UIButton *)visiableBtn {
    if (!_visiableBtn) {
        _visiableBtn = [UIButton new];
        [_visiableBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 26, 0, 0)];
    }
    return _visiableBtn;
}

@end

@interface MHSignupPwdInputView ()

@property (nonatomic, strong) MHSignupPasswordRightView *pwdRightView;

@end

@implementation MHSignupPwdInputView

- (instancetype)init {
    if (self = [super init]) {
        [self setPlaceHolder:NSLocalizedString(@"Password", nil)];
        self.secureTextEntry = YES;
        self.pwdRightView = [MHSignupPasswordRightView new];
        self.pwdRightView.frame = CGRectMake(0, 0, 42, 0);
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
