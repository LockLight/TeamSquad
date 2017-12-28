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
#import "Masonry.h"
#import "BenchViewCell.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

static NSString *benchIdentifier = @"benchIdentifier";

@interface BenchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,BenchViewCelllDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation BenchViewController

#pragma mark - Life Cycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.collectionView];
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.left.bottom.equalTo(self.view);
//        make.width.mas_offset(300);
//    }];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"BenchViewCell" bundle:nil] forCellWithReuseIdentifier:benchIdentifier];
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
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 500, kScreenWidth, kScreenHeight-500) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor yellowColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
        for (NSInteger i = 0; i < 10; i++) {
            [_dataList addObject:[NSString stringWithFormat:@"球员%zd",i]];
        }
    }
    return _dataList;
}

#pragma mark - Private Methods 私有方法

#pragma mark - Public Methods 公共方法

#pragma mark - Event Response 事件响应

#pragma mark - Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BenchViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:benchIdentifier forIndexPath:indexPath];
    cell.title = self.dataList[indexPath.item];
    cell.contentView.backgroundColor = [UIColor redColor];
    cell.delegate = self;
    return cell;
}

- (void)longPressClick:(UILongPressGestureRecognizer *)gesture{
    //记录手指位置
    static CGPoint point;
    //截图图片
    static UIImageView *view;
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            {
                //截图当前cell图片
                view = [self imageViewWithCell:(BenchViewCell *)gesture.view];
                //隐藏cell,设置图片位置
                gesture.view.hidden = YES;
                view.center = gesture.view.center;
                [self.collectionView addSubview:view];
                //获取当前手指位置
                point = [gesture locationOfTouch:0 inView:self.collectionView];
            }
            break;
        case UIGestureRecognizerStateChanged:
            {
                CGFloat x = [gesture locationOfTouch:0 inView:self.collectionView].x - point.x;
                CGFloat y = [gesture locationOfTouch:0 inView:self.collectionView].y - point.y;
                //移动截图
                view.center = CGPointApplyAffineTransform(point, CGAffineTransformMakeTranslation(x, y));
                //遍历可以cell,做响应操作
                for (BenchViewCell *cell in self.collectionView.visibleCells) {
                    if (cell.hidden == YES) continue;
                    //中心点距离
                    CGFloat space = sqrtf(pow(cell.center.x - view.center.x, 2) + pow(cell.center.y - view.center.y, 2));
                    //判断cell移动时机
                    if (space <= view.frame.size.width * 0.5 && space < fabs(view.center.y - cell.center.y) < cell.frame.size.height * 0.5) {
                        //起始位置 与 结束位置
                        NSIndexPath *fromIndexPath = [self.collectionView indexPathForCell:(BenchViewCell *)gesture.view];
                        NSIndexPath *toIndexPath = [self.collectionView indexPathForCell:cell];
                        
                        NSString *str = [self.dataList objectAtIndex:fromIndexPath.item];
                        [self.dataList removeObjectAtIndex:fromIndexPath.item];
                        [self.dataList insertObject:str atIndex:toIndexPath.item];
                        [self.collectionView moveItemAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
                        break;
                    }
                }
            }
            break;
        case UIGestureRecognizerStateEnded:
            {
                [UIView animateWithDuration:0.25 animations:^{
                    view.center = gesture.view.center;
                    view.backgroundColor = gesture.view.backgroundColor;
                } completion:^(BOOL finished) {
                    [view removeFromSuperview];
                    gesture.view.hidden = NO;
                }];
            }
            break;
        default:
            break;
    }
}

- (UIImageView *)imageViewWithCell:(BenchViewCell *)cell{
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(cell.frame.size, NO, 0.0);
    //将屏幕绘制到上下文中
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    [cell.layer renderInContext:contextRef];
    //从上下文中获取到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:image];
    imgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    imgView.layer.cornerRadius = cell.layer.cornerRadius;
    imgView.layer.masksToBounds = cell.layer.masksToBounds;
    return imgView;
}


@end
