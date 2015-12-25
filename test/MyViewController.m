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
#import "UHAExpandableTextCellPopUpView.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate,ACEExpandableTableViewDelegate,UHATableViewCellDelegate> {
    CGFloat *_cellHeight;
}

@property (nonatomic,strong) NSMutableArray  *addPhotosArray;
@property (nonatomic,strong) NSMutableArray  *dataSourceArray;
@property (nonatomic,assign) NSInteger       currentSelectedIndex;
@property (nonatomic,assign) NSInteger       currentSelectedUHATextCellIndex;
@property (nonatomic,strong) UITableView     *tableView;
@property (nonatomic,strong) UHABottomView   *bottomView;
@property (nonatomic,strong) UHAExpandableTextCellPopUpView *popUpView;


@end



static NSString *const reuseImageCellIdentifier = @"UHAImageTableViewCell";
static NSString *const reuseTextCellIdentififer = @"UHATextCell";

@implementation MyViewController

//#ifdef __IPHONE_7_0
//- (UIRectEdge)edgesForExtendedLayout {
//    return UIRectEdgeNone;
//}
//#endif

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _cellHeight = (CGFloat*)malloc(self.dataSourceArray.count);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"图文编辑";
    self.currentSelectedIndex            = -1;
    self.currentSelectedUHATextCellIndex = -1;
    [self initResource];
    
    self.dataSourceArray = [NSMutableArray new];
}

- (void)dealloc {
    free(_cellHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addNewPhotos {
    if (self.currentSelectedIndex < 0) {
        for (NSString *str in self.addPhotosArray) {
            UHAImageEntity *entity = [UHAImageEntity new];
            entity.imageName = str;
            [self.dataSourceArray addObject:entity];
        }
    }
    else {
        NSMutableArray *array = [NSMutableArray new];
        for (NSString *str in self.addPhotosArray) {
            UHAImageEntity *entity = [UHAImageEntity new];
            entity.imageName = str;
            [array addObject:entity];
        }
        NSMutableIndexSet *idxSet = [[NSMutableIndexSet alloc] init];
        NSUInteger index = (NSUInteger)self.currentSelectedIndex;
        [idxSet addIndexesInRange:NSMakeRange(index, array.count-1+index)];
        [self.dataSourceArray insertObjects:array atIndexes:idxSet];
    }
}

#pragma mark - InitResource
- (void)initResource {
    [self initNavigationItems];
    [self initTableView];
    [self initUHABottomView];
    [self initUHAExpandableTextCellPopUpView];
}

#pragma mark - InitNavigationItem
- (void)initNavigationItems {
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(clickCancelButton)];
    UIBarButtonItem *negativeLeftSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeLeftSpacer.width = 0;
    self.navigationItem.leftBarButtonItems = [[NSArray alloc] initWithObjects:negativeLeftSpacer,cancelBarButtonItem, nil];
    
    UIBarButtonItem *nextBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStyleBordered target:self action:@selector(clickNextButton)];
    UIBarButtonItem *negativeRightSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace  target:self action:nil];
    negativeRightSpacer.width = 0;
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:negativeRightSpacer, nextBarButtonItem, nil];
}

#pragma mark - InitTableView
- (void)initTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-40)];
    self.tableView.backgroundColor = UIColor.whiteColor;
    [self.tableView registerClass:[UHAImageTableViewCell class] forCellReuseIdentifier:reuseImageCellIdentifier];
    [self.tableView registerClass:[ACEExpandableTextCell class] forCellReuseIdentifier:reuseTextCellIdentififer];
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.tableView addGestureRecognizer:longPress];
}

#pragma mark - InitUHABottomView
- (void)initUHABottomView {
    self.bottomView = [[UHABottomView alloc]initWithFrame:CGRectMake(0, UI_Screen_Height_Normal-44, UI_Screen_Width_Normal, 44)];
    [self.bottomView.takePhotoButton addTarget:self action:@selector(clickTakePhotoButton)
                              forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView.openAlbumButton addTarget:self action:@selector(clickOpenAlbumButton)
                              forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView.addTextButton   addTarget:self action:@selector(clickAddTextButton)
                              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bottomView];
}

