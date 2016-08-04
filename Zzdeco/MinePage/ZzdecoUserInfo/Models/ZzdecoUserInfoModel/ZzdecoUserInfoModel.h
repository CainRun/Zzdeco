//
//  ZzdecoUserInfoModel.h
//  Zzdeco
//
//  Created by Cain on 17/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZzdecoUserInfoResultModel.h"

@interface ZzdecoUserInfoModel : NSObject

@property (nonatomic, assign) BOOL success;
@property (nonatomic, assign) NSInteger dateline;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) ZzdecoUserInfoResultModel *result;

@end
