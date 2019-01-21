//
//  MHAccountLoginFooterView.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/11.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHAccountLoginFooterView.h"

@implementation MHAccountLoginFooterView

#pragma mark - Override

- (NSString *)tipLblText {
    return NSLocalizedString(@"New User?", nil);
}

- (NSString *)actionBtnText {
    return NSLocalizedString(@"Sign Up>", nil);
}

@end
