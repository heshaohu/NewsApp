//
//  SHNewsHeaderCell.m
//  newsTest
//
//  Created by 贺少虎 on 16/7/5.
//  Copyright © 2016年 he_shao_hu. All rights reserved.
//

#import "SHNewsHeaderCell.h"
#import "SHNewsHeaderView.h"

@implementation SHNewsHeaderCell

#pragma mark static method

+ (CGFloat)getCellHeightWithTitle:(NSString *)title{
    NSDictionary *attrs = @{NSFontAttributeName:[[self class] defaultFont]};
    CGFloat width = [title boundingRectWithSize:CGSizeMake(1000, kNewsTitleHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
    return width;
}

+ (UIFont *)defaultFont{
    return [UIFont systemFontOfSize:16];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.title];
        NSLayoutConstraint* nameLabelCenterXConstraint = [NSLayoutConstraint constraintWithItem:self.title attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
        
        NSLayoutConstraint* nameLabelCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.title attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f];
        
        [self addConstraint:nameLabelCenterXConstraint];
        [self addConstraint:nameLabelCenterYConstraint];

    }
    return self;
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:self.bounds];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [[self class] defaultFont];
        _title.textColor = [UIColor lightGrayColor];
        _title.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _title;
}

- (void)setProgress:(CGFloat)progress{
    
    UIColor *fromColor = [UIColor lightGrayColor];
    UIColor *toColor = [UIColor redColor];
    
    CGFloat r1,g1,b1,r2,g2,b2;
    [toColor getRed:&r1 green:&g1 blue:&b1 alpha:nil];
    [fromColor getRed:&r2 green:&g2 blue:&b2 alpha:nil];
    
    UIColor *nowColor = [UIColor colorWithRed:r1 + (r2 - r1) *progress green:b1 + (b2 - b1) *progress blue:g1 + (g2 - g1) *progress alpha:1];
    self.title.textColor = nowColor;
    
    CGFloat sc = 1.2  - 0.2 * progress;
    self.title.layer.transform = CATransform3DMakeScale(sc, sc, 1);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.title sizeToFit];
    NSLog(@"layout");

}

@end