#pragma mark - InitUHAPopView
- (void)initUHAExpandableTextCellPopUpView {
    self.popUpView = [[UHAExpandableTextCellPopUpView alloc]initWithFrame:CGRectMake((UI_Screen_Width_Normal-150)/2, -50, 150, 45)];
    [self.popUpView.inputButton addTarget:self action:@selector(clickInputButton) forControlEvents:UIControlEventTouchUpInside];
    [self.popUpView.changeStyleButton addTarget:self action:@selector(clickChangeStyleButton) forControlEvents:UIControlEventTouchUpInside];
    [self.popUpView.deleteButton addTarget:self action:@selector(clickDeleteTextCellButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.popUpView];
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = self.dataSourceArray[indexPath.row];
//    if ([self.array[indexPath.row] isEqual: @50]) {
    if ([object isMemberOfClass:[UHATextEntity class]]) {
        return MAX(50.0, _cellHeight[indexPath.row]);
    }
    else {
        return UI_Screen_Width_Normal;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.currentSelectedIndex = [indexPath row];
    //返回当前可见的indexPath 数组
//    NSArray *indexPaths = [self.tableView indexPathsForVisibleRows];
//    NSInteger min = [indexPaths[0] row];
//    NSInteger max = [indexPaths[indexPaths.count-1] row];
    
//    if (![self.array[indexPath.row] isEqual: @50]) {
    id object = self.dataSourceArray[indexPath.row];
    if (![object isMemberOfClass:[UHATextEntity class]]) {
        UHAImageTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (cell.deleteButton.hidden == YES) {
            cell.deleteButton.hidden = NO;
        }
        else {
            cell.deleteButton.hidden = YES;
        }
        [self  minifyPopUpView];
    }
    else {
        self.currentSelectedUHATextCellIndex = [indexPath row];
        struct CGColor *clearColor = UIColor.clearColor.CGColor;
        struct CGColor *blueColor  = UIColor.blueColor.CGColor;
        ACEExpandableTextCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//        cell.textView.layer.borderColor = (cell.textView.layer.borderColor == blueColor) ? clearColor: blueColor;
        
        if (cell.textView.layer.borderColor == blueColor) {
            cell.textView.layer.borderColor = clearColor;
            [self minifyPopUpView];
        }
        else {
            cell.textView.layer.borderColor = blueColor;
            //获取当前cell在屏幕中的坐标 （默认功能弹出框显示在上方，根据y值判断 是否需要显示在下方）
            CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
            CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
            if (rect.origin.y > 100) {
                self.popUpView.backgroundImageView.image = [UIImage  imageNamed:@"富文本编辑_框_文字功能"];
                self.popUpView.frame = CGRectMake((UI_Screen_Width_Normal-150)/2, rect.origin.y-45, 150, 45);
            }
            else {
                self.popUpView.backgroundImageView.image = [UIImage  imageNamed:@"富文本编辑_框_文字功能_反向"];
                self.popUpView.frame = CGRectMake((UI_Screen_Width_Normal-150)/2, rect.origin.y+CGRectGetHeight(cell.frame), 150, 45);
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (![self.array[indexPath.row] isEqual: @50]) {
    id object = self.dataSourceArray[indexPath.row];
    if (![object isMemberOfClass:[UHATextEntity class]]) {
        UHAImageTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.deleteButton.hidden = YES;
    }
    else {
        ACEExpandableTextCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.textView.layer.borderColor = UIColor.clearColor.CGColor;
    }
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataSourceArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath {
    _cellHeight[indexPath.row] = height;
}

- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath {
    UHATextEntity *entity = self.dataSourceArray[indexPath.row];
    entity.text = text;
    [self.dataSourceArray replaceObjectAtIndex:indexPath.row withObject:entity];
}

#pragma mark - UITableViewDataSource
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return  self.array.count;
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
//    if ([self.array[indexPath.row] isEqual: @50]) {
    id object = self.dataSourceArray[indexPath.row];
    if ([object isMemberOfClass:[UHATextEntity class]]) {
        ACEExpandableTextCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseTextCellIdentififer forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell updateWithData:self.dataSourceArray[indexPath.row]];
        cell.expandableTableView  = tableView;
        return cell;
    }
    else {
        UHAImageTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseImageCellIdentifier forIndexPath:indexPath];
        [cell updateWithData:self.dataSourceArray[indexPath.row]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.delegate = self;
        return cell;
    }
}

#pragma mark - UIScrollViewDelegate
// scrollView 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDragging");
    [UIView animateWithDuration:0.005 animations:^{
        self.popUpView.frame = CGRectZero;
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)sender
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.1];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //这里添加你的逻辑，比如，触发上拉加载更多
    if (self.currentSelectedUHATextCellIndex < 0) {
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentSelectedUHATextCellIndex inSection:0];
    CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:indexPath];
    CGRect rect = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
//    [UIView animateWithDuration:0.005 animations:^{
//        self.popUpView.frame = CGRectMake((UI_Screen_Width_Normal-150)/2, rect.origin.y-45, 150, 45);
//    }];
    if (rect.origin.y > 100) {
        self.popUpView.backgroundImageView.image = [UIImage  imageNamed:@"富文本编辑_框_文字功能"];
        self.popUpView.frame = CGRectMake((UI_Screen_Width_Normal-150)/2, rect.origin.y-45, 150, 45);
    }
    else {
        ACEExpandableTextCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        self.popUpView.backgroundImageView.image = [UIImage  imageNamed:@"富文本编辑_框_文字功能_反向"];
        self.popUpView.frame = CGRectMake((UI_Screen_Width_Normal-150)/2, rect.origin.y+CGRectGetHeight(cell.frame), 150, 45);
    }
}


#pragma mark - IBAction
- (void)clickTakePhotoButton {
    UHAImageEntity *entity = [UHAImageEntity new];
    entity.imageName = @"";
    //返回当前可见的indexPath 数组
    NSArray *indexPaths = [self.tableView indexPathsForVisibleRows];
    if(indexPaths.count <= 0) {
        [self.dataSourceArray addObject:entity];
        [self.tableView reloadData];
        return;
    }
    NSInteger min = [indexPaths[0] row];
    NSInteger max = [indexPaths[indexPaths.count-1] row];
    if (self.currentSelectedIndex >= min && self.currentSelectedIndex <= max ) {
        [self.dataSourceArray insertObject:entity atIndex:(NSUInteger)self.currentSelectedIndex+1];
    }
    else {
        self.currentSelectedIndex = -1;
        [self.dataSourceArray insertObject:entity atIndex:1];
    }
    [self minifyPopUpView];
    [self.tableView reloadData];
}

- (void)clickOpenAlbumButton {
    
}

- (void)clickAddTextButton {
    UHATextEntity *entity = [UHATextEntity new];
    entity.text = @"";
    //返回当前可见的indexPath 数组
    NSArray *indexPaths = [self.tableView indexPathsForVisibleRows];
    if(indexPaths.count <= 0) {
        [self.dataSourceArray addObject:entity];
        [self.tableView reloadData];
        return;
    }
    NSInteger min = [indexPaths[0] row];
    NSInteger max = [indexPaths[indexPaths.count-1] row];
    if (self.currentSelectedIndex >= min && self.currentSelectedIndex <= max ) {
        [self.dataSourceArray insertObject:entity atIndex:(NSUInteger)self.currentSelectedIndex+1];
    }
    else {
        self.currentSelectedIndex = -1;
        [self.dataSourceArray insertObject:entity atIndex:1];
    }
    [self minifyPopUpView];
    [self.tableView reloadData];
}

- (void)respondsToDeleteUHATableViewCell:(id)entity {
    [self.dataSourceArray removeObject:entity];
    [self minifyPopUpView];
    [self.tableView reloadData];
}

- (void)respondsToEditUHAImage:(id)entity {
    
}

- (void)clickInputButton {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentSelectedUHATextCellIndex inSection:0];
    ACEExpandableTextCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self minifyPopUpView];
    [cell.textView becomeFirstResponder];
}

- (void)clickChangeStyleButton {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentSelectedUHATextCellIndex inSection:0];
    ACEExpandableTextCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if(kCTLeftTextAlignment == cell.textView.textAlignment) {
        cell.textView.textAlignment = kCTRightTextAlignment;
        [self.popUpView.changeStyleButton setImage:[UIImage imageNamed:@"富文本编辑_按钮_文字对齐_中对齐"] forState:UIControlStateNormal];
    }
    else if (kCTRightTextAlignment == cell.textView.textAlignment) {
        cell.textView.textAlignment = kCTCenterTextAlignment;
        [self.popUpView.changeStyleButton setImage:[UIImage imageNamed:@"富文本编辑_按钮_文字对齐_右对齐"] forState:UIControlStateNormal];
    }
    else {
        cell.textView.textAlignment = kCTLeftTextAlignment;
        [self.popUpView.changeStyleButton setImage:[UIImage imageNamed:@"富文本编辑_按钮_文字对齐_左对齐"] forState:UIControlStateNormal];
    }
    

}

- (void)clickDeleteTextCellButton {
    [self.dataSourceArray removeObjectAtIndex:(NSUInteger)self.currentSelectedUHATextCellIndex];
    [self minifyPopUpView];
    [self.tableView reloadData];
}

- (void)minifyPopUpView {
    self.currentSelectedUHATextCellIndex = -1;
    self.popUpView.frame = CGRectZero;
}

- (void)clickCancelButton {
    UIAlertController * alert= [UIAlertController alertControllerWithTitle:@"您确定要删除为存储的更改吗？"
                                                                   message:@"这个操作无法撤消。"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* delete = [UIAlertAction actionWithTitle:@"删除更改"
                                                     style:UIAlertActionStyleDestructive
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES
                                                                                 completion:nil];
                                                   }];
    UIAlertAction* continueEdit = [UIAlertAction actionWithTitle:@"继续编辑"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             [alert dismissViewControllerAnimated:YES
                                                                                       completion:nil];
                                                         }];
    [alert addAction:continueEdit];
    [alert addAction:delete];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)clickNextButton {
    
}

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
               [self.dataSourceArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                
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
