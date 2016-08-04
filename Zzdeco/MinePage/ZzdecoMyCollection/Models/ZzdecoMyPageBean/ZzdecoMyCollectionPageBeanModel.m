//
//  ZzdecoMyPageBean.m
//  Zzdeco
//
//  Created by Cain on 2/7/16.
//  Copyright © 2016年 zzdeco. All rights reserved.
//

#import "ZzdecoMyCollectionPageBeanModel.h"

@implementation ZzdecoMyCollectionPageBeanModel

- (void)setDataList:(NSArray<ZzdecoMyCollectionDataListModel *> *)dataList {
    
    _dataList = [NSArray yy_modelArrayWithClass:[ZzdecoMyCollectionDataListModel class] json:dataList];
}

@end
