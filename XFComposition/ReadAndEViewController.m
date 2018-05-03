//
//  ReadAndEViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "ReadAndEViewController.h"
#import "RingFristCell.h"//重用 第一行
#import "ReadSecondCell.h"//第2 3行
#import "HomePaSixCell.h"//第4 5行
#import "ReadSixCell.h"
#import "ReadSenvenCell.h"
#import "ReadeightCell.h"
#import "ReadTenCell.h"
#import "HomePaFristheadView.h"
#import "MicReplaceCell.h"

#import "HomeBookRequst.h"//图书列表
#import "BookModel.h"
#import "GetBookBjRequst.h"//读书笔记
#import "GetBookBjModel.h"
#import "GetBookPaiHangRequst.h"//获取图书排行
#import "GetBookPaihangModel.h"
#import "GetReadStartRequst.h"//获取阅读排行
#import "GetReadStartModel.h"
#import "ReadBoBaoRequst.h"//阅读播报

#import "BookRecViewController.h"
#import "ReadinotesViewController.h"
#import "BookRankViewController.h"
#import "BookDetailViewController.h"
@interface ReadAndEViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)NSMutableArray *tuijianbookArray;
@property (nonatomic,strong)NSMutableArray *xuexiaobookArray;
@property (nonatomic,strong)NSMutableArray *xianfengbookArray;
@property (nonatomic,strong)NSMutableArray *remenbookArray;
@property (nonatomic,strong)NSMutableArray *booBJArray;
@property (nonatomic,strong)NSMutableArray *weekArray;
@property (nonatomic,strong)NSMutableArray *monthArray;
@property (nonatomic,strong)NSMutableArray *readpaihangArray1;
@property (nonatomic,strong)NSMutableArray *readpaihangArray2;
@property (nonatomic,strong)XFUserInfo *xf;
@end

