//
//  MHAccountInputView.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/11.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHAccountInputView.h"
#import <Masonry/Masonry.h>

@interface MHAccountInputView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UITextField *tf;

@property (nonatomic, strong) UIView *leftViewContainer;
@property (nonatomic, strong) UIView *rightViewContainer;

@property (nonatomic, strong) UILabel *errorTipLbl;

@end

@implementation MHAccountInputView

#pragma mark - Getters

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = [UIColor blackColor];
    }
    return _bottomLine;
}

- (UITextField *)tf {
    if (!_tf) {
        _tf = [[UITextField alloc] init];
        _tf.textColor = [UIColor blackColor];
        _tf.font = [UIFont systemFontOfSize:14];
        _tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _tf.autocorrectionType = UITextAutocorrectionTypeNo;
        _tf.delegate = self;
    }
    return _tf;
}

- (UIView *)leftViewContainer {
    if (!_leftViewContainer) {
        _leftViewContainer = [UIView new];
    }
    return _leftViewContainer;
}

- (UIView *)rightViewContainer {
    if (!_rightViewContainer) {
        _rightViewContainer = [UIView new];
    }
    return _rightViewContainer;
}

- (UILabel *)errorTipLbl {
    if (!_errorTipLbl) {
        _errorTipLbl = [UILabel new];
        _errorTipLbl.numberOfLines = 0;
        _errorTipLbl.font = [UIFont systemFontOfSize:14];
        _errorTipLbl.textColor = [UIColor blackColor];
        [_errorTipLbl setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    }
    return _errorTipLbl;
}

- (UIKeyboardType)keyboardType {
    return self.tf.keyboardType;
}

- (BOOL)secureTextEntry {
    return self.tf.secureTextEntry;
}

- (UITextContentType)textContentType {
    return self.textContentType;
}

- (NSString *)text {
    return self.tf.text;
}

- (void)setText:(NSString *)text {
    self.tf.text = text;
}

- (RACSignal *)textSignal {
    return self.tf.rac_textSignal;
}

#pragma mark - Setters

- (void)setLeftView:(UIView *)leftView {
    _leftView = leftView;
    CGFloat width = CGRectGetWidth(leftView.frame);
    
    //reset left view container
    [self.leftViewContainer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //update constraint
    [self.leftViewContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.greaterThanOrEqualTo(@(width));
        make.width.equalTo(@(width)).priority(MASLayoutPriorityRequired - 1);
    }];
    //add left view to container
    [self.leftViewContainer addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.leftViewContainer);
    }];
    //update layout
    [self layoutIfNeeded];
}

- (void)setRightView:(UIView *)rightView {
    _rightView = rightView;
    CGFloat width = CGRectGetWidth(rightView.frame);
    
    [self.rightViewContainer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.rightViewContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.greaterThanOrEqualTo(@(width));
        make.width.equalTo(@(width)).priority(MASLayoutPriorityRequired - 1);
    }];
    [self.rightViewContainer addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.rightViewContainer);
    }];
    [self layoutIfNeeded];
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    self.tf.keyboardType = keyboardType;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    self.tf.secureTextEntry = secureTextEntry;
}

- (void)setTextContentType:(UITextContentType)textContentType {
    if (@available(iOS 10.0, *)) {
        self.tf.textContentType = textContentType;
    }
}

- (void)setErrorLabelText:(NSString *)errorLabelText {
    _errorLabelText = errorLabelText;
    self.errorTipLbl.text = _errorLabelText;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.maxLengthOfTextField == 0) {
        return YES;
    }
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    return newLength <= self.maxLengthOfTextField || returnKey;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.errorLabelText = nil;
    return YES;
}

#pragma mark - Life cycles

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.bottomLine];
        [self addSubview:self.leftViewContainer];
        [self addSubview:self.rightViewContainer];
        [self addSubview:self.tf];
        [self addSubview:self.errorTipLbl];

        [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self);
            make.height.equalTo(@1);
        }];
        [self.leftViewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.equalTo(self);
            make.bottom.equalTo(self.tf);
            make.width.greaterThanOrEqualTo(@(0));
            make.width.equalTo(@(0)).priority(MASLayoutPriorityRequired - 1);
        }];
        [self.rightViewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.top.equalTo(self);
            make.bottom.equalTo(self.tf);
            make.width.greaterThanOrEqualTo(@(0));
            make.width.equalTo(@(0)).priority(MASLayoutPriorityRequired - 1);
        }];
        [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.height.equalTo(@31);
            make.bottom.equalTo(self.bottomLine.mas_top);
            make.leading.equalTo(self.leftViewContainer.mas_trailing);
            make.trailing.equalTo(self.rightViewContainer.mas_leading);
        }];
        [self.errorTipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.bottomLine);
            make.top.equalTo(self.bottomLine.mas_bottom).offset(4);
            make.bottom.equalTo(self);
        }];
    }
    return self;
}

#pragma mark - Public API

- (void)setPlaceHolder:(NSString *)placeHolder {
    self.tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:@{
                                                                                                        NSFontAttributeName: [UIFont systemFontOfSize:14],
                                                                                                        NSForegroundColorAttributeName: [UIColor lightGrayColor]}];

}

@end
