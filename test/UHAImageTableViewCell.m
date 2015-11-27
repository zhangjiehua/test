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
        self.myImageView = [UIView new];
//        self.myImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.myImageView];
        [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.contentView).insets(UIEdgeInsetsMake(0, 0, 10, 0));
        }];
        self.myImageView.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                                 saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                                 brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                                      alpha:1];
        
        self.mySelectedView = [UIView new];
        [self.myImageView addSubview: self.mySelectedView];
        [self.mySelectedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.myImageView).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
        self.mySelectedView.layer.borderColor = UIColor.clearColor.CGColor;
        self.mySelectedView.layer.borderWidth = 3;
        
        
        self.deleteButton = [UIButton new];
        self.deleteButton.backgroundColor = UIColor.whiteColor;
        [self.contentView addSubview:self.deleteButton];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(weakSelf.myImageView);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        self.editButton = [UIButton new];
        self.editButton.backgroundColor = UIColor.whiteColor;
        [self.contentView addSubview:self.editButton];
        [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(weakSelf.myImageView);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        
//        [self.button addTarget:self action:@selector(clickButton) forControlEvents:  UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - ButtonAction
- (void)clickButton {
//    self.backgroundColor = UIColor.blackColor;
    NSLog(@"hey, you clicked the cell button!");
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
