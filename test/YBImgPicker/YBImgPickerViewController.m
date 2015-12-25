//
//  YBImgPickerViewController.m
//  settingsTest
//
//  Created by 宋奕兴 on 15/9/7.
//  Copyright (c) 2015年 宋奕兴. All rights reserved.
//
#define empty_width 1
#define maxnum_of_one_line 3
#define itemHeight ( CGRectGetWidth([UIScreen mainScreen].bounds) - (maxnum_of_one_line + 1) * empty_width ) / maxnum_of_one_line
#define item_Size CGSizeMake(itemHeight , itemHeight)
#define rightItemTitle [NSString stringWithFormat:@"已选图片(%ld/%ld)",(long)choosenCount,(long)photoCount - self.firstArr.count]
#define tableCellH 70
#define tableH MIN(CGRectGetWidth([UIScreen mainScreen].bounds) - 64, tableCellH * tableData.count);
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height

#import <AssetsLibrary/AssetsLibrary.h>
#import "YBImgPickerViewController.h"
#import "YBImgPickerViewCell.h"
#import "YBImgPickerTableViewCell.h"
#import <TuSDKGeeV1/TuSDKGeeV1.h>
#import "LoadingImageViewController.h"
//#import "TuSDKFramework.h"

const NSInteger photoCount = 20;
@interface YBImgPickerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TuSDKPFCameraDelegate> {
    NSMutableArray * tableData;
    NSMutableArray * colletionData;
    NSMutableArray * originImgData;
    NSMutableDictionary * choosenImgArray;
    NSMutableDictionary * isChoosenDic;
    NSInteger choosenCount;
    BOOL isShowTable;
}
@property (nonatomic , strong) IBOutlet UICollectionView * myCollectionView;
@property (nonatomic , strong) IBOutlet UITableView * myTableView;
@property (nonatomic , strong) IBOutlet UIView * backView;
@property (nonatomic , strong) UINavigationController *nav;
@property (nonatomic , strong) UIButton * titleBtn;
@property (nonatomic , strong) id <YBImgPickerViewControllerDelegate> delegate;
@property (nonatomic , strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic , strong) ALAssetsGroup * group;
@property (nonatomic,strong)UILabel *footLabel;

@property (nonatomic, assign) UIViewController *controller;

@end

@implementation YBImgPickerViewController
@synthesize myTableView,myCollectionView,backView,titleBtn;
@synthesize assetsLibrary,group;
@synthesize nav;
static NSString * const colletionReuseIdentifier = @"collectionCell";
static NSString * const tableReuseIdentifier = @"tableCell";
- (instancetype)init {
    self = [self initWithNibName:@"YBImgPickerViewController" bundle:nil];
     nav = [[UINavigationController alloc] initWithRootViewController:self];
    
    
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableData = [[NSMutableArray alloc]init];
    colletionData = [[NSMutableArray alloc]init];
    originImgData = [[NSMutableArray alloc]init];
    assetsLibrary = [[ALAssetsLibrary alloc]init];
    choosenImgArray = [[NSMutableDictionary alloc]init];
    isChoosenDic = [[NSMutableDictionary alloc]init];
    choosenCount = 0;
    
    [self initDefaultView];
    [self getTableDate];
//    [self performSelectorOnMainThread:@selector(getTableDate) withObject:nil waitUntilDone:NO];
    
    // Register cell classes
    [myCollectionView registerNib:[UINib nibWithNibName:@"YBImgPickerViewCell" bundle:nil] forCellWithReuseIdentifier:colletionReuseIdentifier];
    [myTableView registerNib:[UINib nibWithNibName:@"YBImgPickerTableViewCell" bundle:nil] forCellReuseIdentifier:tableReuseIdentifier];
    
    
}



