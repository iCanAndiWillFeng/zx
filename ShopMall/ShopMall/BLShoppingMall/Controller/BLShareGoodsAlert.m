//
//  BLShareGoodsAlert.m
//  Hospital
//
//  Created by mac on 2020/3/24.
//  Copyright © 2020 wangbao. All rights reserved.
//

#import "BLShareGoodsAlert.h"

@interface BLShareGoodsAlert ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UITapGestureRecognizer *recognizerTap;
@end

@implementation BLShareGoodsAlert
+ (instancetype)sheetWithData:(NSArray *)dataArr sureBlock:(void(^)(id result))sure{
    BLShareGoodsAlert *sheet = [[BLShareGoodsAlert alloc]init];
    return sheet;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        
        
        _containerView = [UIView new];
        
        [self.view addSubview:_containerView];
        
        _containerView.backgroundColor = [UIColor clearColor];
        
        [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.bottom.top.equalTo(self.view);
        }];
        
        _recognizerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBehind:)];
        [_recognizerTap setNumberOfTapsRequired:1];
        _recognizerTap.cancelsTouchesInView = NO;
        [_containerView addGestureRecognizer:_recognizerTap];
        
        
        _view1 = [[UIView alloc]init];
        
        [_containerView addSubview:_view1];
        
        _view1.backgroundColor = [UIColor whiteColor];
        
        _view1.layer.masksToBounds = YES;
        
        _view1.layer.cornerRadius = 6;
        
        [_view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_containerView);
            make.width.equalTo(_containerView).offset(-80);
            make.top.equalTo(_containerView).offset(autoScaleH(50));
            make.height.mas_offset(autoScaleH(390));
        }];
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_containerView addSubview:sureBtn];
        [sureBtn setTitle:@"xxx医生推荐" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureBtn.titleLabel.font = AR_BOLDFONT16;
        sureBtn.backgroundColor = Theme_HighLight_Color;
        sureBtn.layer.masksToBounds = YES;
        sureBtn.layer.cornerRadius = 22;
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_view1);
            make.width.equalTo(_view1).offset(-106);
            make.top.equalTo(_view1).offset(18);
            make.height.mas_offset(autoScaleH(42));
        }];
        
        UIImageView *imageV = [[UIImageView alloc]init];
        [_view1 addSubview:imageV];
        imageV.backgroundColor = [UIColor redColor];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_view1);
            make.top.equalTo(sureBtn.mas_bottom).offset(autoScaleH(32));
            make.width.height.mas_offset(autoScaleH(200));
        }];
        
        
        _view2 = [[UIView alloc]init];
        
        [_containerView addSubview:_view2];
        
        _view2.backgroundColor = [UIColor whiteColor];
        
        [_view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.centerX.width.equalTo(_containerView);
            make.height.mas_offset(autoScaleH(200));
        }];
        
        NSArray *shareArr = @[@"",@"",@""];
        for (int i = 0; i < shareArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_view2 addSubview:btn];
            [btn setImage:[UIImage imageNamed:@"icon_wehcatshare_nor"] forState:UIControlStateNormal];
            UILabel *nameLab = [[UILabel alloc]init];
            [_view2 addSubview:nameLab];
            nameLab.font = AR_FONT12;
            nameLab.textColor = [UIColor blackColor];
            nameLab.text = @"微信好友";
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_offset(36);
                make.top.equalTo(_view2).offset(20);
                if (i == 0) {
                    make.left.equalTo(_view2).offset(50);
                }
                if (i == 1) {
                    make.centerX.equalTo(_view2);
                }
                if (i == 2) {
                    make.right.equalTo(_view2).offset(-50);
                }
            }];
            [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(btn);
                make.top.equalTo(btn.mas_bottom).offset(5);
            }];
        }
        
        UIButton *copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_view2 addSubview:copyBtn];
        [copyBtn setTitle:@"一键复制" forState:UIControlStateNormal];
        [copyBtn setTitleColor:Theme_HighLight_Color forState:UIControlStateNormal];
        copyBtn.titleLabel.font = AR_FONT12;
        [copyBtn addTarget:self action:@selector(copyText) forControlEvents:UIControlEventTouchUpInside];
        [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_view2).offset(80);
            make.right.equalTo(_view2).offset(-15);
        }];
        
        UITextView *textView = [[UITextView alloc]init];
        [_view2 addSubview:textView];
        textView.backgroundColor = AR_RGBCOLOR(250, 250, 250);
        textView.editable = NO;
        textView.font = AR_FONT12;
        textView.text = @"至在观察者注册方法之前就返回，改变的字典需要包含一个 NSKeyValueChangeNewKey 入口，如果 NSKeyValueObservingOptionNew 也被指定的话，但从来不会包含一个NSKeyValueChangeOldKey 入口。（在一个 initial notification 里，观察者的当前属性可能是旧的，但对观察者来说是新的），你可以使用这个选项代替显式的调用，同时，代码也会被观察者的 observeValueForKeyPath:ofObject:change:context: 方法调用，当这个选项被用于 addObserver:forKeyPath:options:context:，一个通知将会发送到每个被观察者添加进去的索引对象中。";
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_view2).offset(15);
            make.right.equalTo(_view2).offset(-15);
            make.top.equalTo(copyBtn.mas_bottom).offset(0);
            make.bottom.equalTo(_view2).offset(-15);
        }];
        
    }
    return self;
}

- (void)copyText{
    [UIPasteboard generalPasteboard].string = @"string";
}

// 点击其他区域关闭弹窗
- (void)handleTapBehind:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded){
        CGPoint location = [sender locationInView:nil];
        if (![_view1 pointInside:[_view1 convertPoint:location fromView:_view1.superview] withEvent:nil] &&
            ![_view2 pointInside:[_view2 convertPoint:location fromView:_view2.superview] withEvent:nil]){
            
            [_containerView.window removeGestureRecognizer:sender];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
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
