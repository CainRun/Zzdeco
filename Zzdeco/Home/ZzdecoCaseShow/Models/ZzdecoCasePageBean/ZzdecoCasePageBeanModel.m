//
//  ZzdecoCasePageBeanModel.m
//  Zzdeco
//
//  Created by Cain on 11/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoCasePageBeanModel.h"

@implementation ZzdecoCasePageBeanModel

- (void)setDataList:(ZzdecoCaseDataListModel *)dataList {
    
    _dataList = [NSArray yy_modelArrayWithClass:[ZzdecoCaseDataListModel class] json:dataList];
}

@end
