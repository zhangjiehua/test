//
//  SZTextView.h
//  test
//
//  Created by 看看 on 15/11/24.
//  Copyright © 2015年 张杰华. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface SZTextView : UITextView

@property (copy, nonatomic) IBInspectable NSString *placeholder;
@property (nonatomic)  double IBInspectable fadeTime;
@property (copy, nonatomic) NSAttributedString *attributedPlaceholder;
@property (retain, nonatomic) UIColor *placeholderTextColor UI_APPEARANCE_SELECTOR;

@end
