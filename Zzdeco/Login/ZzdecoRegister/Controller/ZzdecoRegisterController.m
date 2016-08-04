//
//  ZzdecoRegisterViewController.m
//  Zzdeco
//
//  Created by Cain on 5/5/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoRegisterController.h"
#import "ZzdecoRegisterViewModel.h"

@interface ZzdecoRegisterController ()

@property (weak, nonatomic) IBOutlet UIButton *clearTextFieldButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *tickButton;

@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UIButton *getVerificationCodeButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger zeroCount;

@property (nonatomic, copy) NSString *verificationCode;

@property (nonatomic, strong) FXBlurView *blurView;

@property (nonatomic, strong) CALBaseControllerTitleView *titleView;

@property (nonatomic, strong) ZzdecoRegisterViewModel *registerViewModel;

@end

@implementation ZzdecoRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.loadingView setHidden:YES];
    [self setRegisterButton];
    
    [self.view addSubview:self.titleView];
    [self addConstraints];
    [self setTitleViewButtonActionBlock];
    
    [self.backgroundImageView addSubview:self.blurView];
    [self.backgroundImageView setImageWithURL:BACKGROUND_IMAGE_URL];
}

#pragma mark - Set Title View
- (void)addConstraints {
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        (void)make.left.top.right;
        make.width.mas_equalTo(CAL_SCREEN_WIDTH);
        make.height.mas_equalTo(64);
    }];
}

- (CALBaseControllerTitleView *)titleView {
    
    CAL_GET_METHOD_RETURN_OBJC(_titleView);
    
    _titleView = [CALBaseControllerTitleView new];
    
    _titleView.titleViewTitle             = @"登录注册";
    _titleView.leftButtonImage            = [UIImage imageNamed:@"button-return"];
    _titleView.leftButtonHighlightedImage = [UIImage imageNamed:@"button-return-click"];
    
    return _titleView;
}

- (void)setTitleViewButtonActionBlock {
    
    CAL_WEAK_SELF(ws);
    
    [self.titleView setCalControllerTitleViewLeftBlock:^(UIButton *leftButton) {
        
        [ws.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - Set Register Button
- (void)setRegisterButton {
    
    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.layer.borderColor   = CAL_COLOR_FROM_HEX_CODE(0xAAAAAA).CGColor;
}

- (IBAction)registerButton:(UIButton *)sender {
    [self.view endEditing:YES];
    
    [sender setEnabled:NO];
    
    if (![self.verificationCodeTextField.text cal_checkAtLeastNumber:4]) {
        
        SHOW_ERROR_ALETVIEW(@"请输入4位有效验证码");
        
        return;
    }
    
    if (![self.verificationCodeTextField.text isEqualToString:CAL_VERIFICATION_CODE]) {
        
        SHOW_ERROR_ALETVIEW(@"您输入的验证码有误, 请重新输入");
        
        return;
    }
    
    [self.loadingView setHidden:NO];
    [self.loadingView startAnimating];
    
    [self.registerViewModel registerRequst:self.verificationCodeTextField.text];
}

#pragma mark - Set Protocol Button
- (IBAction)protocolButton:(UIButton *)sender {
    
    UIStoryboard *board    = [UIStoryboard storyboardWithName:@"CALLoginRegister" bundle:nil];
    UIViewController *viewController = [board instantiateViewControllerWithIdentifier:@"calProtocolViewController"];
    
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - Text Field Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSMutableString *text = [textField.text mutableCopy];
    
    [text replaceCharactersInRange:range withString:string];
    
    if ([text length] > 0) {
        
        self.clearTextFieldButton.hidden = NO;
        
    } else {
        
        self.clearTextFieldButton.hidden = YES;
    }
    
    return [text length] < 5;
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

#pragma mark - Set UITextField
- (IBAction)clearTextFieldButton:(UIButton *)sender {
    
    self.verificationCodeTextField.text = @"";
    
    sender.hidden = YES;
}

#pragma mark - Set Get Verification Code Button
- (IBAction)getVerificationCode:(UIButton *)sender {
    
    [self.registerViewModel getVerificationCode];
}

- (void)actionCountdown {
    
    [self.getVerificationCodeButton setEnabled:NO];
    [self.getVerificationCodeButton setTitle:@"60秒" forState:UIControlStateNormal];
    
    self.zeroCount  = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                                  target:self
                                                selector:@selector(changeGetVerificationButtonTitle)
                                                userInfo:nil
                                                 repeats:true];
    
    self.verificationCode = @"1234";
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

#pragma mark - Set Register View Model
- (ZzdecoRegisterViewModel *)registerViewModel {
    
    CAL_GET_METHOD_RETURN_OBJC(_registerViewModel);
    
    _registerViewModel = [[ZzdecoRegisterViewModel alloc] initRegisterViewModel:self];
    
    return _registerViewModel;
}

#pragma mark - Set Loading View
- (void)stopLoadingView {
    
    self.loadingView.hidden = YES;
    
    [self.loadingView stopAnimating];
    
    self.registerButton.enabled = YES;
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
