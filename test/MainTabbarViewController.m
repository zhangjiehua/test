//
//  MainTabbarViewController.m
//  test
//
//  Created by 张闻闻 on 15/10/27.
//  Copyright © 2015年 张杰华. All rights reserved.
//

#import "MainTabbarViewController.h"

@interface MainTabbarViewController ()

@end

@implementation MainTabbarViewController

+ (instancetype)getInstance
{
    return [self.class new];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (IOS7)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    if (self.noticeName) {
      
        NSNOTIFICATION_ACCEPT_NOTICE_SEL(self.noticeName, @selector(setIndex:));
    }
    
    
    [self setTabBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSNOTIFICATION_REMOVE_SELF_NOTICE;
}

#pragma mark - Addition
- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated {
    for (UIView *view in [self.view subviews]) {
        if ([view isKindOfClass:[UITabBar class]]) {
            //            v.hidden = YES;
            //            CGRect frame = v.frame;
            //            frame.origin.y += 49.0f;
            //            v.frame = frame;
            
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, UI_Screen_Height_Normal, view.frame.size.width, view.frame.size.height)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, UI_Screen_Height_Normal - 49, view.frame.size.width, view.frame.size.height)];
            }
            
        } else {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, UI_Screen_Height_Normal)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, UI_Screen_Height_Normal - 49)];
            }
        }
    }
    
}

#pragma mark - Tabbar Delegate

- (void)setIndex:(NSNotification *)sender
{
    [self setSelectedIndex:[sender.object intValue]];
}

@end
