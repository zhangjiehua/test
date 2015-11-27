//
//  NavigationController.m
//  test
//
//  Created by 张看看 on 15/10/20.
//  Copyright © 2015年 张杰华. All rights reserved.
//

#import "NavigationController.h"



@interface NavigationController ()

@end

@implementation NavigationController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:20], NSFontAttributeName, nil];
    self.navigationBar.titleTextAttributes = dict;
    
    NSArray *list = self.navigationBar.subviews;
    for (id obj in list) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)obj;
            imageView.hidden=YES;
        }
    }
    
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationBar.translucent = NO;
    self.navigationBar.layer.borderWidth = 0;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.navigationBar.frame), 20)];
    [self.navigationBar insertSubview:view atIndex:0];
    
    UIImageView *imageView = [self imageLineViewWithImageSize:CGSizeMake(UI_Screen_Width_Normal, 44) andColor:RGBCOLOR(29, 178, 255)];//RGBCOLOR(18, 110, 193)
    imageView.frame = CGRectMake(0, -20, CGRectGetWidth(self.navigationBar.frame), CGRectGetHeight(imageView.frame) + 20);
    [self.navigationBar insertSubview:imageView atIndex:1];
    
    //    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.navigationBar.frame), 20)];
    //    view2.backgroundColor = RGBACOLOR(255, 255, 255, 0.3);
    //    [self.navigationBar insertSubview:view2 atIndex:2];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - drawline
- (UIImage *)drawLineWithSize:(CGSize)size andColor:(UIColor *)color;
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImageView *)imageLineViewWithImageSize:(CGSize)size andColor:(UIColor *)color
{
    return [[UIImageView alloc] initWithImage:[self drawLineWithSize:size andColor:color]];
}

@end
