//
//  ZzdecoScreenContentLabelCollectionViewCell.h
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZzdecoScreenContentLabelCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong, readonly) UILabel *typeLabel;

@property (nonatomic, copy) NSString *typeString;

@property (nonatomic, assign) NSInteger buttonTag;

@property (nonatomic, assign) BOOL isSelection;

@property (nonatomic, copy) void(^CALScreenContentLabelCollectionButtonBlock)(UIButton *typeButton);

@end
