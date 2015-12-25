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

@property (nonatomic,copy)    IBInspectable NSString *placeholder;
@property (nonatomic)  double IBInspectable fadeTime;
@property (nonatomic,copy)    NSAttributedString *attributedPlaceholder;
@property (nonatomic,retain)  UIColor *placeholderTextColor UI_APPEARANCE_SELECTOR;

@end
