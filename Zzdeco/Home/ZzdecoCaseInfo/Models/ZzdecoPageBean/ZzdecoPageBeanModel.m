//
//  ZzdecoPageBeanModel.m
//  Zzdeco
//
//  Created by Cain on 1/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoPageBeanModel.h"

@implementation ZzdecoPageBeanModel

- (void)setDataList:(NSArray *)dataList {
    
    _dataList = [NSArray yy_modelArrayWithClass:[ZzdecoDataListModel class] json:dataList];
}

@end
