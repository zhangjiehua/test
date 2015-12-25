//
//  DynamicChangeNavigationBarColorViewController.m
//  test
//
//  Created by 看看 on 15/12/22.
//  Copyright © 2015年 张杰华. All rights reserved.
//

#import "DynamicChangeNavigationBarColorViewController.h"
#import "UINavigationBar+Edward.h"

#define NAVBAR_CHANGE_POINT 60

@interface DynamicChangeNavigationBarColorViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DynamicChangeNavigationBarColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = ({
        UITableView *tv = [UITableView new];
        tv.delegate = self;
        tv.dataSource = self;
        tv.frame = CGRectMake(0, 0, UI_Screen_Width_Normal, UI_Screen_Height_Normal);
        [tv registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        tv;
    });
    
    _tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_Screen_Width_Normal, 190)];
//        view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
        UIImageView *imageView = [UIImageView new];
        imageView.frame= CGRectMake(0, -64, UI_Screen_Width_Normal, 254);
        imageView.image = [UIImage imageNamed:@"bg.jpg"];
        [view addSubview:imageView];
        view;
        
    });
    _tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:_tableView];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                             forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT+64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _tableView.delegate = self;
    [self scrollViewDidScroll:_tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _tableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 4;
    }
    else if (section == 1) {
        return 3;
    }
    else {
        return 3;
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"header";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"text";
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
