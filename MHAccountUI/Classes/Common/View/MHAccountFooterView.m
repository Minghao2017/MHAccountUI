//
//  MHAccountFooterView.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/11.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHAccountFooterView.h"
#import "MHAccountComponentFactory.h"
#import "MHAccountLogoButton.h"
#import <Masonry/Masonry.h>

@interface MHAccountFooterView ()

@property (nonatomic, strong) UILabel *tipLbl;
@property (nonatomic, strong) UIButton *actionBtn;
@property (nonatomic, strong) MHAccountLogoButton *fbLoginBtn;
@property (nonatomic, strong) MHAccountLogoButton *googleLoginBtn;

@end

@implementation MHAccountFooterView

#pragma mark - Life cycles

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    return CGSizeMake(size.width, 114); //footer 视图最有高度114：来自设计稿
}

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.tipLbl];
        [self addSubview:self.actionBtn];
        //设置tipLbl+actionBtn居中
        UIView *leftPaddingView = [UIView new];
        UIView *rightPaddingView = [UIView new];
        [self addSubview:leftPaddingView];
        [self addSubview:rightPaddingView];
        [self.tipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.trailing.equalTo(self.actionBtn.mas_leading).offset(-2);
        }];
        [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.tipLbl);
            make.trailing.equalTo(rightPaddingView.mas_leading);
        }];
        [leftPaddingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.trailing.equalTo(self.tipLbl.mas_leading);
            make.top.equalTo(self.tipLbl);
            make.height.equalTo(@1);
        }];
        [rightPaddingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self);
            make.width.equalTo(leftPaddingView);
            make.top.equalTo(self.tipLbl);
            make.height.equalTo(@1);
        }];
        
        UILabel *lbl = [UILabel new];
        lbl.text = NSLocalizedString(@"— or —", nil);
        lbl.textColor = [UIColor lightTextColor];
        lbl.font = [UIFont systemFontOfSize:14];
        [self addSubview:lbl];
        [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.tipLbl.mas_bottom).offset(15);
            make.height.equalTo(@20);
        }];
        
        [self addSubview:self.fbLoginBtn];
        [self addSubview:self.googleLoginBtn];
        [self.fbLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.bottom.equalTo(self);
            make.height.equalTo(@44);
        }];
        [self.googleLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.fbLoginBtn.mas_trailing).offset(12);
            make.bottom.equalTo(self);
            make.trailing.equalTo(self);
            make.height.equalTo(@44);
            make.width.equalTo(self.fbLoginBtn);
        }];
    }
    return self;
}

#pragma mark - Getters

- (UILabel *)tipLbl {
    if (!_tipLbl) {
        _tipLbl = [UILabel new];
        _tipLbl.textColor = [UIColor lightTextColor];
        _tipLbl.font = [UIFont systemFontOfSize:14];
        _tipLbl.text = [self tipLblText];
    }
    return _tipLbl;
}

- (UIButton *)actionBtn {
    if (!_actionBtn) {
        _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_actionBtn setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
        _actionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_actionBtn setTitle:[self actionBtnText] forState:UIControlStateNormal];
    }
    return _actionBtn;
}

- (MHAccountLogoButton *)fbLoginBtn {
    if (!_fbLoginBtn) {
        _fbLoginBtn = [MHAccountLogoButton smallFBLogoButton];
    }
    return _fbLoginBtn;
}

- (MHAccountLogoButton *)googleLoginBtn {
    if (!_googleLoginBtn) {
        _googleLoginBtn = [MHAccountLogoButton smallGoogleLogoButton];
    }
    return _googleLoginBtn;
}

- (void (^)(void))fbBtnCallBack {
    return self.fbLoginBtn.callBack;
}

- (void (^)(void))googleBtnCallBack {
    return self.googleLoginBtn.callBack;
}

#pragma mark - Setters

- (void)setFbBtnCallBack:(void (^)(void))fbBtnCallBack {
    self.fbLoginBtn.callBack = fbBtnCallBack;
}

- (void)setGoogleBtnCallBack:(void (^)(void))googleBtnCallBack {
    self.googleLoginBtn.callBack = googleBtnCallBack;
}

#pragma mark - Sub class methods

- (NSString *)tipLblText {
    return nil;
}

- (NSString *)actionBtnText {
    return nil;
}

@end
