//
//  BLGoodsDetailInfoCell.m
//  Hospital
//
//  Created by mac on 2020/3/23.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import "BLGoodsDetailInfoCell.h"

@implementation BLGoodsDetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.priceLab.font = AR_BOLDFONT16;
    self.nameLab.font = AR_BOLDFONT18;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
