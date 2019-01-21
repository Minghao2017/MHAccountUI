//
//  MHPhoneLoginTabVC.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/14.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHPhoneLoginTabVC.h"
#import "MHAccountInputView.h"
#import "MHAccountComponentFactory.h"
#import "MHLoginPwdInputView.h"
#import "MHAccountLoginFooterView.h"
#import "MHAccountPhoneNumberInputView.h"
#import "MHAccountVercodeInputView.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

typedef NS_ENUM(NSUInteger, MHPhoneLoginTabViewMode) {
    MHPhoneLoginTabViewModeVerCode, //验证码模式
    MHPhoneLoginTabViewModePassword, //密码模式
};

@interface MHPhoneLoginTabVC ()

@property (nonatomic, strong) MHAccountPhoneNumberInputView *phoneNumberInput;
@property (nonatomic, strong) MHAccountVercodeInputView *verCodeInput;
@property (nonatomic, strong) MHLoginPwdInputView *pwdInput;
@property (nonatomic, strong) UIButton *modeToggleBtn;
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) MHAccountLoginFooterView *footerView;

@property (nonatomic, strong) UIButton *footerViewSignUpBtn;

@property (nonatomic, assign) MHPhoneLoginTabViewMode mode;

@end

@implementation MHPhoneLoginTabVC

#pragma mark - Life cycles

- (instancetype)init {
    if (self = [super init]) {
        self.navigationItem.title = NSLocalizedString(@"Phone Number", nil);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self phoneLoginBuildSubViews];
    [self setVerCodeBtnStatus];
    
    if (_lastAccount.length > 0) {
        self.phoneNumberInput.text = _lastAccount;
    }
    _lastAccount = nil;
}

static NSString *_lastAccount = nil;
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _lastAccount = self.phoneNumberInput.text;
}

#pragma mark - Target action methods
//登录按钮
- (void)loginBtnClicked:(UIButton *)sender {
    
}

//发送短信按钮
- (void)sendVerCodeBtnClicked:(UIButton *)sender {
   
}

//忘记密码按钮
- (void)forgetBtnClicked:(UIButton *)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    UIAlertAction *userVercodeAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Login with verification code", nil)
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                  [self toggleMode];
                                                              }];
    UIAlertAction *resetPwdAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Reset password", nil)
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                                                                                         }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:userVercodeAction];
    [alertVC addAction:resetPwdAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - Private methods

- (NSDictionary *)paramsToTransfer {
    return nil;
}

- (void)toggleMode {
    [self.view endEditing:YES];
    switch (self.mode) {
        case MHPhoneLoginTabViewModeVerCode:
            self.mode = MHPhoneLoginTabViewModePassword;
            break;
        case MHPhoneLoginTabViewModePassword:
            self.mode = MHPhoneLoginTabViewModeVerCode;
            break;
    }
    [self updateApperanceToMode:self.mode];
}

- (void)updateApperanceToMode:(MHPhoneLoginTabViewMode)mode {
    self.verCodeInput.hidden = YES;
    self.pwdInput.hidden = YES;
    switch (self.mode) {
        case MHPhoneLoginTabViewModeVerCode:
            self.verCodeInput.hidden = NO;
            self.modeToggleBtn.selected = NO;
            break;
        case MHPhoneLoginTabViewModePassword:
            self.pwdInput.hidden = NO;
            self.modeToggleBtn.selected = YES;
            break;
    }
}

- (void)modeToggelBtnClicked:(UIButton *)sender {
    [self toggleMode];
}

- (void)setVerCodeBtnStatus {
    
}

#pragma mark - Lazy load

- (MHAccountPhoneNumberInputView *)phoneNumberInput {
    if (!_phoneNumberInput) {
        _phoneNumberInput = [MHAccountPhoneNumberInputView new];
        if (@available(iOS 11.0, *)) {
            _phoneNumberInput.textContentType = UITextContentTypeUsername;
        }
        _phoneNumberInput.areaCodeView.areaCode = @"86";
    }
    return _phoneNumberInput;
}

- (MHAccountVercodeInputView *)verCodeInput {
    if (!_verCodeInput) {
        _verCodeInput = [MHAccountVercodeInputView new];
        if (@available(iOS 12.0, *)) {
            _verCodeInput.textContentType = UITextContentTypeOneTimeCode;
        }
        [_verCodeInput.sendVerCodeBtn addTarget:self action:@selector(sendVerCodeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verCodeInput;
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

- (UIButton *)modeToggleBtn {
    if (!_modeToggleBtn) {
        _modeToggleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_modeToggleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _modeToggleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_modeToggleBtn setTitle:NSLocalizedString(@"Use password?", nil) forState:UIControlStateNormal];
        [_modeToggleBtn setTitle:NSLocalizedString(@"Use verification code?", nil) forState:UIControlStateSelected];
        [_modeToggleBtn addTarget:self action:@selector(modeToggelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _modeToggleBtn;
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

- (void)phoneLoginBuildSubViews {
    [self.view addSubview:self.phoneNumberInput];
    [self.view addSubview:self.verCodeInput];
    [self.view addSubview:self.pwdInput];
    [self.view addSubview:self.modeToggleBtn];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.footerView];
    
    [self.phoneNumberInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(35);
        make.trailing.equalTo(self.view).offset(-35);
        make.top.equalTo(self.view).offset(46);
    }];
        
    [self.pwdInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.phoneNumberInput);
        make.top.equalTo(self.phoneNumberInput.mas_bottom).offset(23);
    }];
    [self.verCodeInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.phoneNumberInput);
        make.top.equalTo(self.phoneNumberInput.mas_bottom).offset(23);
    }];
    [self.modeToggleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.phoneNumberInput);
        make.top.equalTo(self.verCodeInput.mas_bottom).offset(15);
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.phoneNumberInput);
        make.top.equalTo(self.verCodeInput.mas_bottom).offset(69);
        make.height.equalTo(@44);
    }];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(35);
        make.trailing.equalTo(self.view).offset(-35);
        make.bottom.equalTo(self.view).offset(-30);
    }];
    
    self.mode = MHPhoneLoginTabViewModeVerCode;
    [self updateApperanceToMode:self.mode];
}

@end
