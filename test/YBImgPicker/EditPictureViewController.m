////
////  EditPictureViewController.m
////  UHA
////
////  Created by chengqianqian on 15/11/30.
////  Copyright © 2015年 chengqianqian. All rights reserved.
////
//
//#import "EditPictureViewController.h"
//#import "UIView+Frame.h"
//#import "StickerCollectionView.h"
//#import "TextView.h"
//#import "ZDStickerView.h"
//
//#define kWidth self.view.frame.size.width
//#define kHeight self.view.frame.size.height
//#define kBtnWidth 50
//
//
//@interface EditPictureViewController ()
//
//@property (nonatomic,strong)UIScrollView *scrollView;
//@property (nonatomic,strong)UIButton *cropBtn;
//@property (nonatomic,strong)UIButton *filterBtn;
//@property (nonatomic,strong)UIButton *stickerBtn;
//@property (nonatomic,strong)UIButton *textBtn;
//@property (nonatomic)BOOL state;
//@property (nonatomic)BOOL filterState;
//@property (nonatomic)BOOL stickerState;
//@property (nonatomic)BOOL textState;
//@property (nonatomic,strong)StickerCollectionView *stickerCV;
//@property (nonatomic,strong)UIView *textView;
//@property (nonatomic)TextView *wordView;
//@property (nonatomic,strong)ZDStickerView *zdStickerView;
//@property (nonatomic,strong)UITextField *textfield;
//
//
//
//@end
//
//@implementation EditPictureViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//  
//    [self initView];
//    
//    //显示贴纸详情
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(StickerDetail:) name:@"StickerDetail" object:nil];
//    //编辑页面消失
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissTextVIew:) name:@"finshWordEdit" object:nil];
//    
//    
//    
//}
//
//#pragma mark - view
//
//-(void)initView
//{
//    self.view.backgroundColor = [UIColor whiteColor];
//    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithRed:240./255 green:240./255 blue:240./255 alpha:1.0]];
//    self.title = @"图片编辑";
//    
//    UIButton *backBtn = [self setButton:CGRectMake(0, 8, 35, 30) withFont:[UIFont systemFontOfSize:16] withBackgroundColor:nil andTitle:@"返回" andTitleColor:[UIColor blackColor]];
//    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    
//    UIButton *sureBtn = [self setButton:CGRectMake(0, 8, 35, 30) withFont:[UIFont systemFontOfSize:16] withBackgroundColor:nil andTitle:@"确定" andTitleColor:[UIColor blackColor]];
//    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchDown];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sureBtn];
//    
//    
//    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, kWidth, kWidth)];
//    self.imageView.image = [UIImage imageNamed:@""];
//    self.imageView.backgroundColor = [UIColor cyanColor];
//    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.view addSubview:self.imageView];
//    
//
//    self.scrollView = [[UIScrollView alloc] init];
//    self.scrollView.frame = CGRectMake(0, kHeight - 60, kWidth, 60);
//    self.scrollView.scrollEnabled = YES;
// //   self.scrollView.contentSize = CGSizeMake(kWidth * 2, 60);
//    self.scrollView.backgroundColor = [UIColor grayColor];
//    self.scrollView.showsHorizontalScrollIndicator = NO;
//    self.scrollView.showsVerticalScrollIndicator = NO;
//    
//    
//    
//    self.cropBtn = [self setButton:CGRectMake(24, 8, kBtnWidth, 30) withFont:nil withBackgroundColor:nil andTitle:nil andTitleColor:nil];
//    self.cropBtn.tag = 101;
//    [self.cropBtn addTarget:self action:@selector(showDetailView:) forControlEvents:UIControlEventTouchDown];
//    
//    self.filterBtn = [self setButton:CGRectMake(self.cropBtn.right + 24, self.cropBtn.y, kBtnWidth, 30) withFont:nil withBackgroundColor:nil andTitle:nil andTitleColor:nil];
//    self.filterBtn.tag = 102;
//    [self.filterBtn addTarget:self action:@selector(showDetailView:) forControlEvents:UIControlEventTouchDown];
//    
//    self.stickerBtn = [self setButton:CGRectMake(self.filterBtn.right + 24, self.cropBtn.y, kBtnWidth, 30) withFont:nil withBackgroundColor:nil andTitle:nil andTitleColor:nil];
//    self.stickerBtn.tag = 103;
//    [self.stickerBtn addTarget:self action:@selector(showDetailView:) forControlEvents:UIControlEventTouchDown];
//    
//    self.textBtn = [self setButton:CGRectMake(self.stickerBtn.right + 24, self.cropBtn.y, kBtnWidth, 30) withFont:nil withBackgroundColor:nil andTitle:nil andTitleColor:nil];
//    self.textBtn.tag = 104;
//    [self.textBtn addTarget:self action:@selector(showDetailView:) forControlEvents:UIControlEventTouchDown];
//    
//    [self changeState];
//    
//    [self.scrollView addSubview:self.cropBtn];
//    [self.scrollView addSubview:self.filterBtn];
//    [self.scrollView addSubview:self.stickerBtn];
//    [self.scrollView addSubview:self.textBtn];
//    [self.view addSubview:self.scrollView];
//    
//}
//
//-(void)changeState
//{
//    if (!self.state) {
//        [self.cropBtn setImage:[UIImage imageNamed:@"单图编辑_按钮_裁剪_未选中"] forState:UIControlStateNormal];
//    }else {
//        [self.cropBtn setImage:[UIImage imageNamed:@"单图编辑_按钮_裁剪_选中"] forState:UIControlStateNormal];
//    }
//
//    if (!self.filterState) {
//        [self.filterBtn setImage:[UIImage imageNamed:@"单图编辑_按钮_滤镜_未选中"] forState:UIControlStateNormal];
//    }else {
//        [self.filterBtn setImage:[UIImage imageNamed:@"单图编辑_按钮_滤镜_选中"] forState:UIControlStateNormal];
//    }
//
//    if (!self.stickerState) {
//        [self.stickerBtn setImage:[UIImage imageNamed:@"单图编辑_按钮_贴纸_未选中"] forState:UIControlStateNormal];
//    }else {
//        [self.stickerBtn setImage:[UIImage imageNamed:@"单图编辑_按钮_贴纸_选中"] forState:UIControlStateNormal];
//    }
//
//    if (!self.textState) {
//        [self.textBtn setImage:[UIImage imageNamed:@"单图编辑_按钮_文字_未选中"] forState:UIControlStateNormal];
//    }else {
//        [self.textBtn setImage:[UIImage imageNamed:@"单图编辑_按钮_文字_选中"] forState:UIControlStateNormal];
//    }
//
//
//}
//
//#pragma mark - 返回
//
//-(void)back
//{
//
//}
//
//#pragma mark - 确定
//-(void)sure
//{
//
//}
//
//-(UIButton *)setButton:(CGRect)frame withFont:(UIFont *)font withBackgroundColor:(UIColor *)color andTitle:(NSString *)title andTitleColor:(UIColor *)titleColor
//{
//    UIButton *button = [[UIButton alloc] init];
//    button.frame = frame;
//    [button setTitle:title forState:UIControlStateNormal];
//    [button setTitleColor:titleColor forState:UIControlStateNormal];
//    button.titleLabel.font = font;
//    button.backgroundColor = color;
//    return button;
//}
//
//-(UILabel *)setLabel:(CGRect)frame withTitle:(NSString *)title titleColor:(UIColor *)titleColor andFont:(UIFont *)font
//{
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = frame;
//    label.text = title;
//    label.textColor = titleColor;
//    label.font = font;
//    return label;
//}
//
//#pragma mark - showDetailView
//
//-(void)showDetailView:(UIButton *)button
//{
//    switch (button.tag) {
//        case 101:{
//        
//            self.state = YES;
//            self.filterState = NO;
//            self.stickerState = NO;
//            self.textState = NO;
//            [self changeState];
//            [self.stickerCV removeFromSuperview];
//            [self.textView removeFromSuperview];
//            
//        }
//            
//            break;
//        case 102:{
//        
//            self.state = NO;
//            self.filterState = YES;
//            self.stickerState = NO;
//            self.textState = NO;
//            [self changeState];
//            [self.stickerCV removeFromSuperview];
//            [self.textView removeFromSuperview];
//        }
//            break;
//        case 103:{
//        
//            self.state = NO;
//            self.filterState = NO;
//            self.stickerState = YES;
//            self.textState = NO;
//            [self changeState];
//            [self collViewControll];
//            [self.textView removeFromSuperview];
//        
//        }
//            break;
//        case 104:{
//           
//            self.state = NO;
//            self.filterState = NO;
//            self.stickerState = NO;
//            self.textState = YES;
//            [self changeState];
//            [self.stickerCV removeFromSuperview];
//            [self showText];
//            
//        
//        }
//            break;
//            
//        default:
//            break;
//    }
//    
//
//}
//
//#pragma mark - 加载贴纸
//
//-(void)collViewControll
//{
//    UICollectionViewFlowLayout * collectionVL = [[UICollectionViewFlowLayout alloc] init];
//    collectionVL.itemSize = CGSizeMake(75,160);
//    collectionVL.sectionInset = UIEdgeInsetsMake(20, 5,  0, 0);
//    collectionVL.minimumLineSpacing = 3;
//    collectionVL.minimumInteritemSpacing = 3;
//    
//    collectionVL.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    self.stickerCV = [[StickerCollectionView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 205 , self.view.frame.size.width, 130) collectionViewLayout:collectionVL];
//    
//    self.stickerCV.backgroundColor = [UIColor yellowColor];
//    self.stickerCV.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
//    self.stickerCV.showsHorizontalScrollIndicator = NO;
//    
//    [self.view addSubview:self.stickerCV];
//    
//}
//
//#pragma mark - 贴纸详情
//
//-(void)StickerDetail:(id)sender
//{
//    
//
//}
//
//#pragma mark - 文字
//
//-(void)showText
//{
//    self.textView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 205, kWidth, 130)];
//    self.textView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
//    [self.view addSubview:self.textView];
//    
//    UIButton *textBtn = [self setButton:CGRectMake(50, 8, 80, 80) withFont:nil withBackgroundColor:nil andTitle:nil andTitleColor:nil];
//    [textBtn setImage:[UIImage imageNamed:@"单图编辑文字_按钮_新建文字"] forState:UIControlStateNormal];
//    [textBtn addTarget:self action:@selector(addText:) forControlEvents:UIControlEventTouchDown];
//    
//    UIButton *templateBtn = [self setButton:CGRectMake(textBtn.right + 60, textBtn.y, textBtn.width, textBtn.height) withFont:nil withBackgroundColor:nil andTitle:nil andTitleColor:nil];
//    [templateBtn setImage:[UIImage imageNamed:@"单图编辑文字_按钮_模板"] forState:UIControlStateNormal];
//    [templateBtn addTarget:self action:@selector(choseTemplate:) forControlEvents:UIControlEventTouchDown];
//    
//    UILabel *textLabel = [self setLabel:CGRectMake(textBtn.x, textBtn.bottom, textBtn.width, 30) withTitle:@"新建文字" titleColor:[UIColor blackColor] andFont:[UIFont systemFontOfSize:14]];
//    textLabel.textAlignment = NSTextAlignmentCenter;
//    [self.textView addSubview:textLabel];
//    
//    UILabel *templateLabel = [self setLabel:CGRectMake(templateBtn.x, templateBtn.bottom, templateBtn.width, 30) withTitle:@"模版" titleColor:[UIColor blackColor] andFont:[UIFont systemFontOfSize:14]];
//    templateLabel.textAlignment = NSTextAlignmentCenter;
//    [self.textView addSubview:templateLabel];
//    
//    [self.textView addSubview:textBtn];
//    [self.textView addSubview:templateBtn];
//}
//
////编辑文字
//-(void)addText:(UIButton *)button
//{
//    self.wordView = [[TextView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
//    [self.view addSubview:self.wordView];
//    
//   
//
//}
//
////选文字模版
//-(void)choseTemplate:(UIButton *)button
//{
//    
//
//}
//
//#pragma mark - 文字编辑页面结束
//-(void)dismissTextVIew:(NSNotification *)notify
//{
//    self.wordView.hidden = YES;
//    [self.wordView.textFiled resignFirstResponder];
//    
//    
//    self.textfield = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, 150, 150)];
//    self.textfield.text = notify.object;
//    self.zdStickerView = [[ZDStickerView alloc] initWithFrame:CGRectMake(50, 50, 150, 150)];
//    self.zdStickerView.contentView = self.textfield;
//    self.zdStickerView.preventsPositionOutsideSuperview = NO;
//    [self.zdStickerView showEditingHandles];
//    
//    [self.imageView addSubview:self.zdStickerView];
//    
//    
//}
//
//
//@end
