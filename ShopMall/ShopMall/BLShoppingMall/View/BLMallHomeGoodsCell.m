//
//  BLMallHomeGoodsCell.m
//  Hospital
//
//  Created by mac on 2020/3/20.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import "BLMallHomeGoodsCell.h"

@implementation BLMallHomeGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.tagLab.width, self.tagLab.height) byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(8,8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.tagLab.bounds;
    maskLayer.path = maskPath.CGPath;
    self.tagLab.layer.mask = maskLayer;
    
    self.feeLab.alpha = 0.7;
    self.nameLab.font = AR_BOLDFONT14;
    self.logo.backgroundColor = [UIColor redColor];
    self.nameLab.text = @"陈李济 | 新会贡品陈皮五年装";
    self.descLab.text = @"滋阴去火，养生方便";
    self.priceLab.text = @"¥ 198.00";
    self.oldPriceLab.text = @"198.00";
}

@end
