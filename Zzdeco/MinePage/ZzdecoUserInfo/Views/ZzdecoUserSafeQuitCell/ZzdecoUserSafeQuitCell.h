//
//  ZzdecoUserSafeQuitCell.h
//  Zzdeco
//
//  Created by Cain on 5/8/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "CALBaseTableViewCell.h"

@interface ZzdecoUserSafeQuitCell : CALBaseTableViewCell

@property (nonatomic, copy) void(^userSafeQuitCellBlock)(UIButton *safeQuit);

@end
