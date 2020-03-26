//
//  BLSelectGoodsSheet.m
//  Hospital
//
//  Created by mac on 2020/3/23.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import "BLSelectGoodsSheet.h"
#import <TPKeyboardAvoidingCollectionView.h>
#import "SSLCollectionViewLayout.h"
@interface BLSelectGoodsSheet ()<UICollectionViewDelegate,UICollectionViewDataSource,SSLCollectionViewLayoutDelegate>
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *numLab;
@property (nonatomic, strong) UILabel *selectedLab;
@property (nonatomic, strong) TPKeyboardAvoidingCollectionView *collectionView;
@property (nonatomic, strong) UITextField *numField;
@property (nonatomic, strong) UILabel *shareTextLab;
@property (nonatomic, strong) NSArray *arr;
@end

@implementation BLSelectGoodsSheet
+ (instancetype)sheetWithData:(NSArray *)dataArr sureBlock:(void(^)(id result))sure{
    BLSelectGoodsSheet *sheet = [[BLSelectGoodsSheet alloc]init];
    sheet.callback  = sure;
    return sheet;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        _arr = @[@"一年装",@"二年装",@"五年",@"45g/盒",@"1000g/盒",@"二十年装"];
        
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
        
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_containerView addSubview:cancelBtn];
        
        [cancelBtn setImage:[UIImage imageNamed:@"icon_closeround_nor"] forState:UIControlStateNormal];
        
        [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_offset(18);
            make.top.equalTo(_containerView).offset(16);
            make.right.equalTo(_containerView).offset(-16);
        }];
        
        _logo = [[UIImageView alloc]init];
        
        [_containerView addSubview:_logo];
        
        _logo.backgroundColor = [UIColor redColor];
        
        [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_offset(97);
            make.top.left.equalTo(_containerView).offset(18);
        }];
        
        _priceLab = [[UILabel alloc]init];
        
        [_containerView addSubview:_priceLab];
        
        _priceLab.font = AR_BOLDFONT21;
        
        _priceLab.textColor = Theme_HighLight_Color;
        
        _priceLab.text = @"178.00";
        
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_logo).offset(10);
            make.left.equalTo(_logo.mas_right).offset(8);
        }];
        
        _numLab = [[UILabel alloc]init];
        
        _numLab.font = AR_FONT12;
        
        _numLab.textColor = AR_RGBCOLOR(153, 153, 153);
        
        _numLab.text = @"剩余2983件";
        
        [_containerView addSubview:_numLab];
        
        [_numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_priceLab);
            make.top.equalTo(_priceLab.mas_bottom).offset(10);
        }];
        
        _selectedLab = [[UILabel alloc]init];
        
        [_containerView addSubview:_selectedLab];
        
        _selectedLab.font = AR_FONT12;
        
        _selectedLab.textColor = AR_RGBCOLOR(153, 153, 153);
        
        _selectedLab.text = @"五年装 45g/盒";
        
        [_selectedLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_numLab);
            make.top.equalTo(_numLab.mas_bottom).offset(10);
        }];
        

        
        SSLCollectionViewLayout *layout = [[SSLCollectionViewLayout alloc]init];
        layout.sectionEdge = UIEdgeInsetsMake(10, 18, 10, 18);
        layout.itemHVSpace = 10;
        layout.itemHeight = 30;
        layout.itemLRSpace = 10;
        layout.delegate = self;
        _collectionView = [[TPKeyboardAvoidingCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_containerView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.equalTo(_containerView);
            make.top.equalTo(_logo.mas_bottom).offset(10);
            make.bottom.equalTo(_containerView).offset(-65);
        }];
        
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_containerView addSubview:shareBtn];
        [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        shareBtn.backgroundColor = Theme_HighLight_Color;
        shareBtn.layer.masksToBounds = YES;
        shareBtn.layer.cornerRadius = 22;
        [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_containerView);
            make.width.equalTo(_containerView).offset(-100);
            make.bottom.equalTo(_containerView).offset(-10);
            make.height.mas_offset(45);
        }];
        UILabel *lab = [[UILabel alloc]init];
        [shareBtn addSubview:lab];
        lab.text = @"立即分享";
        lab.font = AR_BOLDFONT16;
        lab.textColor = [UIColor whiteColor];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(shareBtn);
            make.top.equalTo(shareBtn).offset(6);
        }];
        [shareBtn addSubview:self.shareTextLab];
        [_shareTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(shareBtn);
            make.top.equalTo(lab.mas_bottom).offset(3);
        }];
    }
    return self;
}

