//
//  BLShareGoodsAlert.h
//  Hospital
//
//  Created by mac on 2020/3/24.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import "ZXModallyViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BLShareGoodsAlert : ZXModallyViewController
+ (instancetype)sheetWithData:(NSArray *)dataArr sureBlock:(void(^)(id result))sure;
@end

NS_ASSUME_NONNULL_END
