//
//  ZzdecoChangePhoneViewModel.m
//  Zzdeco
//
//  Created by Cain on 19/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoChangePhoneViewModel.h"
#import "ZzdecoChangePhoneModel.h"
#import "ZzdecoGetChangePhoneVerificationModel.h"
#import "ZzdecoChangePhoneNumerController.h"

@interface ZzdecoChangePhoneViewModel()

@property (nonatomic, strong) ZzdecoChangePhoneNumerController *restPhoneNumerViewController;

@end

@implementation ZzdecoChangePhoneViewModel

- (instancetype)initChangePhoneViewModelWhithController:(UIViewController *)controller {
    
    if (self = [super init]) {
        
        self.restPhoneNumerViewController = (ZzdecoChangePhoneNumerController *)controller;
    }
    
    return self;
}

- (void)changePhoneRequest:(NSDictionary *)parameters {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];

    [sessionManager GET:GET_CHANGE_PHONE_ADDRESS
             parameters:parameters
               progress:nil
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
                    ZzdecoChangePhoneModel *changePhoneModel = [ZzdecoChangePhoneModel yy_modelWithJSON:responseObject];
                    
                    if (!changePhoneModel.success) {
                        
                        SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                        
                        return;
                    }
                    
                    NSLog(@"%@", changePhoneModel);
    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
                    SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                }];
}

- (void)getVerificationCodeRequest:(NSDictionary *)parameters {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager GET:GET_CHANGE_PHONE_VERIFICATION_CODE
             parameters:parameters
               progress:nil
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    ZzdecoGetChangePhoneVerificationModel *getChangePhoneVerificationModel = [ZzdecoGetChangePhoneVerificationModel yy_modelWithJSON:responseObject];
                    
                    if (!getChangePhoneVerificationModel.success) {
                        
                        [AppDelegate userInfoAppDelegate].verificationCode = @"";
                        
                        return;
                    }
                    
                    [AppDelegate userInfoAppDelegate].verificationCode = getChangePhoneVerificationModel.message;
                    
                    NSLog(@"验证码为: %@", getChangePhoneVerificationModel.message);
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    [AppDelegate userInfoAppDelegate].verificationCode = @"";
                    
                    SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                }];
}

@end
