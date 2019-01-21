//
//  MHLastLoginInfoView.h
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/6.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHAccountAlertView.h"

@class MHLastLoginInfoView;

@protocol MHLastLoginInfoViewDelegate <NSObject>

- (void)lastLoginInfoViewDidClickedLoginBtn:(MHLastLoginInfoView *)view;

@end

@interface MHLastLoginInfoView : MHAccountAlertView

@property (nonatomic, weak) id<MHLastLoginInfoViewDelegate> delegate;

@end
