//
//  MHPhoneSignupTabVC.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/14.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHPhoneSignupTabVC.h"
#import "MHSignUpSubscribeTipView.h"
#import "MHAccountSignUpFooterView.h"
#import "MHAccountPhoneNumberInputView.h"
#import "MHAccountVercodeInputView.h"
#import "MHAccountComponentFactory.h"


#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

@interface MHPhoneSignupTabVC ()

@property (nonatomic, strong) MHAccountPhoneNumberInputView *phoneNumberInput;
@property (nonatomic, strong) MHAccountVercodeInputView *verCodeInput;
@property (nonatomic, strong) UIButton *signUpBtn;

@property (nonatomic, strong) MHSignUpSubscribeTipView *subscribeTipView;

@property (nonatomic, strong) MHAccountSignUpFooterView *footerView;
@property (nonatomic, strong) UIButton *footerViewLoginBtn;

@end


@implementation MHPhoneSignupTabVC

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
    [self signUpTabVCBuildSubViews];
    
    _lastAccount = nil;
}

static NSString *_lastAccount = nil;
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _lastAccount = self.phoneNumberInput.text;
}

#pragma mark - Target action methods

- (void)sendVerCodeBtnClicked:(UIButton *)sender {
    
}

- (void)signUpBtnClicked:(UIButton *)sender {
    
}

- (void)serviceTermsCheckoutBtnClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)serviceTermsLinkBtnClicked:(UIButton *)sender {
}

#pragma mark - Lazy load

- (MHAccountPhoneNumberInputView *)phoneNumberInput {
    if (!_phoneNumberInput) {
        _phoneNumberInput = [MHAccountPhoneNumberInputView new];
        
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

- (UIButton *)signUpBtn {
    if (!_signUpBtn) {
        _signUpBtn = [MHAccountComponentFactory gradientRoundButton];
        [_signUpBtn setTitle:NSLocalizedString(@"Sign Up", nil) forState:UIControlStateNormal];
        [_signUpBtn addTarget:self action:@selector(signUpBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signUpBtn;
}

- (MHSignUpSubscribeTipView *)subscribeTipView {
    if (!_subscribeTipView) {
        _subscribeTipView = [MHSignUpSubscribeTipView new];
        [_subscribeTipView.serviceTersLinkBtn addTarget:self action:@selector(serviceTermsLinkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_subscribeTipView.serviceTermsCheckBtn addTarget:self action:@selector(serviceTermsCheckoutBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subscribeTipView;
}

- (MHAccountSignUpFooterView *)footerView {
    if (!_footerView) {
        _footerView = [MHAccountSignUpFooterView new];
        @weakify(self);
        
    }
    return _footerView;
}

- (UIButton *)footerViewLoginBtn {
    if (!_footerViewLoginBtn) {
        _footerViewLoginBtn = self.footerView.actionBtn;
    }
    return _footerViewLoginBtn;
}

- (void)signUpTabVCBuildSubViews {
    [self.view addSubview:self.phoneNumberInput];
    [self.view addSubview:self.verCodeInput];
    [self.view addSubview:self.signUpBtn];
    [self.view addSubview:self.subscribeTipView];
    [self.view addSubview:self.footerView];
    
    [self.phoneNumberInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(35);
        make.trailing.equalTo(self.view).offset(-35);
        make.top.equalTo(self.view).offset(46).priorityMedium();
        make.top.greaterThanOrEqualTo(self.view).offset(20);
    }];
    
    [self.verCodeInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.phoneNumberInput);
        make.top.equalTo(self.phoneNumberInput.mas_bottom).offset(23);
    }];
    [self.signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.phoneNumberInput);
        make.top.greaterThanOrEqualTo(self.verCodeInput.mas_bottom).offset(20);
        make.top.equalTo(self.verCodeInput.mas_bottom).offset(42).priorityLow();
        make.height.equalTo(@44);
    }];
    [self.subscribeTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.phoneNumberInput);
        make.top.equalTo(self.signUpBtn.mas_bottom).offset(19);
    }];
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(self.subscribeTipView.mas_bottom).offset(20);
        make.leading.equalTo(self.view).offset(35);
        make.trailing.equalTo(self.view).offset(-35);
        make.bottom.equalTo(self.view).offset(-30);
    }];
}

@end
