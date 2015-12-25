//
//  YBImgPickerViewCell.m
//  settingsTest
//
//  Created by 宋奕兴 on 15/9/7.
//  Copyright (c) 2015年 宋奕兴. All rights reserved.
//

#import "YBImgPickerViewCell.h"
@interface YBImgPickerViewCell ()
@property (nonatomic , strong) IBOutlet UIImageView * mainImageView;
@property (nonatomic , strong) IBOutlet UIImageView * isChoosenImageView;

@end
@implementation YBImgPickerViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setContentImg:(UIImage *)contentImg {
    if (contentImg) {
        _contentImg = contentImg;
        self.mainImageView.image = _contentImg;
    }
}
- (void)setIsChoosen:(BOOL)isChoosen {
    _isChoosen = isChoosen;
    [UIView animateWithDuration:0.1 animations:^{
        if (isChoosen) {
          //  self.isChoosenImageView.image = [UIImage imageNamed:@"YBimgPickerView.bundle/isChoosenY"];
            self.isChoosenImageView.image = [UIImage imageNamed:@"相册_图标_选中图像"];
            
            self.layer.masksToBounds = YES;
            self.layer.borderColor = [UIColor colorWithRed:174./255 green:153./255 blue:90./255 alpha:1.0].CGColor;
            self.layer.borderWidth = 3.0;
            
        }else {
            self.isChoosenImageView.image = nil;
        }
        self.isChoosenImageView.transform = CGAffineTransformMakeScale (1.1,1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.isChoosenImageView.transform = CGAffineTransformMakeScale (1.0,1.0);
        } completion:^(BOOL finished) {
            
        }];
    }];
    
}
- (void)setIsChoosenImgHidden:(BOOL)isChoosenImgHidden {
    _isChoosenImgHidden = isChoosenImgHidden;
    self.isChoosenImageView.hidden = isChoosenImgHidden;
}
@end