- (UILabel *)shareTextLab{
    if (!_shareTextLab) {
        _shareTextLab = [[UILabel alloc]init];
        _shareTextLab.textColor = [UIColor whiteColor];
        _shareTextLab.font = AR_FONT10;
        _shareTextLab.text = @"分享购买成功后可赚20.00元";
    }
    return _shareTextLab;
}

- (UITextField *)numField{
    if (!_numField) {
        _numField = [[UITextField alloc]init];
        _numField.keyboardType = UIKeyboardTypeNumberPad;
        _numField.backgroundColor = Theme_Bg_Color;
        _numField.textAlignment = NSTextAlignmentCenter;
        _numField.text = @"1";
    }
    return _numField;
}

- (void)share{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:^{
            BLOCK_EXEC(_callback,@"")
        }];
    });
}

- (void)subtract{
    if ([_numField.text integerValue] <= 1) {
        return;
    }
    NSInteger num = [_numField.text integerValue] - 1;
    _numField.text = [NSString stringWithFormat:@"%ld",num];
}

- (void)add{
    NSInteger num = [_numField.text integerValue] + 1;
    _numField.text = [NSString stringWithFormat:@"%ld",num];
}

- (CGFloat)heightOfSectionHeaderForIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}



- (CGFloat)collectionView:(UICollectionView *)collectionView wideForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [NSString stringWithFormat:@"  %@  ",_arr[indexPath.row]];
    CGSize textMaxSize = CGSizeMake(AR_SCREEN_WIDTH - 2 *30, MAXFLOAT);
    CGFloat ww = [text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.width + 20;
    ww = MAX(ww, 60);
    return ww;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.backgroundColor = [UIColor whiteColor];
        for (UIView *view in header.subviews)
        {
            [view removeFromSuperview];
        }
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(18, 5, AR_SCREEN_WIDTH - 36, 0.5)];
        [header addSubview:line];
        line.backgroundColor = Theme_Line_Color;
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 10, AR_SCREEN_WIDTH - 36, 30)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = AR_BOLDFONT14;
        [header addSubview:titleLabel];
        if (indexPath.section == 0) {
            titleLabel.text = @"年份";
        }
        else if(indexPath.section == 1){
            titleLabel.text = @"规格";
        }
        else if (indexPath.section == 2){
            titleLabel.text = @"数量";
            [header addSubview:self.numField];
            
            
            UIButton *subtractbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [subtractbtn addTarget:self action:@selector(subtract) forControlEvents:UIControlEventTouchUpInside];
            subtractbtn.backgroundColor = Theme_Bg_Color;
            [subtractbtn setTitle:@"-" forState:UIControlStateNormal];
            [subtractbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [header addSubview:subtractbtn];
            
            UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [addBtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
            [addBtn setTitle:@"+" forState:UIControlStateNormal];
            [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            addBtn.backgroundColor = Theme_Bg_Color;
            [header addSubview:addBtn];
            
            [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_offset(23);
                make.centerY.equalTo(titleLabel);
                make.right.equalTo(header).offset(-20);
            }];
            [_numField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(titleLabel);
                make.right.equalTo(addBtn.mas_left).offset(-1.5);
                make.width.mas_offset(30);
                make.height.mas_offset(23);
            }];
            [subtractbtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_offset(23);
                make.centerY.equalTo(titleLabel);
                make.right.equalTo(_numField.mas_left).offset(-1.5);
            }];
        }
        return header;
    }
    UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
    footer.backgroundColor = [UIColor whiteColor];
    for (UIView *view in footer.subviews)
    {
        [view removeFromSuperview];
    }

    
    return nil;
    
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 2) {
        return 0;
    }
    return _arr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = AR_RGBCOLOR(247, 247, 247);
    cell.layer.borderColor = AR_RGBCOLOR(187, 187, 187).CGColor;
    cell.layer.borderWidth = 0.5;
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 14;
    for (UIView *vv in cell.contentView.subviews) {
        [vv removeFromSuperview];
    }
    UILabel *textLab = [[UILabel alloc]init];
    [cell.contentView addSubview:textLab];
    textLab.font = AR_FONT14;
    textLab.textColor = AR_RGBCOLOR(160, 160, 160);
    textLab.text = _arr[indexPath.row];
    [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(cell.contentView);
    }];
    if (indexPath.row == 0) {
        cell.backgroundColor = AR_RGBCOLOR(255, 230, 226);
        cell.layer.borderColor = Theme_HighLight_Color.CGColor;
        textLab.textColor = Theme_HighLight_Color;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}


- (void)cancel{
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
