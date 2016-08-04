//
//  ZzdecoCollectionPreviewViewModel.m
//  Zzdeco
//
//  Created by Cain on 26/6/16.
//  Copyright © 2016年 zzdeco. All rights reserved.
//

#import "ZzdecoCollectionPreviewViewModel.h"
#import "ZzdecoCollectionPreviewController.h"
#import "ZzdecoCollectionPreviewModel.h"

@interface ZzdecoCollectionPreviewViewModel()

@property (nonatomic, strong) ZzdecoCollectionPreviewController *collectionPreviewController;

@end

@implementation ZzdecoCollectionPreviewViewModel

- (instancetype)initCollectionPreviewViewModelWithController:(UIViewController *)controller {
    
    if (self = [super init]) {
        
        self.collectionPreviewController = (ZzdecoCollectionPreviewController *)controller;
    }
    
    return self;
}

- (void)collectionCaseInfoRequest:(NSString *)caseID {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{@"id" : caseID};
    
    [sessionManager POST:GET_USER_COLLECTION_CASE_ADDRESS
              parameters:parameters
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                     ZzdecoCollectionPreviewModel *collectionPreviewModel = [ZzdecoCollectionPreviewModel yy_modelWithJSON:responseObject];
                     
                     if (collectionPreviewModel.message.length > 0) {
                         
                         SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                         
                         [self.collectionPreviewController.navigationController popViewControllerAnimated:YES];
                         
                         return;
                     }
                     
                     NSURL *url = [NSURL URLWithString:collectionPreviewModel.resultMap.project.coverImg];
                     
                     [self.collectionPreviewController.infoView.backgroundImageView setImageWithURL:url
                                                                                   placeholderImage:[UIImage imageNamed:@"default_background_image"]];
                     
                     self.collectionPreviewController.infoView.caseName = collectionPreviewModel.resultMap.project.projectName;
                     self.collectionPreviewController.infoView.caseInfo = collectionPreviewModel.resultMap.project.projectContent;

                     [self.collectionPreviewController.infoView.infoTableView reloadData];
                     
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     
                     SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                 }];
}

@end
