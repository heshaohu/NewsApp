//
//  SHNewsCell.m
//  newsTest
//
//  Created by 贺少虎 on 16/7/5.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "SHNewsCell.h"

@interface SHNewsCell()

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *author;
@property (nonatomic, strong) UIImageView *newsImage;

@end


@implementation SHNewsCell

+ (CGFloat)getCellHeight{
    return 100;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.newsImage];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.author];
        [self addConstraintLayout];
    }
    return self;
}


- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectZero];
        _title.font = [UIFont systemFontOfSize:18];
        _title.numberOfLines = 0;
        _title.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    }
    return _title;
}

- (UILabel *)author{
    if (!_author) {
        _author = [[UILabel alloc] initWithFrame:CGRectZero];
        _author.font = [UIFont systemFontOfSize:13];
        _author.textColor = [UIColor colorWithRed:0.6 green:0.62 blue:0.63 alpha:1];
    }
    return _author;
}

- (UIImageView *)newsImage{
    if (!_newsImage) {
        _newsImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _newsImage.contentMode = UIViewContentModeScaleAspectFill;
        _newsImage.clipsToBounds = YES;
    }
    return _newsImage;
}

- (void)addConstraintLayout{
    self.title.translatesAutoresizingMaskIntoConstraints = NO;
    self.newsImage.translatesAutoresizingMaskIntoConstraints = NO;
    self.author.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint* nameImageLeftConstraint = [NSLayoutConstraint constraintWithItem:self.newsImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:kNewsCellMargin];
    
    NSLayoutConstraint* nameLabelCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.newsImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0];
    
    NSLayoutConstraint* nameImageHeightConstraint = [NSLayoutConstraint constraintWithItem:self.newsImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0f constant:-kNewsCellMargin];
    
    NSLayoutConstraint* nameImageWidthConstraint = [NSLayoutConstraint constraintWithItem:self.newsImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0f constant:-kNewsCellMargin];

    [self addConstraint:nameImageLeftConstraint];
    [self addConstraint:nameLabelCenterYConstraint];
    [self addConstraint:nameImageHeightConstraint];
    [self addConstraint:nameImageWidthConstraint];

    
    NSLayoutConstraint* nameTilteLeftConstraint = [NSLayoutConstraint constraintWithItem:self.title attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.newsImage attribute:NSLayoutAttributeRight multiplier:1.0f constant:kNewsCellMargin];
    NSLayoutConstraint* nameTitleTopConstraint = [NSLayoutConstraint constraintWithItem:self.title attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:kNewsCellMargin];
    NSLayoutConstraint* nameTitleRightConstraint = [NSLayoutConstraint constraintWithItem:self.title attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:-kNewsCellMargin];

    [self addConstraint:nameTilteLeftConstraint];
    [self addConstraint:nameTitleTopConstraint];
    [self addConstraint:nameTitleRightConstraint];

    NSLayoutConstraint* nameAuthorLeftConstraint = [NSLayoutConstraint constraintWithItem:self.author attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.newsImage attribute:NSLayoutAttributeRight multiplier:1.0f constant:kNewsCellMargin];
    
    NSLayoutConstraint* nameAuthorBottomConstraint = [NSLayoutConstraint constraintWithItem:self.author attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-kNewsCellMargin];

    [self addConstraint:nameAuthorLeftConstraint];
    [self addConstraint:nameAuthorBottomConstraint];

    // UI 测试
    self.title.text = @"曝KD离开雷霆与威少有关！球风+西决失利令他不满";
    self.newsImage.image = [UIImage imageNamed:@"news.jpg"];
    self.author.text = @"来源：凤凰体育 作者：王VV";

}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}

@end
