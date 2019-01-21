//
//  MHLoginVC.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/6.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHLoginVC.h"
#import "MHPhoneLoginTabVC.h"
#import "MHEmailLoginTabVC.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

@interface MHLoginVC ()

@property (nonatomic, strong) MHPhoneLoginTabVC *phoneLoginTabVC;
@property (nonatomic, strong) MHEmailLoginTabVC *emailLoginTabVC;

@end

@implementation MHLoginVC

#pragma mark - Life cycles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Log in", nil);
}

#pragma mark - Getters

- (MHPhoneLoginTabVC *)phoneLoginTabVC {
    if (!_phoneLoginTabVC) {
        _phoneLoginTabVC = [[MHPhoneLoginTabVC alloc] init];
        @weakify(self);
        [[_phoneLoginTabVC.footerViewSignUpBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self routeToSignUpPage];
        }];
    }
    return _phoneLoginTabVC;
}

- (MHEmailLoginTabVC *)emailLoginTabVC {
    if (!_emailLoginTabVC) {
        _emailLoginTabVC = [[MHEmailLoginTabVC alloc] init];
        @weakify(self);
        [[_emailLoginTabVC.footerViewSignUpBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self routeToSignUpPage];
        }];
    }
    return _emailLoginTabVC;
}

#pragma mark - Private methods

- (void)routeToSignUpPage {
}

#pragma mark - Overrides

- (NSUInteger)numberOfTabItems {
    return 2;
}

- (NSString *)titleForItemAtIndex:(NSUInteger)index {
    if (index == 0 ) {
        return self.phoneLoginTabVC.navigationItem.title;
    } else {
        return self.emailLoginTabVC.navigationItem.title;
    }
}

- (UIViewController *)presentViewControlerForItemAtIndex:(NSUInteger)index {
    if (index == 0 ) {
        return self.phoneLoginTabVC;
    } else {
        return self.emailLoginTabVC;
    }
}

- (NSUInteger)defaultTabIndex {
    return 0;
}

@end
