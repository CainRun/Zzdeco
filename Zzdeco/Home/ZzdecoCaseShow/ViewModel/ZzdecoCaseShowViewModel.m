//
//  ZzdecoCaseShowViewModel.m
//  Zzdeco
//
//  Created by Cain on 10/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoCaseShowViewModel.h"
#import "ZzdecoCaseShowViewController.h"
#import "ZzdecoCaseShowModel.h"
#import "ZzdecoCaseCollectionModel.h"

@interface ZzdecoCaseShowViewModel()

@property (nonatomic, strong) ZzdecoCaseShowViewController *caseInfoCollectionController;

@end

@implementation ZzdecoCaseShowViewModel

- (instancetype)initCaseInfoViewModel:(UIViewController *)controller {
    
    if (self = [super init]) {
        
        self.caseInfoCollectionController = (ZzdecoCaseShowViewController *)controller;
    }
    
    return self;
}

- (void)setCaseID:(NSString *)caseID {
    _caseID = caseID;
}

- (void)caseShowRequest {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{@"projectId" : self.caseID,
                                 @"pageSize" : @"1000",
                                 @"currentPage" : @"1"};

    [sessionManager POST:GET_CASE_IMAGES_ADDRESS
              parameters:parameters
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     
                     ZzdecoCaseShowModel *caseShowModel = [ZzdecoCaseShowModel yy_modelWithJSON:responseObject];
                     
                     if (caseShowModel.message.length > 0) {
                         
                         SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                         
                         return;
                     }
                     
                     for (NSInteger i = 0; i < caseShowModel.resultMap.pageBean.dataList.count; i++) {
                         
                         [self.caseInfoCollectionController.showImageView.imageArray addObject:caseShowModel.resultMap.pageBean.dataList[i]];
                     }
                     
                     self.caseInfoCollectionController.subTitleView.isAcstate = caseShowModel.resultMap.acstate;
                     
                     [self.caseInfoCollectionController.showImageView.imageTableView reloadData];
                     
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     
                     SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                 }];
}

- (void)collectionCase:(NSDictionary *)parameters {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager GET:GET_CASE_COLLECTION_ADDRESS
             parameters:parameters
               progress:nil
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

                    ZzdecoCaseCollectionModel *caseCollectionModel = [ZzdecoCaseCollectionModel yy_modelWithJSON:responseObject];
                    
                    if (!caseCollectionModel.success) {
                        
                        SHOW_ERROR_ALETVIEW(caseCollectionModel.message);
                        
                        return;
                    }
                    
                    self.caseInfoCollectionController.subTitleView.isAcstate = !self.caseInfoCollectionController.subTitleView.isAcstate;
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
                    SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                }];
}

@end
