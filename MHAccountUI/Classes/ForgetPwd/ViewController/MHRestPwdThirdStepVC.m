//
//  MHRestPwdThirdStepVC.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/12.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHRestPwdThirdStepVC.h"
#import "MHAccountInputView.h"
#import "MHAccountComponentFactory.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

@interface MHRestPwdThirdStepVC ()

@property (nonatomic, strong) MHAccountInputView *pwdInput;
@property (nonatomic, strong) MHAccountInputView *confirmPwdInput;
@property (nonatomic, strong) UILabel *pwdTipLbl;
@property (nonatomic, strong) UIButton *resetBtn;

@end

@implementation MHRestPwdThirdStepVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Forgot Password", nil);

    [self thirdStepVCBuildSubViews];
}

- (void)thirdStepVCBuildSubViews {
    [self.view addSubview:self.pwdInput];
    [self.view addSubview:self.confirmPwdInput];
    [self.view addSubview:self.pwdTipLbl];
    [self.view addSubview:self.resetBtn];
    
    [self.pwdInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(35);
        make.trailing.equalTo(self.view).offset(-35);
        make.top.equalTo(self.view).offset(64);
    }];
    [self.confirmPwdInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.pwdInput);
        make.top.equalTo(self.pwdInput.mas_bottom).offset(27);
    }];
    [self.pwdTipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.pwdInput);
        make.top.equalTo(self.confirmPwdInput.mas_bottom).offset(8);
    }];
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.pwdInput);
        make.top.equalTo(self.pwdTipLbl.mas_bottom).offset(31);
        make.height.equalTo(@44);
    }];
}

#pragma mark - Target action methods

- (void)resetBtnClicked:(UIButton *)sender {
    
}

#pragma mark - Lazy load

- (MHAccountInputView *)pwdInput {
    if (!_pwdInput) {
        _pwdInput = [MHAccountInputView new];
        [_pwdInput setPlaceHolder:NSLocalizedString(@"Enter New Password", nil)];
    }
    return _pwdInput;
}

- (MHAccountInputView *)confirmPwdInput {
    if (!_confirmPwdInput) {
        _confirmPwdInput = [MHAccountInputView new];
        [_confirmPwdInput setPlaceHolder:NSLocalizedString(@"Confirm New Password ", nil)];
    }
    return _confirmPwdInput;
}

- (UILabel *)pwdTipLbl {
    if (!_pwdTipLbl) {
        _pwdTipLbl = [MHAccountComponentFactory passwordTipLbl];
    }
    return _pwdTipLbl;
}

- (UIButton *)resetBtn {
    if (!_resetBtn) {
        _resetBtn = [MHAccountComponentFactory gradientRoundButton];
        [_resetBtn setTitle:NSLocalizedString(@"Reset password", nil) forState:UIControlStateNormal];
        [_resetBtn addTarget:self action:@selector(resetBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetBtn;
}

@end

