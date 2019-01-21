//
//  MHSignUpVC.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/6.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHSignUpVC.h"
#import "MHPhoneSignupTabVC.h"
#import "MHEmailSignupTabVC.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

@interface MHSignUpVC ()

@property (nonatomic, strong) MHPhoneSignupTabVC *phoneSignUpTabVC;
@property (nonatomic, strong) MHEmailSignupTabVC *emailSignUpTabVC;

@end

@implementation MHSignUpVC

#pragma mark - Life cycles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Sign Up", nil);
}

#pragma mark - Private methods

- (void)routeToLoginPage {
    
}

- (NSDictionary *)paramsTransferToPhone {
    return nil;
}

- (NSDictionary *)paramsTransferToEmail {
    return nil;
}

#pragma mark - Getters

- (MHPhoneSignupTabVC *)phoneSignUpTabVC {
    if (!_phoneSignUpTabVC) {
        _phoneSignUpTabVC = [[MHPhoneSignupTabVC alloc] init];
        @weakify(self);
        [[_phoneSignUpTabVC.footerViewLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self routeToLoginPage];
        }];
    }
    return _phoneSignUpTabVC;
}

- (MHEmailSignupTabVC *)emailSignUpTabVC {
    if (!_emailSignUpTabVC) {
        _emailSignUpTabVC = [[MHEmailSignupTabVC alloc] init];
        @weakify(self);
        [[_emailSignUpTabVC.footerViewLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self routeToLoginPage];
        }];
    }
    return _emailSignUpTabVC;
}

#pragma mark - Override

- (NSUInteger)numberOfTabItems {
    return 2;
}

- (NSString *)titleForItemAtIndex:(NSUInteger)index {
    if (index == 0 ) {
        return self.phoneSignUpTabVC.navigationItem.title;
    } else  {
        return self.emailSignUpTabVC.navigationItem.title;
    }
}

- (UIViewController *)presentViewControlerForItemAtIndex:(NSUInteger)index {
    if (index == 0 ) {
        return self.phoneSignUpTabVC;
    } else  {
        return self.emailSignUpTabVC;
    }
    return nil;
}

- (NSUInteger)defaultTabIndex {
    return 0;
}

@end
