//
//  MHAccountLogoButton.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/17.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHAccountLogoButton.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

@interface MHAccountLogoButton ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, assign) BOOL constraintsMaked;

@end

@implementation MHAccountLogoButton

#pragma mark - Life cycles

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectZero]) {
        self.imageView = [UIImageView new];
        [self addSubview:self.imageView];
        self.titleLbl = [UILabel new];
        [self addSubview:self.titleLbl];
        self.titleLbl.textColor = [UIColor whiteColor];
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        self.titleLbl.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

- (void)makeContentCenter {
    if (self.constraintsMaked) {
        return;
    }
    self.constraintsMaked = YES;
    UIView *leftSpaceView = [UIView new];
    [self addSubview:leftSpaceView];
    UIView *rightSpaceView = [UIView new];
    [self addSubview:rightSpaceView];
    
    [leftSpaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.leading.equalTo(self);
        make.width.greaterThanOrEqualTo(@8);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(leftSpaceView.mas_trailing);
        make.centerY.equalTo(self);
    }];
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imageView.mas_trailing).offset(14).priorityLow();
        make.centerY.equalTo(self);
    }];
    [rightSpaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.trailing.equalTo(self);
        make.leading.equalTo(self.titleLbl.mas_trailing);
        make.width.equalTo(leftSpaceView);
    }];
}

#pragma mark - Factory methods

+ (instancetype)bigFBLogoButton {
    MHAccountLogoButton *btn = [MHAccountLogoButton new];
    btn.imageView.image = [self fbLogoImage];
    btn.titleLbl.text = NSLocalizedString(@"Log in with Facebook", nil);
    btn.backgroundColor = [UIColor whiteColor];
    @weakify(btn);
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(btn);
        if (btn.callBack) {
            btn.callBack();
        }
    }];
    return btn;
}

+ (instancetype)bigGoogleLogoButton {
    MHAccountLogoButton *btn = [MHAccountLogoButton new];
    btn.imageView.image = [self googleLogoImage];
    btn.titleLbl.text = NSLocalizedString(@"Log in with Google", nil);
    btn.backgroundColor = [UIColor whiteColor];
    @weakify(btn);
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(btn);
        if (btn.callBack) {
            btn.callBack();
        }
//        [MHRouters routeURL:R_Google_Login];
    }];
    return btn;
}

+ (instancetype)smallFBLogoButton {
    MHAccountLogoButton *btn = [MHAccountLogoButton new];
    btn.imageView.image = [self fbLogoImage];
    btn.titleLbl.text = NSLocalizedString(@"Facebook", nil);
    btn.backgroundColor = [UIColor whiteColor];
    [btn makeContentCenter];
    @weakify(btn);
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(btn);
        if (btn.callBack) {
            btn.callBack();
        }
//        [MHRouters routeURL:R_Facebook_Login];
    }];
    return btn;
}

+ (instancetype)smallGoogleLogoButton {
    MHAccountLogoButton *btn = [MHAccountLogoButton new];
    btn.imageView.image = [self googleLogoImage];
    btn.titleLbl.text = NSLocalizedString(@"Google", nil);
    btn.backgroundColor = [UIColor whiteColor];
    [btn makeContentCenter];
    @weakify(btn);
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(btn);
        if (btn.callBack) {
            btn.callBack();
        }
//        [MHRouters routeURL:R_Google_Login];
    }];    return btn;
}

#pragma mark - Private methods

+ (UIImage *)fbLogoImage {
    return [UIImage imageNamed:@"iconfont_account_fb_icon"];
}

+ (UIImage *)googleLogoImage {
    return [UIImage imageNamed:@"account_google_logo"];
}

@end
