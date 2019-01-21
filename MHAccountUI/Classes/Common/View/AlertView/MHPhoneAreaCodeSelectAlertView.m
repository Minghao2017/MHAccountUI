//
//  MHPhoneAreaCodeSelectAlertView.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/11.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHPhoneAreaCodeSelectAlertView.h"

//三方库
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

@interface MHPhoneAreaCodeSelectCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *areaCodeLbl;

@end

@implementation MHPhoneAreaCodeSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLbl = [UILabel new];
        self.titleLbl.font = [UIFont systemFontOfSize:16];
        self.titleLbl.textColor = [UIColor blackColor];
        
        self.areaCodeLbl = [UILabel new];
        self.areaCodeLbl.textAlignment = NSTextAlignmentRight;
        self.areaCodeLbl.font = [UIFont systemFontOfSize:16];
        self.areaCodeLbl.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:self.titleLbl];
        [self.contentView addSubview:self.areaCodeLbl];
        [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(16);
            make.centerY.equalTo(self.contentView);
            make.trailing.lessThanOrEqualTo(self.areaCodeLbl.mas_leading).offset(-8);
        }];
        [self.areaCodeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.contentView).offset(-24);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@48);
        }];
    }
    return self;
}

@end

@interface MHPhoneAreaCodeSelectAlertView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *contentView;

@end

@implementation MHPhoneAreaCodeSelectAlertView

#pragma mark - Lazy load

- (UITableView *)contentView {
    if (!_contentView) {
        _contentView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _contentView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _contentView.rowHeight = 44;
        [_contentView registerClass:[MHPhoneAreaCodeSelectCell class] forCellReuseIdentifier:@"MHPhoneAreaCodeSelectCell"];
        _contentView.dataSource = self;
        _contentView.delegate = self;
    }
    return _contentView;
}

#pragma mark - Override

- (NSString *)titleLblText {
    return NSLocalizedString(@"Select Country/Region", nil);
}

- (CGFloat)contentViewHeight {
    return 205;
}

- (UIView *)alertContentView {
    return self.contentView;
}

- (NSString *)actionButtonText {
    return NSLocalizedString(@"Confirm", nil);
}

- (void)actionButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(areaCodeSelectView:didSelectAreaCode:)]) {
        [self.delegate areaCodeSelectView:self didSelectAreaCode:self.currentSelectAreaCode];
    }
    [super actionButtonClicked:sender];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MHPhoneAreaCodeSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MHPhoneAreaCodeSelectCell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
