//
//  BLSearchHistoryView.m
//  Hospital
//
//  Created by mac on 2020/3/20.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import "BLSearchHistoryView.h"
#import "PACollectionViewFlowLayout.h"
@interface BLSearchHistoryView()<UICollectionViewDelegate,UICollectionViewDataSource,PACollectionViewFlowLayouttDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) PACollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSArray *dataArr;
@end
@implementation BLSearchHistoryView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *titleLab = [[UILabel alloc]init];
        [self addSubview:titleLab];
        titleLab.text = @"历史搜索";
        titleLab.font = AR_BOLDFONT14;
        titleLab.textColor = [UIColor blackColor];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(18);
            make.top.equalTo(self).offset(10);
        }];
        UIButton *cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cleanBtn.backgroundColor = [UIColor redColor];
        [self addSubview:cleanBtn];
        [cleanBtn addTarget:self action:@selector(cleanHistory) forControlEvents:UIControlEventTouchUpInside];
        [cleanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_offset(15);
            make.centerY.equalTo(titleLab);
            make.right.equalTo(self).offset(-20);
        }];
        
        [self addSubview:self.collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.bottom.equalTo(self);
            make.top.equalTo(titleLab.mas_bottom);
        }];
        
        [self reload];
    }
    return self;
}

- (void)reload{
    _dataArr = [self readHistory];
    _dataArr = [[_dataArr reverseObjectEnumerator] allObjects];
    [_collectionView reloadData];
}

- (NSArray *)readHistory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    if (!docDir) {
        NSLog(@"Documents 目录未找到");
    }
    NSString *pathStr = @"BLMallSearchHistory.txt";
    NSString *filePath = [docDir stringByAppendingPathComponent:pathStr];
    NSArray *TemporaryRoot = [[NSArray alloc]initWithContentsOfFile:filePath];
    return TemporaryRoot;
}

- (void)cleanHistory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    if (!docDir) {
        NSLog(@"Documents 目录未找到");
    }
    NSString *pathStr = @"BLMallSearchHistory.txt";
    NSString *filePath = [docDir stringByAppendingPathComponent:pathStr];
    NSMutableArray *TemporaryRoot = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
    [TemporaryRoot removeAllObjects];
    [TemporaryRoot writeToFile:filePath atomically:YES];
    
    _dataArr = @[];
    [_collectionView reloadData];
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        _layout = [[PACollectionViewFlowLayout alloc] init];
        _layout.delegate = self;
        _layout.lineSpace = 10;
        _layout.itemSpace = 10;
        _layout.itemHeight = 28;
        _layout.sectionInsets = UIEdgeInsetsMake(10,20,0,20);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = Theme_Bg_Color;
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 14;
    for (UIView *vv in cell.contentView.subviews) {
        [vv removeFromSuperview];
    }
    UILabel *textLab = [[UILabel alloc]init];
    [cell.contentView addSubview:textLab];
    textLab.font = AR_FONT14;
    textLab.textColor = AR_RGBCOLOR(159, 159, 159);
    textLab.text = _dataArr[indexPath.row];
    [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(cell.contentView);
    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BLOCK_EXEC(_callback,_dataArr[indexPath.row])
}

#pragma mark - FlowLayout Delegate
- (CGFloat)obtainItemWidth:(PACollectionViewFlowLayout *)layout widthAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [NSString stringWithFormat:@"  %@  ",_dataArr[indexPath.row]];
    CGSize textMaxSize = CGSizeMake(AR_SCREEN_WIDTH - 2 *30, MAXFLOAT);
    CGFloat ww = [text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.width;
    ww = MAX(ww, 60);
    return ww;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
