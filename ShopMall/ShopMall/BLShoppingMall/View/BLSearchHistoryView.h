//
//  BLSearchHistoryView.h
//  Hospital
//
//  Created by mac on 2020/3/20.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^BLSearchHistoryBlock)(NSString *string);
@interface BLSearchHistoryView : UIView
@property (nonatomic, copy) BLSearchHistoryBlock callback;
- (void)reload;
@end

NS_ASSUME_NONNULL_END
