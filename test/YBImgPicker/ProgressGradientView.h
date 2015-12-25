//
//  ProgressGradientView.h
//  win7loading
//
//  Created by PowerAuras on 13-11-11.
//  Copyright (c) 2013年 PowerAuras. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@protocol ProgressGradientViewProtocol<NSObject>

-(void)endAnimation;

@end
@interface ProgressGradientView : UIView
{
    CAShapeLayer *mask;
    NSTimer *animationTimer;
    int animationTimerCount;
    CGFloat gradientLocations[3];
}
@property (nonatomic ,assign)id<ProgressGradientViewProtocol>endProtocol;
- (void)setProgress:(float)progress;
- (void)setProgress:(float)progress animated:(BOOL)animated;
@end
