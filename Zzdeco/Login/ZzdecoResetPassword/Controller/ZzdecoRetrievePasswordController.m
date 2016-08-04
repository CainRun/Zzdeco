//
//  ZzdecoRetrievePasswordViewController.m
//  Zzdeco
//
//  Created by Cain on 5/6/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoRetrievePasswordController.h"
#import "ZzdecoRetrievePasswordViewModel.h"

@interface ZzdecoRetrievePasswordController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet KLSwitch *showPassword;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *completeButton;
@property (weak, nonatomic) IBOutlet UIButton *clearPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *clearVerificationCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *getVerificationCodeButton;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@property (nonatomic, strong) FXBlurView *blurView;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger zeroCount;

@property (nonatomic, strong) CALBaseControllerTitleView *titleView;

@property (nonatomic, strong) ZzdecoRetrievePasswordViewModel *retrievePasswordViewModel;

@end

@implementation ZzdecoRetrievePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hidePassword];
    
    [self.view addSubview:self.titleView];
    [self.loadingView setHidden:YES];
    
    if (CAL_USER_PHONER_NUMBER) {
        
        self.phoneNumberLabel.text = CAL_USER_PHONER_NUMBER;
    }
    
    self.isDimiss = YES;
    
    [self.backgroundImageView addSubview:self.blurView];
    [self.backgroundImageView setImageWithURL:BACKGROUND_IMAGE_URL];
    
    [self setTitleViewButtonActionBlock];
}

#pragma mark - Set Title View
- (CALBaseControllerTitleView *)titleView {
    
    CAL_GET_METHOD_RETURN_OBJC(_titleView);
    
    _titleView = [CALBaseControllerTitleView new];
    
    _titleView.titleViewTitle             = @"重置密码";
    _titleView.leftButtonImage            = [UIImage imageNamed:@"button-return"];
    _titleView.leftButtonHighlightedImage = [UIImage imageNamed:@"button-return-click"];

    return _titleView;
}

- (void)setTitleViewButtonActionBlock {
    
    CAL_WEAK_SELF(weakSelf);
    
    [self.titleView setCalControllerTitleViewLeftBlock:^(UIButton *leftButton) {
        
        if (weakSelf.isDimiss) {
            
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark - Set Done Rest Button
- (IBAction)doneResetButton:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if ([self.verificationCodeTextField.text length] < 4) {
        
        SHOW_ERROR_ALETVIEW(@"请输入至少4位的有效的验证码");
        
        return;
    }
    
    if (![self.verificationCodeTextField.text isEqualToString:CAL_VERIFICATION_CODE]) {
        
        SHOW_ERROR_ALETVIEW(@"您输入的验证码有误, 请重新输入");
        
        return;
    }

    if ([self.passwordTextField.text length] < 6) {
        
        SHOW_ERROR_ALETVIEW(@"请输入至少6位的有效密码");
        
        return;
    }
    
    [sender setEnabled:NO];
    [self.loadingView setHidden:NO];
    [self.loadingView startAnimating];

    [self.retrievePasswordViewModel retrievePasswordRequst:@{@"verifyCode" : self.verificationCodeTextField.text,
                                                             @"loginPassword" : self.passwordTextField.text}];
}

#pragma mark - Set Show Password Switch
- (void)hidePassword {
    
    [self.showPassword setOnTintColor:[UIColor whiteColor]];
    [self.showPassword setContrastColor:[UIColor clearColor]];
    
    [self.showPassword setOn: YES
                    animated: YES];
    [self.showPassword setDidChangeHandler:^(BOOL isOn) {
        
        if (self.passwordTextField.secureTextEntry) {
            
            self.passwordTextField.secureTextEntry = NO;
            
            return;
        }
        
        self.passwordTextField.secureTextEntry = YES;
    }];
}

#pragma mark - Text Field Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSMutableString *text = [textField.text mutableCopy];
    
    [text replaceCharactersInRange:range withString:string];
    
    if (textField.tag == 0 && [textField.text length] > 0) {
        
            self.clearVerificationCodeButton.hidden = NO;
        
    } else if (textField.tag == 1 && [textField.text length] > 0) {
        
            self.clearPasswordButton.hidden = NO;
    }
    
    return textField.tag == 0 ? [text length] < 5 : [text length] < 19;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    switch (textField.tag) {
        case 1:
            
            if ([textField.text length] > 0) {
                
                self.clearPasswordButton.hidden = NO;
                
            } else {
                
                self.clearPasswordButton.hidden = YES;
            }
            break;
        default:
            
            if ([textField.text length] > 0) {
                
                self.clearVerificationCodeButton.hidden = NO;
                
            } else {
                
                self.clearVerificationCodeButton.hidden = YES;
            }
            break;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    self.clearPasswordButton.hidden = YES;
    self.clearVerificationCodeButton.hidden = YES;
}

#pragma mark - Button Actions
- (IBAction)clearButton:(UIButton *)sender {
    
    if (sender.tag == 0) {
        
        self.verificationCodeTextField.text     = @"";
        self.clearVerificationCodeButton.hidden = YES;
    } else{
        
        self.passwordTextField.text     = @"";
        self.clearPasswordButton.hidden = YES;
    }
}

#pragma mark - Set Get Verfication Code Button
- (IBAction)getVerificationCode:(UIButton *)sender {
    
    [sender setEnabled:false];
    [sender setTitle:@"60秒" forState:UIControlStateNormal];
    
    self.zeroCount  = 60;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                                  target:self
                                                selector:@selector(changeGetVerificationButtonTitle)
                                                userInfo:nil
                                                 repeats:true];

    [self.retrievePasswordViewModel getVerificationCode];
}

#pragma mark - Change Countdown
- (void)changeGetVerificationButtonTitle {
    
    self.zeroCount--;
    
    [self.getVerificationCodeButton setTitle:[NSString stringWithFormat:@"%ld秒", (long)self.zeroCount]
                                    forState:UIControlStateNormal];
    
    if (self.zeroCount < 0) {
        
        [self.timer invalidate];
        
        [self.getVerificationCodeButton setEnabled:YES];
        [self.getVerificationCodeButton setTitle:@"获取"
                                        forState:UIControlStateNormal];
    }
}

- (ZzdecoRetrievePasswordViewModel *)retrievePasswordViewModel {
    
    CAL_GET_METHOD_RETURN_OBJC(_retrievePasswordViewModel);
    
    _retrievePasswordViewModel = [[ZzdecoRetrievePasswordViewModel alloc] initRetrievePasswordViewModel:self];
    
    return _retrievePasswordViewModel;
}

#pragma mark - Set Loading View
- (void)stopLoadingView {
    
    self.loadingView.hidden = YES;
    
    [self.loadingView stopAnimating];
    
    self.completeButton.enabled = YES;
}

#pragma mark - Set blur View
- (FXBlurView *)blurView {
    
    CAL_GET_METHOD_RETURN_OBJC(_blurView);
    
    _blurView = [[FXBlurView alloc] init];
    
    _blurView.frame      = self.backgroundImageView.frame;
    _blurView.dynamic    = YES;
    _blurView.tintColor  = [UIColor blackColor];
    _blurView.blurRadius = 10.f;
    
    return _blurView;
}

@end
