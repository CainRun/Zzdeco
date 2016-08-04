//
//  ZzdecoLoginViewModel.m
//  Zzdeco
//
//  Created by Cain on 27/5/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoCheckPhoneViewModel.h"
#import "ZzdecoCheckPhoneController.h"
#import "ZzdecoCheckPhoneNumberModel.h"

@interface ZzdecoCheckPhoneViewModel()

@property (nonatomic, strong) ZzdecoCheckPhoneController *checkPhoneController;

@end

@implementation ZzdecoCheckPhoneViewModel

- (instancetype)initCheckViewModel:(UIViewController *)controller {
    
    if (self = [super init]) {
        
        self.checkPhoneController = (ZzdecoCheckPhoneController *)controller;
    }
    
   
    return self;
}

- (void)checkPhoneNumberRequst:(NSDictionary *)parameters {
    
    NSLog(@"%d", CAL_LOGIN_SUCCESS);
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager GET:CHECK_PHONE parameters:parameters
               progress:nil
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    [self.checkPhoneController stopLoadingView];
                    
                    ZzdecoCheckPhoneNumberModel *model = [ZzdecoCheckPhoneNumberModel yy_modelWithJSON:responseObject];
                            
                    if (model.success != 1) {
                        
                        SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                        
                        return;
                    }
                    
                    [AppDelegate userInfoAppDelegate].userPhoneNumber = [parameters objectForKey:@"phone"];

                    if ([model.message isEqualToString:@"login"]) {
                        
                        UIStoryboard *board    = [UIStoryboard storyboardWithName:@"CALLoginRegister" bundle:nil];
                        UIViewController *viewController = [board instantiateViewControllerWithIdentifier:@"calPasswordViewController"];
                        
                        [self.checkPhoneController.navigationController pushViewController:viewController animated:YES];

                    } else if ([model.message isEqualToString:@"sign"]) {
                        
                        UIStoryboard *board    = [UIStoryboard storyboardWithName:@"CALLoginRegister" bundle:nil];
                        UIViewController *viewController = [board instantiateViewControllerWithIdentifier:@"calRegisterViewController"];
                    
                        [self.checkPhoneController.navigationController pushViewController:viewController animated:YES];
                    }

                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    [self.checkPhoneController stopLoadingView];
                    
                    SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                }];
}

@end
