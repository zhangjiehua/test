//
//  BaseViewController.m
//  test
//
//  Created by 张看看 on 15/10/20.
//  Copyright © 2015年 张杰华. All rights reserved.
//

#import "BaseViewController.h"



@interface BaseViewController ()

@end

@implementation BaseViewController

+ (instancetype)getInstance
{
    return [self.class new];
}

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc
{
    
    
}

- (void)initResource
{
    
}

- (void)initBackgroundImageView
{
    /*
     NSString *imageName = @"Common_Background4";
     if (iPhone5) {
     imageName = @"Common_Background5";
     } else if (iPhone6) {
     imageName = @"Common_Background6";
     } else if (iPhone6Plus) {
     imageName = @"Common_Background6p";
     }
     
     UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
     CGRect frame = self.view.frame;
     frame.origin = CGPointZero;
     //    frame.size.height -= frame.origin.y;
     imageView.frame = frame;
     
     [self.view insertSubview:imageView atIndex:0];
     */
    
    self.view.backgroundColor = RGBCOLOR(247, 247, 247);
}

- (void)changeLanguage
{
    if (self.titleInfo && self.titleInfo.length > 0) {
//        self.title = LOCALIZE(self.titleInfo);
    }
}



#pragma mark - Action
- (void)respondsToBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"此刻屏幕的宽度是%f",  [[[UIApplication sharedApplication] delegate]window].bounds.size.width);
}

#pragma mark --DebugLog
- (void)debugLogRect:(CGRect)rect
{
    NSLog(@"\n**********\n {%f,%f},{%f,%f} \n**********",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
}


@end
