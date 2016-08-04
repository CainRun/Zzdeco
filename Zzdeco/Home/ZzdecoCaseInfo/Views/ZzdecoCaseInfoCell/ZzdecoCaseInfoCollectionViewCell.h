//
//  ZzdecoCaseInfoCollectionViewCell.h
//  Zzdeco
//
//  Created by Cain on 5/16/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZzdecoDataListModel.h"

@interface ZzdecoCaseInfoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, copy) NSString *caseTitle;
@property (nonatomic, copy) NSString *caseInfo;

@property (nonatomic, copy) void(^zzdecoCaseInfoCollectionViewBlock)(void);

- (void)reloadTableViewData;

@end
