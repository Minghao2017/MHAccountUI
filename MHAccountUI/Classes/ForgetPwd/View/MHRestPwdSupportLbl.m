//
//  MHRestPwdSupportLbl.m
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/12.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHRestPwdSupportLbl.h"

@implementation MHRestPwdSupportLbl

- (instancetype)init {
    if (self = [super init]) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
        NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Have changed phone number/Email?", nil) attributes:@{
                                                                                                                                                       NSFontAttributeName : [UIFont systemFontOfSize:14],
                                                                                                                                                       NSForegroundColorAttributeName : [UIColor blackColor]
                                                                                                                                                       }];
        NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"CF support", nil) attributes:@{
                                                                                                                                 NSFontAttributeName : [UIFont systemFontOfSize:14],
                                                                                                                                 NSForegroundColorAttributeName : [UIColor blackColor],
                                                                                                                                 NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle]
                                                                                                                                 
                                                                                                                                 }];
        [str appendAttributedString:str1];
        [str appendAttributedString:str2];
        self.attributedText = str;
        self.numberOfLines = 0;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(routeToChatPage)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)routeToChatPage {
    
}

@end
