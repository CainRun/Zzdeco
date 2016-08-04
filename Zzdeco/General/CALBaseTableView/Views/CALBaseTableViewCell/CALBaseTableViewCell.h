//
//  CALBaseTableViewCell.h
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CALBaseTableViewCellLineStyle) {
    
    CALBaseTableViewCellLineDefault,
    CALBaseTableViewCellTwoSpacingStyle,
};

@interface CALBaseTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL isNeedLine;

@property (nonatomic, assign) CALBaseTableViewCellLineStyle tableViewCellLineStyle;

@end
