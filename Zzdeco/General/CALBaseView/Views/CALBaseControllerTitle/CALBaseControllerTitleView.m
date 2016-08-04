//
//  CALControllerTitleView.m
//  Zzdeco
//
//  Created by Cain on 5/4/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "CALBaseControllerTitleView.h"

@interface CALBaseControllerTitleView()

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UILabel  *titleLabel;

@end

@implementation CALBaseControllerTitleView

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.frame = CGRectMake(0, 0, CAL_SCREEN_WIDTH, 64);
        
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.titleLabel];
        
        [self addConstraints];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.titleLabel];
        
        [self addConstraints];
    }
    
    return self;
}

- (void)addConstraints {
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(19);
        make.width.mas_equalTo(CAL_WIDTH_TO_FIT(88));
        make.height.mas_equalTo(CAL_WIDTH_TO_FIT(80));
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(CAL_WIDTH_TO_FIT(-38));
        make.width.height.bottom.equalTo(self.leftButton);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        (void)make.left.bottom;
        make.right.equalTo(self.rightButton);
        make.height.equalTo(self.leftButton);
    }];
}

#pragma mark - Set Title View UIKit
- (UIButton *)leftButton {
    
    CAL_GET_METHOD_RETURN_OBJC(_leftButton);
    
    _leftButton                            = [UIButton buttonWithType:UIButtonTypeSystem];
    _leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [_leftButton setTintColor:[UIColor whiteColor]];
    [_leftButton setImage:[UIImage imageNamed:@"button-close"] forState:UIControlStateNormal];
    [_leftButton setImage:[UIImage imageNamed:@"button-close－click"] forState:UIControlStateHighlighted];

    [_leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return _leftButton;
}

- (UIButton *)rightButton {
    
    CAL_GET_METHOD_RETURN_OBJC(_rightButton);
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    _rightButton.titleLabel.adjustsFontSizeToFitWidth = YES;

    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightButton setTitleColor:CAL_COLOR_FROM_HEX_CODE(0xffffff) forState:UIControlStateHighlighted];
    
    [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    return _rightButton;
}

#pragma mark - Set Title Label
- (UILabel *)titleLabel {
    
    CAL_GET_METHOD_RETURN_OBJC(_titleLabel);

    _titleLabel               = [UILabel new];
    _titleLabel.font          = [UIFont systemFontOfSize:18];
    _titleLabel.textAlignment = NSTextAlignmentRight;
    _titleLabel.textColor     = CAL_COLOR_FROM_HEX_CODE(0x969698);
    
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    
    return _titleLabel;
}

- (void)setTitleStyle:(CALBaseControllerTitleViewStyle)titleStyle {
    
    if (titleStyle == CALBaseControllerTitleViewCenterStyle) {
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        return;

    } else if (titleStyle == CALBaseControllerTitleViewLeftStyle) {
        
        self.titleLabel.textAlignment = NSTextAlignmentLeft;

        return;
    } else if (titleStyle == CALBaseControllerTitleViewRightStyle) {
        
        self.titleLabel.textAlignment = NSTextAlignmentRight;

        return;
    }
}

- (void)setTitleViewTitle:(NSString *)titleViewTitle {
    
    self.titleLabel.text = titleViewTitle;
}

- (void)setTitleTextColor:(UIColor *)titleTextColor {
    
    self.titleLabel.textColor = titleTextColor;
}

#pragma mark - Set Hidden Right Button
- (void)setHiddenRightButton:(BOOL)hiddenRightButton {
    
    self.rightButton.hidden = hiddenRightButton;
}

#pragma mark - Set Button Action
- (void)leftButtonAction:(UIButton *)sender {
    
    if (self.calControllerTitleViewLeftBlock) {
        
        self.calControllerTitleViewLeftBlock(sender);
    }
}

- (void)rightButtonAction:(UIButton *)sender {
    
    if (self.calControllerTitleViewRightBlock) {
        
        self.calControllerTitleViewRightBlock(sender);
    }
}

#pragma mark - Set Left Button Image
- (void)setLeftButtonImage:(UIImage *)leftButtonImage {
    
    [_leftButton setImage:leftButtonImage forState:UIControlStateNormal];
}

- (void)setLeftButtonHighlightedImage:(UIImage *)leftButtonHighlightedImage {
    
    [_leftButton setImage:leftButtonHighlightedImage forState:UIControlStateHighlighted];
}

#pragma mark - Set Right Button Image
- (void)setRightButtonImage:(UIImage *)rightButtonImage {
    
    [_rightButton setImage:rightButtonImage forState:UIControlStateNormal];
}

- (void)setRightButtonHighlightedImage:(UIImage *)rightButtonHighlightedImage {
    
    [_rightButton setImage:rightButtonHighlightedImage forState:UIControlStateHighlighted];
}

#pragma mark - Set Right Button Title
- (void)setRightButtonTitle:(NSString *)rightButtonTitle {
    
    [self.rightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
}

@end
