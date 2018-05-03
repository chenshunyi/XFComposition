//
//  SynchroClassViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "SynchroClassViewController.h"
//#import "SynchroHeadView.h"
#import "MicroClassTypeRquset.h"
#import "MicroClassTypeModel.h"
#import "MicroClassGradeModel.h"
#import "MicroClassLists.h"
#import "WriteListModel.h"
#import "MicoThridCell.h"
#import "MicrodetailController.h"
@interface SynchroClassViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *headView;
@property (nonatomic,strong)NSString *Fristparameter;
@property (nonatomic,strong)NSString *Secondeparameter;
@property (nonatomic,strong)NSString *Thridparameter;
@property (nonatomic,strong)NSArray *classArray;
@property (nonatomic,strong)NSMutableArray *tizaiArray;//体载
@property (nonatomic,strong)NSMutableArray *gradeArray;//年级
@property (nonatomic,strong)NSMutableDictionary *gradeDic;
@property (nonatomic,strong)UIButton *bt;
@property (nonatomic,strong)NSMutableArray *array3;
@property (nonatomic,strong)NSMutableArray *allMicArray;//数据

@property (nonatomic,strong)NSMutableArray *btnArray1;
@property (nonatomic,strong)NSMutableArray *btnArray2;
@property (nonatomic,strong)NSMutableArray *btnArray3;
@end

