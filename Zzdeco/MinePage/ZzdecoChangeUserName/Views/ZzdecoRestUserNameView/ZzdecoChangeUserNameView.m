//
//  ZzdecoRestUserNameView.m
//  Zzdeco
//
//  Created by Cain on 18/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoChangeUserNameView.h"

@interface ZzdecoChangeUserNameView()

@property (nonatomic, strong) UIView *textFieldBackgroundView;
@property (nonatomic, strong) UIView *buttonBackgroundView;

@property (nonatomic, strong) UITextField *userNameTextField;
@property (nonatomic, strong) UIButton *completeButton;

@end

@implementation ZzdecoChangeUserNameView

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.backgroundColor = CAL_COLOR_FROM_HEX_CODE(0xF3F3F3);
        
        [self.textFieldBackgroundView addSubview:self.userNameTextField];
        [self.buttonBackgroundView addSubview:self.completeButton];
        
        [self addSubview:self.textFieldBackgroundView];
        [self addSubview:self.buttonBackgroundView];
        
        [self addConstraints];
    }
    
    return self;
}

- (void)addConstraints {
    
    [self.textFieldBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(self).insets(UIEdgeInsetsMake(CAL_WIDTH_TO_FIT(20), 0, 0, 0));
        make.height.mas_equalTo(CAL_WIDTH_TO_FIT(100));
    }];
    
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.equalTo(self.textFieldBackgroundView).insets(UIEdgeInsetsMake(0, CAL_WIDTH_TO_FIT(50), 0, CAL_WIDTH_TO_FIT(50)));
    }];
    
    [self.buttonBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.textFieldBackgroundView.mas_bottom).offset(CAL_WIDTH_TO_FIT(20));
        make.left.right.equalTo(self).insets(UIEdgeInsetsMake(CAL_WIDTH_TO_FIT(20), 0, 0, 0));
        make.height.mas_equalTo(CAL_WIDTH_TO_FIT(140));
    }];
    
    [self.completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(CAL_WIDTH_TO_FIT(90));
        make.centerY.equalTo(self.buttonBackgroundView);
        make.left.right.equalTo(self.buttonBackgroundView).insets(UIEdgeInsetsMake(0, CAL_WIDTH_TO_FIT(50), 0, CAL_WIDTH_TO_FIT(50)));
    }];
}

#pragma mark - Set Text Field Background View
- (UIView *)textFieldBackgroundView {
    
    CAL_GET_METHOD_RETURN_OBJC(_textFieldBackgroundView);
    
    _textFieldBackgroundView = [[UIView alloc] init];
    _textFieldBackgroundView.backgroundColor = [UIColor whiteColor];
    
    return _textFieldBackgroundView;
}

#pragma mark - Set User Text Field
- (UITextField *)userNameTextField {
    
    CAL_GET_METHOD_RETURN_OBJC(_userNameTextField);
    
    _userNameTextField = [[UITextField alloc] init];
    _userNameTextField.font = [UIFont systemFontOfSize:14];
    _userNameTextField.placeholder = @"请输入您的用户名";
    
    _userNameTextField.adjustsFontSizeToFitWidth = YES;
    
    return _userNameTextField;
}

- (void)setUserName:(NSString *)userName {
    
    self.userNameTextField.text = userName;
}

#pragma mark - Set Button Background View
- (UIView *)buttonBackgroundView {
    
    CAL_GET_METHOD_RETURN_OBJC(_buttonBackgroundView);
    
    _buttonBackgroundView = [[UIView alloc] init];
    _buttonBackgroundView.backgroundColor = [UIColor whiteColor];
    
    return _buttonBackgroundView;
}

#pragma mark - Set Complete Button
- (UIButton *)completeButton {
    
    CAL_GET_METHOD_RETURN_OBJC(_completeButton);
    
    _completeButton = [[UIButton alloc] init];
    
    _completeButton.backgroundColor = CAL_COLOR_FROM_HEX_CODE(0x2E76C8);
    _completeButton.titleLabel.font = [UIFont systemFontOfSize:17];
    
    _completeButton.layer.cornerRadius = 8.0f;
    
    [_completeButton setTitle:@"完成" forState:UIControlStateNormal];
    [_completeButton addTarget:self action:@selector(completeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    return _completeButton;
}

- (void)completeButtonAction {
    
    if (self.zzdecoCompleteButtonBlock) {
        self.zzdecoCompleteButtonBlock(self.userNameTextField.text);
    }
}

@end
