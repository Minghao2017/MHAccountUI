//
//  MHPhoneAreaCodeLeftView.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/11.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHPhoneAreaCodeLeftView.h"
#import <Masonry/Masonry.h>

@interface MHPhoneAreaCodeLeftView ()

@property (nonatomic, strong) UILabel *areCodeLbl;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation MHPhoneAreaCodeLeftView

#pragma mark - Public API

- (void)setAreaCode:(NSString *)areaCode {
    _areaCode = areaCode;
    if (areaCode) {
        self.areCodeLbl.text = [NSString stringWithFormat:@"+%@", areaCode];
    } else {
        self.areCodeLbl.text = @"+000";
    }
}

#pragma mark - Life cycle

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.areCodeLbl];
        [self addSubview:self.lineView];
        
        [self.areCodeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.leading.equalTo(self);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.height.equalTo(@10);
            make.width.equalTo(@1);
            make.leading.equalTo(self.areCodeLbl.mas_trailing).offset(10);
            make.trailing.equalTo(self).offset(-10);
        }];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(areaCodeClicked)];
        [self addGestureRecognizer:tapGesture];
        [self setAreaCode:@"91"];
    }
    return self;
}

#pragma mark - Target action methods

- (void)areaCodeClicked {
    if ([self.delegate respondsToSelector:@selector(areaCodeLeftViewDidClicked:)]) {
        [self.delegate areaCodeLeftViewDidClicked:self];
    }
}

#pragma mark - Lazy load

- (UILabel *)areCodeLbl {
    if (!_areCodeLbl) {
        _areCodeLbl = [UILabel new];
        _areCodeLbl.textColor = [UIColor lightGrayColor];
        _areCodeLbl.font = [UIFont systemFontOfSize:14];
        [_areCodeLbl setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _areCodeLbl;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor lightTextColor];
    }
    return _lineView;
}

@end
