//
//  SHNewsHeaderView.m
//  newsTest
//
//  Created by 贺少虎 on 16/7/5.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "SHNewsHeaderView.h"
#import "SHNewsHeaderCell.h"

static NSString * cellID = @"HeadBarcellid";

@interface SHNewsHeaderView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, assign) NSInteger nowPage; //0 开头

@end

@implementation SHNewsHeaderView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        _nowPage = 0;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        [self registerClass:[SHNewsHeaderCell class] forCellWithReuseIdentifier:cellID];
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [self initWithFrame:frame collectionViewLayout:layout];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _dataArray;
}

#pragma mark datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SHNewsHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.title.text = self.dataArray[indexPath.row];
    if (indexPath.row == _nowPage) {
        [cell setProgress:0.0];
    }else{
        [cell setProgress:1.0];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([SHNewsHeaderCell getCellHeightWithTitle:self.dataArray[indexPath.row]] + kNewsTitleMargin, kNewsTitleHeight);
}


- (void)updatePostionWithContentWidth:(CGFloat)width contentOffsetX:(CGFloat)offsetX{
    if (offsetX <= 0 || offsetX > width) {
        return;
    }
    CGFloat onePageX = width / self.dataArray.count;
    CGFloat buffer = offsetX/onePageX;
    
    _nowPage = (NSInteger)buffer;
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:_nowPage inSection:0];
    SHNewsHeaderCell *fromCell  = (SHNewsHeaderCell *)[self cellForItemAtIndexPath:path];
    CGFloat progress = buffer - _nowPage;
    
    if (fromCell) {
        [fromCell setProgress:progress];
    }
    SHNewsHeaderCell *toCell  = (SHNewsHeaderCell *)[self cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_nowPage + 1 inSection:0]];
    
    if(toCell){
        [toCell setProgress:1 - progress];
    }
    
    [self scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.barDelegate && [self.barDelegate respondsToSelector:@selector(didSelectHeaderItemAtIndex:)]) {
        [self.barDelegate didSelectHeaderItemAtIndex:indexPath.row];
    }
}



@end
