//
//  BLMallHomeVC.m
//  Hospital
//
//  Created by mac on 2020/3/19.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import "BLMallHomeVC.h"
#import "XRCarouselView.h"
#import "BLMallHomeGoodsCell.h"
#import "NormalWebViewController.h"
#import "BLMallSearchVC.h"
#import "BLMallAllGoodsVC.h"
#import "BLGoodsListVC.h"
#import "BLGoodsDetailVC.h"
#import <Masonry/Masonry.h>
@interface BLMallHomeVC ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,XRCarouselViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) XRCarouselView *bannerView;
@property (nonatomic, strong) UIView *partnerView;
@property (nonatomic, strong) UIImageView *logo;
@end

@implementation BLMallHomeVC
{
    BOOL _displayfees;
}
-(void)viewWillAppear:(BOOL)animated {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTopBarTitle:@"养生商城"];
    
    self.AR_TopTitleLabel.textColor = [UIColor whiteColor];
    
    [self.AR_BackBtn setImage:[UIImage imageNamed:@"icon_topright_white_nor"] forState:UIControlStateNormal];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.AR_TopBarView.backgroundColor = Theme_HighLight_Color;
  
    [self creatViews];
}

- (void)creatViews{
    UIImageView *topBg = [[UIImageView alloc]init];
    [self.view addSubview:topBg];
    topBg.backgroundColor = Theme_HighLight_Color;
    [topBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(self.view);
        make.top.equalTo(self.view).offset(63);
        make.height.mas_offset(40);
    }];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.view.frame.size.width, 40) byRoundingCorners:UIRectCornerBottomRight |UIRectCornerBottomLeft cornerRadii:CGSizeMake(15,15)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = topBg.bounds;
    maskLayer.path = maskPath.CGPath;
    topBg.layer.mask = maskLayer;
    
    topBg.userInteractionEnabled = YES;
    UISearchBar *searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(15, 0, AR_SCREEN_WIDTH - 30, 30)];
    [topBg addSubview:searchbar];
    searchbar.placeholder = @"  请输入商品名称搜索";
    searchbar.delegate = self;
    searchbar.searchBarStyle = UISearchBarStyleProminent;
    [searchbar setContentMode:UIViewContentModeLeft];
    searchbar.layer.masksToBounds = YES;
    searchbar.layer.cornerRadius = 15.0;
    searchbar.backgroundImage = [UIImage yy_imageWithColor:[UIColor whiteColor]];
    UITextField *searchField = nil;
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 13.0) {
        searchField = searchbar.searchTextField;
    }else{
        searchField = [searchbar valueForKey:@"_searchField"];
    }
    [searchField setBorderStyle:UITextBorderStyleNone];
    searchField.clearButtonMode = UITextFieldViewModeNever;
    searchField.font = AR_FONT14;
    [self.view addSubview:self.collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.bottom.equalTo(self.view);
        make.top.equalTo(topBg.mas_bottom).offset(0);
    }];
    
}



- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"BLMallHomeGoodsCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"mallHomeGoodCell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ViewCollectionViewHeader1"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ViewCollectionViewHeader2"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ViewCollectionViewHeader0"];
    }
    return _collectionView;
}

- (UIView *)partnerView{
    if (!_partnerView) {
        _partnerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,65)];
        _partnerView.backgroundColor = [UIColor whiteColor];
        UIView *bgv = [[UIView alloc]init];
        [_partnerView addSubview:bgv];
        bgv.backgroundColor = AR_RGBCOLOR(249, 247, 244);
        bgv.layer.masksToBounds = YES;
        bgv.layer.cornerRadius = 22;
        [bgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_partnerView);
            make.width.equalTo(_partnerView).offset(-22);
            make.height.equalTo(_partnerView).offset(-20);
        }];

        _logo = [[UIImageView alloc]init];
        [bgv addSubview:_logo];
        _logo.layer.masksToBounds = YES;
        _logo.layer.cornerRadius = 15;
        _logo.backgroundColor = [UIColor redColor];
        [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgv);
            make.left.equalTo(bgv).offset(10);
            make.width.height.mas_offset(30);
        }];
        UILabel *descLab = [[UILabel alloc]init];
        [bgv addSubview:descLab];
        descLab.font = AR_FONT15;
        descLab.textColor = [UIColor blackColor];
        descLab.text = @"尚未成为合伙人";
        [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgv);
            make.left.equalTo(_logo.mas_right).offset(6);
        }];
        
        UIButton *lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [bgv addSubview:lookBtn];
        [lookBtn setTitle:@"立即加入 >" forState:UIControlStateNormal];
        [lookBtn setTitleColor:Theme_HighLight_Color forState:UIControlStateNormal];
        [lookBtn addTarget:self action:@selector(toPartner) forControlEvents:UIControlEventTouchUpInside];
        lookBtn.titleLabel.font = AR_FONT15;
        [lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgv);
            make.right.equalTo(bgv).offset(-15);
        }];
    }
    return _partnerView;
}

