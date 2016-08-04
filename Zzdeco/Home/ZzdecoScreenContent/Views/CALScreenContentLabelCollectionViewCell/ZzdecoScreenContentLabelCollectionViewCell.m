//
//  ZzdecoScreenContentLabelCollectionViewCell.m
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoScreenContentLabelCollectionViewCell.h"

@interface ZzdecoScreenContentLabelCollectionViewCell()

@property (nonatomic, strong) UIButton *typeButton;
@property (nonatomic, strong, readwrite) UILabel *typeLabel;

@end

@implementation ZzdecoScreenContentLabelCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {

        [self.contentView addSubview:self.typeLabel];

        [self addConstraints];
    }

    return self;
}

#pragma mark - Set UIKit Constraints
- (void)addConstraints {

    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        (void)make.edges;
    }];
}

#pragma mark - Set Type Label
- (UILabel *)typeLabel {
    
    CAL_GET_METHOD_RETURN_OBJC(_typeLabel);
    
    _typeLabel               = [UILabel new];
    _typeLabel.font          = [UIFont systemFontOfSize:16];
    _typeLabel.textColor     = [UIColor whiteColor];
    _typeLabel.textAlignment = NSTextAlignmentCenter;
    
    _typeLabel.adjustsFontSizeToFitWidth = YES;

    return _typeLabel;
}

- (void)setTypeString:(NSString *)typeString {
    
    _typeLabel.text = typeString;
}

@end
