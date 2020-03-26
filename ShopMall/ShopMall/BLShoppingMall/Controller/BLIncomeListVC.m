//
//  BLIncomeListVC.m
//  Hospital
//
//  Created by mac on 2020/3/25.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import "BLIncomeListVC.h"
#import "BLIncomeListCell.h"
#import <Masonry/Masonry.h>
@interface BLIncomeListVC ()
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation BLIncomeListVC
{
    NSInteger _page;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTopBarTitle:@"今日收益"];
    
    self.view.backgroundColor = Theme_Bg_Color;
    
    [self setPointView];
    
}

- (void)setPointView{
    UIView *topbgView = [self setTopView];
    
    
    UILabel *logLab = [[UILabel alloc]init];
    
    [self.view addSubview:logLab];
    
    logLab.text = @"收益详情";
    
    logLab.font = AR_FONT12;
    
    logLab.textColor = AR_RGBCOLOR(119, 119, 119);
    
    [logLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topbgView.mas_bottom).offset(8);
        make.left.equalTo(self.view).offset(20);
    }];
    
    [self.AR_TableView registerClass:[BLIncomeListCell class] forCellReuseIdentifier:NSStringFromClass([BLIncomeListCell class])];
    self.AR_TableView.backgroundColor = [UIColor whiteColor];
    self.AR_TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.AR_TableView.estimatedRowHeight = 70;
    self.AR_TableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.AR_TableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.bottom.equalTo(self.view);
        make.top.equalTo(logLab.mas_bottom).offset(8);
    }];
    
    [self addFreshView];
    
    _page = 1;
    
    [self getLogsWithPage:_page];
}

- (UIView *)setTopView{
    
    UIView *topbgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, AR_SCREEN_WIDTH, 108)];
    
    [self.view addSubview:topbgView];
    
    topbgView.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [UIView new];
    
    [topbgView addSubview:line];
    
    line.backgroundColor = AR_RGBCOLOR(208, 208, 208);
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(topbgView);
        make.height.equalTo(topbgView).offset(-30);
        make.width.mas_offset(.5);
    }];
    
    NSArray *pointArr = @[@{@"title":@"当前积分",
                            @"point":@"100",
                           },
                          @{@"title":@"累计积分",
                            @"point":@"2000",
                          }
    ];
    for (int i = 0; i < pointArr.count; i++) {
        
        NSDictionary *dic = pointArr[i];
        
        UILabel *titleLab = [[UILabel alloc]init];
        
        [topbgView addSubview:titleLab];
        
        titleLab.font = AR_FONT12;
        
        titleLab.textColor = AR_RGBCOLOR(118, 118, 118);
        
        titleLab.textAlignment = NSTextAlignmentCenter;
        
        titleLab.text = dic[@"title"];
        
        
        
        UILabel *pointLab = [[UILabel alloc]init];
        
        [topbgView addSubview:pointLab];
        
        pointLab.font = AR_BOLDFONT24;
        
        pointLab.textColor = Theme_HighLight_Color;
        
        pointLab.textAlignment = NSTextAlignmentCenter;
        
        pointLab.text = dic[@"point"];
        
        [pointLab mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.equalTo(topbgView).offset(26);
            }
            else{
                make.left.equalTo(topbgView.mas_centerX).offset(26);
            }
            make.top.equalTo(topbgView).offset(20);
        }];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(pointLab.mas_bottom).offset(8);
            make.left.equalTo(pointLab);
        }];
    }
    
    return topbgView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)getLogsWithPage:(NSInteger)page{
    [self displayLoadingToast:@"加载中"];
    __weak __typeof(self)weakSelf = self;
    [[ARFZXHttpManager sharedInstance] requestWithUrl:@"doctorPoint/getLogs"
                                          Enparameter:@{@"page":@(page),
                                                        @"page_size":@(20)
                                                        }
                                            Parameter:@{}
                                        completeBlock:^(NSError *error, id result) {
                                            [weakSelf hideToast];
                                            [weakSelf.AR_TableView.mj_header endRefreshing];
                                            [weakSelf.AR_TableView.mj_footer endRefreshing];
                                            NSString *status = EncodeFromDic(result, @"status");
                                            if ([status isEqualToString:@"1"]) {
                                                if (page == 1) {
                                                    [weakSelf.dataArr removeAllObjects];
                                                }
                                                
//                                                NSArray *data = [ARPointLogModel mj_objectArrayWithKeyValuesArray:result[@"point_logs"]];
//                                                
//                                                [weakSelf.dataArr addObjectsFromArray:data];
//                                                
//                                                
//                                                if (data.count < 20) {
//                                                    [weakSelf.AR_TableView.mj_footer endRefreshingWithNoMoreData];
//                                                }
//                                                [weakSelf.AR_TableView reloadData];
                                             
                                            }
                                        }];
}


- (void)addFreshView
{
    __weak __typeof(self)weakSelf = self;
    //下拉刷新
    self.AR_TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        [weakSelf getLogsWithPage:_page];
    }];
    
    //上拉刷新
   MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _page ++;
        [weakSelf getLogsWithPage:_page];
    }];
    self.AR_TableView.mj_footer = footer;
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [UIView new];
    v.backgroundColor = Theme_Bg_Color;
    return v;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BLIncomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BLIncomeListCell class])];
    if (!cell) {
        cell = [[BLIncomeListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([BLIncomeListCell class])];
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
