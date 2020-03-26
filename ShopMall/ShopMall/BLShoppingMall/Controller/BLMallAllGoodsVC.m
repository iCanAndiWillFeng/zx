//
//  BLMallAllGoodsVC.m
//  Hospital
//
//  Created by mac on 2020/3/21.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import "BLMallAllGoodsVC.h"
#import "BLMallSearchVC.h"
#import "ZXSwitchView.h"
#import "ZXMdeiciaModel.h"
#import "BLGoodsListVC.h"
@interface BLMallAllGoodsVC ()<UISearchBarDelegate,ZXSwitchViewDelegate>
@property (nonatomic, strong) UISearchBar *searchbar;
@property (nonatomic, strong) ZXSwitchView *switchView;
@property (nonatomic, strong) UIScrollView *scroller;
@property (nonatomic, strong) NSMutableDictionary *vDict;
@property (nonatomic, strong) NSArray *classArr;
@end

@implementation BLMallAllGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTopView];
    
    [self.view addSubview:self.switchView];
    
    [self.view addSubview:self.scroller];
    
    [self getCategories];
    
}

- (void)setTopView{
    [self.AR_BackBtn setImage:[UIImage imageNamed:@"arrow-left"] forState:UIControlStateNormal];
    self.AR_BackBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view bringSubviewToFront:self.AR_TopBarView];
    self.AR_TopBarView.frame = CGRectMake(0, 0, AR_SCREEN_WIDTH, kTopHeight+0.5);
    self.AR_BottomLineView.hidden = YES;
    [self.AR_BackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.AR_TopBarView);
        make.top.equalTo(self.AR_TopBarView).offset(kStatusBarHeight );
        make.height.mas_offset(40);
        make.width.mas_offset(40);
    }];

    

    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(15, 0, AR_SCREEN_WIDTH - 30, 30)];
    [self.AR_TopBarView addSubview:_searchbar];
    [_searchbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.AR_BackBtn.mas_right).offset(0);
        make.centerY.equalTo(self.AR_BackBtn);
        make.right.equalTo(self.AR_TopBarView).offset(-14);
        make.height.mas_offset(30);
    }];
    _searchbar.placeholder = @"  请输入商品名称搜索";
    _searchbar.delegate = self;
    _searchbar.searchBarStyle = UISearchBarStyleProminent;
    [_searchbar setContentMode:UIViewContentModeLeft];
    _searchbar.layer.masksToBounds = YES;
    _searchbar.layer.cornerRadius = 15.0;
    _searchbar.backgroundImage = [UIImage yy_imageWithColor:Theme_Bg_Color];
    UITextField *searchField = nil;
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 13.0) {
        searchField = _searchbar.searchTextField;
    }else{
        searchField = [_searchbar valueForKey:@"_searchField"];
    }
    [searchField setBorderStyle:UITextBorderStyleNone];
    searchField.clearButtonMode = UITextFieldViewModeNever;
    searchField.font = AR_FONT14;
    
   
}

- (ZXSwitchView *)switchView{
    if (!_switchView) {
        _switchView = [[ZXSwitchView alloc]initWithFrame:CGRectMake(0, 63, self.view.frame.size.width, 30)];
        _switchView.delegate = self;
        _switchView.textColor = [UIColor blackColor];
        _switchView.selectedColor = Theme_HighLight_Color;
        _switchView.textFont = AR_FONT12;
        _switchView.hiddenRedLine = YES;
    }
    return _switchView;
}

- (UIScrollView *)scroller{
    if (!_scroller) {
        _scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 63+30, self.view.frame.size.width, self.view.frame.size.height - 63 - 30)];
        _scroller.pagingEnabled = YES;
        _scroller.directionalLockEnabled = YES;
        _scroller.bounces = NO;
        _scroller.delegate = self;
    }
    return _scroller;
}

- (void)getCategories{
    
    [[ARFZXHttpManager sharedInstance] requestWithUrl:@"commonArticle/getCategories"
                                          Enparameter:@{}
                                            Parameter:@{}
                                        completeBlock:^(NSError *error, id result) {
                                            NSString *status = EncodeFromDic(result, @"status");
                                            if ([status isEqualToString:@"1"]) {
                                                
                                                _classArr = [ZXNameIDModel mj_objectArrayWithKeyValuesArray:result[@"categories"]];
                                                
                                                
                                                self.switchView.classes = _classArr;
                                                
                                                self.switchView.titleKeyPath = @"name";
                                                
                                                self.scroller.contentSize=CGSizeMake( self.view.frame.size.width*_classArr.count , 0 );
                                                
                                                [self creatChildView:0];
                                            }
                                        }];
}


- (void)didSelect:(NSInteger)index{
    
    [self creatChildView:index];
    CGFloat point = self.view.frame.size.width * index;
    [_scroller setContentOffset:CGPointMake(point,0) animated:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat pageWidth = scrollView.frame.size.width;
    
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    [self creatChildView:page];
    
    [self.switchView setCurrentView:page];
}

- (void)creatChildView:(NSInteger)index{
    
   
    ZXNameIDModel *model = _classArr[index];
    
  
    NSString *key = model.ID;
    
    
    BLGoodsListVC *vc = self.vDict[key];
     
    
    if (!vc) {

       
        vc = [[BLGoodsListVC alloc]init];
        
        vc.ID = model.ID;
              
        [self addChildViewController:vc];
       
        [self.vDict setObject:vc forKey:key];
     
        vc.view.frame = CGRectMake(index * self.view.frame.size.width, 0, self.view.frame.size.width, _scroller.frame.size.height);
       
        [_scroller addSubview:vc.view];
     }
    
}

- (NSMutableDictionary *)vDict{
    if (!_vDict) {
        _vDict = [NSMutableDictionary dictionary];
    }
    return _vDict;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    BLMallSearchVC *vc = [[BLMallSearchVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    return NO;
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
