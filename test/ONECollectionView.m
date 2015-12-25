//
//  ONECollectionView.m
//  test
//
//  Created by 看看 on 15/12/21.
//  Copyright © 2015年 张杰华. All rights reserved.
//

#import "ONECollectionView.h"
#import "UHACollectionViewCell.h"

static NSString *const reuseCellIdentifier=@"cell";
@implementation ONECollectionView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = UIColor.whiteColor;
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[UHACollectionViewCell class] forCellWithReuseIdentifier:reuseCellIdentifier];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 27;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UHACollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:reuseCellIdentifier forIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((UI_Screen_Width_Normal-1.5)/3, (UI_Screen_Width_Normal-3)/3);
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0,0,0,0);
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
