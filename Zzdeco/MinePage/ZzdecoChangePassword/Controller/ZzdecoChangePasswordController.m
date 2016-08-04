//
//  ZzdecoResetPasswordViewController.m
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoChangePasswordController.h"
#import "ZzdecoChangePasswordViewModel.h"
#import "ZzdecoRetrievePasswordController.h"

@interface ZzdecoChangePasswordController() <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *resetPasswordTextField;

@property (nonatomic, strong) CALBaseControllerTitleView *titleView;

@property (nonatomic, strong) ZzdecoChangePasswordViewModel *changePasswordViewModel;

@property (nonatomic, strong) UIAlertView *alertView;

@end

@implementation ZzdecoChangePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleView];
    
    [self setTitleViewButtonActionBlock];
    [self addConstraints];
}

- (void)addConstraints {
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        (void)make.left.top.right;
        make.width.mas_equalTo(CAL_SCREEN_WIDTH);
        make.height.mas_equalTo(64);
    }];
}

- (CALBaseControllerTitleView *)titleView {
    
    CAL_GET_METHOD_RETURN_OBJC(_titleView);

    _titleView                 = [CALBaseControllerTitleView new];
    _titleView.backgroundColor = CAL_COLOR_FROM_HEX_CODE(0x3c3c3c);
    _titleView.titleViewTitle  = @"修改登陆密码";
    _titleView.titleStyle      = CALBaseControllerTitleViewCenterStyle;
    _titleView.titleTextColor  = [UIColor whiteColor];
    
    return _titleView;
}

- (void)setTitleViewButtonActionBlock {
    
    CAL_WEAK_SELF(ws);
    
    [self.titleView setCalControllerTitleViewLeftBlock:^(UIButton *leftButton) {
        
        [ws.navigationController popViewControllerAnimated:YES];
    }];
}

- (IBAction)showPassword:(UISwitch *)sender {
    
    if (sender.on) {
        
        self.passwordTextField.secureTextEntry      = YES;
        self.resetPasswordTextField.secureTextEntry = YES;
        
    } else {
        
        self.passwordTextField.secureTextEntry      = NO;
        self.resetPasswordTextField.secureTextEntry = NO;
    }
}

#pragma mark - Text Field Delegate Method
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSMutableString *text = [textField.text mutableCopy];
    
    [text replaceCharactersInRange:range withString:string];
    
    return [text length] < 19;
}

#pragma mark - Complete Button Action
- (IBAction)completeButton:(UIButton *)sender {
    
    NSLog(@"%@", CAL_USER_PASSWORD);
    
    if (![self.passwordTextField.text isEqualToString:CAL_USER_PASSWORD]) {
        
        self.alertView.message = @"您所输入的原密码有误";
        [self.alertView show];
        
        return;
    }
    
    if ([self.resetPasswordTextField.text isEqualToString:self.passwordTextField.text]) {
        
        self.alertView.message = @"您所输入的密码与旧密码相同";
        [self.alertView show];
        
        return;
    }
    
    if (!self.resetPasswordTextField.text.length) {
        
        self.alertView.message = @"请您输入新密码";
        [self.alertView show];
        
        return;
    }
    
    if (![self.resetPasswordTextField.text cal_checkAtLeastNumber:8]) {
        
        self.alertView.message = @"请您输入至少8位的有效密码";
        [self.alertView show];
        
        return;
    }
    
    [self changePassword];
}

#pragma mark - Change Password
- (void)changePassword {

    NSDictionary *parameter = @{@"oldPassword" : self.passwordTextField.text,
                                @"newPassword" : self.resetPasswordTextField.text};
    
    [self.changePasswordViewModel changePasswordRequest:parameter];
}

#pragma mark - Set UIAlertView
- (UIAlertView *)alertView {
    CAL_GET_METHOD_RETURN_OBJC(_alertView);
    
    _alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                            message:@""
                                           delegate:nil
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil, nil];

    return _alertView;
}

- (ZzdecoChangePasswordViewModel *)changePasswordViewModel {
    
    CAL_GET_METHOD_RETURN_OBJC(_changePasswordViewModel);
    
    _changePasswordViewModel = [[ZzdecoChangePasswordViewModel alloc] initChangePasswordViewModel:self];
    
    return _changePasswordViewModel;
}

- (IBAction)forgotPassword:(UIButton *)sender {
    
    UIStoryboard *board              = [UIStoryboard storyboardWithName:@"CALLoginRegister" bundle:nil];
    ZzdecoRetrievePasswordController *viewController = (ZzdecoRetrievePasswordController *)[board instantiateViewControllerWithIdentifier:@"zzdecoRetrievePasswordController"];
    viewController.isDimiss = YES;
    
    [self presentViewController:viewController animated:YES completion:nil];
}

@end
