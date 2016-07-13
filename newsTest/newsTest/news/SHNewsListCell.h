//
//  SHNewsListCell.h
//  newsTest
//
//  Created by 贺少虎 on 16/7/5.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHNewsCell.h"

@protocol SHNewsListDelegate;

@interface SHNewsListCell : UICollectionViewCell

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) id <SHNewsListDelegate> delegate;

@end

@protocol SHNewsListDelegate <NSObject>

@optional

- (void)selectNewsAtIndexPath:(NSIndexPath*)newsIndexPath withListIndex:(NSIndexPath *)indexPath;

@end