//
//  ZzdecoMyCollectionViewModel.h
//  Zzdeco
//
//  Created by Cain on 23/6/16.
//  Copyright © 2016年 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZzdecoMyCollectionViewModel : NSObject

@property (nonatomic, assign) NSInteger currentPage;

- (instancetype)initCollectionViewModelWithController:(UIViewController *)controller;

- (void)getMyCollectionList;

@end
