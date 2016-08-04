//
//  ZzdecoCasePageBeanModel.h
//  Zzdeco
//
//  Created by Cain on 11/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZzdecoCaseDataListModel.h"

@interface ZzdecoCasePageBeanModel : NSObject

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSArray<ZzdecoCaseDataListModel *> *dataList;

@end
