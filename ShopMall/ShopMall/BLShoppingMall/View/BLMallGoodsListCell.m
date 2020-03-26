//
//  BLMallGoodsListCell.m
//  Hospital
//
//  Created by mac on 2020/3/21.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import "BLMallGoodsListCell.h"

@implementation BLMallGoodsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.tagLab.width, self.tagLab.height) byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(8,8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.tagLab.bounds;
    maskLayer.path = maskPath.CGPath;
    self.tagLab.layer.mask = maskLayer;
    self.logo.layer.masksToBounds = YES;
    self.logo.layer.cornerRadius = 4;
    self.shareBtn.layer.masksToBounds = YES;
    self.shareBtn.layer.cornerRadius = 4;
    self.nameLab.font = AR_BOLDFONT16;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
