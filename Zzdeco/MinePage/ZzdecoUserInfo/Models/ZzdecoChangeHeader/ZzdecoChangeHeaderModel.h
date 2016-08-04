//
//  ZzdecoChangeHeaderModel.h
//  Zzdeco
//
//  Created by Cain on 7/7/16.
//  Copyright © 2016年 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZzdecoChangeHeaderDataModel.h"

@interface ZzdecoChangeHeaderModel : NSObject

@property (nonatomic, assign) BOOL success;

@property (nonatomic, strong) ZzdecoChangeHeaderDataModel *data;

@end
