//
//  YBImgPickerViewController.h
//  settingsTest
//
//  Created by 宋奕兴 on 15/9/7.
//  Copyright (c) 2015年 宋奕兴. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <TuSDKFramework.h>
#import <TuSDKGeeV1/TuSDKGeeV1.h>
@protocol YBImgPickerViewControllerDelegate <NSObject>

@optional
- (void)YBImagePickerDidFinishWithImages:(NSArray *)imageArray;

@end

@interface YBImgPickerViewController : UIViewController

@property(nonatomic,strong)NSMutableArray *firstArr;
@property(nonatomic) BOOL isAdd;

- (void)showInViewContrller:(UIViewController *)vc choosenNum:(NSInteger)choosenNum delegate:(id<YBImgPickerViewControllerDelegate>)vcdelegate;

@end


#pragma mark - ExtendCameraBaseController
/**
 *  基础相机组件范例 - 相机视图控制器
 */
@interface ExtendCameraBaseController : TuSDKPFCameraViewController

@end


#pragma mark - ExtendCameraBaseView
/**
 *  基础相机组件范例视图自定义
 */
@interface ExtendCameraBaseView : TuSDKPFCameraView

@end

