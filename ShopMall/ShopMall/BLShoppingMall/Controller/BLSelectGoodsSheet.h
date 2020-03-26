//
//  BLSelectGoodsSheet.h
//  Hospital
//
//  Created by mac on 2020/3/23.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import "ZXModallyViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^BLSelectSheetBlock)(id result);
@interface BLSelectGoodsSheet : ZXModallyViewController
@property (nonatomic, copy) BLSelectSheetBlock callback;
+ (instancetype)sheetWithData:(NSArray *)dataArr sureBlock:(void(^)(id result))sure;
@end

NS_ASSUME_NONNULL_END
