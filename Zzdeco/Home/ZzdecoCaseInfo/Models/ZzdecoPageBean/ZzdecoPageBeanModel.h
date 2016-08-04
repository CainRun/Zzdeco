//
//  ZzdecoPageBeanModel.h
//  Zzdeco
//
//  Created by Cain on 1/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZzdecoDataListModel.h"

@interface ZzdecoPageBeanModel : NSObject

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSArray <ZzdecoDataListModel *> *dataList;

@property (nonatomic, copy) NSString *success;

@end
