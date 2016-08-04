//
//  ZzdecoScreenContentTitleCell.m
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoScreenContentTitleCell.h"

@interface ZzdecoScreenContentTitleCell()

//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZzdecoScreenContentTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.titleLabel];
        
        [self addConstraint];
    }
    
    return self;
}

- (void)addConstraint {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        (void)make.edges;
    }];
}

#pragma mark - Set Title Label
- (UILabel *)titleLabel {
    
    CAL_GET_METHOD_RETURN_OBJC(_titleLabel);
    
    _titleLabel      = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:22];
    
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    
    return _titleLabel;
}

- (void)setTitleString:(NSString *)titleString {
    
    self.titleLabel.text = titleString;
}

@end
