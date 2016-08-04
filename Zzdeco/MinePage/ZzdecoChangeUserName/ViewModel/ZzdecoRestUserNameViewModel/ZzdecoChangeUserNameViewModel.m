//
//  ZzdecoRestUserNameViewModel.m
//  Zzdeco
//
//  Created by Cain on 18/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoChangeUserNameViewModel.h"
#import "ZzdecoChangeUserNameController.h"
#import "ZzdecoChangeUserNameModel.h"

@interface ZzdecoChangeUserNameViewModel() <UIAlertViewDelegate>

@property (nonatomic, strong) ZzdecoChangeUserNameController *changeUserNameViewController;

@end

@implementation ZzdecoChangeUserNameViewModel

- (instancetype)initRestUserNameViewModelWithController:(UIViewController *)controller {
    
    if (self = [super init]) {
        
        self.changeUserNameViewController = (ZzdecoChangeUserNameController *)controller;
    }
    
    return self;
}

- (void)restUserNameRequest:(NSString *)userName {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];

    [sessionManager POST:GET_NAME_HEADER_ADDRESS
              parameters:@{@"userName" : userName}
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
                     ZzdecoChangeUserNameModel *restUserNameModel = [ZzdecoChangeUserNameModel yy_modelWithJSON:responseObject];
                     
                     if (!restUserNameModel.success) {
                         
                         SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                         return;
                     }
                     
                     SHOW_ERROR_ALETVIEW(restUserNameModel.message);
                     
                     [AppDelegate userInfoAppDelegate].userName = userName;
                     
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
                     SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                 }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self.changeUserNameViewController.navigationController popViewControllerAnimated:YES];
}

@end
