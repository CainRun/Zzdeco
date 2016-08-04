//
//  ZzdecoRestPhoneNumerViewController.m
//  Zzdeco
//
//  Created by Cain on 5/12/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoChangePhoneNumerController.h"
#import "ZzdecoChangePhoneViewModel.h"

@interface ZzdecoChangePhoneNumerController() <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *oldPhoneVerificationCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *changePhoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *changePhoneVerificationCodeTextField;

@property (weak, nonatomic) IBOutlet UIButton *getOldPhoneVerificationCode;
@property (weak, nonatomic) IBOutlet UIButton *getNewPhoneVerificationCode;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (nonatomic, strong) NSTimer     *timer;
@property (nonatomic, strong) UIAlertView *alertView;

@property (nonatomic, assign) NSInteger zeroCount;

@property (nonatomic, strong) CALBaseControllerTitleView *titleView;

@property (nonatomic, strong) ZzdecoChangePhoneViewModel *changePhoneViewModel;;

@end

@implementation ZzdecoChangePhoneNumerController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.phoneLabel.text = CAL_USER_PHONER_NUMBER;
    
    [self.view addSubview:self.titleView];
    [self addConstraints];
    [self setTitleViewButtonActionBlock];
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
    
    _titleView                = [CALBaseControllerTitleView new];
    
    _titleView.backgroundColor            = CAL_COLOR_FROM_HEX_CODE(0x3c3c3c);
    _titleView.titleViewTitle             = @"变更手机";
    _titleView.titleStyle                 = CALBaseControllerTitleViewCenterStyle;
    _titleView.titleTextColor             = [UIColor whiteColor];

    return _titleView;
}

- (void)setTitleViewButtonActionBlock {
    
    CAL_WEAK_SELF(ws);
    
    [self.titleView setCalControllerTitleViewLeftBlock:^(UIButton *leftButton) {
        
        [ws.navigationController popViewControllerAnimated:YES];
    }];
}

- (IBAction)getVerificationCode:(UIButton *)sender {
    
    [sender setEnabled:false];
    [sender setTitle:@"60秒" forState:UIControlStateNormal];
    
    self.zeroCount  = 60;
    
    if (sender.tag == 0) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                                      target:self
                                                    selector:@selector(changeOldGetVerificationButtonTitle)
                                                    userInfo:nil
                                                     repeats:true];
        
        NSDictionary *parameters = @{@"mobile" : CAL_USER_PHONER_NUMBER};
        
        [self.changePhoneViewModel getVerificationCodeRequest:parameters];
        
    } else {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                                      target:self
                                                    selector:@selector(changeNewGetVerificationButtonTitle)
                                                    userInfo:nil
                                                     repeats:true];
        
        NSDictionary *parameters = @{@"mobile" : self.changePhoneNumberTextField.text};
        
        [self.changePhoneViewModel getVerificationCodeRequest:parameters];
    }
}

- (IBAction)completeButtonAction:(UIButton *)sender {
    [self.view endEditing:YES];
    
    [self checkNumberPhone];
}

#pragma mark - Change Count Down
- (void)changeOldGetVerificationButtonTitle {
    
    self.zeroCount--;
    
    [self.getOldPhoneVerificationCode setTitle:[NSString stringWithFormat:@"%ld秒", (long)self.zeroCount]
                                    forState:UIControlStateNormal];
    
    if (self.zeroCount < 0) {
        
        [self.timer invalidate];
        
        [self.getOldPhoneVerificationCode setEnabled:YES];
        [self.getOldPhoneVerificationCode setTitle:@"点击获取"
                                        forState:UIControlStateNormal];
    }
}

- (void)changeNewGetVerificationButtonTitle {
    
    self.zeroCount--;
    
    [self.getNewPhoneVerificationCode setTitle:[NSString stringWithFormat:@"%ld秒", (long)self.zeroCount]
                                      forState:UIControlStateNormal];
    
    if (self.zeroCount < 0) {
        
        [self.timer invalidate];
        
        [self.getNewPhoneVerificationCode setEnabled:YES];
        [self.getNewPhoneVerificationCode setTitle:@"点击获取"
                                          forState:UIControlStateNormal];
    }
}

#pragma mark - Check Method
- (void)checkNumberPhone {
        
    if ([self.changePhoneNumberTextField.text isEqualToString:CAL_USER_PHONER_NUMBER]) {
        
        self.alertView.message = @"您所输入的手机号与当前相同";
        [self.alertView show];
        
        return;
    }
    
    if (![self.changePhoneNumberTextField.text cal_checkAtLeastNumber:11]) {

        self.alertView.message = @"请输入正确的手机号码";
        [self.alertView show];
        
        return;
    }
    
    [self checkOldVerificationCode];
}

- (void)checkOldVerificationCode {
    
    if ([self.oldPhoneVerificationCodeTextField.text isEqual: @""] || [self.changePhoneVerificationCodeTextField.text isEqual: @""]) {
        
        self.alertView.message = @"您还未输入验证码";
        [self.alertView show];
        
        return;
    }
    
    NSDictionary *parameters = @{@"oldPhone" : CAL_USER_PHONER_NUMBER,
                                 @"oldverifyCode" : self.oldPhoneVerificationCodeTextField.text,
                                 @"newPhone" : self.changePhoneNumberTextField.text,
                                 @"newverifyCode": self.changePhoneVerificationCodeTextField.text};
    
    [self.changePhoneViewModel changePhoneRequest:parameters];
}

#pragma mark - Text Field Delegate Method
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSMutableString *text = [textField.text mutableCopy];
    
    [text replaceCharactersInRange:range withString:string];

    if (textField.tag == 0) {
        
        return [text length] < 5;
    }
    
    return [text length] < 12;
}

#pragma mark - Set Alert View
- (UIAlertView *)alertView {
    
    CAL_GET_METHOD_RETURN_OBJC(_alertView);
    
    _alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                            message:@""
                                           delegate:nil
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil, nil];
    
    return _alertView;
}

- (ZzdecoChangePhoneViewModel *)changePhoneViewModel {
    
    CAL_GET_METHOD_RETURN_OBJC(_changePhoneViewModel);
    
    _changePhoneViewModel = [[ZzdecoChangePhoneViewModel alloc] initChangePhoneViewModelWhithController:self];
    
    return _changePhoneViewModel;
}

@end
