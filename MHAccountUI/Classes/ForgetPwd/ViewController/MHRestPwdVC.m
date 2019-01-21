//
//  MHRestPwdVC.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/6.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHRestPwdVC.h"
#import "MHAccountPhoneNumberInputView.h"
#import "MHAccountEmailInputView.h"
#import "MHAccountComponentFactory.h"
#import "MHRestPwdSupportLbl.h"
#import "MHRestPwdDefine.h"
#import "MHRestPwdSecondStepVC.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

@interface MHRestPwdVC ()

@property (nonatomic, assign) MHRestPwdType type;

@property (nonatomic, strong) UILabel *tipLbl;
@property (nonatomic, strong) MHAccountPhoneNumberInputView *phoneNumberInput;
@property (nonatomic, strong) MHAccountEmailInputView *emailInput;
@property (nonatomic, strong) UIButton *sendVercodeBtn;

@property (nonatomic, strong) MHRestPwdSupportLbl *supportLbl;

@end

@implementation MHRestPwdVC

#pragma mark - Life cycles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Forgot Password", nil);
    [self resetPwdVCBuildSubViews];
}

- (void)resetPwdVCBuildSubViews {
    [self.view addSubview:self.tipLbl];
    [self.tipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(31);
        make.leading.equalTo(self.view).offset(35);
        make.trailing.equalTo(self.view).offset(-35);
    }];
    switch (self.type) {
        case MHRestPwdTypePhone:
        {
            self.tipLbl.text = NSLocalizedString(@"Please enter your registered phone number.", nil);
            [self.view addSubview:self.phoneNumberInput];
            [self.phoneNumberInput mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.tipLbl.mas_bottom).offset(34);
                make.leading.trailing.equalTo(self.tipLbl);
            }];
            break;
        }
        case MHRestPwdTypeEmail:
        {
            self.tipLbl.text = NSLocalizedString(@"Please enter your registered Email.", nil);
            [self.view addSubview:self.emailInput];
            [self.emailInput mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.tipLbl.mas_bottom).offset(34);
                make.leading.trailing.equalTo(self.tipLbl);
            }];
            break;
        }
    }
    [self.view addSubview:self.sendVercodeBtn];
    [self.sendVercodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.tipLbl);
        make.top.equalTo(self.tipLbl.mas_bottom).offset(102);
        make.height.equalTo(@44);
    }];
    
    [self.view addSubview:self.supportLbl];
    [self.supportLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.tipLbl);
        make.top.equalTo(self.sendVercodeBtn.mas_bottom).offset(42);
    }];
}

#pragma mark - Target action methods

- (void)sendVercodeBtnClicked:(UIButton *)sender {
    
}

- (void)gotoNextController {
    NSString *value;
    switch (self.type) {
        case MHRestPwdTypePhone:
            value = self.phoneNumberInput.text;
            break;
        case MHRestPwdTypeEmail:
            value = self.emailInput.text;
            break;
    }
    MHRestPwdSecondStepVC *vc = [[MHRestPwdSecondStepVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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

- (MHAccountPhoneNumberInputView *)phoneNumberInput {
    if (!_phoneNumberInput) {
        _phoneNumberInput = [MHAccountPhoneNumberInputView new];
    }
    return _phoneNumberInput;
}

- (MHAccountEmailInputView *)emailInput {
    if (!_emailInput) {
        _emailInput = [MHAccountEmailInputView new];
        [_emailInput setPlaceHolder:NSLocalizedString(@"Email", nil)];
    }
    return _emailInput;
}

- (UIButton *)sendVercodeBtn {
    if (!_sendVercodeBtn) {
        _sendVercodeBtn = [MHAccountComponentFactory gradientRoundButton];
        [_sendVercodeBtn setTitle:NSLocalizedString(@"Send Verification Code", nil) forState:UIControlStateNormal];
        [_sendVercodeBtn addTarget:self action:@selector(sendVercodeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendVercodeBtn;
}

- (MHRestPwdSupportLbl *)supportLbl {
    if (!_supportLbl) {
        _supportLbl = [MHRestPwdSupportLbl new];
    }
    return _supportLbl;
}

@end
