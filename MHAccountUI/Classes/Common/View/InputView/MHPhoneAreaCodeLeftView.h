//
//  MHPhoneAreaCodeLeftView.h
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/11.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MHPhoneAreaCodeLeftView;

@protocol MHPhoneAreaCodeLeftViewDelegate <NSObject>

- (void)areaCodeLeftViewDidClicked:(MHPhoneAreaCodeLeftView *)view;

@end

@interface MHPhoneAreaCodeLeftView : UIView

@property (nonatomic, weak) id<MHPhoneAreaCodeLeftViewDelegate> delegate;

@property (nonatomic, copy) NSString *areaCode;

@end
