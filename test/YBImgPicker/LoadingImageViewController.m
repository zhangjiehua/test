

//
//  LoadingImageViewController.m
//  惠生活
//
//  Created by huihui on 15/11/17.
//  Copyright © 2015年 huihui. All rights reserved.
//

#import "LoadingImageViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ProgressGradientView.h"

#define RATIO kwidth / 320
#define UIColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define buttonUI(frame)    [[UIButton alloc] initWithFrame:(frame)]
#define kwidth  [[UIScreen mainScreen] applicationFrame].size.width
#define Kheight  [[UIScreen mainScreen] applicationFrame].size.height
#define kUIViewBackgroundColor(VIEW,COLOR)        VIEW.backgroundColor = [UIColor COLOR];
#define kFont(font)      [UIFont systemFontOfSize:(font)]
#define kNORMAL           UIControlStateNormal
#define kTouchUp          UIControlEventTouchUpInside
#define viewUI(frame)       [[UIView alloc] initWithFrame:(frame)]
#define labelUI(frame)      [[UILabel alloc] initWithFrame:(frame)]
@interface LoadingImageViewController ()<ProgressGradientViewProtocol>{
    ProgressGradientView *pgv;
    CGFloat progress;
    
}
@property (nonatomic ,strong)UIButton *dismiss;//取消按钮
@property (nonatomic ,strong)UIView *loadingLines;
@property (nonatomic ,strong)UILabel *tilteLable;
@property (nonatomic ,strong)UIView *coverView;
@property (nonatomic ,strong)NSTimer *time;
@property (nonatomic) int num;
@property (nonatomic) float count;
@end

@implementation LoadingImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorRGBA(242.0, 242.0, 242.0, 1);
    
    pgv=[[ProgressGradientView alloc] initWithFrame:CGRectMake(20,336 * RATIO,kwidth-40,4)];
    [self.view addSubview:pgv];
    pgv.endProtocol = self;
    /**
     *动画运行的时间为固定
     *时间改变 ，判断协议的参数也要发生改变不要忘记更改
     *
     *******/
    self.count = (float)self.imageArr.count;
    
    self.time =  [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(animationTimerFired:) userInfo:nil repeats:YES];
   
    [self.view addSubview:self.dismiss];
    [self.view addSubview:self.tilteLable];
}
-(void)endAnimation{
    
    self.time.fireDate = [NSDate distantFuture];
    NSLog(@"zou le ");

}
- (void)animationTimerFired:(NSTimer*)theTimer {
    
    if (self.imageArr.count == 1 || self.imageArr.count == 2) {
        
        self.tilteLable.text = [NSString stringWithFormat:@"正在导入图片 (%lu/%lu)",(unsigned long)self.imageArr.count,(unsigned long)self.imageArr.count];
        [pgv setProgress:progress];
    }else{
    
        int re=rand()% self.imageArr.count;
        if (re== 2) {
            
            int y = ++self.num;
            
             self.tilteLable.text = [NSString stringWithFormat:@"正在导入图片 (%lu/%lu)",(unsigned long)y,(unsigned long)self.imageArr.count];
          
            progress+= 2.00/self.count;
            
            [pgv setProgress:progress];
            
        }
    
    }

}

-(UIButton *)dismiss{
    if (_dismiss == nil) {
        _dismiss = buttonUI(CGRectMake((kwidth-42)/2, Kheight-42- 41*RATIO, 42, 42));
        [_dismiss setTitle:@"取消" forState:kNORMAL];
        [_dismiss setTitleColor:[UIColor blackColor] forState:kNORMAL];
        _dismiss.titleLabel.font = kFont(15);
        [_dismiss addTarget:self action:@selector(next) forControlEvents:kTouchUp];
    }
    return _dismiss;
}
- (UILabel *)tilteLable{
    if (_tilteLable == nil) {
        _tilteLable = labelUI(CGRectMake((kwidth-175)/2, 276 * RATIO, 175, 42));
        _tilteLable.textAlignment = NSTextAlignmentCenter;
        _tilteLable.text = @"正在导入图片(n/N)";
        _tilteLable.font = [UIFont fontWithName:@"STHeitiJ-Medium" size:17];
    }
    return _tilteLable;
}
-(void)next{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
