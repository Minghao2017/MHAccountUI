//
//  MHRestPwdSecondStepVC.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/12.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHRestPwdSecondStepVC.h"
#import "MHAccountVercodeInputView.h"
#import "MHAccountComponentFactory.h"
#import "MHRestPwdSupportLbl.h"
#import "MHRestPwdDefine.h"
#import "MHRestPwdThirdStepVC.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

@interface MHRestPwdSecondStepVC ()

@property (nonatomic, assign) MHRestPwdType type;
@property (nonatomic, copy) NSString *value;

@property (nonatomic, strong) UILabel *tipLbl;
@property (nonatomic, strong) MHAccountVercodeInputView *vercodeInput;
@property (nonatomic, strong) UIButton *submitBtn;

@property (nonatomic, strong) MHRestPwdSupportLbl *supportLbl;

@end

@implementation MHRestPwdSecondStepVC

#pragma mark - Life cycles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Forgot Password", nil);
    [self secondStepVCBuildSubViews];
    [self setVercodeBtnStatus];
}

#pragma mark - Private methods

- (void)secondStepVCBuildSubViews {
    [self.view addSubview:self.tipLbl];
    [self.tipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(31);
        make.leading.equalTo(self.view).offset(35);
        make.trailing.equalTo(self.view).offset(-35);
    }];
    self.tipLbl.text = [self tipText];
    
    [self.view addSubview:self.vercodeInput];
    [self.vercodeInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipLbl.mas_bottom).offset(34);
        make.leading.trailing.equalTo(self.tipLbl);
    }];
    
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.tipLbl);
        make.top.equalTo(self.tipLbl.mas_bottom).offset(102);
        make.height.equalTo(@44);
    }];
    
    [self.view addSubview:self.supportLbl];
    [self.supportLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.tipLbl);
        make.top.equalTo(self.submitBtn.mas_bottom).offset(42);
    }];
}

- (void)setVercodeBtnStatus {
 
}

#pragma mark - Target action methods

- (void)submitBtnClicked:(UIButton *)sender {
    
}

- (void)sendVerCodeBtnClicked:(UIButton *)sender {
    
}

#pragma mark - Private methods

- (NSString *)tipText {
    NSString *ret;
    switch (self.type) {
        case MHRestPwdTypePhone:
        {
            ret = NSLocalizedString(@"We sent SMS to ", nil);
            ret = [ret stringByAppendingString:self.value];
            ret = [ret stringByAppendingString:@"."];
            ret = [ret stringByAppendingString:NSLocalizedString(@"Please check your message.", nil)];
            break;
        }
        case MHRestPwdTypeEmail:
        {
            ret = NSLocalizedString(@"We sent a verification code to \"", nil);
            ret = [ret stringByAppendingString:self.value];
            ret = [ret stringByAppendingString:@"\"."];
            ret = [ret stringByAppendingString:NSLocalizedString(@"Please check your email.", nil)];
            break;
        }
    }
    return ret;
}

#pragma mark - Lazy load

- (UILabel *)tipLbl {
    if (!_tipLbl) {
        _tipLbl = [UILabel new];
        _tipLbl.textColor = [UIColor blackColor];
        _tipLbl.font = [UIFont systemFontOfSize:14];
        _tipLbl.numberOfLines = 0;
    }
    return _tipLbl;
}

- (MHAccountVercodeInputView *)vercodeInput {
    if (!_vercodeInput) {
        _vercodeInput = [MHAccountVercodeInputView new];
        [_vercodeInput.sendVerCodeBtn addTarget:self action:@selector(sendVerCodeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _vercodeInput;
}

- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [MHAccountComponentFactory gradientRoundButton];
        [_submitBtn setTitle:NSLocalizedString(@"Submit", nil) forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (MHRestPwdSupportLbl *)supportLbl {
    if (!_supportLbl) {
        _supportLbl = [MHRestPwdSupportLbl new];
    }
    return _supportLbl;
}

@end
