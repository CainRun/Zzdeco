//
//  CALBaseTableViewCell.m
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "CALBaseTableViewCell.h"

@interface CALBaseTableViewCell()

@property (nonatomic, strong) UIImageView *lineImageView;

@end

@implementation CALBaseTableViewCell

- (void)setIsNeedLine:(BOOL)isNeedLine {
    
    if (isNeedLine) {
        
        [self addSeparatorLine];
    }
}

- (void)addSeparatorLine {
    
    [self.contentView addSubview:self.lineImageView];
}

- (UIImageView *)lineImageView {
    
    CAL_GET_METHOD_RETURN_OBJC(_lineImageView);
    
    _lineImageView       = [UIImageView new];
    _lineImageView.image = [UIImage imageNamed:@"cell_line"];
    _lineImageView.alpha = 0.7;
    
    return _lineImageView;
}

- (void)setTableViewCellLineStyle:(CALBaseTableViewCellLineStyle)tableViewCellLineStyle {
    
    if (tableViewCellLineStyle == CALBaseTableViewCellLineDefault) {
        
        [self.lineImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            (void)make.bottom;
            make.left.equalTo(self).offset(15);
            make.width.mas_offset(CAL_SCREEN_WIDTH);
        }];

    } else {
        
        [self.lineImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            (void)make.bottom;
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
        }];
    }
}

@end
