//
//  CompositionLibraryViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "CompositionLibraryViewController.h"
//#import "ConmHeadView.h"
//#import "ConmppsitionView.h"
#import "FristCollectionViewCell.h"
#import "SecondCollectionViewCell.h"
#import "ThridCollectionViewCell.h"
#import "FristHeadView.h"
#import "FristFootView.h"
#import "SecondHeadView.h"
#import "ActivityController.h"


#import "WriteListModel.h"
#import "CommWriteListRequst.h"
#import "CommwritelistModel.h"
#import "VolunteerRequst.h"
#import "ActiveInfoModel.h"
#import "GetHjListRequst.h"

#import "MoreCompositionViewController.h"
#import "WritingViewController.h"
#import "WritingxzViewController.h"

#import "CompositMenuView.h"
#import "SubmissionController.h" //推荐活动
#import "haocihaojumodel.h"
@interface CompositionLibraryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,FristHeadViewDelegate,GetmoreDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;


@property (nonatomic,strong)NSMutableArray *btnArray;
@property (nonatomic,strong)NSMutableArray *compositionArray;

@property (nonatomic,strong)NSMutableArray *haocitext;
@property (nonatomic,strong)NSMutableArray *haocitable;

@property (nonatomic,strong)NSMutableArray *secondArray;
@property (nonatomic,strong)NSString *moreStr;
@property (nonatomic,strong)CompositMenuView *menuView;
@property (nonatomic,assign)BOOL isShow;
@end

@implementation CompositionLibraryViewController
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"e8f3fa"];
        _collectionView.showsVerticalScrollIndicator =NO;
        [_collectionView registerClass:[FristCollectionViewCell class] forCellWithReuseIdentifier:@"cellFrist"];//注册cell
        [_collectionView registerClass:[FristHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1"];//注册cell的headview
        [_collectionView registerClass:[FristFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot1"];
        [_collectionView registerClass:[SecondCollectionViewCell class] forCellWithReuseIdentifier:@"cellSecond"];
        [_collectionView registerClass:[SecondHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2"];
        [_collectionView registerClass:[ThridCollectionViewCell class] forCellWithReuseIdentifier:@"cellThrid"];
        
    }
    return _collectionView;
}
-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc]init];
    }
    return _btnArray;
}
-(NSMutableArray *)compositionArray{
    if (!_compositionArray) {
        _compositionArray = [[NSMutableArray alloc]init];
    }
    return _compositionArray;
}
-(NSMutableArray *)secondArray{
    if (!_secondArray) {
        _secondArray = [[NSMutableArray alloc]init];
    }
    return _secondArray;
}

-(void)requst :(NSString *)gardeId{
    __weak typeof (self) weakSelf = self;
    CommWriteListRequst *requst = [[CommWriteListRequst alloc]init];
    
    [requst Comm_GetWriteListrequstWithindex:@"1" withpagesiz:@"8" withgradid:gardeId withtypeid:@"0" withishot:@"-1" withtuijian:@"-1"  withlabelid:@"0"  withkeword:@"" BlogStatic:@"1"  :^(NSDictionary *json) {
        [weakSelf.compositionArray removeAllObjects];
//        CommData *commData = [CommData mj_objectWithKeyValues:json];
//        NSLog(@"-------%@",commData.ret_data);
//        NSLog(@"+++++++%@",commData.ret_data.pageInfo);
//        NSLog(@"duoshao%lu",(unsigned long)commData.ret_data.pageInfo.count);
//        self.compositionArray = commData.ret_data.pageInfo;
        
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            CommwritelistModel *model = [CommwritelistModel loadWithJSOn:dic];
            [weakSelf.compositionArray addObject:model];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
        
    }];


}

