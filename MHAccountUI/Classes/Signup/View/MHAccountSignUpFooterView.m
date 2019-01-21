//
//  MHAccountSignUpFooterView.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/11.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHAccountSignUpFooterView.h"

@implementation MHAccountSignUpFooterView

#pragma mark - Override

- (NSString *)tipLblText {
    return NSLocalizedString(@"Existing User?", nil);
}

- (NSString *)actionBtnText {
    return NSLocalizedString(@"Log In>", nil);
}

@end
