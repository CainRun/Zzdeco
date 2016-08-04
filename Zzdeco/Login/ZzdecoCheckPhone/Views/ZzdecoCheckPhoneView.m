//
//  ZzdecoCheckPhoneView.m
//  Zzdeco
//
//  Created by Cain on 28/5/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoCheckPhoneView.h"

@interface ZzdecoCheckPhoneView() <UITextFieldDelegate>

@property (nonatomic, strong) UILabel     *tipsLabel;
@property (nonatomic, strong) UIButton    *continueButton;
@property (nonatomic, strong) UIButton    *clearTextFieldButton;
@property (nonatomic, strong) UITextField *phoneNumberTextField;
@property (nonatomic, strong) UIImageView *lineImageView;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@end

@implementation ZzdecoCheckPhoneView

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, CAL_SCREEN_WIDTH, CAL_SCREEN_HEIGHT);
        
        [self addSubview:self.backgroundImageView];

        [self addSubview:self.tipsLabel];
        [self addSubview:self.phoneNumberTextField];
        [self addSubview:self.clearTextFieldButton];
        [self addSubview:self.lineImageView];
        [self addSubview:self.continueButton];
        [self addSubview:self.loadingView];
        
        [self addConstraints];
    }
    
    return self;
}

- (void)addConstraints {
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self);
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.lineImageView);
        make.width.mas_offset(CAL_WIDTH_TO_FIT(100));
        make.height.mas_offset(CAL_WIDTH_TO_FIT(100));
        make.bottom.equalTo(self.lineImageView.mas_top).offset(CAL_WIDTH_TO_FIT(-20));
    }];
    
    [self.phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.lineImageView.mas_top);
        make.height.mas_offset(CAL_WIDTH_TO_FIT(88));
        make.left.equalTo(self.tipsLabel.mas_right).offset(CAL_WIDTH_TO_FIT(10));
    }];
    
    [self.clearTextFieldButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.phoneNumberTextField);
        make.left.equalTo(self.phoneNumberTextField.mas_right).offset(CAL_WIDTH_TO_FIT(10));
        make.right.equalTo(self.lineImageView).offset(CAL_WIDTH_TO_FIT(-65));
    }];
    
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.continueButton);
        make.bottom.equalTo(self.continueButton.mas_top).offset(CAL_WIDTH_TO_FIT(-40));
    }];
    
    [self.continueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_offset(CAL_WIDTH_TO_FIT(88));
        make.centerY.equalTo(self).offset(CAL_WIDTH_TO_FIT(-50));
        make.left.equalTo(self).offset(CAL_WIDTH_TO_FIT(50));
        make.right.equalTo(self).offset(CAL_WIDTH_TO_FIT(-50));
    }];
    
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.continueButton);
        make.top.equalTo(self.continueButton.mas_bottom).offset(CAL_WIDTH_TO_FIT(60));
    }];
}

#pragma mark - Set Tips Label
- (UILabel *)tipsLabel {
    
    CAL_GET_METHOD_RETURN_OBJC(_tipsLabel);
    
    _tipsLabel               = [UILabel new];
    _tipsLabel.text          = @"手机号码\n+86";
    _tipsLabel.font          = [UIFont systemFontOfSize:18];
    _tipsLabel.textColor     = [UIColor whiteColor];
    _tipsLabel.numberOfLines = 2;
    
    [_tipsLabel setAttributedText:[NSAttributedString cal_attributedStringRangeAddLineSpacing:@"手机号码\n+86" font:11 lineSpacing:5 range:NSMakeRange(0, 4)]];

    _tipsLabel.textAlignment = NSTextAlignmentCenter;
    _tipsLabel.adjustsFontSizeToFitWidth = YES;

    return _tipsLabel;
}

#pragma mark - Set Line Image View
- (UIImageView *)lineImageView {
    
    CAL_GET_METHOD_RETURN_OBJC(_lineImageView);
    
    _lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_line"]];
    
    return _lineImageView;
}