- (void)GetBlogHaoju{
    //    [SVProgressHUD showWithStatus:@"正在加载..."];
    __weak typeof (self) weakSelf = self;
    VolunteerRequst *requst = [[VolunteerRequst alloc]init];
    [requst GetBlogHaojuWithBlogid:0 :^(NSDictionary *json){
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            
            ActiveInfoModel *model = [ActiveInfoModel loadWithJSOn:dic];
            [weakSelf.secondArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
    }
     ];
    
}
-(void)GetReadActive{
    __weak typeof (self) weakSelf = self;
    VolunteerRequst *requst = [[VolunteerRequst alloc]init];
    
    [requst GetVolunteerRequstWithpagesize:1 :@"2" WithAcitivieTypeID:@"0" :^(NSDictionary *json) {
        [weakSelf.secondArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            
            ActiveInfoModel *model = [ActiveInfoModel loadWithJSOn:dic];
            [weakSelf.secondArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
        
    }];
}
-(void)GetHj{
//    __weak typeof (self) weakSelf = self;
      __weak typeof (self) weakSelf = self;
    
    GetHjListRequst *requst = [[GetHjListRequst alloc]init];
    [requst GetHjListRequstWithblogid:@"0"  pageindex:@"1" pagesize:@"4" :^(NSDictionary *json) {
        
        self.haocitext = [NSMutableArray array];
        
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            
            haocihaojumodel *model = [haocihaojumodel loadWithJSOn:dic];
            [weakSelf.haocitext addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
        
        
        
    }];
}
-(CompositMenuView *)menuView{
    if (!_menuView) {
        _menuView = [[CompositMenuView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_menuView];
    }
    return _menuView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"作文库";
//    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_caidan_s"] style: UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
//
//    self.navigationItem.leftBarButtonItem=item;
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"3690CE"];
    [self.view addSubview:self.collectionView];
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.moreStr = @"全部习作";
        [self requst:@"0"];
        [self GetReadActive];
        [self GetBlogHaoju];
        [self GetHj];
        [self.collectionView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    
    [self.collectionView.mj_header beginRefreshing];
    
    
//    [self.view addSubview:self.scrollView];
}
-(void)showMenu{
    _isShow = !_isShow;
    if (_isShow) {
        [self.menuView showView];
    }else{
        [self.menuView dismissView];
    }
    
}
/*************
 这里可以数据请求
 *************/
-(void)srollView :(UIButton *)btn{
    for (UIButton *bt in self.btnArray){
        if (bt.tag == btn.tag) {
            [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else
        {
            [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    if (btn.tag == 1000) {

        [self requst:@"0"];
        self.moreStr = @"全部习作";
    }else if (btn.tag == 1001) {
        [self requst:@"5"];
        self.moreStr = @"微课习作";
    }else if (btn.tag == 1002) {
        [self requst:@"7"];
        self.moreStr = @"活动习作";
    }else if (btn.tag == 1003) {
        [self requst:@"4"];
        self.moreStr = @"独立习作";
    }


}
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.compositionArray.count;
        
    }else if (section == 1){
        
        return self.secondArray.count;
    }else if (section == 2){
        
        return 4;
    }return 0;
    
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        FristCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellFrist" forIndexPath:indexPath];
        
        CommwritelistModel *model = self.compositionArray[indexPath.row];
        if ([model.BlogTitle isEqualToString:@""]) {
            model.BlogTitle = @"暂无";
        }
        cell.titleLabel.text = [NSString stringWithFormat:@"《%@》",model.BlogTitle];

        cell.nameLabel.text = [NSString stringWithFormat:@"作者：%@",model.UserName];
        cell.numberLabel.text = [NSString stringWithFormat:@"点评人数：%@",model.PyNum];
        if ([model.labels isEqualToString:@""]) {
            model.labels = @"暂无";
        }
        cell.bqLabel.text = [NSString stringWithFormat:@"标签：%@",model.labels];
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.UserPic];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
        
        
        
        
        return cell;
    }else if (indexPath.section == 1){
        SecondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellSecond" forIndexPath:indexPath];
        ActiveInfoModel *model = self.secondArray[indexPath.row];
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.activepic];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
        
        cell.titleLabel.text = model.activename;
        return cell;
    }else if (indexPath.section == 2){
        
        ThridCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellThrid" forIndexPath:indexPath];
        
        haocihaojumodel *model =  _haocitext[indexPath.row];
        cell.textView.text = model.info;
        cell.label.text = model.byusername;
        return cell;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout
//每个cell的大小，因为有indexPath，所以可以判断哪一组，或者哪一个item，可一个给特定的大小，等同于layout的itemSize属性

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
    
        return CGSizeMake(WidthFrame/2-7, HeightFrame/8);
        
    }else if (indexPath.section == 1){
        return CGSizeMake(WidthFrame/2-30, HeightFrame/6);
        
    }else
        return CGSizeMake(WidthFrame/2-30, HeightFrame/6);
}
// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //    return UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    if (section == 0) {
        return UIEdgeInsetsMake(2, 2, 2, 2);
    }else if (section == 1){
        return UIEdgeInsetsMake(2, 15, 2, 15);
    }
    return UIEdgeInsetsMake(2, 15, 2, 15);;
}
//横向
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

// 竖向   设置最小行间距，也就是前一行与后一行的中间最小间隔  行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return CGSizeMake(WidthFrame, 40);
//    }else
        return CGSizeMake(WidthFrame, 40);;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section {
        if (section == 0) {
            return CGSizeMake(WidthFrame, 40);
        }else
    return CGSizeZero;
    
}
#pragma mark 头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    
//    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            if (kind == UICollectionElementKindSectionHeader) {
                FristHeadView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header1" forIndexPath:indexPath];
                self.btnArray=view.tabBtnArray;
                view.delegate = self;
                return view;
            }else if (kind == UICollectionElementKindSectionFooter){
                FristFootView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"foot1" forIndexPath:indexPath];
                view.delegate = self;
                return view;
            }
            
            
        }else if (indexPath.section == 1){
            if (kind == UICollectionElementKindSectionHeader) {
                SecondHeadView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header2" forIndexPath:indexPath];
                view.moreBt.hidden = NO;
                [view.moreBt addTarget:self action:@selector(tuijisnhuofong) forControlEvents:UIControlEventTouchUpInside];
                [view.Titlebt setTitle:@"推荐活动" forState:UIControlStateNormal];
                return view;
            }
        
        
        }else if (indexPath.section == 2){
            if (kind == UICollectionElementKindSectionHeader) {
                SecondHeadView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header2" forIndexPath:indexPath];
                   view.moreBt.hidden = YES;
                [view.Titlebt setTitle:@"好词好句" forState:UIControlStateNormal];
                return view;
            }

        
        
        }
        
            return nil;
    
}

- (void)tuijisnhuofong{
    
    ActivityController *vc = [[ActivityController alloc]init];
    vc.titleStr = @"学生投稿活动";
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)requstHtml{
    

}



    



#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        WritingxzViewController *vc = [[WritingxzViewController alloc]init];
//        vc.model = self.compositionArray[indexPath.row];
        CommwritelistModel *model = self.compositionArray[indexPath.row];
        vc.workId = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1){
        
        SubmissionController *vc = [[SubmissionController alloc]init];
        ActiveInfoModel *model = self.secondArray[indexPath.row];
        //    NSLog(@"---%@",model.activetype);
        vc.SubActiveID = model.activeid;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}



-(void)getMoreWithdifference{

    MoreCompositionViewController *moreVC = [[MoreCompositionViewController alloc]init];
    moreVC.str = self.moreStr;
    
    [self.navigationController pushViewController:moreVC animated:YES];

}


@end
