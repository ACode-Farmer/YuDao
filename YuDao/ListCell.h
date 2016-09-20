//
//  ListCell.h
//  YuDao
//
//  Created by 汪杰 on 16/9/7.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListCelldelegate <NSObject>

@required
- (void)changeListTypeCellBtn:(NSInteger )page;

@end

@interface ListCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic, weak) id<ListCelldelegate> delegate;

@end