- (void)initDefaultView {
    //naviegationBar
    self.view.frame = [UIScreen mainScreen].bounds;
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithRed:240./255 green:240./255 blue:240./255 alpha:1.0]];
    self.navigationItem.titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
     titleBtn = [[UIButton alloc]initWithFrame:self.navigationItem.titleView.frame];
    [titleBtn setTitle:@"相册名" forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"style_default_arrow_down"] forState:UIControlStateNormal];
 //   [titleBtn setTitleColor:self.navigationController.navigationBar.tintColor forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 73, 0, 0)];
    [titleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -35, 0, 0)];
    [titleBtn addTarget:self action:@selector(showTableView) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem.titleView addSubview:titleBtn];
    
    UIButton *cancleBtn = [self setButton:CGRectMake(0, 0, 50, 35) withFont:[UIFont fontWithName:@"San Francisco" size:15] withBackgroundColor:nil andTitle:@"取消" andTitleColor:[UIColor blackColor]];
    [cancleBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancleBtn];
    
    UIButton *finshBtn = [self setButton:CGRectMake(0, 0, 50, 35) withFont:[UIFont boldSystemFontOfSize:16] withBackgroundColor:nil andTitle:@"下一步" andTitleColor:[UIColor blackColor]];
    [finshBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:finshBtn];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    //tableView
    myTableView.rowHeight = tableCellH;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.hidden = YES;
    
    //collectionView
    UICollectionViewFlowLayout * mycollectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
    mycollectionViewLayout.minimumInteritemSpacing = empty_width;
    mycollectionViewLayout.minimumLineSpacing = empty_width ;
    mycollectionViewLayout.itemSize = item_Size;
    mycollectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    mycollectionViewLayout.sectionInset = UIEdgeInsetsMake(empty_width, empty_width , 0, empty_width);
    myCollectionView.collectionViewLayout = mycollectionViewLayout;
    myCollectionView.delegate = self;
    myCollectionView.dataSource = self;
    myCollectionView.backgroundColor = [UIColor whiteColor];
    //backView
    isShowTable = NO;
    backView.alpha = 0;
    UITapGestureRecognizer * backViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showTableView)];
    [backView addGestureRecognizer:backViewTap];
    
    //footView
    
    self.footLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeight - 27, kWidth, 27)];
    self.footLabel.text = rightItemTitle;
    _footLabel.textAlignment = NSTextAlignmentCenter;
    [_footLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [self.view addSubview:_footLabel];
}
- (void)setTableViewHeight {
    for(NSLayoutConstraint * constraint in myTableView.constraints){
        if (constraint.firstItem == myTableView && constraint.firstAttribute == NSLayoutAttributeHeight) {
            constraint.constant = tableH;
        }
    }
    for(NSLayoutConstraint * constraint in myTableView.superview.constraints){
        if (constraint.firstItem == myTableView && constraint.firstAttribute == NSLayoutAttributeTop) {
            constraint.constant = -tableH;
        }
    }
    [self.view layoutIfNeeded];
}
- (void)getTableDate {
    
    NSLog(@">>>>>>>");
    
    void (^assetsGroupsEnumerationBlock)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *assetsGroup, BOOL *stop) {
        if(assetsGroup) {
            [assetsGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
            NSMutableArray * isChoosenArray = [[NSMutableArray alloc]init];
            if(assetsGroup.numberOfAssets > 0) {
                [tableData addObject:assetsGroup];
                for (int i = 0; i< assetsGroup.numberOfAssets; i++) {
                    [isChoosenArray addObject:[NSNumber numberWithBool:NO]];
                }
               
                [isChoosenDic setObject:isChoosenArray forKey:[assetsGroup valueForProperty:ALAssetsGroupPropertyName]];
                
            }else if(assetsGroup.numberOfAssets == 0){
            
                [myTableView reloadData];
                [self getCollectionData:0];
                
                [myTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            
            }
        }
        
        [self setTableViewHeight];
        
       
    };
    
    
   
    
    void (^assetsGroupsFailureBlock)(NSError *) = ^(NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    };
    
    
    // Enumerate Camera Roll
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:assetsGroupsEnumerationBlock failureBlock:assetsGroupsFailureBlock];
    
    // Photo Stream
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupPhotoStream usingBlock:assetsGroupsEnumerationBlock failureBlock:assetsGroupsFailureBlock];
    
    // Album
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:assetsGroupsEnumerationBlock failureBlock:assetsGroupsFailureBlock];
    
    // Event
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupEvent usingBlock:assetsGroupsEnumerationBlock failureBlock:assetsGroupsFailureBlock];
    
    // Faces
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupFaces usingBlock:assetsGroupsEnumerationBlock failureBlock:assetsGroupsFailureBlock];

    
}
- (void)getCollectionData:(NSInteger)tag {
    if (colletionData.count) {
        [colletionData removeAllObjects];
    }
    if (originImgData.count) {
        [originImgData removeAllObjects];
    }
    
    
    [colletionData addObject:[UIImage imageNamed:@"相册_按钮_to相机页面"]];
    
    if (tableData.count) {
        group = [tableData objectAtIndex:tag];
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result) {
                NSString *type=[result valueForProperty:ALAssetPropertyType];
                if ([type isEqualToString:ALAssetTypePhoto]) {
                    [colletionData addObject:[UIImage imageWithCGImage:[result thumbnail]]];
                    [originImgData addObject:result];
                }
                [myCollectionView reloadData];
               
            }
        }];
    }
    
    NSLog(@"colloectionData  %lu",(unsigned long)colletionData.count);
}



