//
//  UHABottomView.m
//  test
//
//  Created by 看看 on 15/11/27.
//  Copyright © 2015年 张杰华. All rights reserved.
//

#import "UHABottomView.h"
#import <Masonry.h>

@implementation UHABottomView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    self.backgroundColor = UIColor.whiteColor;
    UIView *lineView = [UIView new];
    lineView.frame = CGRectMake(0, 0, UI_Screen_Width_Normal, 1);
    lineView.backgroundColor = UIColor.grayColor;
    [self addSubview:lineView];
    
    __weak __typeof(self) weakSelf = self;
    self.takePhotoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.takePhotoButton setImage:[UIImage imageNamed:@"富文本_按钮_拍照"] forState:UIControlStateNormal];
    [self addSubview:self.takePhotoButton];
    self.openAlbumButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.openAlbumButton setImage:[UIImage imageNamed:@"富文本_按钮_相册"] forState:UIControlStateNormal];
    [self addSubview:self.openAlbumButton];
    self.addTextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.addTextButton setImage:[UIImage imageNamed:@"富文本_按钮_文本"] forState:UIControlStateNormal];
    [self addSubview:self.addTextButton];
    self.saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.saveButton setImage:[UIImage imageNamed:@"富文本_按钮_保存"] forState:UIControlStateNormal];
    [self addSubview:self.saveButton];
    
    [self.takePhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(weakSelf);
        make.right.equalTo(weakSelf.openAlbumButton.mas_left);//.offset(0);
        make.width.height.mas_equalTo(@[weakSelf.openAlbumButton,weakSelf.addTextButton,weakSelf.saveButton]);
    }];
    
    [self.openAlbumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf);
        make.right.equalTo(weakSelf.addTextButton.mas_left);
    }];
    
    [self.addTextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf);
        make.right.equalTo(weakSelf.saveButton.mas_left);
    }];
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(weakSelf);
    }];
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
