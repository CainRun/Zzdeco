//
//  CALBaseControllerSubTitleView.m
//  Zzdeco
//
//  Created by Cain on 5/9/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "CALBaseControllerSubTitleView.h"

@interface CALBaseControllerSubTitleView()

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation CALBaseControllerSubTitleView

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.isAcstate = NO;
        
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        
        [self addConstraints];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.isAcstate = NO;

        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        
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
        
        make.right.equalTo(self).offset(CAL_WIDTH_TO_FIT(-20));
        make.width.height.bottom.equalTo(self.leftButton);
    }];
}

#pragma mark - Set Title View UIKit
- (UIButton *)leftButton {
    
    CAL_GET_METHOD_RETURN_OBJC(_leftButton);
    
    _leftButton                            = [UIButton buttonWithType:UIButtonTypeSystem];
    _leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [_leftButton setTintColor:[UIColor whiteColor]];
    [_leftButton setImage:[UIImage imageNamed:@"button-return"] forState:UIControlStateNormal];
    [_leftButton setImage:[UIImage imageNamed:@"button-return-click"] forState:UIControlStateHighlighted];
    
    [_leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return _leftButton;
}

- (UIButton *)rightButton {
    
    CAL_GET_METHOD_RETURN_OBJC(_rightButton);
    
    _rightButton     = [UIButton buttonWithType:UIButtonTypeSystem];
    
    _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [_rightButton setTintColor:[UIColor whiteColor]];
    
    [_rightButton setImage:[UIImage imageNamed:@"button-focus_on"] forState:UIControlStateNormal];
    [_rightButton setImage:[UIImage imageNamed:@"button-focus_on-selected"] forState:UIControlStateHighlighted];
    
    [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return _rightButton;
}

#pragma mark - Set Right Button image
- (void)setIsAcstate:(BOOL)isAcstate {
    
    _isAcstate = isAcstate;
    
    if (isAcstate) {
        
        [self.rightButton setImage:[UIImage imageNamed:@"button-focus_on-selected"] forState:UIControlStateNormal];
        [self.rightButton setImage:[UIImage imageNamed:@"button-focus_on-selected-click"] forState:UIControlStateHighlighted];
        
    } else {

        [self.rightButton setImage:[UIImage imageNamed:@"button-focus_on"] forState:UIControlStateNormal];
        [self.rightButton setImage:[UIImage imageNamed:@"button-focus_on-selected"] forState:UIControlStateHighlighted];
    }
}

#pragma mark - Set Button Action
- (void)leftButtonAction:(UIButton *)sender {
    
    if (self.calControllerSubTitleViewLeftBlock) {
        
        self.calControllerSubTitleViewLeftBlock(sender);
    }
}

- (void)rightButtonAction:(UIButton *)sender {
    
    if (self.calControllerSubTitleViewRightBlock) {
        
        self.calControllerSubTitleViewRightBlock(sender);
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