- (UIImageView *)backgroundImageView {
    
    CAL_GET_METHOD_RETURN_OBJC(_backgroundImageView);
    
    _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_background_image"]];
    
    return _backgroundImageView;
}

#pragma mark - Set Text Field
- (UITextField *)phoneNumberTextField {
    
    CAL_GET_METHOD_RETURN_OBJC(_phoneNumberTextField);
    
    _phoneNumberTextField               = [UITextField new];
    _phoneNumberTextField.font          = [UIFont systemFontOfSize:14];
    _phoneNumberTextField.textColor     = [UIColor whiteColor];
    _phoneNumberTextField.delegate      = self;
    _phoneNumberTextField.textAlignment = NSTextAlignmentCenter;
    _phoneNumberTextField.keyboardType  = UIKeyboardTypePhonePad;
    
    _phoneNumberTextField.adjustsFontSizeToFitWidth = YES;
    
    return _phoneNumberTextField;
}

#pragma mark - Text Field Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSMutableString *text = [textField.text mutableCopy];
    
    [text replaceCharactersInRange:range withString:string];
    
    if ([text length] > 0) {
        
        self.clearTextFieldButton.hidden = NO;
        
    } else {
        
        self.clearTextFieldButton.hidden = YES;
    }
    
    return [text length] < 12;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([textField.text length] > 0) {
        
        self.clearTextFieldButton.hidden = NO;
        
    } else {
        
        self.clearTextFieldButton.hidden = YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    self.clearTextFieldButton.hidden = YES;
}

#pragma mark - Set Loading View
- (void)stopLoadingView {
    
    self.loadingView.hidden = YES;
    
    [self.loadingView stopAnimating];
    
    self.continueButton.enabled = YES;
}

#pragma mark - Set Activity Indicator View
- (UIActivityIndicatorView *)loadingView {
    
    CAL_GET_METHOD_RETURN_OBJC(_loadingView);
    
    _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    _loadingView.hidden = YES;
    
    return _loadingView;
}

#pragma mark - Set Continue Button
- (UIButton *)continueButton {
    
    CAL_GET_METHOD_RETURN_OBJC(_continueButton);
    
    _continueButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    _continueButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _continueButton.backgroundColor = [UIColor redColor];
    
    [_continueButton setTintColor:CAL_COLOR_FROM_HEX_CODE(0xAAAAAA)];
    [_continueButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_continueButton addTarget:self action:@selector(checkPhoneNumber:) forControlEvents:UIControlEventTouchUpInside];
    
    return _continueButton;
}

- (void)checkPhoneNumber:(UIButton *)sender {
    [sender setEnabled:NO];
    
    [AppDelegate userInfoAppDelegate].userPhoneNumber = self.phoneNumberTextField.text;
    
    if (![self.phoneNumberTextField.text cal_checkAtLeastNumber:11]) {
        
        [self stopLoadingView];
        
        SHOW_ERROR_ALETVIEW(@"请输入11位有效手机号码");
        return;
    }
    
    self.loadingView.hidden = NO;
    
    [self.loadingView startAnimating];
    
    if (self.zzdecoCheckPhoenRequstBlock) {
        self.zzdecoCheckPhoenRequstBlock(self.phoneNumberTextField.text);
    }
}

#pragma mark - Set Clear Text Field Button
- (UIButton *)clearTextFieldButton {
    
    CAL_GET_METHOD_RETURN_OBJC(_clearTextFieldButton);
    
    _clearTextFieldButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    _clearTextFieldButton.hidden = YES;
    
    [_clearTextFieldButton setTintColor:[UIColor grayColor]];
    [_clearTextFieldButton setImage:[UIImage imageNamed:@"button-shutdown-b"] forState:UIControlStateNormal];
    [_clearTextFieldButton setImage:[UIImage imageNamed:@"button-shutdown-b-click"] forState:UIControlStateHighlighted];
    [_clearTextFieldButton addTarget:self action:@selector(clearTextFieldButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return _clearTextFieldButton;
}

- (void)clearTextFieldButton:(UIButton *)sender {
    
    self.phoneNumberTextField.text = @"";
    
    sender.hidden = YES;
}

@end
