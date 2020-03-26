//
//  BLGoodsListVC.m
//  Hospital
//
//  Created by mac on 2020/3/21.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import "BLGoodsListVC.h"
#import "BLMallSortView.h"
#import "BLMallGoodsListCell.h"
#import <Masonry/Masonry.h>
@interface BLGoodsListVC ()
@property (nonatomic, strong) BLMallSortView *soreView;
@end

@implementation BLGoodsListVC
{
    CGFloat _y;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.source == 1) {
        [self setTopBarTitle:@"分类商品"];
        _y = 64;
    }
    
    [self.view addSubview:self.soreView];
    
    [self.AR_TableView registerNib:[UINib nibWithNibName:@"BLMallGoodsListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"goodsListCell"];
    self.AR_TableView.backgroundColor = [UIColor whiteColor];
    self.AR_TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.AR_TableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.bottom.equalTo(self.view);
        make.top.equalTo(self.soreView.mas_bottom).offset(0);
    }];
}


- (BLMallSortView *)soreView{
    if (!_soreView) {
        _soreView = [[BLMallSortView alloc]initWithFrame:CGRectMake(0, _y, self.view.frame.size.width, 35)];
    }
    return _soreView;
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
