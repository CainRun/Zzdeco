//
//  ZzdecoResetPasswordViewModel.m
//  Zzdeco
//
//  Created by Cain on 13/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoChangePasswordViewModel.h"
#import "ZzdecoChangePasswordController.h"
#import "ZzdecoChangePasswordModel.h"

@interface ZzdecoChangePasswordViewModel()

@property (nonatomic, strong) ZzdecoChangePasswordController *changePasswordViewController;

@end

@implementation ZzdecoChangePasswordViewModel

- (instancetype)initChangePasswordViewModel:(UIViewController *)controller {
    
    if (self = [super init]) {
        
        self.changePasswordViewController = (ZzdecoChangePasswordController *)controller;
    }
    
    return self;
}

- (void)changePasswordRequest:(NSDictionary *)parameter {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];

    [sessionManager GET:GET_CHANGE_PASSWORD_ADDRESS
              parameters:parameter
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
                     ZzdecoChangePasswordModel *changePasswordModel = [ZzdecoChangePasswordModel yy_modelWithJSON:responseObject];
                     
                     if (!changePasswordModel.success) {
                         
                         SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                         
                         return;
                     }
                     
                     SHOW_ERROR_ALETVIEW(changePasswordModel.message);
                     
                     [self.changePasswordViewController.navigationController popViewControllerAnimated:YES];
                     
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                             
                     SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                 }];
}

@end
