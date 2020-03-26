//
//  BLMallSortView.m
//  Hospital
//
//  Created by mac on 2020/3/21.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import "BLMallSortView.h"

@implementation BLMallSortView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = AR_RGBCOLOR(245, 245, 245);
        NSArray *options = @[@"综合排序",@"销量排序",@"价格排序"];
        UIButton *last = nil;
        for (int i = 0; i < options.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:btn];
            btn.titleLabel.font = AR_FONT12;
            [btn setTitle:options[i] forState:UIControlStateNormal];
            [btn setTitleColor:AR_RGBCOLOR(165, 165, 165) forState:UIControlStateNormal];
            [btn setTitleColor:Theme_HighLight_Color forState:UIControlStateSelected];
            btn.tag = i;
            [btn addTarget:self action:@selector(sortSelected:) forControlEvents:UIControlEventTouchUpInside];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.height.equalTo(self);
                make.width.equalTo(self).multipliedBy(0.33);
                if (i == 0) {
                    make.left.equalTo(self);
                }
                else{
                    make.left.equalTo(last.mas_right);
                }
            }];
            last = btn;
        }
    }
    return self;
}

- (void)sortSelected:(UIButton *)btn{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
