//
//  MHPhoneAreaCodeSelectAlertView.h
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/11.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHAccountAlertView.h"

@class MHPhoneAreaCodeSelectAlertView;

@protocol MHPhoneAreaSelectAlertViewDelegate <NSObject>

- (void)areaCodeSelectView:(MHPhoneAreaCodeSelectAlertView *)view didSelectAreaCode:(NSString *)areaCode;

@end

@interface MHPhoneAreaCodeSelectAlertView : MHAccountAlertView

@property (nonatomic, copy) NSString *currentSelectAreaCode;
@property (nonatomic, weak) id<MHPhoneAreaSelectAlertViewDelegate> delegate;

@end
