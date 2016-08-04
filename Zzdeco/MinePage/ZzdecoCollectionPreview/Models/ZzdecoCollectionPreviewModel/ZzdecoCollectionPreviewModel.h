//
//  ZzdecoCollectionPreviewModel.h
//  Zzdeco
//
//  Created by Cain on 26/6/16.
//  Copyright © 2016年 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZzdecoCollectionPreviewResultMapModel.h"

@interface ZzdecoCollectionPreviewModel : NSObject

@property (nonatomic, strong) ZzdecoCollectionPreviewResultMapModel *resultMap;

@property (nonatomic, assign) BOOL success;

@property (nonatomic, copy) NSString *message;

@end
