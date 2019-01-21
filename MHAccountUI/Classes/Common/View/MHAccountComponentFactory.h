//
//  MHAccountComponentFactory.h
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/7.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHAccountComponentFactory : NSObject

+ (UIButton *)gradientRoundButton;
+ (UIButton *)gradientButton;
+ (UIButton *)whiteBorderedButton;

+ (UILabel *)passwordTipLbl;

@end
