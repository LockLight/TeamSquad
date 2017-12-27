/************************************************************************************
 
 ====================================================================================
 类名 :   BenchViewController.m
 工程 :   TeamSquad
 项目 :   <#我不忧#>
 功能 :   <#功能介绍#>
 作者 :   locklight
 日期 :   2017/12/27
 公司 : Copyright © 2017年 locklight. All rights reserved.
 版本 :   <#1.0#>
 ====================================================================================
 
 ************************************************************************************/

#import "BenchViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

static NSString *benchIdentifier = @"benchIdentifier";

@interface BenchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation BenchViewController

#pragma mark - Life Cycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:benchIdentifier];
}

#pragma mark - Getters And Setters
#pragma mark -- get方法

#pragma mark -- set方法
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        //itme宽高
        CGFloat itemWH = ([UIScreen mainScreen].bounds.size.width - 50) / 3.0;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing= 20;
        layout.minimumInteritemSpacing = 8;
        layout.itemSize = CGSizeMake(itemWH, itemWH);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor yellowColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

#pragma mark - Private Methods 私有方法

#pragma mark - Public Methods 公共方法

#pragma mark - Event Response 事件响应

#pragma mark - Delegate


@end
