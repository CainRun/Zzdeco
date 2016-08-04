//
//  ZzdecoViewModel.m
//  Zzdeco
//
//  Created by Cain on 14/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoUserInfoViewModel.h"
#import "ZzdecoUserInfoController.h"
#import "ZzdecoUserInfoModel.h"
#import "ZzdecoPasswordStateModel.h"
#import "ZzdecoLoginOutMdeol.h"
#import "ZzdecoUserInfoResultModel.h"
#import "ZzdecoChangeHeaderModel.h"
#import "ZzdecoChangeUserNameModel.h"

@interface ZzdecoUserInfoViewModel()

@property (nonatomic, strong) ZzdecoUserInfoController *userInfoViewController;

@end

@implementation ZzdecoUserInfoViewModel

- (instancetype)initViewModelWithController:(UIViewController *)controller {
    
    if (self = [super init]) {
        
        self.userInfoViewController = (ZzdecoUserInfoController *)controller;
    }
    
    return self;
}

- (void)loginOutRequest:(NSInteger)loginOutTag {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager GET:GET_LOGOUT_ADDRESS
              parameters:nil
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     
                     ZzdecoLoginOutMdeol *loginOutModel = [ZzdecoLoginOutMdeol yy_modelWithJSON:responseObject];

                     if (!loginOutModel.success) {
                         
                         if (loginOutTag == 1) {
                             SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                         }

                         return;
                     }
                     
                     [AppDelegate userInfoAppDelegate].loginStatus = CAL_LOGIN_STATUS_INIT;
                     
                     [self.userInfoViewController.navigationController popToRootViewControllerAnimated:YES];
                     
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     
                     if (loginOutTag == 1) {
                         SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                     }
                 }];
}

- (void)getPasswordState {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager GET:GET_PASSWORD_SAFETY_ADDRESS
             parameters:nil
               progress:nil
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    ZzdecoPasswordStateModel *passwordStateModel = [ZzdecoPasswordStateModel yy_modelWithJSON:responseObject];
                    
                    if (!passwordStateModel.success) {
                        
                        return;
                    }
                    
                    [self.userInfoViewController getPasswordDactyl:passwordStateModel.result];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                }];
}

- (void)getUserInfo {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager GET:GET_USER_INFO_ADDRESS
             parameters:nil
               progress:nil
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    ZzdecoUserInfoModel *userInfoModel = [ZzdecoUserInfoModel yy_modelWithJSON:responseObject];

                    if (!userInfoModel.success) {
                        
                        return;
                    }
                    
                    if (userInfoModel.result) {
                        
                        self.userInfoViewController.restultModel = userInfoModel.result;
                        
                        [self.userInfoViewController.userInfoTableView reloadData];
                    }
                    
                    [AppDelegate userInfoAppDelegate].userName = userInfoModel.result.userName;
                    [AppDelegate userInfoAppDelegate].userID = userInfoModel.result.userId;

                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

                    SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                }];
}

- (void)uploadHeder:(UIImage *)uploadImage {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    NSData *imageData = UIImageJPEGRepresentation(uploadImage, 0.5);

    NSNumber *userID = [NSNumber numberWithInteger:CAL_USER_ID];
    
    NSDictionary *parameter = @{@"userId" : userID};
    
    [sessionManager POST:GET_UP_HEADER_ADDRESS parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];

        [formData appendPartWithFileData:imageData name:@"Filedata" fileName:fileName mimeType:@"image/png"];
        
                } progress:nil
                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
                       ZzdecoChangeHeaderModel *changeHeaderModel = [ZzdecoChangeHeaderModel yy_modelWithJSON:responseObject];
                       
                       if (!changeHeaderModel.success) {
                           
                           SHOW_ERROR_ALETVIEW(@"头像上传失败, 请稍后重试");
                           
                           return;
                       }
                       
                       [self setUserHader:changeHeaderModel.data.fileName];

                   } failure:nil];
}

- (void)setUserHader:(NSString *)headerName {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager POST:GET_NAME_HEADER_ADDRESS
             parameters:@{@"authPhoto" : headerName}
               progress:nil
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
                    ZzdecoChangeUserNameModel *restUserNameModel = [ZzdecoChangeUserNameModel yy_modelWithJSON:responseObject];

                    if (!restUserNameModel.success) {
                        
                        SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                        return;
                    }
                    
                    SHOW_ERROR_ALETVIEW(restUserNameModel.message);
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    SHOW_ERROR_ALETVIEW(@"头像上传失败, 请稍后重试");
                }];
}

@end
