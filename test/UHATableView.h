//
//  UHATableView.h
//  test
//
//  Created by 看看 on 15/11/18.
//  Copyright © 2015年 张杰华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UHATableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *cellData;

@end
