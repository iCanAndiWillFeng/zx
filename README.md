# zx


商城类页面展示


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTopBarTitle:@"养生商城"];
    
    self.AR_TopTitleLabel.textColor = [UIColor whiteColor];
    
    [self.AR_BackBtn setImage:[UIImage imageNamed:@"icon_topright_white_nor"] forState:UIControlStateNormal];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.AR_TopBarView.backgroundColor = Theme_HighLight_Color;
  
    [self creatViews];
}
