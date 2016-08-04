//
//  ZzdecoCaseInfoViewModel.m
//  Zzdeco
//
//  Created by Cain on 1/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoCaseInfoViewModel.h"
#import "ZzdecoCaseInfoCollectionViewController.h"
#import "ZzdecoCaseInfoModel.h"

@interface ZzdecoCaseInfoViewModel()

@property (nonatomic, strong) ZzdecoCaseInfoCollectionViewController *caseInfoCollectionController;

@property (nonatomic, strong) UIButton *ReRequestButton;

@end

@implementation ZzdecoCaseInfoViewModel

- (instancetype)initCaseInfoViewModel:(UIViewController *)controller {
    
    if (self = [super init]) {
        
        self.pageCount = 1;
        
        self.caseInfoCollectionController = (ZzdecoCaseInfoCollectionViewController *)controller;
    }
    
    return self;
}

- (void)caseInfoRequest {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [self.parameter setObject:@"5" forKey:@"pageSize"];
    [self.parameter setObject:[NSString stringWithFormat:@"%ld", (long)self.pageCount] forKey:@"currentPage"];
    
    [sessionManager POST:GET_CASE_INFO_ADDRESS
              parameters:self.parameter
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     
                     ZzdecoCaseInfoModel *caseInfoModel = [ZzdecoCaseInfoModel yy_modelWithJSON:responseObject];
                     
                     if (caseInfoModel.pageBean.success.length > 0) {
                         
                         [self addReRequestButton];
                         
                         SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);

                         return;
                     }
                     
                     if (caseInfoModel.pageBean.dataList.count > 0) {
                         self.pageCount += 1;
                     }
                     
                     for (NSInteger i = 0; i < caseInfoModel.pageBean.dataList.count; i++) {
                         
                          [self.caseInfoCollectionController.dataSource addObject:caseInfoModel.pageBean.dataList[i]];
                     }
                     
                     [self.caseInfoCollectionController.collectionView reloadData];
                     
                     if (self.ReRequestButton) {
                         
                         [self.ReRequestButton removeFromSuperview];
                     }
                     
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

                     [self addReRequestButton];
                     
                      SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                 }];
}

- (void)addReRequestButton {
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.ReRequestButton];
    
    [self.ReRequestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        (void)make.edges;
    }];
}

- (UIButton *)ReRequestButton {
    
    CAL_GET_METHOD_RETURN_OBJC(_ReRequestButton);
    
    _ReRequestButton = [[UIButton alloc] init];
        
    [_ReRequestButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_ReRequestButton setTitle:@"点击屏幕刷新" forState:UIControlStateNormal];
    
    [_ReRequestButton addTarget:self action:@selector(ReRequest) forControlEvents:UIControlEventTouchUpInside];
    
    return _ReRequestButton;
}

- (void)ReRequest {
    
    [self caseInfoRequest];
}

- (NSMutableDictionary *)parameter {
    
    CAL_GET_METHOD_RETURN_OBJC(_parameter);
    
    _parameter = [NSMutableDictionary dictionary];
    
    return _parameter;
}

@end
