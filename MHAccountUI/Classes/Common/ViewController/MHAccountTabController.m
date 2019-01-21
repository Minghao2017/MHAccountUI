//
//  MHAccountTabController.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/10.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHAccountTabController.h"

@interface MHAccountTabController ()

@end

@implementation MHAccountTabController

#pragma mark - Life cycles;

- (instancetype)init {
    if (self = [super init]) {
        self.dataSource = self;
    }
    return self;
}

#pragma mark - MHTabControllerDataSource

- (NSUInteger)numberOfTabItems {
    return 0;
}

- (NSString *)titleForItemAtIndex:(NSUInteger)index {
    return nil;
}

- (UIViewController *)presentViewControlerForItemAtIndex:(NSUInteger)index {
    return nil;
}

- (NSUInteger)defaultTabIndex {
    return 0;
}

@end
