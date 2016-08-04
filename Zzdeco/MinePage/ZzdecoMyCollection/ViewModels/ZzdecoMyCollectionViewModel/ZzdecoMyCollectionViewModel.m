//
//  ZzdecoMyCollectionViewModel.m
//  Zzdeco
//
//  Created by Cain on 23/6/16.
//  Copyright © 2016年 zzdeco. All rights reserved.
//

#import "ZzdecoMyCollectionViewModel.h"
#import "ZzdecoMyCollectionViewController.h"
#import "ZzdecoMyCollectionModel.h"

@interface ZzdecoMyCollectionViewModel()

@property (nonatomic, strong) ZzdecoMyCollectionViewController *myCollectionViewController;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ZzdecoMyCollectionViewModel

- (instancetype)initCollectionViewModelWithController:(UIViewController *)controller {
    
    if (self = [super init]) {
        
        self.currentPage = 1;
        
        self.myCollectionViewController = (ZzdecoMyCollectionViewController *)controller;
    }
    
    return self;
}

- (void)getMyCollectionList {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    NSDictionary *patameters = @{@"currentPage" : [NSString stringWithFormat:@"%ld", (long)self.currentPage]};
    
    [sessionManager POST:GET_USER_COLLECTION_ADDRESS
              parameters:patameters
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     
                     ZzdecoMyCollectionModel *myCollectionModel = [ZzdecoMyCollectionModel yy_modelWithJSON:responseObject];
                     
                     if (myCollectionModel.pageBean.success.length > 0) {
                         
                         SHOW_ERROR_ALETVIEW(@"您还未收藏任何案例哦");
                         [self.myCollectionViewController.navigationController popViewControllerAnimated:YES];
                         
                         return;
                     }
                     
                     for (NSInteger i = 0; i < myCollectionModel.pageBean.dataList.count; i++) {
                         
                         [self.dataSource addObject:myCollectionModel.pageBean.dataList[i]];
                     }
                     
                     self.currentPage += 1;
                     
                     self.myCollectionViewController.dataSourceArray = self.dataSource;
                     
                     [self.myCollectionViewController.CALMyCollectionCollectionView reloadData];
                     
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     
                     SHOW_ERROR_ALETVIEW(REQUEST_ERRORMESSAGE);
                 }];
}

- (NSMutableArray *)dataSource {
    
    CAL_GET_METHOD_RETURN_OBJC(_dataSource);
    
    _dataSource = [NSMutableArray array];
    
    return _dataSource;
}

@end
