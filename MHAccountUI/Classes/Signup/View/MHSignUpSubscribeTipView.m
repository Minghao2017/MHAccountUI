//
//  MHSignUpSubscribeTipView.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/17.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHSignUpSubscribeTipView.h"
#import <Masonry/Masonry.h>

@interface MHSignUpSubscribeTipView ()

@property (nonatomic, strong) UIButton *serviceTermsCheckBtn;
@property (nonatomic, strong) UILabel *serviceTermsTopLinkLbl;
@property (nonatomic, strong) UILabel *serviceTermsBottomLinkLbl;
@property (nonatomic, strong) UIButton *serviceTersLinkBtn;

@end

@implementation MHSignUpSubscribeTipView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.serviceTermsCheckBtn];
        [self addSubview:self.serviceTermsTopLinkLbl];
        [self addSubview:self.serviceTermsBottomLinkLbl];
        [self addSubview:self.serviceTersLinkBtn];
        
        [self.serviceTermsCheckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.equalTo(self);
            make.width.height.equalTo(@25);
        }];
        self.serviceTermsCheckBtn.imageEdgeInsets = UIEdgeInsetsMake(-11, -11, 0, 0);
        [self.serviceTermsTopLinkLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.serviceTermsCheckBtn.mas_trailing);
            make.trailing.equalTo(self);
            make.top.equalTo(self.serviceTermsCheckBtn);
        }];
        [self.serviceTermsBottomLinkLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.serviceTermsTopLinkLbl);
            make.top.equalTo(self.serviceTermsTopLinkLbl.mas_bottom).offset(5);
            make.bottom.equalTo(self);
        }];
        [self.serviceTersLinkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.equalTo(self.serviceTermsTopLinkLbl);
            make.bottom.equalTo(self.serviceTermsBottomLinkLbl);
        }];
    }
    return self;
}

- (UIButton *)serviceTermsCheckBtn {
    if (!_serviceTermsCheckBtn) {
        _serviceTermsCheckBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _serviceTermsCheckBtn.selected = YES;
    }
    return _serviceTermsCheckBtn;
}

- (UILabel *)serviceTermsTopLinkLbl {
    if (!_serviceTermsTopLinkLbl) {
        _serviceTermsTopLinkLbl = [UILabel new];
        _serviceTermsTopLinkLbl.textColor = [UIColor blackColor];
        _serviceTermsTopLinkLbl.font = [UIFont systemFontOfSize:12];
        _serviceTermsTopLinkLbl.numberOfLines = 0;
        _serviceTermsTopLinkLbl.text = NSLocalizedString(@"Subscribe our DM to get more sale information", nil);
    }
    return _serviceTermsTopLinkLbl;
}

- (UILabel *)serviceTermsBottomLinkLbl {
    if (!_serviceTermsBottomLinkLbl) {
        _serviceTermsBottomLinkLbl = [UILabel new];
        _serviceTermsBottomLinkLbl.textColor = [UIColor blackColor];
        _serviceTermsBottomLinkLbl.font = [UIFont systemFontOfSize:12];
        _serviceTermsBottomLinkLbl.numberOfLines = 0;
        _serviceTermsBottomLinkLbl.text = nil;
        NSString* string = NSLocalizedString(@"By clicking sign up, you agree to our terms>", nil);
        
        NSRange range = [string rangeOfString:NSLocalizedString(@"our terms>", nil)];
        NSMutableAttributedString *mutableAttr = [[NSMutableAttributedString alloc] initWithString:string];
        [mutableAttr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:range];
        
        _serviceTermsBottomLinkLbl.attributedText = mutableAttr;
    }
    return _serviceTermsBottomLinkLbl;
}

- (UIButton *)serviceTersLinkBtn {
    if (!_serviceTersLinkBtn) {
        _serviceTersLinkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _serviceTersLinkBtn;
}

@end
