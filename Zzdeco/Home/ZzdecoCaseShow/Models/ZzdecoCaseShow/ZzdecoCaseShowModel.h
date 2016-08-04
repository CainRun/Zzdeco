//
//  ZzdecoCaseShowModel.h
//  Zzdeco
//
//  Created by Cain on 11/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZzdecoCaseResultMapModel.h"

@interface ZzdecoCaseShowModel : NSObject

@property (nonatomic, strong) ZzdecoCaseResultMapModel *resultMap;

@property (nonatomic, copy) NSString *message;

@end
