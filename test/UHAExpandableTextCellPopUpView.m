//
//  UHATableViewCellPopView.m
//  test
//
//  Created by 看看 on 15/12/2.
//  Copyright © 2015年 张杰华. All rights reserved.
//

#import "UHAExpandableTextCellPopUpView.h"
#import <Masonry.h>

@implementation UHAExpandableTextCellPopUpView


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.clearColor;
        __weak __typeof(self) weakSelf = self;
        self.backgroundImageView = [UIImageView new];
        self.backgroundImageView.image = [UIImage  imageNamed:@"富文本编辑_框_文字功能"];
        [self addSubview:self.backgroundImageView];
        self.inputButton = [UIButton new];
        [self.inputButton setImage:[UIImage imageNamed:@"富文本编辑_按钮_编辑文本"] forState:UIControlStateNormal];
        [self addSubview:self.inputButton];
        
        self.changeStyleButton = [UIButton new];
        [self.changeStyleButton setImage:[UIImage imageNamed:@"富文本编辑_按钮_文字对齐_左对齐"] forState:UIControlStateNormal];
        [self addSubview:self.changeStyleButton];
        
        self.deleteButton = [UIButton new];
        [self.deleteButton setImage:[UIImage imageNamed:@"富文本编辑_按钮_文字删除"] forState:UIControlStateNormal];
        [self addSubview:self.deleteButton];
        
        [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(0,0,0,0));
        }];
        [self.inputButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(weakSelf);
            make.right.equalTo(weakSelf.changeStyleButton.mas_left);
            make.width.height.equalTo(@[weakSelf.changeStyleButton,weakSelf.deleteButton]);
        }];
        
        [self.changeStyleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            make.right.equalTo(weakSelf.deleteButton.mas_left);
        }];
        
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(weakSelf);
        }];
    }
    return self;
}

@end
