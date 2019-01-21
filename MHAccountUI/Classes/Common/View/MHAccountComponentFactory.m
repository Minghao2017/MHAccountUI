//
//  MHAccountComponentFactory.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/7.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHAccountComponentFactory.h"

@implementation MHAccountComponentFactory

+ (UIButton *)gradientButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setBackgroundImage:[UIImage imageNamed:@"account_gradient_btn"] forState:UIControlStateNormal];
    return btn;
}

+ (UIButton *)gradientRoundButton {
    UIButton *btn = [self createSystemButton];
    [btn setBackgroundImage:[UIImage imageNamed:@"account_gradient_btn"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"account_gradient_btn_disabled"] forState:UIControlStateDisabled];
    return btn;
}

+ (UIButton *)whiteBorderedButton {
    UIButton *btn = [self createSystemButton];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [[UIColor orangeColor] CGColor];
    return btn;
}

+ (UIButton *)createSystemButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 4;
    btn.layer.masksToBounds = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    return btn;
}

+ (UILabel *)passwordTipLbl {
    UILabel *lbl = [UILabel new];
    lbl.textColor = [UIColor blackColor];
    lbl.font = [UIFont systemFontOfSize:12];
    lbl.text = NSLocalizedString(@"Your password must be 6-20 characters.", nil);
    return lbl;
}
@end
