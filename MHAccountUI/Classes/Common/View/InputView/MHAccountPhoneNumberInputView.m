//
//  MHAccountPhoneNumberInputView.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/11.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHAccountPhoneNumberInputView.h"

@interface MHAccountPhoneNumberInputView ()

@property (nonatomic, strong) MHPhoneAreaCodeLeftView *areaCodeView;

@end

@implementation MHAccountPhoneNumberInputView

- (instancetype)init {
    if (self = [super init]) {
        self.keyboardType = UIKeyboardTypePhonePad;
        [self setPlaceHolder:NSLocalizedString(@"Phone Number", nil)];
        self.areaCodeView = [MHPhoneAreaCodeLeftView new];
        self.areaCodeView.frame = CGRectMake(0, 0, 44, 0);
        self.leftView = self.areaCodeView;
    }
    return self;
}

@end