#pragma mark UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSLog(@"%lu",(unsigned long)colletionData.count);
    return colletionData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YBImgPickerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:colletionReuseIdentifier forIndexPath:indexPath];
    cell.contentImg = [colletionData objectAtIndex:indexPath.item];
    NSArray * isChoosenArray = [isChoosenDic objectForKey:[group valueForProperty:ALAssetsGroupPropertyName]];
    if (indexPath.item != 0) {
        cell.isChoosenImgHidden = NO;
        cell.isChoosen = [[isChoosenArray objectAtIndex:indexPath.item - 1]boolValue];
    }else {
        cell.isChoosenImgHidden = YES;
    }
    // Configure the cell
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        if (choosenCount >= photoCount) {
            return;
        }
        
        
//        SimpleCameraComponent *simp = [[SimpleCameraComponent alloc]init];
//        [simp showSimpleWithController:self];
        
        [TuSDKTSDeviceSettings checkAllowWithController:self type:lsqDeviceSettingsCamera completed:^(lsqDeviceSettingsType type, BOOL openSetting) {
            
            if (openSetting) {
                lsqLError(@"无法打开相机");
                return;
            }
            [self showCameraController];
            
        }];
        
        
        
    }else {

        NSInteger  tag = indexPath.item - 1;
        
        NSMutableArray * isChoosenArray = [isChoosenDic objectForKey:[group valueForProperty:ALAssetsGroupPropertyName]];
        BOOL isChoosen = [[isChoosenArray objectAtIndex:tag]boolValue];
        ALAsset * asset = [originImgData objectAtIndex:tag];
        
        if (!isChoosen) {
            if (choosenCount >= photoCount) {
                return;
            }
            choosenCount += 1;
            [choosenImgArray setObject:asset forKey:indexPath];
        }else {
                choosenCount -= 1;
            [choosenImgArray removeObjectForKey:indexPath];
        }
        self.footLabel.text = rightItemTitle;
        if (choosenImgArray.count) {
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }else {
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }
        
        [isChoosenArray replaceObjectAtIndex:tag withObject:[NSNumber numberWithBool:!isChoosen]];
        [isChoosenDic setObject:isChoosenArray forKey:[group valueForProperty:ALAssetsGroupPropertyName]];
        
        [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        
    }
}

#pragma mark  - 相机
- (void)showCameraController;
{
    
    TuSDKPFCameraOptions *opt = [TuSDKPFCameraOptions build];
    /* 这里是option配置功能选项，配置相机的功能 */
    opt.componentClazz = [ExtendCameraBaseController class]; //控制器
//    opt.viewClazz = [ExtendCameraBaseView class];
    opt.enableFilters = YES;
  //  opt.showFilterDefault = YES;
    opt.saveToAlbum = NO;
    opt.saveToTemp = NO;
    
    TuSDKPFCameraViewController *controller = opt.viewController;
    controller.delegate = self;
    [self presentModalNavigationController:controller animated:YES];
    
}

- (void)onTuSDKPFCamera:(TuSDKPFCameraViewController *)controller captureResult:(TuSDKResult *)result;
{
    NSLog(@"相片  %@",result.image);
    
    [controller dismissModalViewControllerAnimated];
}

- (void)onComponent:(TuSDKCPViewController *)controller result:(TuSDKResult *)result error:(NSError *)error;
{
    
}



#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@" tableview 的数量 %lu",(unsigned long)tableData.count);
    return tableData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YBImgPickerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:tableReuseIdentifier forIndexPath:indexPath];
    ALAssetsGroup * assetsGroup = [tableData objectAtIndex:indexPath.row];
    cell.albumTitle = [NSString stringWithFormat:@"%@", [assetsGroup valueForProperty:ALAssetsGroupPropertyName]];
    cell.photoNum = assetsGroup.numberOfAssets;
    cell.albumImg = [UIImage imageWithCGImage:assetsGroup.posterImage];
    cell.backgroundColor = tableView.backgroundColor;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self getCollectionData:indexPath.row];
    [self showTableView];
    
}
//#pragma mark imagePicker 
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    UIImage * image = [[UIImage alloc]init];
//    image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    if (image) {
//        
//        // 保存图片到相册中
//        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
//        {
//            UIImageWriteToSavedPhotosAlbum(image,self,nil, NULL);
//            [choosenImgArray setObject:image forKey:@"camare"];
//        }
//        
//        [picker dismissViewControllerAnimated:NO completion:^() {
//            [self save];
//        }];
//        
//    }
//}

