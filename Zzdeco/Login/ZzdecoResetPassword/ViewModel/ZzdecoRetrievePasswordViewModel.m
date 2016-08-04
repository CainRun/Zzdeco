//
//  ZzdecoRetrievePasswordViewModel.m
//  Zzdeco
//
//  Created by Cain on 28/5/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoRetrievePasswordViewModel.h"
#import "ZzdecoRetrievePasswordController.h"
#import "ZzdecoRetrievePasswordModel.h"
#import "ZzdecoGetChangePasswordVerificationCodeModel.h"

@interface ZzdecoRetrievePasswordViewModel()

@property (nonatomic, strong) ZzdecoRetrievePasswordController *retrievePasswordController;

@end

@implementation ZzdecoRetrievePasswordViewModel

- (instancetype)initRetrievePasswordViewModel:(UIViewController *)controller {
    
    if (self = [super init]) {
        
        self.retrievePasswordController = (ZzdecoRetrievePasswordController *)controller;
    }
    
    return self;
}

- (void)retrievePasswordRequst:(NSDictionary *)parameters {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager POST:REST_PASSWORD_ADDRESS
              parameters:parameters
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     
                     [self.retrievePasswordController stopLoadingView];
        
                     ZzdecoRetrievePasswordModel *model = [ZzdecoRetrievePasswordModel yy_modelWithJSON:responseObject];
                        
                     if (model.success != 1) {
                            
                         SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                         
                         return;
                     }
                        
                     [self.retrievePasswordController dismissViewControllerAnimated:YES completion:nil];
                     
                     if (self.retrievePasswordController.isDimiss) {
                         
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginPopToRootViewController" object:nil];
                         
                     } else {
                         
                         [self.retrievePasswordController.navigationController popToRootViewControllerAnimated:YES];
                     }

                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        
                     [self.retrievePasswordController stopLoadingView];
                        
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
                     
                     ZzdecoGetChangePasswordVerificationCodeModel *getChangePasswordVerificationCodeModel = [ZzdecoGetChangePasswordVerificationCodeModel yy_modelWithJSON:responseObject];
                     
                     if (!getChangePasswordVerificationCodeModel.success) {
                         
                         [AppDelegate userInfoAppDelegate].verificationCode = @"";
                         
                         return;
                     }
                     
                     [AppDelegate userInfoAppDelegate].verificationCode = getChangePasswordVerificationCodeModel.message;

                     NSLog(@"验证码: %@", getChangePasswordVerificationCodeModel.message);
                     
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     
                     [AppDelegate userInfoAppDelegate].verificationCode = @"";
                     
                     SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                 }];
}

@end
