//
//  WorkMarkViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "WorkMarkViewController.h"
#import "WorkMarkCell.h"
#import "GetTeachNeedCheckListRequst.h"
#import "GetTeachNeedCheckListModel.h"
#import "MenuView.h"
#import "PicListViewController.h"
@interface WorkMarkViewController ()<UITableViewDelegate,UITableViewDataSource,WorkMarkCellDelegate>
@property (nonatomic,strong)UITextField *textfield;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)MenuView *menuView1;
@property (nonatomic,assign)BOOL isShow1;
@property (nonatomic,strong)NSString *str1;

@property (nonatomic,strong)NSMutableArray *WorkArray;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)XFUserInfo *xf;
@property (nonatomic,strong)NSString *checkType;

@end

@implementation WorkMarkViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
-(void)creatHeadView{
    
    UIButton *typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    typeButton.frame = CGRectMake(20, 5+64, 80, 30);
    [typeButton setTitle:@"作品状态" forState:UIControlStateNormal];
    typeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [typeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [typeButton addTarget:self action:@selector(showtype) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:typeButton];
    
    self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(130, 5+64, WidthFrame-210, 30)];
    self.textfield.placeholder = @"输入活动名称";
    self.textfield.layer.cornerRadius = 6;
    self.textfield.layer.masksToBounds = YES;
    self.textfield.layer.borderWidth = 2;
    self.textfield.layer.borderColor = [[UIColor colorWithHexString:@"D4D5D4"] CGColor];
    self.textfield.clearButtonMode=YES;
    self.textfield.leftViewMode=UITextFieldViewModeAlways;
    [self.textfield setBorderStyle:UITextBorderStyleRoundedRect];
    self.textfield.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.textfield];
    
    UIButton *selectbt = [UIButton buttonWithType:UIButtonTypeCustom];
    selectbt.frame = CGRectMake(CGRectGetMaxX(self.textfield.frame)+10, 5+64, 50, 30);
    [selectbt setTitle:@"搜索" forState:UIControlStateNormal];
    [selectbt addTarget:self action:@selector(sousuo) forControlEvents:UIControlEventTouchUpInside];
    selectbt.titleLabel.font = [UIFont systemFontOfSize:16];
    [selectbt setBackgroundColor:[UIColor colorWithHexString:@"3691CE"]];
    selectbt.layer.cornerRadius =6;
    selectbt.layer.masksToBounds = YES;
    [self.view addSubview:selectbt];
    
    
}
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
    }
    return _xf;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+45, WidthFrame, HeightFrame-64-45) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
                _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线
        [_tableView registerClass:[WorkMarkCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView;
}
-(MenuView *)menuView1{
    if (!_menuView1) {
        __weak typeof (self) weakSelf = self;
        NSArray *array = [NSArray array];
        array = @[@"全部状态",@"未评审",@"已评审",@"被退回"];
        _menuView1 = [[MenuView alloc]initWithFrame:CGRectMake(20, 64+5+30, 80, 30*array.count)cellarray:array block:^(NSInteger i) {
            weakSelf.isShow1 = NO;
            weakSelf.page = 1;
            if (i == 0) {
                weakSelf.checkType = @"-1";
            }else if (i == 1){
                weakSelf.checkType = @"0";
            }else if (i == 2){
                weakSelf.checkType = @"1";
            }else if (i == 3){
                weakSelf.checkType = @"2";
            }
            [weakSelf GetTeachNeedCheckList:self.checkType];
            
        }];
        [self.view addSubview:_menuView1];
    }
    return _menuView1;
}

-(NSMutableArray *)WorkArray{
    if (!_WorkArray) {
        _WorkArray = [[NSMutableArray alloc]init];
    }
    return _WorkArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatHeadView];
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"作品批阅";
    self.view.backgroundColor = [UIColor whiteColor];
    self.xf = [XFUserInfo getUserInfo];
    self.page = 1;
    self.checkType = @"-1";
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self GetTeachNeedCheckList:self.checkType];
        [self.tableView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer=[MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{
        
        
        [self requstMore];
        [self.tableView.mj_footer endRefreshing];
    }];

}
//获取制定志愿教师需要批阅的习作列表
-(void)GetTeachNeedCheckList :(NSString *)checkType{
    GetTeachNeedCheckListRequst *requst = [[GetTeachNeedCheckListRequst alloc]init];
    [requst GetTeachNeedCheckListRequstWithuserId:self.xf.Loginid withactiveId:self.activeId withPageIndex:@"1" withPageSize:@"20" withcheckType:checkType withworkName:self.textfield.text :^(NSDictionary *json) {
        [self.WorkArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetTeachNeedCheckListModel *model = [GetTeachNeedCheckListModel loadWithJSOn:dic];
            [self.WorkArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];

}
-(void)requstMore{
    self.page +=1;
    GetTeachNeedCheckListRequst *requst = [[GetTeachNeedCheckListRequst alloc]init];
    [requst GetTeachNeedCheckListRequstWithuserId:self.xf.Loginid withactiveId:self.activeId withPageIndex:[NSString stringWithFormat:@"%ld",(long)self.page] withPageSize:@"20" withcheckType:self.checkType withworkName:self.textfield.text :^(NSDictionary *json) {
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetTeachNeedCheckListModel *model = [GetTeachNeedCheckListModel loadWithJSOn:dic];
            [self.WorkArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];

}
-(void)showtype{
    _isShow1 = !_isShow1;
    if (_isShow1) {
        [self.menuView1 showView];
    }else{
        [self.menuView1 dismissView];
    }
}
-(void)sousuo{

}
-(void)dianping:(UIButton *)bt{
    GetTeachNeedCheckListModel *model = self.WorkArray[bt.tag - 1000];
    PicListViewController *vc = [[PicListViewController alloc]init];
    vc.blogid = model.WorkId;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.WorkArray.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    GetTeachNeedCheckListModel *Model = self.WorkArray[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[WorkMarkCell class] contentViewWidth:[self cellContentViewWith]];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WorkMarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.bt.tag = 1000+indexPath.row;
    GetTeachNeedCheckListModel *Model = self.WorkArray[indexPath.row];
    cell.model = Model;
    return  cell;
    
    
}

#pragma header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
    
}

-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}


@end
