//
//  MHAccountEmailInputView.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/19.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHAccountEmailInputView.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

@interface MHAccountEmailAutoCompleteCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLbl;

@end

@implementation MHAccountEmailAutoCompleteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.titleLbl = [UILabel new];
        self.titleLbl.textColor = [UIColor blackColor];
        self.titleLbl.font = [UIFont systemFontOfSize:14];
        self.titleLbl.numberOfLines = 0;
        [self.contentView addSubview:self.titleLbl];
        [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(10);
            make.trailing.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.contentView).offset(9);
            make.bottom.equalTo(self.contentView).offset(-9);
        }];
    }
    return self;
}

@end

/**
 实现tableView固有大小等于contentSize
 */
@interface MHAcountEmailInputTableView : UITableView
@end

@implementation MHAcountEmailInputTableView

- (void)setContentSize:(CGSize)contentSize {
    [super setContentSize:contentSize];
    [self invalidateIntrinsicContentSize];
}

- (CGSize)intrinsicContentSize {
    return self.contentSize;
}

@end

@interface MHAccountEmailInputView ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) MHAcountEmailInputTableView *autoCompleteEmailList;
@property (nonatomic, strong) NSArray<NSString *> *dataSource;

@end

@implementation MHAccountEmailInputView

#pragma mark - Life cycle

- (instancetype)init {
    if (self = [super init]) {
        self.keyboardType = UIKeyboardTypeEmailAddress;
        @weakify(self);
        [[self.textSignal distinctUntilChanged]  subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            [self updateAutoCompleteEmailListView];
        }];
    }
    return self;
}

#pragma mark - Private methods

- (void)updateAutoCompleteEmailListView {
    [self showEmailListView];
    [self updateDataSource];
    [self.autoCompleteEmailList reloadData];
}

- (void)updateDataSource {
    NSString *text = self.text;
    if (text.length == 0) {
        self.dataSource = nil;
        return;
    }
    
    NSArray *components = [text componentsSeparatedByString:@"@"];
    
    NSArray *emails = @[@"gmail.com",@"hotmail.com",@"yahoo.com",@"outlook.com",@"icloud.com"];
    if (components.count > 1) {
        NSString *filter = components[1];
        if (filter.length > 0) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
                return [evaluatedObject hasPrefix:filter.lowercaseString];
            }];
            emails = [emails filteredArrayUsingPredicate:predicate];
        }
    }
    
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:emails.count];
    for (NSString *email in emails) {
        [temp addObject:[NSString stringWithFormat:@"%@@%@", components.firstObject, email]];
    }
    
    self.dataSource = [temp copy];
    
    if (self.dataSource.count == 1 &&
        [text isEqualToString:self.dataSource.firstObject]) {
        self.dataSource = nil;
    }
}

- (UIView *)nearestViewControllerRootView {
    return [self nearestViewControllerForView:self].view;
}

- (UIViewController *)nearestViewControllerForView:(UIResponder *)responder {
    if ([responder isKindOfClass:[UIViewController class]]) {
        return (UIViewController *)responder;
    }
    return [self nearestViewControllerForView:responder.nextResponder];
}

- (void)showEmailListView {
    if (self.text.length == 0) {
        return;
    }
    if (!self.autoCompleteEmailList.superview) {
        UIView *containerView = [self nearestViewControllerRootView];
        [containerView addSubview:self.autoCompleteEmailList];
        [self.autoCompleteEmailList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self);
            make.top.equalTo(self.mas_bottom);
        }];
    }
}

- (void)hideEmailListView {
    [self.autoCompleteEmailList removeFromSuperview];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MHAccountEmailAutoCompleteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MHAccountEmailAutoCompleteCell" forIndexPath:indexPath];
    NSString *email = self.dataSource[indexPath.row];
    cell.titleLbl.text = email;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *email = self.dataSource[indexPath.row];
    self.text = email;
    [self hideEmailListView];
}

#pragma mark - Getters

- (MHAcountEmailInputTableView *)autoCompleteEmailList {
    if (!_autoCompleteEmailList) {
        _autoCompleteEmailList = [[MHAcountEmailInputTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _autoCompleteEmailList.separatorInset = UIEdgeInsetsZero;
        [_autoCompleteEmailList registerClass:[MHAccountEmailAutoCompleteCell class] forCellReuseIdentifier:@"MHAccountEmailAutoCompleteCell"];
        _autoCompleteEmailList.rowHeight = UITableViewAutomaticDimension;
        _autoCompleteEmailList.dataSource = self;
        _autoCompleteEmailList.delegate = self;
    }
    return _autoCompleteEmailList;
}

@end
