//
//  BaseViewController.h
//  test
//
//  Created by 张看看 on 15/10/20.
//  Copyright © 2015年 张杰华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAHttpManager.h"
#import "MBProgressHUD.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NSString *titleInfo;

+ (instancetype)getInstance;

- (void)initResource;
- (void)initBackgroundImageView;

- (void)changeLanguage;

- (void)keyBoardAppearOrDisappear:(CGRect)keyboardFrame andDuration:(NSTimeInterval)duration and:(UIViewAnimationOptions)options andNotification:(NSNotification *)notify;

- (void)hideKeyboard:(id)sender;
- (void)respondsToBack:(id)sender;



- (void)debugLogRect:(CGRect)rect;


@end
