//
//  SHNewsHeaderView.h
//  newsTest
//
//  Created by 贺少虎 on 16/7/5.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat kNewsTitleMargin = 30.0f;
static CGFloat kNewsTitleHeight = 44.0f;

@protocol SHNewsHeaderDelegate;

@interface SHNewsHeaderView : UICollectionView

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) id <SHNewsHeaderDelegate>barDelegate;

- (void)updatePostionWithContentWidth:(CGFloat)width contentOffsetX:(CGFloat)offsetX;

@end

@protocol SHNewsHeaderDelegate <NSObject>

@optional

- (void)didSelectHeaderItemAtIndex:(NSInteger)index;

@end