@implementation SynchroClassViewController
-(NSArray *)classArray{
    if (!_classArray) {
        _classArray = @[@"所有课程",@"即将进行",@"正在进行",@"结束课程"];
    }
    return _classArray;
}
-(NSMutableArray *)array3{
    if (!_array3) {
        _array3 = [[NSMutableArray alloc]init];
    }
    return _array3;
}
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 215)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//        [_tableView registerClass:[ThidTableViewCell class] forCellReuseIdentifier:@"cell2"];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  
    if (indexPath.row == 0) {
        for (int i = 0; i<self.classArray.count; i++) {
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            bt.frame = CGRectMake(40+(60+30)*i, 8, 60, 30);
            bt.tag = 1000+i;
            
            bt.layer.cornerRadius = 6;
            bt.clipsToBounds = YES;
            bt.backgroundColor = UIColorFromRGBA(30, 144, 255, 1.0f);
            [bt setTitle:self.classArray[i] forState:UIControlStateNormal];
            [bt addTarget:self action:@selector(Fristcell:) forControlEvents:UIControlEventTouchUpInside];
            bt.titleLabel.font = [UIFont systemFontOfSize:11];
            [self.btnArray1 addObject:bt];
            if (i == 0) {
                [bt setTitleColor:[UIColor colorWithHexString:@"#292421"] forState:UIControlStateNormal];
            }
            
            [cell addSubview:bt];
            
        }
        
    }else if (indexPath.row ==1){
        
        for (int i = 0; i<self.tizaiArray.count; i++) {
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            bt.frame = CGRectMake(40+(60+20)*i, 8, 60, 30);
            bt.tag = 1000+i;
            MicroClassTypeModel *model = self.tizaiArray[i];
            
            bt.layer.cornerRadius = 6;
            bt.clipsToBounds = YES;
            bt.backgroundColor = UIColorFromRGBA(30, 144, 255, 1.0f);
            [bt setTitle:model.tizainame forState:UIControlStateNormal];
            [bt addTarget:self action:@selector(Secondcell:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                [bt setTitleColor:[UIColor colorWithHexString:@"#F4A460"] forState:UIControlStateNormal];
            }
            bt.titleLabel.font = [UIFont systemFontOfSize:12];
            
            [self.btnArray2 addObject:bt];
            [cell addSubview:bt];
            
        }
        return cell;
        
    }else if (indexPath.row ==2){
        

        for (int i = 0; i<self.array3.count; i++) {
            self.bt = [UIButton buttonWithType:UIButtonTypeCustom];
            self.bt.frame = CGRectMake(40+(60+15)*i, 8, 60, 30);
            self.bt.tag = 1000+i;
            
            self.bt.layer.cornerRadius = 6;
            self.bt.clipsToBounds = YES;
            MicroClassGradeModel *model = self.array3[i];
            [self.bt setTitle:model.gradename forState:UIControlStateNormal];
            [self.bt addTarget:self action:@selector(Thirdcell:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                [self.bt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            }
            self.bt.backgroundColor = UIColorFromRGBA(30, 144, 255, 1.0f);
            self.bt.titleLabel.font = [UIFont systemFontOfSize:12];
            [self.btnArray3 addObject:self.bt];
            [cell addSubview:self.bt];
            
        }
        
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)Fristcell :(UIButton *)bt{
    for (UIButton *btn in self.btnArray1){
        if (btn.tag == bt.tag) {
            [btn setTitleColor:[UIColor colorWithHexString:@"#292421"] forState:UIControlStateNormal];
        }else
        {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }

    NSArray *array = @[@"0",@"1",@"2",@"3"];
    self.Fristparameter = array[bt.tag-1000];
    
    [self GetMicroClass];
    
}
-(void)Secondcell :(UIButton*)bt{
    for (UIButton *btn in self.btnArray2){
        if (btn.tag == bt.tag) {
            [btn setTitleColor:[UIColor colorWithHexString:@"#F4A460"] forState:UIControlStateNormal];
        }else
        {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
    
//    [self.tableView reloadData];
    NSIndexPath *indexPathA = [NSIndexPath indexPathForRow:2 inSection:0]; //单行刷新,刷新第0段第2行
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathA,nil] withRowAnimation:UITableViewRowAnimationNone];
    
    MicroClassTypeModel *model = self.tizaiArray[bt.tag-1000];
    
    self.Secondeparameter = model.zaitiid;
    
    [self.bt removeFromSuperview];
    
    self.array3 = self.gradeDic[self.gradeArray[bt.tag-1000]];
    MicroClassGradeModel *model2 = self.array3[bt.tag - 1000];//默认一开始选中第一个
    self.Thridparameter = model2.gid;
    
    
    [self GetMicroClass];

    
}
-(void)Thirdcell :(UIButton *)bt{
    for (UIButton *btn in self.btnArray3){
        if (btn.tag == bt.tag) {
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }else
        {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
    MicroClassGradeModel *model = self.array3[bt.tag - 1000];
    self.Thridparameter = model.gid;
    
    [self GetMicroClass];
    
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 220, WidthFrame, HeightFrame-220) collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColorFromRGBA(240, 255, 255, 1.0f);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[MicoThridCell class] forCellWithReuseIdentifier:@"MicCell3"];
        _collectionView.backgroundColor = [UIColor whiteColor];
//        [_collectionView registerClass:[MicoFristCell class] forCellWithReuseIdentifier:@"MicCell1"];
        
    }
    return _collectionView;
    
}
-(NSMutableArray *)tizaiArray {
    if (!_tizaiArray) {
        _tizaiArray = [[NSMutableArray alloc]init];
    }
    return _tizaiArray;
}
-(NSMutableArray *)gradeArray{
    if (!_gradeArray) {
        _gradeArray = [[NSMutableArray alloc]init];
    }
    return _gradeArray;
}
-(NSMutableDictionary *)gradeDic{
    if (!_gradeDic) {
        _gradeDic = [[NSMutableDictionary alloc]init];
    }
    return _gradeDic;
}
-(NSString *)Fristparameter{
    if (!_Fristparameter) {
        _Fristparameter = @"";
    }
    return _Fristparameter;
}
-(NSString *)Secondeparameter{
    if (!_Secondeparameter) {
        _Secondeparameter = @"";
    }
    return _Secondeparameter;
}
-(NSString *)Thridparameter{
    if (!_Thridparameter) {
        _Thridparameter = @"";
    }
    return _Thridparameter;
}

-(NSMutableArray *)allMicArray{
    if (!_allMicArray) {
        _allMicArray = [[NSMutableArray alloc]init];
    }
    return _allMicArray;
}
-(NSMutableArray *)btnArray1{
    if (!_btnArray1) {
        _btnArray1 = [[NSMutableArray alloc]init];
    }
    return _btnArray1;
}
-(NSMutableArray *)btnArray2{
    if (!_btnArray2) {
        _btnArray2 = [[NSMutableArray alloc]init];
    }
    return _btnArray2;
}
-(NSMutableArray *)btnArray3{
    if (!_btnArray3) {
        _btnArray3 = [[NSMutableArray alloc]init];
    }
    return _btnArray3;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self leftBarButton];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton =NO;

    [self.view addSubview:self.tableView];
    
    self.Fristparameter = @"0";//默认第一行选中
    [self.view addSubview:self.collectionView];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self GetMicroType];
        [self GetMicroClass];
        [self.collectionView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.mj_footer=[MJRefreshBackNormalFooter   footerWithRefreshingBlock:^{
        
        
        //            [self requstMore];
        [self.collectionView.mj_footer endRefreshing];
    }];

}

-(void)GetMicroType{
    __weak typeof (self) weakSelf = self;
    MicroClassTypeRquset *requst = [[MicroClassTypeRquset alloc]init];
    
    [requst GetmicrTypeWith:@"2" :^(NSDictionary *json) {
        [weakSelf.tizaiArray removeAllObjects];
        [weakSelf.gradeArray removeAllObjects];
        [weakSelf.array3 removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"]) {
            MicroClassTypeModel *model = [MicroClassTypeModel loadWithJSOn:dic];
            [weakSelf.tizaiArray addObject:model];
            
            [weakSelf.gradeArray addObject:model.tizainame];
            
            weakSelf.array3 = weakSelf.gradeDic[weakSelf.gradeArray[0]];//默认第3行一开始选中；
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic2 in model.childgrade) {
                MicroClassGradeModel *model2 = [MicroClassGradeModel loadWithJSOn:dic2];

                [array addObject:model2];
            }
            [weakSelf.gradeDic setValue:array forKey:dic[@"tizainame"]];
        }
//        NSLog(@"%@",json);
        MicroClassTypeModel *moren = weakSelf.tizaiArray[0];
        weakSelf.Secondeparameter = moren.zaitiid;//默认第2行一开始选中
//        NSLog(@"------%lu",(unsigned long)self.tizaiArray.count);
//        NSLog(@"------%lu",[self.gradeDic[self.gradeArray[1]] count]);
//        NSLog(@"------%lu",[self.gradeDic[self.gradeArray[2]] count]);
//        NSLog(@"------%lu",[self.gradeDic[self.gradeArray[3]] count]);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];

}
-(void)GetMicroClass{
    __weak typeof (self) weakSelf = self;
    NSLog(@"33333  1:%@",self.Fristparameter);
    NSLog(@"33333  2:%@",self.Secondeparameter);
    NSLog(@"33333  3:%@",self.Thridparameter);
    MicroClassLists *requst = [[MicroClassLists alloc]init];
    [requst GetmicrListWith:self.Fristparameter :self.Secondeparameter :self.Thridparameter :^(NSDictionary *json) {
//        NSLog(@"====%@",json);
        [weakSelf.allMicArray removeAllObjects];
        for (NSDictionary *dic in json[@"ret_data"][@"pageInfo"]) {
            WriteListModel *model = [WriteListModel loadWithJSOn:dic];
            [weakSelf.allMicArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
 
    }];

}
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.allMicArray.count;
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MicoThridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MicCell3" forIndexPath:indexPath];
    WriteListModel *model  = self.allMicArray[indexPath.row];
    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.MicroclassInfoAttr1];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str]];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"Mic01"] options:SDWebImageRefreshCached];
    cell.titleLabel.text = model.MicroclassInfoTitle;
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(WidthFrame/3-30,HeightFrame/8+20);
}
// 设置整个组的缩进量是多少
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 20, 2, 20);
    
}
#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WriteListModel *model  = self.allMicArray[indexPath.row];
    
    MicrodetailController *vc = [[MicrodetailController alloc]init];
    vc.classId = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"选择%ld",indexPath.item);
}
-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    
    self.navigationItem.leftBarButtonItem=item;
    
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
