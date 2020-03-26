//
//  BLMallPersonCenterVC.m
//  Hospital
//
//  Created by mac on 2020/3/25.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import "BLMallPersonCenterVC.h"
#import "BLMallIncomeCell.h"
#import "BLIncomeListVC.h"
#import <Masonry/Masonry.h>
@interface BLMallPersonCenterVC ()
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *levelLab;
@end

@implementation BLMallPersonCenterVC

-(void)viewWillAppear:(BOOL)animated {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = Theme_Bg_Color;
    
    UIImageView *bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 164)];
    
    [self.view addSubview:bgImgView];
    
    bgImgView.backgroundColor = Theme_HighLight_Color;
    
    bgImgView.userInteractionEnabled = YES;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backBtn setImage:[UIImage imageNamed:@"icon_topright_white_nor"] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [bgImgView addSubview:backBtn];
        
    backBtn.frame = CGRectMake(0, 20, 50, 40);
    
    if (IS_IPHONE_X) {
        backBtn.frame = CGRectMake(0, 30, 50, 40);
    }
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 100)];
    
    topView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:topView];
    
    _logo = [[UIImageView alloc]init];
    
    [topView addSubview:_logo];
    
    _logo.layer.masksToBounds = YES;
    
    _logo.layer.cornerRadius = 27;
    
    _logo.backgroundColor = [UIColor yellowColor];
    
    _nameLab = [[UILabel alloc]init];
    
    [topView addSubview:_nameLab];
    
    _nameLab.font = AR_BOLDFONT18;
    
    _nameLab.textColor = [UIColor whiteColor];
    
    _nameLab.text = @"何川清医生";
    
    _levelLab = [[UILabel alloc]init];
    
    [topView addSubview:_levelLab];
    
    _levelLab.font = AR_FONT12;
    
    _levelLab.textColor = AR_RGBCOLOR(236, 192, 131);
    
    _levelLab.layer.masksToBounds = YES;
    
    _levelLab.layer.cornerRadius = 11;
    
    _levelLab.textAlignment = NSTextAlignmentCenter;
    
    _levelLab.backgroundColor = [UIColor blackColor];
    
    _levelLab.text = @"初级合伙人";
    
    UIImageView *rightImg = [[UIImageView alloc]init];
    
    [topView addSubview:rightImg];
    
    rightImg.image = [UIImage imageNamed:@"icon_arrowright_white_nor"];
    
    [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(54);
        make.top.equalTo(topView).offset(8);
        make.left.equalTo(topView).offset(20);
    }];
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logo);
        make.left.equalTo(_logo.mas_right).offset(10);
    }];
    [_levelLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_logo);
        make.left.equalTo(_nameLab);
        make.width.mas_offset(82);
        make.height.mas_offset(22);
    }];
    [rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_logo);
        make.right.equalTo(topView).offset(-18);
        make.height.mas_offset(16);
        make.width.mas_offset(10);
    }];
    
    [self.AR_TableView registerNib:[UINib nibWithNibName:NSStringFromClass([BLMallIncomeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([BLMallIncomeCell class])];
    self.AR_TableView.backgroundColor = [UIColor clearColor];
    self.AR_TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.AR_TableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(self.view);
        make.width.equalTo(self.view).offset(-14);
        make.top.equalTo(self.view).offset(154);
    }];
    
    self.AR_TableView.layer.masksToBounds = YES;
    self.AR_TableView.layer.cornerRadius = 8;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 32;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v =[[UIView alloc]init];
    v.backgroundColor = [UIColor whiteColor];
    for (UIView *vv in v.subviews) {
        [vv removeFromSuperview];
    }
    CGFloat wide = self.view.frame.size.width - 17;
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, wide/3, 32)];
    [v addSubview:titleLab];
    titleLab.text = @"合伙人收益";
    titleLab.textColor = [UIColor blackColor];
    titleLab.font = AR_BOLDFONT12;
    
    UILabel *levelLab = [[UILabel alloc]initWithFrame:CGRectMake(wide / 3 * 2 - 15, 0, wide/3, 32)];
    [v addSubview:levelLab];
    levelLab.textAlignment = NSTextAlignmentRight;
    levelLab.text = @"初级合伙人";
    levelLab.textColor = Theme_HighLight_Color;
    levelLab.font = AR_FONT12;

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 31.5, wide, 0.5)];
    [v addSubview:line];
    line.backgroundColor = Theme_Line_Color;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.view.frame.size.width - 14, 32) byRoundingCorners:UIRectCornerTopRight |UIRectCornerTopLeft cornerRadii:CGSizeMake(8,8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = v.bounds;
    maskLayer.path = maskPath.CGPath;
    v.layer.mask = maskLayer;
    
    return v;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BLMallIncomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BLMallIncomeCell class])];
    if (!cell) {
        cell = [[BLMallIncomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([BLMallIncomeCell class])];
    }
    if (indexPath.row == [tableView numberOfRowsInSection:0] - 1) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.view.frame.size.width - 14, 100) byRoundingCorners:UIRectCornerBottomRight |UIRectCornerBottomLeft cornerRadii:CGSizeMake(8,8)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = cell.bounds;
        maskLayer.path = maskPath.CGPath;
        cell.layer.mask = maskLayer;
    }
    if (indexPath.row == 0 || indexPath.row == 2) {
        cell.btn3.hidden = cell.valueLab3.hidden = cell.nameLab3.hidden = YES;
    }
    else{
        cell.btn3.hidden = cell.valueLab3.hidden = cell.nameLab3.hidden = NO;
    }
    if (indexPath.row == 2) {
        cell.titleLab.text = @"";
        for (UIView *vv in cell.contentView.subviews) {
            if (vv.tag == 1000) {
                [vv removeFromSuperview];
            }
        }
        UIButton *cashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cell.contentView addSubview:cashBtn];
        cashBtn.backgroundColor = Theme_HighLight_Color;
        [cashBtn setTitle:@"微信提现" forState:UIControlStateNormal];
        [cashBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cashBtn.titleLabel.font = AR_FONT14;
        cashBtn.tag = 1000;
        cashBtn.layer.masksToBounds = YES;
        cashBtn.layer.cornerRadius = 12;
        [cashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(86);
            make.height.mas_offset(25);
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView).offset(-30);
        }];
    }
    [cell.btn1 addTarget:self action:@selector(cellBtnClick:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn2 addTarget:self action:@selector(cellBtnClick:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn3 addTarget:self action:@selector(cellBtnClick:event:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)cellBtnClick:(UIButton *)btn event:(UIEvent *)event{
    //通过event获取手指的位置
    UITouch *touch = [[event allTouches] anyObject];
    //获取手指在tableView中的位置
    CGPoint point = [touch locationInView:self.AR_TableView];
    //获取indexPath
    NSIndexPath *index = [self.AR_TableView indexPathForRowAtPoint:point];
    if (index) {
        BLIncomeListVC *vc = [[BLIncomeListVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
