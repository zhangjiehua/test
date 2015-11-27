//
//  MainTabbarViewController.h
//  test
//
//  Created by 张闻闻 on 15/10/27.
//  Copyright © 2015年 张杰华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabbarViewController : UITabBarController

@property (strong, nonatomic) NSString *noticeName;

+ (instancetype)getInstance;

@end
