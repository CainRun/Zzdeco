//
//  ZzdecoRegisterSuccessViewController.m
//  Zzdeco
//
//  Created by Cain on 5/5/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoRegisterSuccessViewController.h"
#import "ZzdecoRetrievePasswordController.h"

@interface ZzdecoRegisterSuccessViewController()

@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (nonatomic, strong) FXBlurView *blurView;

@property (nonatomic, strong) CALBaseControllerTitleView *titleView;

@end

@implementation ZzdecoRegisterSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *tipsLabelString = @"初始登陆密码已通过短信发送至您的手机，为了您的账号安全, 请尽快修改。";
    NSRange range = NSMakeRange(tipsLabelString.length - 6, 5);
    
    [self.tipsLabel setAttributedText:[NSAttributedString cal_attributedStringAddLine:tipsLabelString range:range]];
    
    [self.view addSubview:self.titleView];

    [self.backgroundImageView addSubview:self.blurView];
    [self.backgroundImageView setImageWithURL:BACKGROUND_IMAGE_URL];

    [self setTitleViewButtonActionBlock];
}

#pragma mark - Set Title View
- (CALBaseControllerTitleView *)titleView {
    
    CAL_GET_METHOD_RETURN_OBJC(_titleView);
    
    _titleView = [CALBaseControllerTitleView new];
    
    _titleView.titleViewTitle             = @"重置密码";
    _titleView.leftButtonImage            = [UIImage imageNamed:@"button-menu"];
    _titleView.leftButtonHighlightedImage = [UIImage imageNamed:@"button-menu-click"];
    
    return _titleView;
}

- (void)setTitleViewButtonActionBlock {
    
    CAL_WEAK_SELF(ws);
    
    [self.titleView setCalControllerTitleViewLeftBlock:^(UIButton *leftButton) {
        
        [ws.navigationController popToRootViewControllerAnimated:YES];
    }];
}

#pragma mark - Set Success Register Button
- (IBAction)successRegisterButton:(UIButton *)sender {
    
    [AppDelegate userInfoAppDelegate].loginStatus = CAL_LOGIN_STATUS_SUCCESS;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Set Reset Password Button
- (IBAction)resetPasswordButton:(UIButton *)sender {
    
    UIStoryboard *board              = [UIStoryboard storyboardWithName:@"CALLoginRegister" bundle:nil];
    ZzdecoRetrievePasswordController *viewController = (ZzdecoRetrievePasswordController *)[board instantiateViewControllerWithIdentifier:@"calRetrievePasswordViewController"];
    viewController.isDimiss = NO;

    [self.navigationController pushViewController:viewController animated:YES];
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
