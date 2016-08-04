//
//  ZzdecoMyPageBean.h
//  Zzdeco
//
//  Created by Cain on 2/7/16.
//  Copyright © 2016年 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZzdecoMyCollectionDataListModel.h"

@interface ZzdecoMyCollectionPageBeanModel : NSObject

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSArray<ZzdecoMyCollectionDataListModel *> *dataList;

@property (nonatomic, copy) NSString *success;

@end
