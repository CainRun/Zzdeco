//
//  ZzdecoLoginViewModel.m
//  Zzdeco
//
//  Created by Cain on 27/5/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoLoginViewModel.h"
#import "ZzdecoLoginViewController.h"
#import "ZzdecoLoginModel.h"

@interface ZzdecoLoginViewModel()

@property (nonatomic, strong) ZzdecoLoginViewController *loginViewController;
@property (nonatomic, strong) ZzdecoLoginModel *loginModel;

@end

@implementation ZzdecoLoginViewModel

- (instancetype)initLoginViewModel:(UIViewController *)controller {
    
    if (self = [super init]) {
        
        self.loginViewController = (ZzdecoLoginViewController *)controller;
    }
    
    return self;
}

- (void)loginRequst:(NSDictionary *)parameters {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager GET:LOGIN_ADDRESS parameters:parameters
               progress:nil
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    ZzdecoLoginModel *loginModel = [ZzdecoLoginModel yy_modelWithJSON:responseObject];
                    
                    [self.loginViewController stopLoadingView];
                    
                    if (loginModel.success == 0) {
                        
                        SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                        
                        return;
                    }
                    
                    [AppDelegate userInfoAppDelegate].loginStatus = CAL_LOGIN_STATUS_SUCCESS;
                    [AppDelegate userInfoAppDelegate].userPassword = [parameters objectForKey:@"loginPassword"];
                    
                    [self.loginViewController.navigationController popToRootViewControllerAnimated:YES];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    [self.loginViewController stopLoadingView];

                    SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                }];

}

@end
