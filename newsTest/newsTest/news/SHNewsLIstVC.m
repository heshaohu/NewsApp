//
//  SHNewsLIstVC.m
//  newsTest
//
//  Created by 贺少虎 on 16/7/5.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "SHNewsLIstVC.h"
#import "SHNewsHeaderView.h"
#import "SHNewsListCell.h"

static NSString * collectionID = @"ListCellIdentifier";

@interface SHNewsListVC () <UICollectionViewDelegate, UICollectionViewDataSource,SHNewsListDelegate,SHNewsHeaderDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) SHNewsHeaderView * headView;

@end

@implementation SHNewsListVC

- (CGFloat)getSystemBarHeight{
   return (self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻";
}


- (void)dealloc{
    [_collectionView removeObserver:self forKeyPath:@"contentOffset"];
    _collectionView = nil;
}


- (void)loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.headView];
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

-(SHNewsHeaderView *)headView{
    if (!_headView) {
        _headView = [[SHNewsHeaderView alloc] initWithFrame:CGRectMake(0, [self getSystemBarHeight], self.view.bounds.size.width, kNewsTitleHeight)];
        _headView.dataArray = self.titleArray;
        _headView.barDelegate = self;
    }
    return _headView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.view.bounds.size.width , self.view.bounds.size.height - kNewsTitleHeight);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.headView.frame)) collectionViewLayout:layout];
        
        [_collectionView registerClass:[SHNewsListCell class] forCellWithReuseIdentifier:collectionID];
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

#pragma mark collectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _headView.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SHNewsListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
    //    cell.dataSource = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3",nil];

    cell.delegate = self;
    return cell;
}

- (void)didSelectHeaderItemAtIndex:(NSInteger)index{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionLeft];
}

#pragma mark KVO

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSString*, id> *)change context:(nullable void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        NSValue *value = change[@"new"];
        CGPoint point = [value CGPointValue];
        [self.headView updatePostionWithContentWidth:self.collectionView.contentSize.width contentOffsetX:point.x];
    }
}


@end
