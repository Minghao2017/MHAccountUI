//
//  MHAccountAlertView.h
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/11.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 提示视图。从屏幕底部弹出
 */
@interface MHAccountAlertView : UIView

#pragma mark - show/hide

- (void)showInView:(UIView *)view animated:(BOOL)animated;
- (void)hideAnimated:(BOOL)animated;

#pragma mark - Sub class methods

- (NSString *)titleLblText;
- (NSString *)actionButtonText;

- (CGFloat)contentViewHeight;
- (UIView *)alertContentView;

- (void)closeButtonClicked:(UIButton *)sender;
- (void)actionButtonClicked:(UIButton *)sender;

@end
