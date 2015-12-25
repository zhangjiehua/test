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
        _imageView = ({
            UIImageView *imgView = [UIImageView new];
            imgView.backgroundColor = UIColor.orangeColor;
            [self addSubview:imgView];
            __weak __typeof(self) weakSelf = self;
            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(2,2,2,2));
//                make.size.mas_equalTo(CGSizeMake(( CGRectGetWidth([UIScreen mainScreen].bounds) - (3 + 1) * 1 ) / 3, ( CGRectGetWidth([UIScreen mainScreen].bounds) - (3 + 1) * 1 ) / 3));
            }];
            imgView;
        });
        
//        self.imageView = [UIImageView new];
//        self.imageView.backgroundColor = UIColor.orangeColor;
//        [self addSubview:self.imageView];
//        __weak __typeof(self) weakSelf = self;
//        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(2,2,2,2));
//            make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(weakSelf.frame)-4, CGRectGetHeight(weakSelf.frame)-4));
//        }];
    }
    return self;
}

@end
