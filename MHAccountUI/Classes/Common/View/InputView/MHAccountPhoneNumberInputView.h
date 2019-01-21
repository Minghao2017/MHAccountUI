//
//  MHAccountPhoneNumberInputView.h
//  Minghao Xue
//
//  Created by Minghao Xue on 2018/9/11.
//  Copyright © 2018 Minghao Xue. All rights reserved.
//

#import "MHAccountInputView.h"
#import "MHPhoneAreaCodeLeftView.h"

@interface MHAccountPhoneNumberInputView : MHAccountInputView

@property (nonatomic, readonly) MHPhoneAreaCodeLeftView *areaCodeView;

@end
