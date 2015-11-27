//
//  ViewController.m
//  test
//
//  Created by 张 on 15/10/8.
//  Copyright (c) 2015年 张杰华. All rights reserved.
//

#import "ViewController.h"
#import "UHACollectionView.h"
#import "UHATableView.h"

@interface ViewController ()

@property (nonatomic, strong) UHACollectionView *collectionView;
@property (nonatomic, strong) UHATableView      *tableView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = UIColor.clearColor;
    self.navigationController.navigationBar.barTintColor = UIColor.blueColor;

    [self configTableView];
}

- (void)configTableView {
    self.tableView = [[UHATableView alloc]initWithFrame:CGRectMake(0, 0, UI_Screen_Width_Normal, UI_Screen_Height_Normal)];
    self.tableView.cellData = [NSMutableArray arrayWithArray:@[ @"Existing text", @""]];
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
//    [self.tableView setEditing:YES animated:YES];
}

- (void)configCollectionView {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UHACollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
