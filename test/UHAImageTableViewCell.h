//
//  UHATableViewCell.h
//  test
//
//  Created by 看看 on 15/11/18.
//  Copyright © 2015年 张杰华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UHAImageEntity.h"

@protocol UHATableViewCellDelegate <NSObject>

@optional

- (void)respondsToDeleteUHATableViewCell:(id )entity;
- (void)respondsToEditUHAImage:(id)entity;

@end



@interface UHAImageTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView   *myImageView;
@property (nonatomic,strong) UIButton      *deleteButton;
@property (nonatomic,strong) UIButton      *editButton;
//@property (nonatomic,strong) UIView        *mySelectedView;
@property (nonatomic,strong) UHAImageEntity *entity;
@property (nonatomic,assign) id<UHATableViewCellDelegate> delegate;

- (void)updateWithData:(UHAImageEntity *)entity;

@end
