//
//  BLGoodsListVC.h
//  Hospital
//
//  Created by mac on 2020/3/21.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import "ARCommonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BLGoodsListVC : ARCommonViewController
@property (nonatomic, assign) NSInteger source;   ///  0 全部商品   1分类商品
@property (nonatomic, strong) NSString *ID;
@end

NS_ASSUME_NONNULL_END
