//
//  UHATableViewCell.m
//  test
//
//  Created by 看看 on 15/11/18.
//  Copyright © 2015年 张杰华. All rights reserved.
//

#import "UHAImageTableViewCell.h"
#import <Masonry.h>

@implementation UHAImageTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.backgroundColor = [UIColor clearColor];
        __weak __typeof(self) weakSelf = self;
        self.myImageView = [UIImageView new];
        self.myImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.myImageView];
        [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.contentView).insets(UIEdgeInsetsMake(0, 0, 10, 0));
        }];
        self.myImageView.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                                 saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                                 brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                                      alpha:1];
//        self.mySelectedView = [UIView new];
//        [self.myImageView addSubview: self.mySelectedView];
//        [self.mySelectedView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(weakSelf.myImageView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
//        }];
//        self.mySelectedView.layer.borderColor = UIColor.clearColor.CGColor;
//        self.mySelectedView.layer.borderWidth = 3;
        
        self.deleteButton = [UIButton new];
//        self.deleteButton.backgroundColor = UIColor.whiteColor;
        [self.deleteButton setBackgroundImage:[UIImage imageNamed:@"富文本编辑_按钮_删除图片"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.deleteButton];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(weakSelf.myImageView);
            make.size.mas_equalTo(CGSizeMake(24, 24));
        }];
        [self.deleteButton addTarget:self action:@selector(deleteCurentEntity:) forControlEvents:UIControlEventTouchUpInside];

        
        self.editButton = [UIButton new];
//        self.editButton.backgroundColor = UIColor.whiteColor;
        [self.editButton setBackgroundImage:[UIImage imageNamed:@"富文本编辑_按钮_进入单图编辑"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.editButton];
        [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(weakSelf.myImageView);
            make.size.mas_equalTo(CGSizeMake(81, 37));
        }];
        [self.editButton addTarget:self action:@selector(editCurrentEntity:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - ButtonAction
- (void)deleteCurentEntity:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(respondsToDeleteUHATableViewCell:)]) {
        [self.delegate respondsToDeleteUHATableViewCell:self.entity];
    }
}

- (void)editCurrentEntity:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(respondsToEditUHAImage:)]) {
        [self.delegate respondsToEditUHAImage:self.entity];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)updateWithData:(UHAImageEntity *)entity {
    self.entity = entity;
    self.deleteButton.hidden = YES;
    self.myImageView.image = [UIImage imageNamed:entity.imageName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
