//
//  BLGoodsDetailVC.m
//  Hospital
//
//  Created by mac on 2020/3/23.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import "BLGoodsDetailVC.h"
#import "XRCarouselView.h"
#import "BLGoodsDetailInfoCell.h"
#import "BLGoodsOptionCell.h"
#import "BLSelectGoodsSheet.h"
#import "BLGoodsServiceSheet.h"
#import "BLShareGoodsAlert.h"
@interface BLGoodsDetailVC ()<XRCarouselViewDelegate,UIWebViewDelegate>
@property (nonatomic, strong) XRCarouselView *bannerView;
@property (nonatomic, strong) UIWebView *web;
@property (nonatomic, strong) UILabel *shareLab;
@end

@implementation BLGoodsDetailVC
{
    CGFloat _webHeight;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTopBarTitle:@"商品详情"];
    
    [self creatView];
}


- (void)creatView{
    self.AR_GroupTableView.backgroundColor = [UIColor whiteColor];
    [self.AR_GroupTableView registerNib:[UINib nibWithNibName:@"BLGoodsDetailInfoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"goodsDetailInfoCell"];
    [self.AR_GroupTableView registerClass:[BLGoodsOptionCell class] forCellReuseIdentifier:@"optionCell"];
    self.AR_GroupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.AR_GroupTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.bottom.equalTo(self.view).offset(-63);
    }];
    
    UIView *bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.bottom.equalTo(self.view);
        make.top.equalTo(self.AR_GroupTableView.mas_bottom);
    }];
    
    UIView *last = nil;
    for (int i = 0; i < 2; i++) {
        UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [bottomView addSubview:homeBtn];
        homeBtn.backgroundColor = [UIColor redColor];
        
        UILabel *textLab = [[UILabel alloc]init];
        [bottomView addSubview:textLab];
        textLab.textColor = [UIColor blackColor];
        textLab.font = AR_FONT10;
        
        [homeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_offset(27);
            make.top.equalTo(bottomView).offset(13);
            if (i == 0) {
                make.left.equalTo(bottomView).offset(15);
            }
            else{
                make.left.equalTo(last.mas_right).offset(25);
            }
        }];
        [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(homeBtn);
            make.top.equalTo(homeBtn.mas_bottom).offset(5);
        }];
        if (i == 0) {
            textLab.text = @"首页";
        }
        else{
            textLab.text = @"客服";
        }
        
        last = homeBtn;
    }
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:shareBtn];
    [shareBtn setTitle:@"分享赚20元" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.backgroundColor = Theme_HighLight_Color;
    shareBtn.titleLabel.font = AR_FONT15;
    shareBtn.layer.masksToBounds = YES;
    shareBtn.layer.cornerRadius = 20;
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(38);
        make.centerY.equalTo(bottomView);
        make.left.equalTo(last.mas_right).offset(16);
        make.right.equalTo(bottomView).offset(-10);
    }];
    
    UIView *headView = [[UIView alloc]init];
    [headView addSubview:self.bannerView];
    
    UIView *shareView = [[UIView alloc]init];
    [headView addSubview:shareView];
    shareView.backgroundColor = AR_RGBACOLOR(214, 95, 76, 0.7);
    [shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.top.equalTo(headView);
        make.height.mas_offset(52);
    }];
    
    _shareLab = [[UILabel alloc]init];
    [shareView addSubview:_shareLab];
    _shareLab.font = AR_FONT16;
    _shareLab.textColor = [UIColor whiteColor];
    _shareLab.text = @"分享购买后可赚12.45元";
    
    UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareView addSubview:topBtn];
    topBtn.backgroundColor = Theme_HighLight_Color;
    [topBtn setTitle:@"立即分享" forState:UIControlStateNormal];
    [topBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [topBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    topBtn.titleLabel.font = AR_FONT15;
    topBtn.layer.masksToBounds = YES;
    topBtn.layer.cornerRadius = 4;
    [topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(98);
        make.height.mas_offset(32);
        make.centerY.equalTo(shareView);
        make.right.equalTo(shareView).offset(-14);
    }];
    
    [_shareLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shareView);
        make.left.equalTo(shareView).offset(26);
        make.right.equalTo(topBtn.mas_left).offset(-10);
    }];
    
    self.AR_GroupTableView.tableHeaderView = headView;
    self.AR_GroupTableView.tableHeaderView.height = AR_SCREEN_WIDTH;
    self.AR_GroupTableView.sectionHeaderHeight = 0.0001;
    
}

