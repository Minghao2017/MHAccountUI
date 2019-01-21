//
//  MHAccountInputView.h
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/11.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <ReactiveObjC/ReactiveObjC.h>

@interface MHAccountInputView : UIView

/**
 设置左侧视图。
 注意：
 1. 需要提前配置好frame以确定显示的最小宽度；
 2. 要确保显示正确的宽度需要保证子视图在水平方向上的约束是完备的。如subview1.leading=leftView.leanding,subview2.leading=subview1.trailing ... lastview.trailing=leftview.trailing
 */
@property (nonatomic, strong) UIView *leftView;

/**
 设置右侧视图。
 使用方法同上。
 */
@property (nonatomic, strong) UIView *rightView;

@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) BOOL secureTextEntry;
@property (nonatomic, assign) UITextContentType textContentType;
@property (nonatomic, copy) NSString *text;

/**
 错误提示信息
 */
@property (nonatomic, copy) NSString *errorLabelText;
/**
 TextField的最大长度。0为不受限制。defaults to 0。
 */
@property (nonatomic, assign) NSUInteger maxLengthOfTextField;

@property (nonatomic, readonly) RACSignal *textSignal;

- (void)setPlaceHolder:(NSString *)placeHolder;

@end