@implementation ReadAndEViewController
-(NSMutableArray *)tuijianbookArray{
    if (!_tuijianbookArray) {
        _tuijianbookArray  = [[NSMutableArray alloc]init];
    }
    return _tuijianbookArray;
}
-(NSMutableArray *)xuexiaobookArray{
    if (!_xuexiaobookArray) {
        _xuexiaobookArray = [[NSMutableArray alloc]init];
    }
    return _xuexiaobookArray;
}
-(NSMutableArray *)xianfengbookArray{
    if (!_xianfengbookArray) {
        _xianfengbookArray = [[NSMutableArray alloc]init];
    }
    return _xianfengbookArray;
}
-(NSMutableArray *)remenbookArray{
    if (!_remenbookArray) {
        _remenbookArray = [[NSMutableArray alloc]init];
    }
    return _remenbookArray;
}
-(NSMutableArray *)booBJArray{
    if (!_booBJArray) {
        _booBJArray = [[NSMutableArray alloc]init];
    }
    return _booBJArray;
}
-(NSMutableArray *)weekArray{
    if (!_weekArray) {
        _weekArray = [[NSMutableArray alloc]init];
    }
    return _weekArray;
}
-(NSMutableArray *)monthArray{
    if (!_monthArray) {
        _monthArray = [[NSMutableArray alloc]init];
    }
    return _monthArray;
}
-(NSMutableArray *)readpaihangArray1{
    if (!_readpaihangArray1) {
        _readpaihangArray1 = [[NSMutableArray alloc]init];
    }
    return _readpaihangArray1;
}
-(NSMutableArray *)readpaihangArray2{
    if (!_readpaihangArray2) {
        _readpaihangArray2 = [[NSMutableArray alloc]init];
    }
    return _readpaihangArray2;
}
-(XFUserInfo *)xf{
    if (!_xf) {
        _xf = [[XFUserInfo alloc]init];
        _xf = [XFUserInfo getUserInfo];
    }
    return _xf;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [self bookRequst:@"0" :self.tuijianbookArray :@"4"];
        [self bookRequst:@"1" :self.xuexiaobookArray :@"4"];
        [self bookRequst:@"1" :self.xianfengbookArray :@"2"];
        [self bookRequst:@"2" :self.remenbookArray :@"2"];
        [self readBJRequst];
        [self GetBookpaihangRequst:@"0" :self.weekArray];//周排行
        [self GetBookpaihangRequst:@"1" :self.monthArray];//月排行
        
        [self ReadStartRequst:@"0" :@"4" :self.readpaihangArray1];//阅读排行
        [self ReadStartRequst:@"1" :@"4" :self.readpaihangArray2];
//        [self getReadBoBao:@"1"];//阅读播报
//        [self getReadBoBao:@"2"];//阅读播报
        [self.collectionView.mj_header endRefreshing];
        
        
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    
    [self.collectionView.mj_header beginRefreshing];
    
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[RingFristCell class] forCellWithReuseIdentifier:@"Read1"];
        [_collectionView registerClass:[ReadSecondCell class] forCellWithReuseIdentifier:@"Read23"];
        [_collectionView registerClass:[HomePaSixCell class] forCellWithReuseIdentifier:@"Read45"];
        [_collectionView registerClass:[ReadSixCell class] forCellWithReuseIdentifier:@"Read6"];
        [_collectionView registerClass:[ReadSenvenCell class] forCellWithReuseIdentifier:@"Read79"];
        [_collectionView registerClass:[ReadeightCell class] forCellWithReuseIdentifier:@"Read8"];
        [_collectionView registerClass:[ReadTenCell class] forCellWithReuseIdentifier:@"Read10"];
        [_collectionView registerClass:[MicReplaceCell class] forCellWithReuseIdentifier:@"MicReplaceCell"];
        
        [_collectionView registerClass:[HomePaFristheadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header1"];//注册cell的headview

    }
    return _collectionView;
}
//图书列表
-(void)bookRequst :(NSString *)chaperid :(NSMutableArray *)array :(NSString *)pagesize{
    HomeBookRequst *bookRequst = [[HomeBookRequst alloc]init];
    [bookRequst HomeGetBookListWithchaperid :chaperid :@"0" :pagesize :^(NSDictionary *json) {
        [array removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            BookModel *model = [BookModel loadWithJSOn:dic];
            [array addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    
}
//读书笔记
-(void)readBJRequst{
    GetBookBjRequst *requst = [[GetBookBjRequst alloc]init];
    [requst GetBookBjRequstWithPageIndex:@"1" withPageSize:@"8" withflag:@"1" withistuijian:@"0" :^(NSDictionary *json) {
        [self.booBJArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            GetBookBjModel *model = [GetBookBjModel loadWithJSOn:dic];
            [self.booBJArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    

}
//获取图书排行
-(void)GetBookpaihangRequst :(NSString *)flag :(NSMutableArray *)array{
    GetBookPaiHangRequst *requst = [[GetBookPaiHangRequst alloc]init];
    [requst GetBookPaiHangRequstWithflag:flag :^(NSDictionary *json) {
        [array removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"]) {
            GetBookPaihangModel *model = [GetBookPaihangModel loadWithJSOn:dic];
            [array addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    
}
//获取阅读排行
-(void)ReadStartRequst :(NSString *)flag :(NSString *)num :(NSMutableArray *)array{
    GetReadStartRequst *requst = [[GetReadStartRequst alloc]init];
    [requst GetReadStartRequstwithflag:flag withnum:num :^(NSDictionary *json) {
        [array removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"]) {
            
            GetReadStartModel *model = [GetReadStartModel loadWithJSOn:dic];
            [array addObject:model];
        }

            [self.collectionView reloadData];

        
    }];

}
//阅读播报
-(void)getReadBoBao :(NSString *)flag{
    ReadBoBaoRequst *requst = [[ReadBoBaoRequst alloc]init];
    [requst ReadBoBaoRequstWithPageIndex:@"1" withPageSize:@"4" withflag:flag withistuijian:@"0" :^(NSDictionary *json) {
        
    }];
}
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        if (self.tuijianbookArray.count == 0) {
            return 0;
        }
        return self.tuijianbookArray.count;
    }else if (section == 2){
        if (self.xuexiaobookArray.count == 0) {
            return 0;
        }
        return self.xuexiaobookArray.count;
    }else if (section == 3){
        if (self.xianfengbookArray.count == 0) {
            return 0;
        }
        return self.xianfengbookArray.count;
    }else if (section == 4){
        if (self.remenbookArray.count ==0) {
            return 0;
        }
        return self.remenbookArray.count;
    }else if (section == 5){
        return 1;//横幅
    }else if (section == 6){
        return self.booBJArray.count;//读书笔记
    }else if (section == 7){
        return 1;//10大排行
    }else if (section == 8){
        return 1;//读书排行
    }
    return 0;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 9;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        RingFristCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Read1" forIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:@"banner_yuedu"];
        UIButton *button = cell.bt;
        [button addTarget:self action:@selector(goBacka) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    else if (indexPath.section == 1){
        if (self.tuijianbookArray.count == 0) {
            MicReplaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicReplaceCell" forIndexPath:indexPath];
            return cell;
        }
        ReadSecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Read23" forIndexPath:indexPath];
        BookModel *model1 = self.tuijianbookArray[indexPath.row];
        
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model1.BookPic];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
        cell.nameLabel.text = [NSString stringWithFormat:@"《%@》",model1.BookName];
        return cell;
        
    }
    else if (indexPath.section == 2){
        if (self.xuexiaobookArray.count == 0) {
            MicReplaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicReplaceCell" forIndexPath:indexPath];
            return cell;
        }
        ReadSecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Read23" forIndexPath:indexPath];
        BookModel *model1 = self.xuexiaobookArray[indexPath.row];
        
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model1.BookPic];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
        cell.nameLabel.text = [NSString stringWithFormat:@"《%@》",model1.BookName];
        return cell;
    }else if (indexPath.section == 3){
        if (self.tuijianbookArray.count == 0) {
            MicReplaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicReplaceCell" forIndexPath:indexPath];
            return cell;
        }
        HomePaSixCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Read45" forIndexPath:indexPath];
        BookModel *model1 = self.xianfengbookArray[indexPath.row];
        
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model1.BookPic];
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
        //        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:str]];
        cell.label1.text = [NSString stringWithFormat:@"《%@》",model1.BookName];
        cell.label2.text = [NSString stringWithFormat:@"出版社:%@",model1.BookPublic];
        cell.label3.text = [NSString stringWithFormat:@"添加时间:%@",model1.BookAddTime];
        cell.label4.text = [NSString stringWithFormat:@"作者:%@",model1.BookAuthor];
        cell.label5.text = model1.BookPublic;
        cell.label6.text = [NSString stringWithFormat:@"阅读人数:%@",model1.BookIntroduction];

        return cell;
    }else if (indexPath.section == 4){
        if (self.remenbookArray.count == 0) {
            MicReplaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicReplaceCell" forIndexPath:indexPath];
            return cell;
        }
        HomePaSixCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Read45" forIndexPath:indexPath];
        BookModel *model1 = self.remenbookArray[indexPath.row];
        
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model1.BookPic];
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
        //        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:str]];
        cell.label1.text = [NSString stringWithFormat:@"《%@》",model1.BookName];
        cell.label2.text = [NSString stringWithFormat:@"出版社:%@",model1.BookPublic];
        cell.label3.text = [NSString stringWithFormat:@"添加时间:%@",model1.BookAddTime];
        cell.label4.text = [NSString stringWithFormat:@"作者:%@",model1.BookAuthor];
        cell.label5.text = model1.BookPublic;
        cell.label6.text = [NSString stringWithFormat:@"阅读人数:%@",model1.BookIntroduction];
        return cell;
    }else if (indexPath.section == 5){
        ReadSixCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Read6" forIndexPath:indexPath];
        return  cell;
    }else if (indexPath.section == 6){
        ReadSenvenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Read79" forIndexPath:indexPath];
        GetBookBjModel *model = self.booBJArray[indexPath.row];
        cell.textLable.text = model.deptname;
        cell.schoolLabel.text = model.username;
        return  cell;
    }else if (indexPath.section == 7){
        ReadeightCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Read8" forIndexPath:indexPath];
        cell.Warray = self.weekArray;
        cell.Marray = self.monthArray;
        return cell;
    }else if (indexPath.section == 8){
        ReadTenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Read10" forIndexPath:indexPath];
        
        cell.array1 = self.readpaihangArray1;
        cell.array2 = self.readpaihangArray2;
        return  cell;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return CGSizeMake(WidthFrame, HeightFrame/3);
        
    }else if (indexPath.section == 1){
        return CGSizeMake((WidthFrame-20-30)/4, HeightFrame/6+20);
        
    }else if (indexPath.section == 2){
        return CGSizeMake((WidthFrame-20-30)/4, HeightFrame/6+20);
        
    }
    else if (indexPath.section == 3){
        return CGSizeMake(WidthFrame/2-15, 110);
        
    }else if (indexPath.section == 4){
        return CGSizeMake(WidthFrame/2-15, 110);
        
    }
    else if (indexPath.section == 5){
        return CGSizeMake(WidthFrame, 40);//横幅
        
    }else if (indexPath.section == 6){
        return CGSizeMake(WidthFrame/2-30, 20);
        
    }else if (indexPath.section == 7){
        return CGSizeMake(WidthFrame-40, 230);
        
    }else if (indexPath.section == 8){
        return CGSizeMake(WidthFrame-40, 80);
        
    }
    return CGSizeZero;
    
}
// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //    return UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    if (section == 0) {
        return UIEdgeInsetsZero;
    }else if (section == 1 || section == 2 ){
        
        return UIEdgeInsetsMake(5, 10, 5, 10);
    
    }else if (section == 3 || section == 4){
        return UIEdgeInsetsMake(5, 10, 5, 10);
    
    }else if (section == 7){
        return UIEdgeInsetsMake(5, 20, 5, 20);
    
    }
    else if (section == 6 || section == 8){
        return UIEdgeInsetsMake(5, 20, 5, 20);
    }
    return UIEdgeInsetsMake(0, 0, 5, 0);
    
}

//横向
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
// 竖向   设置最小行间距，也就是前一行与后一行的中间最小间隔  行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0 || section ==5) {
        return CGSizeZero;
    }else
        return CGSizeMake(WidthFrame, 25);
    
}

#pragma mark 头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0 || indexPath.section == 5) {
            
            return nil;
        }else {
            
            HomePaFristheadView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header1" forIndexPath:indexPath];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button = view.bt;
            if (indexPath.section == 1){
                view.bt.hidden = NO;
                view.textLable.text = @"图书推荐";
                button.tag  = 1000;
                [button addTarget:self action:@selector(gotoMore:) forControlEvents:UIControlEventTouchUpInside];
            }else if (indexPath.section == 2){
                 view.bt.hidden = NO;
                view.textLable.text = @"学校推荐";
                button.tag  = 1001;
            }else if (indexPath.section == 3){
                 view.bt.hidden = NO;
                view.textLable.text = @"先锋推荐";
                button.tag  = 1002;
            }else if (indexPath.section == 4){
                 view.bt.hidden = NO;
                view.textLable.text = @"热门推荐";
                button.tag  = 1003;
            }else if (indexPath.section == 6){
                 view.bt.hidden = NO;
                view.textLable.text = @"读书笔记";
                button.tag  = 1004;
                [button addTarget:self action:@selector(gotoMore:) forControlEvents:UIControlEventTouchUpInside];
            }else if (indexPath.section == 7){
                view.bt.hidden = YES;
                view.textLable.text = @"十大读书排行榜";
                button.tag  = 1005;
                [button addTarget:self action:@selector(gotoMore:) forControlEvents:UIControlEventTouchUpInside];
            }else if (indexPath.section == 8){
                 view.bt.hidden = NO;
                view.textLable.text = @"读书排行";
                button.tag  = 1006;
                [button addTarget:self action:@selector(gotoMore:) forControlEvents:UIControlEventTouchUpInside];
            }else if (indexPath.section == 9){
                view.textLable.text = @"互动交流";
                button.tag  = 1007;
                [button addTarget:self action:@selector(gotoMore:) forControlEvents:UIControlEventTouchUpInside];
            }
            return view;
            
        }
    }
    return nil;
    
}
-(void)gotoMore :(UIButton *)bt{
    if (bt.tag == 1000 || bt.tag == 1001 || bt.tag == 1002 || bt.tag == 1003  ) {
        BookRecViewController *vc = [[BookRecViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (bt.tag ==1004){
        
        ReadinotesViewController *vc = [[ReadinotesViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (bt.tag ==1006){
        
        BookRankViewController *vc = [[BookRankViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}
#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    }else{
        if (self.xf.Loginid == NULL) {
            [SVProgressHUD showInfoWithStatus:@"您还未登录"];
            return;
        }
        BookDetailViewController *vc = [[BookDetailViewController alloc]init];
        
        if (indexPath.section == 1) {
            BookModel *model1 = self.tuijianbookArray[indexPath.item];
            
            vc.bookid = model1.ID;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.section == 2){
            BookModel *model1 = self.xuexiaobookArray[indexPath.item];
            
            vc.bookid = model1.ID;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.section == 3){
            BookModel *model1 = self.xianfengbookArray[indexPath.item];
            
            vc.bookid = model1.ID;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.section == 4){
            BookModel *model1 = self.remenbookArray[indexPath.item];
            
            vc.bookid = model1.ID;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
}
-(void)goBacka{
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