- (void)toPartner{
    NormalWebViewController *vc = [[NormalWebViewController alloc]init];
    vc.url = @"https://www.baidu.com";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - XRCarouselViewDelegate
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index{
   
}

- (void)carouselView:(XRCarouselView *)carouselView currentIndex:(NSInteger)index{
    
}

- (XRCarouselView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[XRCarouselView alloc]initWithFrame:CGRectMake(10, 8, AR_SCREEN_WIDTH - 20, 140)];
        _bannerView.time = 3; // 设置轮播的执行时间
        _bannerView.delegate = self; // 代理
//        _bannerView.pagePosition = PositionHide;
        _bannerView.layer.masksToBounds = YES;
        _bannerView.layer.cornerRadius = 4;
        _bannerView.imageArray = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1584681542272&di=02010f26cdf4d300a09b88d68ccec078&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D1484500186%2C1503043093%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D853",
        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1584681542272&di=07cae959c0d810eae25fb2d5fb63b998&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D2247852322%2C986532796%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D853"];
    }
    return _bannerView;
}

- (void)displayfee:(UIButton *)btn{
    if (btn.tag == 1) {
        _displayfees = YES;
    }
    else{
        _displayfees = NO;
    }
    [_collectionView reloadData];
}

- (void)toAllGoods{
    BLMallAllGoodsVC *vc = [[BLMallAllGoodsVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 15, 0, 15);
}

#pragma mark - 视图内容
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeZero;
    }
    else if (indexPath.section == 1){
        return CGSizeMake((self.view.frame.size.width - 60) / 4, 80);
    }
    else{
        return  CGSizeMake((self.view.frame.size.width - 50) / 2, 250);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(self.view.frame.size.width, 148);
    }
    else if (section == 1){
        return CGSizeMake(self.view.frame.size.width, 65);
    }
    else{
        return CGSizeMake(self.view.frame.size.width, 54);
    }
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    // 视图添加到 UICollectionReusableView 创建的对象中
    if (kind == UICollectionElementKindSectionHeader && indexPath.section == 0) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ViewCollectionViewHeader0" forIndexPath:indexPath];
                
        [headerView addSubview:self.bannerView];
        return headerView;
    }else if (kind == UICollectionElementKindSectionHeader && indexPath.section == 1) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ViewCollectionViewHeader1" forIndexPath:indexPath];
        [headerView addSubview:self.partnerView];
        return headerView;
    }else if (kind == UICollectionElementKindSectionHeader && indexPath.section == 2) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ViewCollectionViewHeader2" forIndexPath:indexPath];
                
        for (UIView *vv in headerView.subviews) {
            [vv removeFromSuperview];
        }
        
        UIView *line = [[UIView alloc]init];
        [headerView addSubview:line];
        line.backgroundColor = Theme_Bg_Color;
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.width.equalTo(headerView);
            make.height.mas_offset(4);
        }];
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.textColor = [UIColor blackColor];
        titleLab.text = @"热销商品";
        titleLab.font = AR_BOLDFONT18;
        [headerView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView).offset(16);
            make.left.equalTo(headerView).offset(16);
        }];
        UIButton *showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        showBtn.tag = 1;
        [showBtn addTarget:self action:@selector(displayfee:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:showBtn];
        showBtn.backgroundColor = [UIColor redColor];
        [showBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleLab);
            make.left.equalTo(titleLab.mas_right).offset(8);
            make.width.height.mas_offset(12);
        }];
        UIButton *unshowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        unshowBtn.tag = 2;
        [unshowBtn addTarget:self action:@selector(displayfee:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:unshowBtn];
        unshowBtn.backgroundColor = [UIColor redColor];
        [unshowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleLab);
            make.left.equalTo(showBtn.mas_right).offset(5);
            make.width.height.mas_offset(12);
        }];
        
        UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [headerView addSubview:allBtn];
        [allBtn setTitle:@"全部商品" forState:UIControlStateNormal];
        [allBtn setTitleColor:Theme_HighLight_Color forState:UIControlStateNormal];
        allBtn.titleLabel.font = AR_FONT12;
        [allBtn addTarget:self action:@selector(toAllGoods) forControlEvents:UIControlEventTouchUpInside];
        [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleLab);
            make.right.equalTo(headerView).offset(-22);
        }];
        return headerView;
    }
    else {
        return nil;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    else if (section == 1){
        return 4;
    }
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        for (UIView *vv in cell.contentView.subviews) {
            if (vv.tag == 100) {
                [vv removeFromSuperview];
            }
        }
        UIImageView *imgView = [[UIImageView alloc]init];
        [cell.contentView addSubview:imgView];
        imgView.tag = 100;
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(cell.contentView);
            make.width.equalTo(cell.contentView).multipliedBy(.65);
            make.height.equalTo(cell.contentView).multipliedBy(.65);
        }];
        imgView.backgroundColor = [UIColor redColor];
        UILabel *nameLab = [[UILabel alloc]init];
        [cell.contentView addSubview:nameLab];
        nameLab.tag = 100;
        nameLab.font = AR_FONT12;
        nameLab.textColor = AR_RGBCOLOR(156, 156, 156);
        nameLab.text = @"精选商品";
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell.contentView);
            make.top.equalTo(imgView.mas_bottom).offset(6);
        }];
        return cell;
    }
    else if (indexPath.section == 2){
        BLMallHomeGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mallHomeGoodCell" forIndexPath:indexPath];
        cell.feeLab.hidden = _displayfees ? NO : YES;
        return cell;
    }
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        BLGoodsListVC *vc = [[BLGoodsListVC alloc]init];
        vc.source = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 2){
        BLGoodsDetailVC *vc = [[BLGoodsDetailVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    BLMallSearchVC *vc = [[BLMallSearchVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    return NO;
}



- (id)getResult{
   __block id a = nil;
   dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1---%@",[NSThread currentThread]);
        
        a = @{@"a":@"100"};
        
        dispatch_semaphore_signal(sem);
    });
    
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    
    return a;
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
