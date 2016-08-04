//
//  ZzdecoLoginViewController.m
//  Zzdeco
//
//  Created by Cain on 5/4/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoCheckPhoneController.h"
#import "ZzdecoLoginViewController.h"
#import "ZzdecoCheckPhoneViewModel.h"

@interface ZzdecoCheckPhoneController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIButton *clearTextFieldButton;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (nonatomic, strong) FXBlurView *blurView;

@property (nonatomic, strong) CALBaseControllerTitleView *titleView;

@property (nonatomic, strong) ZzdecoCheckPhoneViewModel *checkPhoneViewModel;

@end

@implementation ZzdecoCheckPhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginPopToRootViewController) name:@"LoginPopToRootViewController" object:nil];
    
    [self setContinueButton];
    [self setTitleViewButtonActionBlock];

    self.loadingView.hidden = YES;
    
    [self.backgroundImageView addSubview:self.blurView];
    [self.backgroundImageView setImageWithURL:BACKGROUND_IMAGE_URL];
    
    [self.view addSubview:self.titleView];
}

#pragma mark - Set TitleView
- (CALBaseControllerTitleView *)titleView {
    
    CAL_GET_METHOD_RETURN_OBJC(_titleView);
    
    _titleView                = [CALBaseControllerTitleView new];
    _titleView.titleViewTitle = @"登录注册";
    
    _titleView.leftButtonImage            = [UIImage imageNamed:@"button-close"];
    _titleView.leftButtonHighlightedImage = [UIImage imageNamed:@"button-close-click"];
    
    return _titleView;
}

- (void)setTitleViewButtonActionBlock {
    
    CAL_WEAK_SELF(ws);
    
    [self.titleView setCalControllerTitleViewLeftBlock:^(UIButton *leftButton) {
        
        [ws.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - Pop To Root View Controller
- (void)loginPopToRootViewController {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Set Continue Button
- (void)setContinueButton {
    
    self.continueButton.layer.masksToBounds = YES;
    self.continueButton.layer.borderColor   = CAL_COLOR_FROM_HEX_CODE(0xAAAAAA).CGColor;
}

- (IBAction)nextButton:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if (![self.phoneNumberTextField.text cal_checkAtLeastNumber:11]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                            message:@"请输入11位有效手机号码"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        
        return;
    }
    
    self.loadingView.hidden = NO;
    
    [sender setEnabled:NO];
    
    [self.loadingView startAnimating];

    [self.checkPhoneViewModel checkPhoneNumberRequst:@{@"phone" : self.phoneNumberTextField.text}];
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

- (IBAction)clearTextFieldButton:(UIButton *)sender {
    
    self.phoneNumberTextField.text = @"";
    
    sender.hidden = YES;
}

#pragma mark - Remove Observer
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:@"LoginPopToRootViewController"];
}

#pragma mark - Set Login View Model
- (ZzdecoCheckPhoneViewModel *)checkPhoneViewModel {
    
    CAL_GET_METHOD_RETURN_OBJC(_checkPhoneViewModel);
    
    _checkPhoneViewModel = [[ZzdecoCheckPhoneViewModel alloc] initCheckViewModel:self];
    
    return _checkPhoneViewModel;
}

#pragma mark - Set Loading View
- (void)stopLoadingView {
    
    self.loadingView.hidden = YES;
    
    [self.loadingView stopAnimating];
    
    self.continueButton.enabled = YES;
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
