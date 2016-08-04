//
//  ZzdecoUserHeadCell.h
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "CALBaseTableViewCell.h"

@interface ZzdecoUserHeadCell : CALBaseTableViewCell

@property (weak, nonatomic, readonly) IBOutlet UIImageView *userHeaderImageView;

@property (nonatomic, strong) UIImage *userHead;

@end
