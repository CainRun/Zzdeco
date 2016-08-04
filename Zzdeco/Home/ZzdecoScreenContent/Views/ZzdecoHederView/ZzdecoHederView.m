//
//  ZzdecoHederView.m
//  Zzdeco
//
//  Created by Cain on 31/5/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoHederView.h"

@interface ZzdecoHederView()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZzdecoHederView

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.size = CGSizeMake(CAL_SCREEN_WIDTH, CAL_WIDTH_TO_FIT(150));
        
        [self addSubview:self.titleLabel];
        [self addConstraints];
    }
    
    return self;
}

- (void)addConstraints {
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self);
    }];
}

- (UILabel *)titleLabel {
    
    CAL_GET_METHOD_RETURN_OBJC(_titleLabel);
    
    _titleLabel               = [UILabel new];
    _titleLabel.textColor     = [UIColor whiteColor];
    _titleLabel.text          = @"筛选";
    _titleLabel.font          = [UIFont systemFontOfSize:19];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    
    return _titleLabel;
}

@end
