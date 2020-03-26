//
//  BLMallSearchVC.m
//  Hospital
//
//  Created by mac on 2020/3/20.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import "BLMallSearchVC.h"
#import "BLSearchHistoryView.h"
#import "BLMallGoodsListCell.h"
#import <Masonry/Masonry.h>
@interface BLMallSearchVC ()<UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchbar;
@property (nonatomic, strong) BLSearchHistoryView *historyView;
@end

@implementation BLMallSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTopView];
    
    [self.view addSubview:self.historyView];
    
    [self.AR_TableView registerNib:[UINib nibWithNibName:@"BLMallGoodsListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"goodsListCell"];
    self.AR_TableView.backgroundColor = [UIColor whiteColor];
    self.AR_TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.AR_TableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(66.5);
    }];
    self.AR_TableView.hidden = YES;
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

    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.AR_TopBarView addSubview:cancelBtn];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:AR_RGBCOLOR(130, 130, 130) forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = AR_FONT14;
    [cancelBtn addTarget:self  action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.AR_BackBtn);
        make.right.equalTo(self.AR_TopBarView).offset(-14);
    }];

    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(15, 0, AR_SCREEN_WIDTH - 30, 30)];
    [self.AR_TopBarView addSubview:_searchbar];
    [_searchbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.AR_BackBtn.mas_right).offset(0);
        make.centerY.equalTo(self.AR_BackBtn);
        make.right.equalTo(cancelBtn.mas_left).offset(-10);
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
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 2.5)];
    line.backgroundColor = Theme_Bg_Color;
    [self.view addSubview:line];
}

- (BLSearchHistoryView *)historyView{
    if (!_historyView) {
        _historyView = [[BLSearchHistoryView alloc]initWithFrame:CGRectMake(0, 66.5, self.view.frame.size.width, self.view.frame.size.height - 67)];
        AR_WeakSelf(weakSelf);
        _historyView.callback = ^(NSString * _Nonnull string) {
            weakSelf.searchbar.text = string;
            weakSelf.historyView.hidden = YES;
            weakSelf.AR_TableView.hidden = NO;
        };
    }
    return _historyView;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        searchBar.text = nil;
        [searchBar resignFirstResponder];
        self.historyView.hidden = NO;
        self.AR_TableView.hidden = YES;
    }
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (searchBar.text.length > 0) {
        [self saveHistoryWithKeyword:searchBar.text];
        _historyView.hidden = YES;
        self.AR_TableView.hidden = NO;
    }
    [searchBar resignFirstResponder];
}

- (void)cancelSearch{
    [_searchbar resignFirstResponder];
    _searchbar.text = @"";
    _historyView.hidden = NO;
    [_historyView reload];
    self.AR_TableView.hidden = YES;
}

- (void)saveHistoryWithKeyword:(NSString *)keyword{
    //写入文件
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    if (!docDir) {
        NSLog(@"Documents 目录未找到");
    }
    NSString *pathStr = @"BLMallSearchHistory.txt";
    NSString *filePath = [docDir stringByAppendingPathComponent:pathStr];
    NSMutableArray *TemporaryRoot = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
    if (AR_IsNilOrNull(TemporaryRoot)) {//第一次存的时候数组为空
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [array addObject:keyword];
        [array writeToFile:filePath atomically:YES];
    }
    else{
        [TemporaryRoot addObject:keyword];
        [TemporaryRoot writeToFile:filePath atomically:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 136;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BLMallGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsListCell"];
    if (!cell) {
        cell = [[BLMallGoodsListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"goodsListCell"];
    }
    return cell;
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
