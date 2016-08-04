//
//  ZzdecoScreenContentCell.h
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "CALBaseTableViewCell.h"

@interface ZzdecoScreenContentCell : CALBaseTableViewCell

@property (nonatomic, copy) NSString *typeString;

@property (nonatomic, strong) NSArray *typeArray;

@property (nonatomic, assign) NSInteger indexPath;

@property (nonatomic, copy) void(^didSelectedItemAction)(void);

@property (nonatomic, copy) void(^zzdecoScreenContentCellBlock)(NSInteger index, NSInteger typeID);

- (void)cancelCurrentItem;
- (void)firstItemSelected:(BOOL)selected;
- (void)setLabelCollectionViewData;

@end
