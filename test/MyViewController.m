//
//  MyViewController.m
//  test
//
//  Created by 看看 on 15/11/19.
//  Copyright © 2015年 张杰华. All rights reserved.
//

#import "MyViewController.h"
#import "UHAImageTableViewCell.h"
#import "ACEExpandableTextCell.h"
#import "UHABottomView.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate,ACEExpandableTableViewDelegate> {
    CGFloat *_cellHeight;
}

@property (nonatomic,strong) NSMutableArray   *addPhotosArray;
@property (nonatomic,strong) NSMutableArray   *dataSourceArray;
@property (nonatomic,strong) UITableView      *tableView;


@property (nonatomic, strong) NSMutableArray  *array;
//@property (nonatomic, strong) NSMutableArray  *cellHeight;

@end


static NSString *const reuseImageCellIdentifier = @"UHAImageTableViewCell";
static NSString *const reuseTextCellIdentififer = @"UHATextCell";

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    // Do any additional setup after loading the view.
    [self initNavigationItems];
    [self initTableView];
    
    UHABottomView *bottomView = [[UHABottomView alloc]initWithFrame:CGRectMake(0, UI_Screen_Height_Normal-40, UI_Screen_Width_Normal, 40)];
    [self.view addSubview:bottomView];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.tableView addGestureRecognizer:longPress];
    
    self.array = [[NSMutableArray alloc]initWithObjects:@(UI_Screen_Width_Normal),@(UI_Screen_Width_Normal),@(50),@(UI_Screen_Width_Normal),@(50),@(UI_Screen_Width_Normal), nil];
    self.cellData = [NSMutableArray arrayWithArray:@[ @"0", @"1", @"2", @"3", @"4", @"5"]];
    _cellHeight = (CGFloat*)malloc(self.cellData.count);
//    self.cellHeight = [[NSMutableArray alloc]initWithCapacity:self.array.count];
//     _cellHeight[[self.array count]];
}

- (void)dealloc {
    free(_cellHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - InitNavigationItem
- (void)initNavigationItems {

    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelAction)];
    UIBarButtonItem *negativeLeftSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeLeftSpacer.width = 0;
    self.navigationItem.leftBarButtonItems = [[NSArray alloc] initWithObjects:negativeLeftSpacer,cancelBarButtonItem, nil];
    
    UIBarButtonItem *nextBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStyleBordered target:self action:@selector(nextAction)];
    UIBarButtonItem *negativeRightSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace  target:self action:nil];
    negativeRightSpacer.width = 0;
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:negativeRightSpacer, nextBarButtonItem, nil];
}

#pragma mark - InitTableView
- (void)initTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.backgroundColor = UIColor.whiteColor;
    [self.tableView registerClass:[UHAImageTableViewCell class] forCellReuseIdentifier:reuseImageCellIdentifier];
    [self.tableView registerClass:[ACEExpandableTextCell class] forCellReuseIdentifier:reuseTextCellIdentififer];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.array[indexPath.row] isEqual: @50]) {
        return MAX(50.0, _cellHeight[indexPath.row]);
    }
    else {
        return UI_Screen_Width_Normal;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![self.array[indexPath.row] isEqual: @50]) {
        UHAImageTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        struct CGColor *clearColor = UIColor.clearColor.CGColor;
        struct CGColor *blueColor  = UIColor.blueColor.CGColor;
        cell.mySelectedView.layer.borderColor = (cell.mySelectedView.layer.borderColor == blueColor) ? clearColor : blueColor;
        //获取当前cell在屏幕中的坐标 （默认功能弹出框显示在上方，根据y值判断 是否需要显示在下方）
        CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
        CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    }
    else {
        ACEExpandableTextCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [cell.textView becomeFirstResponder];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![self.array[indexPath.row] isEqual: @50]) {
        UHAImageTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.mySelectedView.layer.borderColor = UIColor.clearColor.CGColor;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.array removeObjectAtIndex:indexPath.row];
    [self.cellData removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath
{
    //    if ([self.array[indexPath.row] isEqual: @50]) {
    _cellHeight[indexPath.row] = height;
    //    }
}

- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath
{
    //    if ([self.array[indexPath.row] isEqual: @50]) {
    [_cellData replaceObjectAtIndex:indexPath.row withObject:text];
    //    }
}

#pragma mark - UITableViewDataSource
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
//    static NSString *identifier = @"";
    if ([self.array[indexPath.row] isEqual: @50]) {
        ACEExpandableTextCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseTextCellIdentififer forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//        return cell;
//        UHATextTableViewCell *cell = [tableView expandableTextCellWithId:reuseTextCellIdentififer];
        cell.text = [self.cellData objectAtIndex:indexPath.row];
        cell.textView.placeholder = @"Placeholder";
        cell.expandableTableView = tableView ;
        return cell;
    }
    else {
        UHAImageTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseImageCellIdentifier forIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",indexPath.row]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
}

#pragma mark - IBAction
- (IBAction)longPressGestureRecognized:(id)sender {
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving.
    static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
    
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                sourceIndexPath = indexPath;
                
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                
                // Take a snapshot of the selected row using helper method.
                snapshot = [self customSnapshoFromView:cell];
                
                // Add the snapshot as subview, centered at cell's center...
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [self.tableView addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    // Offset for gesture location.
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    cell.alpha = 0.0;
                    
                } completion:^(BOOL finished) {
                    
                    cell.hidden = YES;
                    
                }];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            CGPoint center = snapshot.center;
            center.y = location.y;
            snapshot.center = center;
            
            // Is destination valid and is it different from source?
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                
                // ... update data source.
               [self.array exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
               [self.cellData exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                
                // ... move the rows.
                [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
                [self.tableView reloadData];
            }
            break;
        }
            
        default: {
            // Clean up.
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
                
            }];
            
            break;
        }
    }
}

- (void)cancelAction {
    UIAlertController * alert= [UIAlertController alertControllerWithTitle:@"您确定要删除为存储的更改吗？"
                                                                   message:@"这个操作无法撤消。"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* delete = [UIAlertAction actionWithTitle:@"删除更改" style:UIAlertActionStyleDestructive
                                                   handler:^(UIAlertAction * action)
                                                   {
                                                       [alert dismissViewControllerAnimated:YES
                                                                                 completion:nil];
                                                   }];
    UIAlertAction* continueEdit = [UIAlertAction actionWithTitle:@"继续编辑" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action)
                                                         {
                                                            [alert dismissViewControllerAnimated:YES
                                                                                      completion:nil];
                                                         }];
    [alert addAction:continueEdit];
    [alert addAction:delete];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)nextAction {
    
}


#pragma mark - Helper methods

/** @brief Returns a customized snapshot of a given view. */
- (UIView *)customSnapshoFromView:(UIView *)inputView {
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}



@end
