//
//  MHLastLoginInfoView.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/6.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHLastLoginInfoView.h"
#import "MHAccountComponentFactory.h"
#import "MHBundleHelper.h"

#import <Masonry/Masonry.h>

#define ContentViewHeight  (MHDevice.MHiPhoneX ? (296 + 43) : 296)

@interface MHLastLoginInfoView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *accountInfoView;
@property (nonatomic, strong) UIView *avatarView;

@property (nonatomic, weak) UILabel *accountIdentifierLbl;

@end

@implementation MHLastLoginInfoView

#pragma mark - Getters

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapped:)];
        [_contentView addGestureRecognizer:tapGesture];
        
        UILabel *tipLbl = [UILabel new];
        tipLbl.text = NSLocalizedString(@"Login with the following account", nil);
        tipLbl.textColor = [UIColor blackColor];
        tipLbl.font = [UIFont systemFontOfSize:14];
        [_contentView addSubview:tipLbl];
        [tipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self->_contentView);
            make.top.equalTo(self->_contentView).offset(15);
        }];
        
        [_contentView addSubview:self.accountInfoView];
        [self.accountInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tipLbl.mas_bottom).offset(18);
            make.centerX.equalTo(self->_contentView);
            make.width.equalTo(@170);
            make.height.equalTo(@124);
        }];
    }
    return _contentView;
}

- (UIView *)accountInfoView {
    if (!_accountInfoView) {
        _accountInfoView = [UIView new];
        _accountInfoView.backgroundColor = [UIColor whiteColor];
        _accountInfoView.layer.cornerRadius = 4;
        _accountInfoView.layer.borderColor = [UIColor blackColor].CGColor;
        _accountInfoView.layer.borderWidth = 1;
        [_accountInfoView addSubview:self.avatarView];
        [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self->_accountInfoView);
            make.top.equalTo(self->_accountInfoView).offset(19);
            make.width.height.equalTo(@56);
        }];
        
        UILabel *accountIdentifierLbl = [UILabel new];
        accountIdentifierLbl.textColor = [UIColor blackColor];
        accountIdentifierLbl.font = [UIFont systemFontOfSize:14];
        accountIdentifierLbl.textAlignment = NSTextAlignmentCenter;
        accountIdentifierLbl.numberOfLines = 0;
        [_accountInfoView addSubview:accountIdentifierLbl];
        [accountIdentifierLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self->_accountInfoView).offset(20);
            make.trailing.equalTo(self->_accountInfoView).offset(-20);
            make.top.equalTo(self.avatarView.mas_bottom).offset(12);
            make.bottom.lessThanOrEqualTo(self->_accountInfoView);
        }];
        self.accountIdentifierLbl = accountIdentifierLbl;
    }
    return _accountInfoView;
}

- (UIView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[UIView alloc] init];
    }
    return _avatarView;
}

#pragma mark - Target action methods

- (void)contentViewTapped:(UITapGestureRecognizer *)gesture {
    [self delegateLoginBtnClicked];;
}

#pragma mark - Public API

#pragma mark - Private methods

- (NSString *)displayStringForIdentifier:(NSString *)identifier {
    NSArray *components = [identifier componentsSeparatedByString:@"@"];
    NSString *leftStr = components.firstObject;
    NSString *rightStr;
    if (components.count >= 2) {
        rightStr = components[1];
    }
    
    NSString *retStr;
    if (leftStr.length == 0) {
        retStr = nil;
    } else if (leftStr.length == 1) {
        retStr = leftStr;
    } else if (leftStr.length <= 3) {
        retStr = [NSString stringWithFormat:@"%c***%c", [leftStr characterAtIndex:0],[leftStr characterAtIndex:leftStr.length - 1]];
    } else {
        NSRange range = NSMakeRange(leftStr.length / 2 - 1, 3);
        retStr = [leftStr stringByReplacingCharactersInRange:range withString:@"***"];
    }
    if (rightStr.length > 0) {
        retStr = [NSString stringWithFormat:@"%@@%@", retStr, rightStr];
    }
    return retStr;
}

- (UIImage *)fbLogoImage {
    return [MHBundleHelper imageNamed:@"account_fb_round_logo"];
}

- (UIImage *)googleLogoImage {
    return [MHBundleHelper imageNamed:@"account_google_round_logo"];
}

- (void)delegateLoginBtnClicked {
    if ([self.delegate respondsToSelector:@selector(lastLoginInfoViewDidClickedLoginBtn:)]) {
        [self.delegate lastLoginInfoViewDidClickedLoginBtn:self];
    }
}

#pragma mark - Override

- (NSString *)titleLblText {
    return NSLocalizedString(@"Previous Users", nil);
}

- (NSString *)actionButtonText {
    return NSLocalizedString(@"Log In", nil);
}

- (CGFloat)contentViewHeight {
    return 205;
}

- (UIView *)alertContentView {
    return self.contentView;
}

- (void)actionButtonClicked:(UIButton *)sender {
    [self delegateLoginBtnClicked];
    [super actionButtonClicked:sender];
}

@end
