//
//  ZzdecoPasswordViewController.m
//  Zzdeco
//
//  Created by Cain on 5/5/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoLoginViewController.h"
#import "ZzdecoLoginViewModel.h"

#import "ZzdecoRetrievePasswordController.h"

@interface ZzdecoLoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *clearTextFieldButton;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@property (unsafe_unretained, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet KLSwitch *showPassword;

@property (nonatomic, strong) FXBlurView *blurView;

@property (nonatomic, strong) CALBaseControllerTitleView *titleView;

@property (nonatomic, strong) ZzdecoLoginViewModel *loginViewModel;

@end

@implementation ZzdecoLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLoginButton];
    [self setTitleViewButtonActionBlock];
    [self hidePassword];
    
    self.loadingView.hidden = YES;
    
    [self.view addSubview:self.titleView];
    
    [self.backgroundImageView addSubview:self.blurView];
    [self.backgroundImageView setImageWithURL:BACKGROUND_IMAGE_URL];
}

#pragma mark - Set Title View
- (CALBaseControllerTitleView *)titleView {
    
    CAL_GET_METHOD_RETURN_OBJC(_titleView);
    
    _titleView                = [CALBaseControllerTitleView new];
    _titleView.titleViewTitle = @"登录注册";
    
    _titleView.leftButtonImage            = [UIImage imageNamed:@"button-return"];
    _titleView.leftButtonHighlightedImage = [UIImage imageNamed:@"button-return-click"];
    
    return _titleView;
}

#pragma mark - Login Button
- (void)setLoginButton {
    
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.borderColor   = CAL_COLOR_FROM_HEX_CODE(0xAAAAAA).CGColor;
}

- (void)setTitleViewButtonActionBlock {
    
    CAL_WEAK_SELF(ws);
    
    [self.titleView setCalControllerTitleViewLeftBlock:^(UIButton *leftButton) {
        
        [ws.navigationController popViewControllerAnimated:YES];
    }];    
}

#pragma mark - Button Action
- (IBAction)loginButton:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if ([self.passwordTextField.text length] < 6) {
        
        SHOW_ERROR_ALETVIEW(@"请输入至少6位的有效密码");
        
        return;
    }
    
    [sender setEnabled:NO];
    
    self.loadingView.hidden = NO;

    [self.loadingView startAnimating];
    
    [self.loginViewModel loginRequst:@{@"loginPassword" : self.passwordTextField.text}];
}

#pragma mark - Set Fogot Password Button
- (IBAction)fogotPasswordButton:(UIButton *)sender {
    
    UIStoryboard *board              = [UIStoryboard storyboardWithName:@"CALLoginRegister" bundle:nil];
    ZzdecoRetrievePasswordController *viewController = (ZzdecoRetrievePasswordController *)[board instantiateViewControllerWithIdentifier:@"zzdecoRetrievePasswordController"];
    viewController.isDimiss = YES;

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

    return [text length] < 19;
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
    
    self.passwordTextField.text = @"";
    
    sender.hidden = YES;
}

- (void)hidePassword {
    
    [self.showPassword setOnTintColor:[UIColor clearColor]];
    
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

#pragma mark - Set Login View Model
- (ZzdecoLoginViewModel *)loginViewModel {
    
    CAL_GET_METHOD_RETURN_OBJC(_loginViewModel);
    
    _loginViewModel = [[ZzdecoLoginViewModel alloc] initLoginViewModel:self];
    
    return _loginViewModel;
}

#pragma mark - Set Loading View
- (void)stopLoadingView {
    
    self.loadingView.hidden = YES;
    
    [self.loadingView stopAnimating];
    
    self.loginButton.enabled = YES;
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
