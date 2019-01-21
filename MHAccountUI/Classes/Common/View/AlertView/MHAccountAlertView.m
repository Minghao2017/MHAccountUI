//
//  MHAccountAlertView.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/11.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHAccountAlertView.h"
#import "MHAccountComponentFactory.h"

#import <Masonry/Masonry.h>

@interface MHAccountAlertView ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *bottomContainerView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *contentWrapperView;
@property (nonatomic, strong) UIButton *actionBtn;

@property (nonatomic, strong) MASConstraint *bottomContainerViewBottomCons;

@property (nonatomic, weak) UIView *presentingView;

@end

@implementation MHAccountAlertView

#pragma mark - Getters

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self addSubview:_backgroundView];
        [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewTapped)];
        [_backgroundView addGestureRecognizer:tap];
    }
    return _backgroundView;
}

- (UIView *)bottomContainerView {
    if (!_bottomContainerView) {
        _bottomContainerView = [UIView new];
        [self addSubview:_bottomContainerView];
        _bottomContainerView.backgroundColor = [UIColor whiteColor];
        
        [_bottomContainerView addSubview:self.titleView];
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44);
            make.leading.trailing.top.equalTo(self->_bottomContainerView);
        }];
        
        [_bottomContainerView addSubview:self.contentWrapperView];
        [self.contentWrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleView.mas_bottom);
            make.leading.trailing.equalTo(self->_bottomContainerView);
            make.height.equalTo(@([self contentViewHeight]));
        }];
        
        [_bottomContainerView addSubview:self.actionBtn];
        [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self->_bottomContainerView);
            make.top.equalTo(self.contentWrapperView.mas_bottom);
            make.height.equalTo(@46);
            make.bottom.equalTo(self->_bottomContainerView);
        }];
    }
    return _bottomContainerView;
}

- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [UIView new];
        
        UILabel *lbl = [UILabel new];
        lbl.text = [self titleLblText];
        lbl.font = [UIFont systemFontOfSize:18];
        lbl.textColor = [UIColor lightGrayColor];
        [_titleView addSubview:lbl];
        [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self->_titleView);
        }];
        
        UIButton *closeBtn = [UIButton new];
        UIImage *image = [UIImage imageNamed:@"iconfont_close"];
        [closeBtn setImage:image forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self->_titleView);
            make.height.with.equalTo(@44);
            make.trailing.equalTo(self->_titleView).offset(-20);
        }];
        
        UIView *borderView = [UIView new];
        borderView.backgroundColor = [UIColor whiteColor];
        [_titleView addSubview:borderView];
        [borderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self->_titleView);
            make.height.equalTo(@1);
        }];
    }
    return _titleView;
}

- (UIView *)contentWrapperView {
    if (!_contentWrapperView) {
        _contentWrapperView = [UIView new];
        _contentWrapperView.backgroundColor = [UIColor whiteColor];
        UIView *contentView = [self alertContentView];
        if (contentView) {
            [_contentWrapperView addSubview:contentView];
            [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self->_contentWrapperView);
            }];
        }
    }
    return _contentWrapperView;
}

- (UIButton *)actionBtn {
    if (!_actionBtn) {
        _actionBtn = [MHAccountComponentFactory gradientButton];
        _actionBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_actionBtn setTitle:[self actionButtonText] forState:UIControlStateNormal];
        [_actionBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionBtn;
}

#pragma mark - Sub class methods

- (NSString *)titleLblText {
    return nil;
}

- (NSString *)actionButtonText {
    return nil;
}

- (CGFloat)contentViewHeight {
    return 44;
}

- (UIView *)alertContentView {
    return nil;
}

- (void)closeButtonClicked:(UIButton *)sender {
    
}

- (void)actionButtonClicked:(UIButton *)sender {
    
}

#pragma mark - Public API

- (void)showInView:(UIView *)view animated:(BOOL)animated {
    self.presentingView = view;
    [self showAnimated:animated];
}

#pragma mark - Private methods


#pragma mark - Target action methods

- (void)closeBtnClicked:(UIButton *)sender {
    [self closeButtonClicked:sender];
    [self hideAnimated:YES];
}

- (void)loginBtnClicked:(UIButton *)sender {
    [self actionButtonClicked:sender];
    [self hideAnimated:YES];
}

- (void)bgViewTapped {
    [self hideAnimated:YES];
}

#pragma mark - Show/Hide

- (void)showAnimated:(BOOL)animated {
    if (self.superview) {
        [self removeFromSuperview];
    }
    
    if (!self.presentingView) {
        return;
    }
    
    //add self to view hierarchy
    [self.presentingView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.presentingView);
    }];
    
    if (animated) {
        //set bgview alpha
        self.backgroundView.alpha = 0.0;
        
        //place content view to bottom
        [self.bottomContainerViewBottomCons uninstall];
        [self.bottomContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self);
            self.bottomContainerViewBottomCons = make.top.equalTo(self.mas_bottom);
        }];
        [self layoutIfNeeded];
        
        //show animated
        [self.bottomContainerViewBottomCons uninstall];
        [self.bottomContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
            self.bottomContainerViewBottomCons = make.bottom.equalTo(self);
        }];
        [UIView animateWithDuration:0.25 animations:^{
            self.backgroundView.alpha = 1.0;
            [self layoutIfNeeded];
        }];
    } else {
        //show
        [self.bottomContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self);
            self.bottomContainerViewBottomCons = make.bottom.equalTo(self);
        }];
    }
}

- (void)hideAnimated:(BOOL)animated {
    if (!animated) {
        [self removeFromSuperview];
        self.backgroundView.alpha = 1.0;
    }
    
    //hide animated
    [self.bottomContainerViewBottomCons uninstall];
    [self.bottomContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.bottomContainerViewBottomCons = make.top.equalTo(self.mas_bottom);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.alpha = 0.0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.backgroundView.alpha = 1.0;
        [self removeFromSuperview];
    }];
}

@end