#pragma mark self
- (void)showInViewContrller:(UIViewController *)vc choosenNum:(NSInteger)choosenNum delegate:(id<YBImgPickerViewControllerDelegate>)vcdelegate{
    
    self.delegate = vcdelegate;
    choosenCount = choosenNum;
    
    [vc presentViewController:nav animated:YES completion:nil];
    
}
- (void)hide{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)save {
//    [self dismissViewControllerAnimated:YES completion:^{
//        NSMutableArray * resuletData = [NSMutableArray arrayWithArray:[choosenImgArray allValues]];
//        for (int i = 0; i<resuletData.count; i++) {
//            ALAsset * asset = [resuletData objectAtIndex:i];
//            if ([asset isKindOfClass:[ALAsset class]]) {
//                UIImage * image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
//                [resuletData replaceObjectAtIndex:i withObject:image];
//            }
//        }
//        if ([self.delegate respondsToSelector:@selector(YBImagePickerDidFinishWithImages:)]) {
//            [self.delegate YBImagePickerDidFinishWithImages:resuletData];
//        }
//    }];
    
    
    NSMutableArray *resuletData = [NSMutableArray arrayWithArray:[choosenImgArray allValues]];

    
    for (int i = 0; i<resuletData.count; i++) {
        ALAsset * asset = [resuletData objectAtIndex:i];
        if ([asset isKindOfClass:[ALAsset class]]) {
            UIImage * image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
            [resuletData replaceObjectAtIndex:i withObject:image];
        }
    }
    
    NSLog(@"相片1》》》》》%@",resuletData);
    if (self.isAdd) {
        
        [resuletData addObjectsFromArray:self.firstArr];
    }
    
    NSLog(@"相片2》》》》%@",resuletData);
    
  //  DPViewController *nextViewController = [[DPViewController alloc] init];
//    MoveViewController *nextViewController = [[MoveViewController alloc] init];
//    nextViewController.dataArray = [NSMutableArray arrayWithArray:resuletData];
//    [self.navigationController pushViewController:nextViewController animated:YES];
    
    LoadingImageViewController *load = [[LoadingImageViewController alloc] init];
    load.imageArr = [NSMutableArray arrayWithArray:resuletData];
    [self presentModalNavigationController:load animated:YES];
    
   

}
- (void)showTableView {
    myTableView.hidden = NO;
    backView.userInteractionEnabled = YES;
    if (isShowTable) {
        [UIView animateWithDuration:0.1 animations:^{
            for(NSLayoutConstraint * constraint in myTableView.superview.constraints){
                if (constraint.firstItem == myTableView && constraint.firstAttribute == NSLayoutAttributeTop) {
                    constraint.constant += 5;
                }
            }
            backView.alpha = 0;
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            titleBtn.imageView.transform = CGAffineTransformMakeRotation(0);
            [UIView animateWithDuration:0.1 animations:^{
                for(NSLayoutConstraint * constraint in myTableView.superview.constraints){
                    if (constraint.firstItem == myTableView && constraint.firstAttribute == NSLayoutAttributeTop) {
                        constraint.constant = -tableH;
                    }
                }
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                backView.userInteractionEnabled = NO;
                isShowTable = !isShowTable;
            }];
        }];
    }else {
        [UIView animateWithDuration:0.1 animations:^{
            for(NSLayoutConstraint * constraint in myTableView.superview.constraints){
                if (constraint.firstItem == myTableView && constraint.firstAttribute == NSLayoutAttributeTop) {
                    constraint.constant = 64 + 5;
                }
            }
            backView.alpha = 1;
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            titleBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
            [UIView animateWithDuration:0.1 animations:^{
                for(NSLayoutConstraint * constraint in myTableView.superview.constraints){
                    if (constraint.firstItem == myTableView && constraint.firstAttribute == NSLayoutAttributeTop) {
                        constraint.constant = 64;
                    }
                }
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                backView.userInteractionEnabled = YES;
                isShowTable = !isShowTable;
            }];
        }];
    }
}


#pragma mark - 重构

-(UIButton *)setButton:(CGRect)frame withFont:(UIFont *)font withBackgroundColor:(UIColor *)color andTitle:(NSString *)title andTitleColor:(UIColor *)titleColor
{
    UIButton *button = [[UIButton alloc] init];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    button.backgroundColor = color;
    return button;
}




- (void)dealloc {
    tableData = nil;
    colletionData = nil;
    originImgData = nil;
    choosenImgArray = nil;
    isChoosenDic = nil;
    
    myCollectionView = nil;
    myTableView = nil;
    backView = nil;
    nav = nil;
    titleBtn = nil;
    _delegate = nil;
    assetsLibrary = nil;
    group = nil;
}



@end

#pragma mark - ExtendCameraBaseController
/**
 *  基础相机组件范例 - 相机视图控制器
 */
@interface ExtendCameraBaseController()
@end

@implementation ExtendCameraBaseController
- (void)configDefaultStyleView:(TuSDKPFCameraView *)view;
{
    if (!view) return;
    [super configDefaultStyleView:view];
    
    UIButton *imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 8, 60, 60)];
    
    [imageBtn setImage:[UIImage imageNamed:@"相机_图标_相册"] forState:UIControlStateNormal];
    // 关闭摄像头按钮
    [imageBtn addTouchUpInsideTarget:self action:@selector(cancelAction)];
    [view.bottomBar addSubview:imageBtn];
}


@end

