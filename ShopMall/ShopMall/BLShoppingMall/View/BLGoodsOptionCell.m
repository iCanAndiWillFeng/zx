//
//  BLGoodsOptionCell.m
//  Hospital
//
//  Created by mac on 2020/3/23.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import "BLGoodsOptionCell.h"

@implementation BLGoodsOptionCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        _titleLab = [[UILabel alloc]init];
        [self.contentView addSubview:_titleLab];
        _titleLab.font = AR_FONT14;
        _titleLab.textColor = AR_RGBCOLOR(180, 180, 180);
        
        _descLab = [[UILabel alloc]init];
        [self.contentView addSubview:_descLab];
        _descLab.textColor = [UIColor blackColor];
        _descLab.font = AR_FONT14;
        
        _rightLab = [[UILabel alloc]init];
        [self.contentView addSubview:_rightLab];
        _rightLab.font = AR_FONT14;
        _rightLab.textColor = AR_RGBCOLOR(180, 180, 180);
        
        _rightImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_rightImg];
        _rightImg.image = [UIImage imageNamed:@"icon_right1_nor"];
        
        _line = [[UIView alloc]init];
        [self.contentView addSubview:_line];
        _line.backgroundColor = Theme_Line_Color;
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.bottom.right.equalTo(self.contentView);
            make.height.mas_offset(.5);
        }];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(16);
        }];
        [_rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-13);
        }];
        [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(_titleLab.mas_right).offset(15);
            make.right.equalTo(_rightLab.mas_left).offset(-10);
        }];
        [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(12);
            make.height.mas_offset(8);
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-13);
        }];
        
        [_titleLab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_rightLab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_descLab setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