- (void)share{
    BLShareGoodsAlert *alert = [BLShareGoodsAlert sheetWithData:@[] sureBlock:^(id  _Nonnull result) {
        
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - XRCarouselViewDelegate
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index{
   
}

- (void)carouselView:(XRCarouselView *)carouselView currentIndex:(NSInteger)index{
}

- (XRCarouselView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[XRCarouselView alloc]initWithFrame:CGRectMake(0, 0, AR_SCREEN_WIDTH, AR_SCREEN_WIDTH)];
        _bannerView.time = 3; // 设置轮播的执行时间
        _bannerView.delegate = self; // 代理
        _bannerView.pagePosition = PositionHide;
        _bannerView.imageArray = @[@"https://bailu-img.oss-cn-shanghai.aliyuncs.com/bailu_d/202001/ea7e44aeda694eaee15e06c6b9ccbafb.png",
        @"https://bailu-img.oss-cn-shanghai.aliyuncs.com/bailu_d/202001/5039599b7b6fe64955bacbd8d9716683.png",
        @"https://bailu-img.oss-cn-shanghai.aliyuncs.com/bailu_d/202001/f20f705f1bbc7512462fa2df0f327bcc.png"];
    }
    return _bannerView;
}

- (UIWebView *)web{
    if (!_web) {
        _web =[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, AR_SCREEN_WIDTH, 1)];
        _web.backgroundColor = [UIColor whiteColor];
        _web.scalesPageToFit = YES;
        _web.delegate = self;
        _web.scrollView.delegate = self;
        _web.scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
        _web.scrollView.scrollEnabled = NO;
        _web.opaque = NO;
        NSString *js = [self adaptWebViewForHtml:@"<p><img src=\"http://static.bailuzy.com/bailu_d/202001/c029a0e083fef57a45e1d7db1281aa53.png\"><br></p>"];
        [_web loadHTMLString:js baseURL:nil];
    }
    return _web;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else if (section == 1 || section == 2){
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return UITableViewAutomaticDimension;
    }
    if (indexPath.section == 1 || indexPath.section == 2) {
        return 45;
    }
    return _webHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        BLGoodsDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsDetailInfoCell"];
        if (!cell) {
            cell = [[BLGoodsDetailInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"goodsDetailInfoCell"];
        }
        cell.priceLab.text = @"198.00 - 298.00";
        return cell;
    }
    else if (indexPath.section == 1){
        BLGoodsOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"optionCell"];
        if (!cell) {
            cell = [[BLGoodsOptionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"optionCell"];
        }
        cell.rightImg.hidden = YES;
        if (indexPath.row == 0) {
            cell.titleLab.text = @"发货";
            cell.descLab.text = @"广州 ";
            cell.rightLab.text = @"已售 983件";
        }
        else if (indexPath.row == 1){
            cell.titleLab.text = @"服务";
            cell.descLab.text = @"快递包邮,七天包退货";
            cell.rightLab.text = @"";
        }
        return cell;
    }
    else if (indexPath.section == 2){
        BLGoodsOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"optionCell"];
        if (!cell) {
            cell = [[BLGoodsOptionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"optionCell"];
        }
        cell.rightImg.hidden = YES;
        cell.rightLab.text = @"";
        if (indexPath.row == 0) {
            cell.titleLab.text = @"已选";
            cell.descLab.text = @"五年装, 45g/盒,  1件";
            cell.rightImg.hidden = NO;
        }
        else if (indexPath.row == 1){
            cell.titleLab.text = @"快递";
            cell.descLab.text = @"订单满58元包邮，不满收10元";
        }
        return cell;
    }
    else if (indexPath.section == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:self.web];
        [_web mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.top.bottom.equalTo(cell.contentView);
        }];
        return cell;
    }
    
    return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return 40;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 5, AR_SCREEN_WIDTH, 40)];
    head.backgroundColor = [UIColor whiteColor];
    if (section == 3) {
        UILabel *title = [[UILabel alloc]init];
        [head addSubview:title];
        title.textColor = [UIColor blackColor];
        title.font = AR_BOLDFONT16;
        title.text = @"商品详情";
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(head).offset(16);
            make.centerY.equalTo(head);
        }];
    }
   
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 0;
    }
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *foot = [UIView new];
    foot.backgroundColor = Theme_Bg_Color;
    return foot;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            BLGoodsServiceSheet *sheet = [BLGoodsServiceSheet sheetWithData:@[] sureBlock:^(id  _Nonnull result) {

            }];
            [self presentViewController:sheet animated:YES completion:nil];
        });
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            BLSelectGoodsSheet *sheet = [BLSelectGoodsSheet sheetWithData:@[] sureBlock:^(id  _Nonnull result) {

            }];
            [self presentViewController:sheet animated:YES completion:nil];
        });
    }
}

//HTML适配图片文字
- (NSString *)adaptWebViewForHtml:(NSString *) htmlStr
{
    NSMutableString *headHtml = [[NSMutableString alloc] initWithCapacity:0];
    
    [headHtml appendString : @"<html>" ];
    
    [headHtml appendString : @"<head>" ];
    
    [headHtml appendString : @"<meta charset=\"utf-8\">" ];

    [headHtml appendString : @"<meta id=\"viewport\" name=\"viewport\" content=\"width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=false\"/>" ];

    [headHtml appendString : @"<meta name=\"apple-mobile-web-app-capable\" content=\"yes\"/>" ];

    [headHtml appendString : @"<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\"/>" ];

    [headHtml appendString : @"<meta name=\"black\" name=\"apple-mobile-web-app-status-bar-style\"/>" ];
    
    [headHtml appendString:@"<style type='text/css'>img {max-width: 100%!important;}</style>"];
    
    [headHtml appendString : @"</head>" ];
    
    [headHtml appendString : @"<body>" ];

    NSString *bodyHtml;
    bodyHtml = [NSString stringWithString:headHtml];
    
    bodyHtml = [bodyHtml stringByAppendingString:htmlStr];
    
    NSString *html = [NSString stringWithFormat:@"%@</body></html>",bodyHtml];
    
    return html;
    
}

- (void)webViewDidFinishLoad:(UIWebView* )webView {
    NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    NSString *htmlWidth = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollWidth"];
    float i = [htmlWidth floatValue]/[htmlHeight floatValue];
    //webview控件的最终高度
    float height = AR_SCREEN_WIDTH/i;
    _webHeight = height;
    [self.AR_GroupTableView reloadData];
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
