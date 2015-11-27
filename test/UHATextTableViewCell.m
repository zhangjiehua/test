//
//  UHATextTableViewCell.m
//  test
//
//  Created by 看看 on 15/11/20.
//  Copyright © 2015年 张杰华. All rights reserved.
//

#import "UHATextTableViewCell.h"
#import <Masonry.h>

#define kPadding 5

@interface UHATextTableViewCell ()<UITextViewDelegate>
@property (nonatomic, strong) SZTextView *textView;
@end

@implementation UHATextTableViewCell

#pragma mark - init
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.backgroundColor = UIColor.clearColor;
//
//        __weak  __typeof(self) weakSelf = self;
//
//        self.myView = [UIView new];
//        [self.contentView addSubview:self.myView];
//        [self.myView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(weakSelf.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
//        }];
//        self.myView.backgroundColor = UIColor.blackColor;
//        
//        
//      
//        
//        self.button = [UIButton new];
//        [self.contentView addSubview:self.button];
//        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(weakSelf.contentView).insets(UIEdgeInsetsMake(10, 5, 10, 5));
//        }];
//        [self.button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return self;
//}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        __weak typeof(self) weakSelf = self;
        [self.contentView addSubview:self.textView];
        self.myView = [UIView new];
        [self.contentView addSubview:self.myView];
        [self.myView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        self.myView.backgroundColor = UIColor.blackColor;
    }
    return self;
}

- (SZTextView *)textView
{
    if (_textView == nil) {
        CGRect cellFrame = self.contentView.bounds;
        cellFrame.origin.y += kPadding;
        cellFrame.size.height -= kPadding;
        
        _textView = [[SZTextView alloc] initWithFrame:cellFrame];
        _textView.delegate = self;
        
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = [UIFont systemFontOfSize:18.0f];
        
        _textView.scrollEnabled = NO;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.showsHorizontalScrollIndicator = NO;
        // textView.contentInset = UIEdgeInsetsZero;
    }
    return _textView;
}

- (void)setText:(NSString *)text
{
    _text = text;
    
    // update the UI and the cell size with a delay to allow the cell to load
    self.textView.text = text;
    [self performSelector:@selector(textViewDidChange:)
               withObject:self.textView
               afterDelay:0.1];
}

- (CGFloat)cellHeight
{
    return [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, FLT_MAX)].height + kPadding * 2;
}

- (void)updateTextViewHeight {
    [self textViewDidChange:self.textView];
}

#pragma mark - Text View Delegate

-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([self.expandableTableView.delegate respondsToSelector:@selector(tableView:textViewDidEndEditing:)]) {
        [(id<UHAExpandableTableViewDelegate>)self.expandableTableView.delegate tableView:self.expandableTableView textViewDidEndEditing:self.textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if ([self.expandableTableView.delegate respondsToSelector:@selector(tableView:textViewDidChangeSelection:)]) {
        [(id<UHAExpandableTableViewDelegate>)self.expandableTableView.delegate tableView:self.expandableTableView textViewDidChangeSelection:self.textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([self.expandableTableView.delegate respondsToSelector:@selector(tableView:textView:shouldChangeTextInRange:replacementText:)]) {
        id<UHAExpandableTableViewDelegate> delegate = (id<UHAExpandableTableViewDelegate>)self.expandableTableView.delegate;
        return [delegate tableView:self.expandableTableView
                          textView:textView
           shouldChangeTextInRange:range
                   replacementText:text];
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    // make sure the cell is at the top
    [self.expandableTableView scrollToRowAtIndexPath:[self.expandableTableView indexPathForCell:self]
                                    atScrollPosition:UITableViewScrollPositionTop
                                            animated:YES];
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.expandableTableView.delegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [(id<UHAExpandableTableViewDelegate>)self.expandableTableView.delegate textViewDidBeginEditing:textView];
    }
}

- (void)textViewDidChange:(UITextView *)theTextView
{
    if ([self.expandableTableView.delegate conformsToProtocol:@protocol(UHAExpandableTableViewDelegate)]) {
        
        id<UHAExpandableTableViewDelegate> delegate = (id<UHAExpandableTableViewDelegate>)self.expandableTableView.delegate;
        NSIndexPath *indexPath = [self.expandableTableView indexPathForCell:self];
        
        // update the text
        _text = self.textView.text;
        
        [delegate tableView:self.expandableTableView
                updatedText:_text
                atIndexPath:indexPath];
        
        CGFloat newHeight = [self cellHeight];
        CGFloat oldHeight = [delegate tableView:self.expandableTableView heightForRowAtIndexPath:indexPath];
        if (fabs(newHeight - oldHeight) > 0.01) {
            
            // update the height
            if ([delegate respondsToSelector:@selector(tableView:updatedHeight:atIndexPath:)]) {
                [delegate tableView:self.expandableTableView
                      updatedHeight:newHeight
                        atIndexPath:indexPath];
            }
            
            // refresh the table without closing the keyboard
            [self.expandableTableView beginUpdates];
            [self.expandableTableView endUpdates];
        }
    }
}


@end

#pragma mark -

@implementation UITableView (UHATextTableViewCell)

- (UHATextTableViewCell *)expandableTextCellWithId:(NSString *)cellId
{
    UHATextTableViewCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UHATextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.expandableTableView = self;
    }
    return cell;
}


#pragma mark - ButtonAction
- (void)click {
    NSLog(@"textCell be clicked");
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
