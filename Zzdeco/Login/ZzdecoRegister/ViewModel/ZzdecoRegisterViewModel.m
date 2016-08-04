//
//  ZzdecoRegisterViewModel.m
//  Zzdeco
//
//  Created by Cain on 27/5/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoRegisterViewModel.h"
#import "ZzdecoRegisterController.h"
#import "ZzdecoRegisterModel.h"
#import "ZzdecoGetVerificationCodeModel.h"

@interface ZzdecoRegisterViewModel()

@property (nonatomic, strong) ZzdecoRegisterController *registerViewController;

@end

@implementation ZzdecoRegisterViewModel

- (instancetype)initRegisterViewModel:(UIViewController *)controller {
    
    if (self = [super init]) {
        
        self.registerViewController = (ZzdecoRegisterController *)controller;
    }
    
    return self;
}

#pragma mark - Register Requst
- (void)registerRequst:(NSString *)verificationCode {
    
    NSDictionary *parameters = @{@"verifyCode" : verificationCode,
                                 @"protocolState" : @"1"};
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager POST:REGISTER_ADDRESS
              parameters:parameters
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                     [self.registerViewController stopLoadingView];
                     
                     ZzdecoRegisterModel *model = [ZzdecoRegisterModel yy_modelWithJSON:responseObject];
        
                     if (model.success != 1) {
                        
                         SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                         return;
                     }
                    
                     UIStoryboard *board              = [UIStoryboard storyboardWithName:@"CALLoginRegister" bundle:nil];
                     UIViewController *viewController = [board instantiateViewControllerWithIdentifier:@"calRegisterSuccessViewController"];
                    
                     [self.registerViewController.navigationController pushViewController:viewController animated:YES];
                    
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                     [self.registerViewController stopLoadingView];
                    
                     SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                 }];
}

#pragma mark - Get Verificaiton Code
- (void)getVerificationCode {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager POST:GET_VERIFICATION_CODE
              parameters:nil
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                     ZzdecoGetVerificationCodeModel *getVerificationCodeModel = [ZzdecoGetVerificationCodeModel yy_modelWithJSON:responseObject];
                     
                     if (!getVerificationCodeModel.success) {
                         
                         [AppDelegate userInfoAppDelegate].verificationCode = @"";
                         
                         return;
                     }
                     
                     NSLog(@"验证码: %@", getVerificationCodeModel.message);
                     
                     [AppDelegate userInfoAppDelegate].verificationCode = getVerificationCodeModel.message;
                     
                     [self.registerViewController actionCountdown];
                     
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   
                   [AppDelegate userInfoAppDelegate].verificationCode = @"";

                   SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
               }];
}

@end
