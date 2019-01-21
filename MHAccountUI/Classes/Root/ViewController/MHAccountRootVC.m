//
//  MHAccountRootVC.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/6.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHAccountRootVC.h"

#import "MHAccountComponentFactory.h"
#import "MHAccountLogoButton.h"
#import "MHLastLoginInfoView.h"
#import "MHLoginVC.h"

#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface MHAccountRootVC ()<MHLastLoginInfoViewDelegate>

@property (nonatomic, strong) MHLastLoginInfoView *lastLoginInfoView;

@end

@implementation MHAccountRootVC

#pragma mark - Life cycles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self accountRootBuildSubVies];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showLastLoginInfoView];
    });
}

#pragma mark - MHLastLoginInfoViewDelegate
//快捷登录按钮
- (void)lastLoginInfoViewDidClickedLoginBtn:(MHLastLoginInfoView *)view {
    
}

#pragma mark - 上次登录信息

- (void)showLastLoginInfoView {
    
    //show last login info view
    [self.lastLoginInfoView showInView:self.view animated:YES];
}

#pragma mark - Getters

- (MHLastLoginInfoView *)lastLoginInfoView {
    if (!_lastLoginInfoView) {
        _lastLoginInfoView = [MHLastLoginInfoView new];
        _lastLoginInfoView.delegate = self;
    }
    return _lastLoginInfoView;
}

- (void)accountRootBuildSubVies {
    self.navigationItem.title = NSLocalizedString(@"Log in/Sign Up", nil);
    
    UIImageView *logoIV = [UIImageView new];
    logoIV.layer.cornerRadius = 40;
    logoIV.image = [UIImage imageNamed:@"account_app_logo"];
    [self.view addSubview:logoIV];
    [logoIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(22);
        make.width.height.equalTo(@80);
    }];
    
    MHAccountLogoButton *fbBtn = [MHAccountLogoButton bigFBLogoButton];
    [fbBtn makeContentCenter];
    [self.view addSubview:fbBtn];
    [fbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(35);
        make.trailing.equalTo(self.view).offset(-35);
        make.top.equalTo(logoIV.mas_bottom).offset(72).priorityLow();
        make.height.equalTo(@44);
    }];
    @weakify(self);
    fbBtn.callBack = ^{
        @strongify(self);
    };
    
    MHAccountLogoButton *gBtn = [MHAccountLogoButton bigGoogleLogoButton];
    [self.view addSubview:gBtn];
    [gBtn.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(fbBtn.imageView);
        make.centerY.equalTo(gBtn);
    }];
    gBtn.callBack = ^{
        @strongify(self);
    };
    
    [gBtn.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(gBtn.imageView.mas_trailing).offset(14);
        make.centerY.equalTo(gBtn);
    }];
    [gBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.height.equalTo(fbBtn);
        make.top.equalTo(fbBtn.mas_bottom).offset(30);
    }];
    
    UILabel *lbl = [UILabel new];
    lbl.text = NSLocalizedString(@"— or —", nil);
    lbl.textColor = [UIColor blackColor];
    lbl.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(gBtn.mas_bottom).offset(60);
    }];
    
    UIButton *signUpBtn = [MHAccountComponentFactory gradientRoundButton];
    [self.view addSubview:signUpBtn];
    [signUpBtn setTitle:NSLocalizedString(@"New User? Sign Up", nil) forState:UIControlStateNormal];
    [signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbl.mas_bottom).offset(22);
        make.leading.trailing.height.equalTo(fbBtn);
    }];
    [[signUpBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
    }];
    
    UIButton *loginBtn = [MHAccountComponentFactory whiteBorderedButton];
    [self.view addSubview:loginBtn];
    [loginBtn setTitle:NSLocalizedString(@"Existing User? Log In", nil) forState:UIControlStateNormal];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.height.equalTo(fbBtn);
        make.top.equalTo(signUpBtn.mas_bottom).offset(30);
        make.bottom.lessThanOrEqualTo(self.view).offset(-30);
    }];
    [[loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        MHLoginVC *loginVC = [MHLoginVC new];
        [self.navigationController pushViewController:loginVC animated:YES];
    }];
}
@end
