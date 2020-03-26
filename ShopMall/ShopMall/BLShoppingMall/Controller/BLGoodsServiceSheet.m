//
//  BLGoodsServiceSheet.m
//  Hospital
//
//  Created by mac on 2020/3/24.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import "BLGoodsServiceSheet.h"

@interface BLGoodsServiceSheet ()
@property (nonatomic, strong) UIView *containerView;
@end

@implementation BLGoodsServiceSheet
+ (instancetype)sheetWithData:(NSArray *)dataArr sureBlock:(void(^)(id result))sure{
    BLGoodsServiceSheet *sheet = [[BLGoodsServiceSheet alloc]init];
    return sheet;
}

- (instancetype)init{

    self = [super init];

    if (self) {
    
        _containerView = [UIView new];
        
        [self.view addSubview:_containerView];
        
        _containerView.backgroundColor = [UIColor whiteColor];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.view.frame.size.width, autoScaleH(556)) byRoundingCorners:UIRectCornerTopRight |UIRectCornerTopLeft cornerRadii:CGSizeMake(18,18)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _containerView.bounds;
        maskLayer.path = maskPath.CGPath;
        _containerView.layer.mask = maskLayer;
        
        [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.bottom.equalTo(self.view);
            make.height.mas_offset(autoScaleH(556));
        }];
        
        UILabel *titleLab = [[UILabel alloc]init];
        
        [_containerView addSubview:titleLab];
        
        titleLab.font = AR_BOLDFONT16;
        
        titleLab.textColor = [UIColor blackColor];
        
        titleLab.text = @"享受服务";
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_containerView);
            make.top.equalTo(_containerView).offset(16);
        }];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_containerView addSubview:cancelBtn];
        
        [cancelBtn setImage:[UIImage imageNamed:@"icon_closeround_nor"] forState:UIControlStateNormal];
        
        [cancelBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
        
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_offset(18);
            make.top.equalTo(_containerView).offset(16);
            make.right.equalTo(_containerView).offset(-16);
        }];
    
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_containerView addSubview:sureBtn];
        [sureBtn setTitle:@"我知道了" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureBtn.titleLabel.font = AR_BOLDFONT16;
        [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.backgroundColor = Theme_HighLight_Color;
        sureBtn.layer.masksToBounds = YES;
        sureBtn.layer.cornerRadius = 22;
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_containerView);
            make.width.equalTo(_containerView).offset(-100);
            make.bottom.equalTo(_containerView).offset(-10);
            make.height.mas_offset(45);
        }];
        
        
        UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectZero];
        scroll.pagingEnabled = NO;
        scroll.directionalLockEnabled = YES;
        scroll.bounces = NO;
        [_containerView addSubview:scroll];
        
        [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.equalTo(_containerView);
            make.top.equalTo(titleLab.mas_bottom).offset(10);
            make.bottom.equalTo(sureBtn.mas_top).offset(-10);
        }];
        
        NSArray *arr = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
        UIView *last = nil;
        for (int i = 0; i < arr.count; i++) {
            UIImageView *img = [[UIImageView alloc]init];
            [scroll addSubview:img];
            img.image = [UIImage imageNamed:@"icon_attentiona_nor"];
            
            UILabel *title = [[UILabel alloc]init];
            [scroll addSubview:title];
            title.font = AR_FONT14;
            title.textColor = AR_RGBCOLOR(113, 113, 113);
            title.text = @"七天无理由";
            
            UILabel *textLab = [[UILabel alloc]init];
            [scroll addSubview:textLab];
            textLab.font = AR_FONT12;
            textLab.textColor = AR_RGBCOLOR(113, 113, 113);
            textLab.numberOfLines = 0;
            textLab.text = @"满足7天无理由退换货申请条件的前提下,包邮商品需要买家承担退换邮费,非包邮商品需要买家成安发货和退货邮费。";
            
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_offset(16);
                make.left.equalTo(scroll).offset(23);
                if (!last) {
                    make.top.equalTo(scroll).offset(20);
                }
                else{
                    make.top.equalTo(last.mas_bottom).offset(35);
                }
            }];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(img);
                make.left.equalTo(img.mas_right).offset(10);
            }];
            [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(title);
                make.right.equalTo(_containerView).offset(-30);
                make.top.equalTo(title.mas_bottom).offset(8);
                if (i == arr.count - 1) {
                    make.bottom.equalTo(scroll).offset(-20);
                }
            }];
            
            last = textLab;
        }
    }
    return self;
}

- (void)sure{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (ZXModallyAnimationController *)animationController {
    ZXModallyAnimationController *animation = [[ZXModallyAnimationController alloc]init];
    animation.animationStyle = WSModallyAnimationStyleActionSheet;
    animation.position = WSAnimationStartBottom;
    return animation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
