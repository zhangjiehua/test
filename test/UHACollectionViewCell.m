//
//  UHACollectionViewCell.m
//  test
//
//  Created by 张闻闻 on 15/11/17.
//  Copyright © 2015年 张杰华. All rights reserved.
//

#import "UHACollectionViewCell.h"
#import <Masonry.h>

@implementation UHACollectionViewCell

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.purpleColor;
        self.imageView = [UIImageView new];
        self.imageView.backgroundColor = UIColor.orangeColor;
        [self addSubview:self.imageView];
        __weak __typeof(self) weakSelf = self;
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(5,5,5,5));
            make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(weakSelf.frame)-10, CGRectGetHeight(weakSelf.frame)-10));
        }];
    }
    return self;
}

@end
