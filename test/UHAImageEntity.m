//
//  UHAImage.m
//  test
//
//  Created by 看看 on 15/11/30.
//  Copyright © 2015年 张杰华. All rights reserved.
//

#import "UHAImageEntity.h"

@implementation UHAImageEntity

- (instancetype)copyWithZone:(NSZone *)zone
{
    UHAImageEntity *entity = [UHAImageEntity new];
    entity.imageName = [self.imageName copy];
    return entity;
}

@end
