//
//  MHLoginPwdInputView.h
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/11.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHAccountInputView.h"

@interface MHLoginPasswordRightView : UIView

@property (nonatomic, readonly) UIButton *forgetBtn;

@end

@interface MHLoginPwdInputView : MHAccountInputView

@property (nonatomic, readonly) MHLoginPasswordRightView *pwdRightView;

@end
