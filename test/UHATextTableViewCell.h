//
//  UHATextTableViewCell.h
//  test
//
//  Created by 看看 on 15/11/20.
//  Copyright © 2015年 张杰华. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SZTextView.h"

@protocol UHAExpandableTableViewDelegate <UITableViewDelegate, UITextViewDelegate>

@required
- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(UITableView *)tableView textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)tableView:(UITableView *)tableView textViewDidChangeSelection:(UITextView*)textView;
- (void)tableView:(UITableView *)tableView textViewDidEndEditing:(UITextView*)textView;
@end

@interface UHATextTableViewCell : UITableViewCell


@property (nonatomic, strong) UIView *myView;
//@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, weak) UITableView *expandableTableView;
@property (nonatomic, strong, readonly) SZTextView  *textView;
@property (nonatomic, readonly) CGFloat cellHeight;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIButton *button;
//@property (assign, nonatomic) id<UHAExpandableTableViewDelegate> delegate;

-(void)updateTextViewHeight; // Call to update the textView height (useful for viewdidload)


@end

#pragma mark -

@interface UITableView (UHATextTableViewCell)

// return the cell with the specified ID. It takes care of the dequeue if necessary
- (UHATextTableViewCell *)expandableTextCellWithId:(NSString *)cellId;

@end