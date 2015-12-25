//
//  UHAText.m
//  test
//
//  Created by 看看 on 15/11/30.
//  Copyright © 2015年 张杰华. All rights reserved.
//

#import "UHATextEntity.h"

@implementation UHATextEntity

- (instancetype)copyWithZone:(NSZone *)zone
{
    UHATextEntity *entity = [UHATextEntity copy];
    entity.text = [self.text copy];
    return entity;
}

@end
