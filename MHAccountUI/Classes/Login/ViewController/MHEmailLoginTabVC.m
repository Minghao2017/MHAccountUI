//
//  MHEmailLoginTabVC.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/14.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHEmailLoginTabVC.h"
#import "MHAccountComponentFactory.h"
#import "MHLoginPwdInputView.h"
#import "MHAccountEmailInputView.h"
#import "MHAccountLoginFooterView.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

@interface MHEmailLoginTabVC ()

@property (nonatomic, strong) MHAccountEmailInputView *emailInput;
@property (nonatomic, strong) MHLoginPwdInputView *pwdInput;
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) MHAccountLoginFooterView *footerView;
@property (nonatomic, strong) UIButton *footerViewSignUpBtn;

@property (nonatomic, assign) NSUInteger passwordWrongCount; //密码错误超过三次

@end

@implementation MHEmailLoginTabVC

#pragma mark - Life cycles

- (instancetype)init {
    if (self = [super init]) {
        self.navigationItem.title = NSLocalizedString(@"Email", nil);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self emailLoginBuildSubViews];
}

#pragma mark - Target action methods

- (void)loginBtnClicked:(UIButton *)sender {
    
}

- (void)forgetBtnClicked:(UIButton *)sender {
    
}

#pragma mark - Lazy load

- (MHAccountEmailInputView *)emailInput {
    if (!_emailInput) {
        _emailInput = [MHAccountEmailInputView new];
        if (@available(iOS 11, *)) {
            _emailInput.textContentType = UITextContentTypeUsername;
        }
        [_emailInput setPlaceHolder:NSLocalizedString(@"Email", nil)];
    }
    return _emailInput;
}

- (MHLoginPwdInputView *)pwdInput {
    if (!_pwdInput) {
        _pwdInput = [MHLoginPwdInputView new];
        if (@available(iOS 11, *)) {
            _pwdInput.textContentType = UITextContentTypePassword;
        }
        [_pwdInput.pwdRightView.forgetBtn addTarget:self action:@selector(forgetBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pwdInput;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [MHAccountComponentFactory gradientRoundButton];
        [_loginBtn setTitle:NSLocalizedString(@"Log In", nil) forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (MHAccountLoginFooterView *)footerView {
    if (!_footerView) {
        _footerView = [MHAccountLoginFooterView new];
        @weakify(self);
        _footerView.fbBtnCallBack = ^{
            @strongify(self);
            
        };
        _footerView.googleBtnCallBack = ^{
            @strongify(self);
        };
        [[_footerView.actionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
        }];
    }
    return _footerView;
}

- (UIButton *)footerViewSignUpBtn {
    if (!_footerViewSignUpBtn) {
        _footerViewSignUpBtn = self.footerView.actionBtn;
    }
    return _footerViewSignUpBtn;
}

- (void)emailLoginBuildSubViews {
    [self.view addSubview:self.emailInput];
    [self.view addSubview:self.pwdInput];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.footerView];
    
    [self.emailInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(35);
        make.trailing.equalTo(self.view).offset(-35);
        make.top.equalTo(self.view).offset(46);
    }];
    [self.pwdInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.emailInput);
        make.top.equalTo(self.emailInput.mas_bottom).offset(23);
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.emailInput);
        make.top.equalTo(self.pwdInput.mas_bottom).offset(69);
        make.height.equalTo(@44);
    }];
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(35);
        make.trailing.equalTo(self.view).offset(-35);
        make.bottom.equalTo(self.view).offset(-30);
    }];
}

@end
